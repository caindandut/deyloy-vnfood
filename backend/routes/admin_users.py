from fastapi import APIRouter, Depends, HTTPException, Query
from typing import Optional
import mysql.connector

try:
    from ..database import get_db_connection
    from ..auth import get_current_admin_user
    from ..models import UserRoleUpdateRequest, UserStatusUpdateRequest
    from ..utils.database_queries import get_dish_ingredients, get_dish_instructions
except ImportError:
    from backend.database import get_db_connection
    from backend.auth import get_current_admin_user
    from backend.models import UserRoleUpdateRequest, UserStatusUpdateRequest
    from backend.utils.database_queries import get_dish_ingredients, get_dish_instructions


router = APIRouter(prefix="/admin/users", tags=["Admin - Users"])


def _get_user_by_id(cursor, user_id: int):
    cursor.execute(
        "SELECT id, username, role, is_active, created_at FROM users WHERE id = %s",
        (user_id,)
    )
    user = cursor.fetchone()
    if not user:
        raise HTTPException(status_code=404, detail="Không tìm thấy người dùng")
    return user


@router.get("")
async def list_users(
    search: Optional[str] = Query(None, description="Tìm theo username"),
    role: Optional[str] = Query(None, description="Lọc theo role"),
    status: Optional[str] = Query(None, description="active/inactive"),
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        conditions = ["1=1"]
        params = []

        if search:
            conditions.append("username LIKE %s")
            params.append(f"%{search}%")

        if role:
            conditions.append("role = %s")
            params.append(role)

        if status in {"active", "inactive"}:
            conditions.append("is_active = %s")
            params.append(status == "active")

        where_clause = " AND ".join(conditions)

        cursor.execute(
            f"""
            SELECT id, username, role, is_active, created_at
            FROM users
            WHERE {where_clause}
            ORDER BY created_at DESC
            """,
            params
        )
        users = cursor.fetchall()
        return {"users": users}
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/{user_id}/role")
async def update_user_role(
    user_id: int,
    payload: UserRoleUpdateRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    new_role = payload.role.lower()
    if new_role not in {"user", "admin"}:
        raise HTTPException(status_code=400, detail="Role không hợp lệ")

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        user = _get_user_by_id(cursor, user_id)
        if user["username"] in {admin_user}:
            raise HTTPException(status_code=400, detail="Không thể thay đổi quyền của chính bạn tại đây")

        cursor.execute(
            "UPDATE users SET role = %s WHERE id = %s",
            (new_role, user_id)
        )
        conn.commit()
        return {"message": "Đã cập nhật quyền người dùng", "user_id": user_id, "role": new_role}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/{user_id}/status")
async def update_user_status(
    user_id: int,
    payload: UserStatusUpdateRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        user = _get_user_by_id(cursor, user_id)
        if user["username"] == admin_user:
            raise HTTPException(status_code=400, detail="Không thể khóa tài khoản của chính bạn")

        cursor.execute(
            "UPDATE users SET is_active = %s WHERE id = %s",
            (payload.is_active, user_id)
        )
        conn.commit()
        return {"message": "Đã cập nhật trạng thái người dùng", "user_id": user_id, "is_active": payload.is_active}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.get("/{user_id}/stats")
async def get_user_stats(
    user_id: int,
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _get_user_by_id(cursor, user_id)

        cursor.execute("SELECT COUNT(*) AS total FROM history WHERE user_id = %s", (user_id,))
        history_total = cursor.fetchone()["total"]

        cursor.execute("SELECT COUNT(*) AS total FROM favorites WHERE user_id = %s", (user_id,))
        favorites_total = cursor.fetchone()["total"]

        cursor.execute("SELECT COUNT(*) AS total FROM shopping_lists WHERE user_id = %s", (user_id,))
        shopping_lists_total = cursor.fetchone()["total"]

        # Get last recognition from history table (đã bao gồm tất cả vì tự động lưu khi nhận diện)
        cursor.execute(
            """
            SELECT recognized_at
            FROM history
            WHERE user_id = %s
            ORDER BY recognized_at DESC
            LIMIT 1
            """,
            (user_id,)
        )
        last_activity_row = cursor.fetchone()

        return {
            "history_count": history_total,  # Tổng số lần nhận diện (đã tự động lưu)
            "favorites_count": favorites_total,
            "shopping_list_count": shopping_lists_total,
            "last_recognition": last_activity_row["recognized_at"] if last_activity_row else None
        }
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.get("/{user_id}/history")
async def get_user_history(
    user_id: int,
    language: str = Query('vi', description="Ngôn ngữ"),
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")
    
    cursor = conn.cursor(dictionary=True)
    try:
        _get_user_by_id(cursor, user_id)
        
        query = """
            SELECT h.id as history_id, d.id as dish_id, dt.name, dt.description, dt.region_info,
                   d.image_url, d.video_url, d.class_id, h.recognized_at
            FROM history h
            JOIN dishes d ON h.dish_id = d.id
            LEFT JOIN dish_translations dt ON d.id = dt.dish_id AND dt.language_code = %s
            WHERE h.user_id = %s
            ORDER BY h.recognized_at DESC
        """
        cursor.execute(query, (language, user_id))
        history_results = cursor.fetchall()
        
        for item in history_results:
            dish_id = item['dish_id']
            item['ingredients'] = get_dish_ingredients(dish_id, cursor, language)
            item['instructions'] = get_dish_instructions(dish_id, cursor, language)
        
        return history_results
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.get("/{user_id}/favorites")
async def get_user_favorites(
    user_id: int,
    language: str = Query('vi', description="Ngôn ngữ"),
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")
    
    cursor = conn.cursor(dictionary=True)
    try:
        _get_user_by_id(cursor, user_id)
        
        query = """
            SELECT f.id, f.dish_id, f.created_at, d.class_id, d.image_url, d.video_url,
                   dt.name, dt.description, dt.region_info
            FROM favorites f
            JOIN dishes d ON f.dish_id = d.id
            LEFT JOIN dish_translations dt ON d.id = dt.dish_id AND dt.language_code = %s
            WHERE f.user_id = %s
            ORDER BY f.created_at DESC
        """
        cursor.execute(query, (language, user_id))
        favorites = cursor.fetchall()
        
        for item in favorites:
            dish_id = item['dish_id']
            item['ingredients'] = get_dish_ingredients(dish_id, cursor, language)
            item['instructions'] = get_dish_instructions(dish_id, cursor, language)
        
        return favorites
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.get("/{user_id}/shopping-lists")
async def get_user_shopping_lists(
    user_id: int,
    language: str = Query('vi', description="Ngôn ngữ"),
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")
    
    cursor = conn.cursor(dictionary=True)
    try:
        _get_user_by_id(cursor, user_id)
        
        query = """
            SELECT sl.id, sl.name, sl.created_at, sl.updated_at,
                   COUNT(sli.id) as item_count,
                   SUM(CASE WHEN sli.is_checked = TRUE THEN 1 ELSE 0 END) as checked_count
            FROM shopping_lists sl
            LEFT JOIN shopping_list_items sli ON sl.id = sli.list_id
            WHERE sl.user_id = %s
            GROUP BY sl.id, sl.name, sl.created_at, sl.updated_at
            ORDER BY sl.updated_at DESC
        """
        cursor.execute(query, (user_id,))
        lists = cursor.fetchall()
        
        for list_item in lists:
            list_id = list_item['id']
            items_query = """
                SELECT sli.id, sli.ingredient_id, sli.ingredient_name, 
                       sli.quantity, sli.is_checked, sli.created_at,
                       it.name as ingredient_display_name
                FROM shopping_list_items sli
                LEFT JOIN ingredients i ON sli.ingredient_id = i.id
                LEFT JOIN ingredient_translations it ON i.id = it.ingredient_id AND it.language_code = %s
                WHERE sli.list_id = %s
                ORDER BY sli.created_at ASC
            """
            cursor.execute(items_query, (language, list_id,))
            list_item['items'] = cursor.fetchall()
        
        return lists
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()

