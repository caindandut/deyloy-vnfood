from fastapi import APIRouter, HTTPException, Depends

try:
    from ..models import SaveHistoryRequest
    from ..database import get_db_connection
    from ..auth import get_current_user_required
    from ..utils.database_queries import get_dish_ingredients, get_dish_instructions
except ImportError:
    from backend.models import SaveHistoryRequest
    from backend.database import get_db_connection
    from backend.auth import get_current_user_required
    from backend.utils.database_queries import get_dish_ingredients, get_dish_instructions

router = APIRouter()

@router.get("/history")
async def get_history(
    language: str = 'vi',
    current_user: str = Depends(get_current_user_required)
):
    conn = get_db_connection()
    if not conn:
         raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        query = """
            SELECT h.id as history_id, d.id as dish_id, dt.name, dt.description, dt.region_info,
                   d.image_url, d.video_url, d.class_id, h.recognized_at
            FROM history h
            JOIN users u ON h.user_id = u.id
            JOIN dishes d ON h.dish_id = d.id
            LEFT JOIN dish_translations dt ON d.id = dt.dish_id AND dt.language_code = %s
            WHERE u.username = %s
            ORDER BY h.recognized_at DESC
            LIMIT 20
        """
        cursor.execute(query, (language, current_user))
        history_results = cursor.fetchall()

        for item in history_results:
            dish_id = item['dish_id']
            item['ingredients'] = get_dish_ingredients(dish_id, cursor, language)
            item['instructions'] = get_dish_instructions(dish_id, cursor, language)

        return history_results
    except Exception as e:
         print(f"Lỗi truy vấn lịch sử: {e}")
         raise HTTPException(status_code=500, detail="Lỗi truy vấn lịch sử.")
    finally:
         if cursor: cursor.close()
         if conn: conn.close()

@router.post("/save_history")
async def save_history(request: SaveHistoryRequest, current_user: str = Depends(get_current_user_required)):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT id FROM users WHERE username = %s", (current_user,))
        user_db = cursor.fetchone()
        if not user_db:
            raise HTTPException(status_code=404, detail="Không tìm thấy user")

        user_id = user_db['id']

        # Check if already exists (tránh duplicate nếu đã tự động lưu khi nhận diện)
        cursor.execute(
            "SELECT id FROM history WHERE user_id = %s AND dish_id = %s ORDER BY recognized_at DESC LIMIT 1",
            (user_id, request.dish_id)
        )
        existing = cursor.fetchone()
        
        if existing:
            # Đã có trong lịch sử rồi (có thể đã tự động lưu khi nhận diện)
            return {"message": "Món ăn này đã có trong lịch sử", "already_exists": True}
        
        # Manual ID generation
        cursor.execute("SELECT MAX(id) FROM history")
        row = cursor.fetchone()
        next_id = (row['MAX(id)'] or 0) + 1

        cursor.execute("INSERT INTO history (id, user_id, dish_id) VALUES (%s, %s, %s)", (next_id, user_id, request.dish_id))
        conn.commit()

        return {"message": "Đã lưu vào lịch sử thành công", "already_exists": False}
    except Exception as e:
        conn.rollback()
        print(f"LỖI: Không thể lưu lịch sử: {e}")
        raise HTTPException(status_code=500, detail="Không thể lưu lịch sử")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

