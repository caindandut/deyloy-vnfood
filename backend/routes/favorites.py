from fastapi import APIRouter, HTTPException, Depends
from typing import Optional

try:
    from ..models import FavoriteCreate
    from ..database import get_db_connection
    from ..auth import get_current_user_required, get_current_user_optional
    from ..utils.database_queries import get_dish_ingredients, get_dish_instructions
except ImportError:
    from backend.models import FavoriteCreate
    from backend.database import get_db_connection
    from backend.auth import get_current_user_required, get_current_user_optional
    from backend.utils.database_queries import get_dish_ingredients, get_dish_instructions

router = APIRouter()

@router.get("/favorites/test")
async def test_favorites():
    return {"message": "Favorites endpoint is working"}

@router.post("/favorites")
async def add_favorite(
    favorite: FavoriteCreate,
    current_user: str = Depends(get_current_user_required)
):
    print(f"DEBUG: POST /favorites called with dish_id={favorite.dish_id}, user={current_user}")
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
        
        cursor.execute("SELECT id FROM dishes WHERE id = %s", (favorite.dish_id,))
        dish = cursor.fetchone()
        if not dish:
            raise HTTPException(status_code=404, detail="Không tìm thấy món ăn")
        
        # Manual ID generation
        cursor.execute("SELECT MAX(id) FROM favorites")
        row = cursor.fetchone()
        next_id = (row['MAX(id)'] or 0) + 1

        cursor.execute(
            "INSERT IGNORE INTO favorites (id, user_id, dish_id) VALUES (%s, %s, %s)",
            (next_id, user_id, favorite.dish_id)
        )
        conn.commit()
        
        if cursor.rowcount == 0:
            return {"message": "Món ăn đã có trong danh sách yêu thích"}
        
        return {"message": "Đã thêm vào yêu thích thành công"}
    except HTTPException:
        raise
    except Exception as e:
        conn.rollback()
        print(f"Lỗi khi thêm favorite: {e}")
        raise HTTPException(status_code=500, detail="Không thể thêm vào yêu thích")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.delete("/favorites/{dish_id}")
async def remove_favorite(
    dish_id: int,
    current_user: str = Depends(get_current_user_required)
):
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
        
        cursor.execute(
            "DELETE FROM favorites WHERE user_id = %s AND dish_id = %s",
            (user_id, dish_id)
        )
        conn.commit()
        
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Món ăn không có trong danh sách yêu thích")
        
        return {"message": "Đã xóa khỏi yêu thích thành công"}
    except HTTPException:
        raise
    except Exception as e:
        conn.rollback()
        print(f"Lỗi khi xóa favorite: {e}")
        raise HTTPException(status_code=500, detail="Không thể xóa khỏi yêu thích")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.get("/favorites")
async def get_favorites(
    language: str = 'vi',
    current_user: str = Depends(get_current_user_required)
):
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
    except HTTPException:
        raise
    except Exception as e:
        print(f"Lỗi khi lấy favorites: {e}")
        raise HTTPException(status_code=500, detail="Không thể lấy danh sách yêu thích")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.get("/favorites/check/{dish_id}")
async def check_favorite(
    dish_id: int,
    current_user: Optional[str] = Depends(get_current_user_optional)
):
    if current_user is None:
        return {"is_favorite": False}
    
    conn = get_db_connection()
    if not conn:
        return {"is_favorite": False}
    
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT id FROM users WHERE username = %s", (current_user,))
        user_db = cursor.fetchone()
        if not user_db:
            return {"is_favorite": False}
        
        user_id = user_db['id']
        
        cursor.execute(
            "SELECT COUNT(*) as count FROM favorites WHERE user_id = %s AND dish_id = %s",
            (user_id, dish_id)
        )
        result = cursor.fetchone()
        
        return {"is_favorite": result['count'] > 0}
    except Exception as e:
        print(f"Lỗi khi check favorite: {e}")
        return {"is_favorite": False}
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

