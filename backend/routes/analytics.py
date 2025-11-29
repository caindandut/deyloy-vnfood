from fastapi import APIRouter, Depends, HTTPException
import mysql.connector

try:
    from ..database import get_db_connection
    from ..auth import get_current_admin_user
except ImportError:
    from backend.database import get_db_connection
    from backend.auth import get_current_admin_user


router = APIRouter(prefix="/admin/analytics", tags=["Admin - Analytics"])


def _format_datetime(value):
    if hasattr(value, "isoformat"):
        return value.isoformat()
    return value


@router.get("")
async def get_admin_analytics(
    language: str = "vi",
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        # Count recognitions from history table (đã bao gồm tất cả vì tự động lưu khi nhận diện)
        cursor.execute(
            """
            SELECT 
                d.id AS dish_id,
                COALESCE(dt.name, CONCAT('Dish #', d.id)) AS dish_name,
                COUNT(*) AS recognition_count
            FROM history h
            JOIN dishes d ON h.dish_id = d.id
            LEFT JOIN dish_translations dt 
                ON dt.dish_id = d.id AND dt.language_code = %s
            GROUP BY d.id, dt.name
            ORDER BY recognition_count DESC
            """,
            (language,)
        )
        recognition_rows = cursor.fetchall() or []
        
        # Get total recognitions count from history table
        cursor.execute("SELECT COUNT(*) AS total FROM history")
        total_recognitions_row = cursor.fetchone() or {"total": 0}
        total_recognitions = total_recognitions_row["total"]

        cursor.execute("SELECT COUNT(*) AS total_users FROM users")
        total_users_row = cursor.fetchone() or {"total_users": 0}

        # Get recent activity from history table
        cursor.execute(
            """
            SELECT 
                h.id AS history_id,
                u.username,
                COALESCE(dt.name, CONCAT('Dish #', d.id)) AS dish_name,
                h.recognized_at
            FROM history h
            JOIN users u ON h.user_id = u.id
            JOIN dishes d ON h.dish_id = d.id
            LEFT JOIN dish_translations dt 
                ON dt.dish_id = d.id AND dt.language_code = %s
            ORDER BY h.recognized_at DESC
            LIMIT 20
            """,
            (language,)
        )
        activity_rows = cursor.fetchall() or []
        recent_activity = [
            {
                "history_id": row["history_id"],
                "username": row["username"],
                "dish_name": row["dish_name"],
                "recognized_at": _format_datetime(row["recognized_at"])
            }
            for row in activity_rows
        ]

        cursor.execute(
            """
            SELECT 
                DATE(recognized_at) AS trend_date,
                COUNT(*) AS recognition_count
            FROM history
            WHERE recognized_at >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
            GROUP BY trend_date
            ORDER BY trend_date ASC
            """
        )
        trend_rows = cursor.fetchall() or []
        recognition_trend = [
            {
                "date": _format_datetime(row["trend_date"]),
                "recognition_count": row["recognition_count"]
            }
            for row in trend_rows
        ]

        cursor.execute(
            """
            SELECT
                d.id AS dish_id,
                COALESCE(dt.name, CONCAT('Dish #', d.id)) AS dish_name,
                COUNT(*) AS favorite_count
            FROM favorites f
            JOIN dishes d ON f.dish_id = d.id
            LEFT JOIN dish_translations dt
                ON dt.dish_id = d.id AND dt.language_code = %s
            GROUP BY d.id, dt.name
            ORDER BY favorite_count DESC
            LIMIT 1
            """,
            (language,)
        )
        favorite_row = cursor.fetchone()

        return {
            "total_users": total_users_row["total_users"],
            "total_recognitions": total_recognitions,
            "recognitions_by_dish": recognition_rows,
            "most_popular_dish": recognition_rows[0] if recognition_rows else None,
            "most_favorited_dish": favorite_row,
            "recent_activity": recent_activity,
            "recognition_trend": recognition_trend
        }
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()

