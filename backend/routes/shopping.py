from fastapi import APIRouter, HTTPException, Depends
from typing import Optional, List

try:
    from ..models import ShoppingListCreate, ShoppingListItemCreate, AddDishToShoppingList
    from ..database import get_db_connection
    from ..auth import get_current_user_required
    from ..utils.database_queries import get_dish_ingredients
except ImportError:
    from backend.models import ShoppingListCreate, ShoppingListItemCreate, AddDishToShoppingList
    from backend.database import get_db_connection
    from backend.auth import get_current_user_required
    from backend.utils.database_queries import get_dish_ingredients

router = APIRouter()

@router.post("/shopping-lists")
async def create_shopping_list(
    data: ShoppingListCreate,
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
        list_name = data.name or "Danh sách mua sắm"
        
        # Manual ID generation
        cursor.execute("SELECT MAX(id) FROM shopping_lists")
        row = cursor.fetchone()
        next_id = (row['MAX(id)'] or 0) + 1
        
        cursor.execute(
            "INSERT INTO shopping_lists (id, user_id, name) VALUES (%s, %s, %s)",
            (next_id, user_id, list_name)
        )
        conn.commit()
        list_id = next_id
        
        return {
            "id": list_id,
            "name": list_name,
            "user_id": user_id,
            "message": "Đã tạo danh sách mua sắm thành công"
        }
    except HTTPException:
        raise
    except Exception as e:
        conn.rollback()
        print(f"Lỗi khi tạo shopping list: {e}")
        raise HTTPException(status_code=500, detail="Không thể tạo danh sách mua sắm")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.get("/shopping-lists")
async def get_shopping_lists(
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
    except HTTPException:
        raise
    except Exception as e:
        print(f"Lỗi khi lấy shopping lists: {e}")
        raise HTTPException(status_code=500, detail="Không thể lấy danh sách mua sắm")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.get("/shopping-lists/{list_id}")
async def get_shopping_list(
    list_id: int,
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
        
        # Kiểm tra list thuộc về user
        cursor.execute(
            "SELECT * FROM shopping_lists WHERE id = %s AND user_id = %s",
            (list_id, user_id)
        )
        shopping_list = cursor.fetchone()
        if not shopping_list:
            raise HTTPException(status_code=404, detail="Không tìm thấy danh sách mua sắm")
        
        query = """
            SELECT sli.id, sli.ingredient_id, sli.ingredient_name, 
                   sli.quantity, sli.is_checked, sli.created_at,
                   it.name as ingredient_display_name
            FROM shopping_list_items sli
            LEFT JOIN ingredients i ON sli.ingredient_id = i.id
            LEFT JOIN ingredient_translations it ON i.id = it.ingredient_id AND it.language_code = %s
            WHERE sli.list_id = %s
            ORDER BY sli.created_at ASC
        """
        cursor.execute(query, (language, list_id,))
        items = cursor.fetchall()
        
        shopping_list['items'] = items
        return shopping_list
    except HTTPException:
        raise
    except Exception as e:
        print(f"Lỗi khi lấy shopping list: {e}")
        raise HTTPException(status_code=500, detail="Không thể lấy danh sách mua sắm")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.post("/shopping-lists/{list_id}/items")
async def add_item_to_list(
    list_id: int,
    item: ShoppingListItemCreate,
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
        
        # Kiểm tra list thuộc về user
        cursor.execute(
            "SELECT id FROM shopping_lists WHERE id = %s AND user_id = %s",
            (list_id, user_id)
        )
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail="Không tìm thấy danh sách mua sắm")
        
        # Manual ID generation
        cursor.execute("SELECT MAX(id) FROM shopping_list_items")
        row = cursor.fetchone()
        next_id = (row['MAX(id)'] or 0) + 1

        cursor.execute(
            """INSERT INTO shopping_list_items 
               (id, list_id, ingredient_id, ingredient_name, quantity, is_checked) 
               VALUES (%s, %s, %s, %s, %s, %s)""",
            (next_id, list_id, item.ingredient_id, item.ingredient_name, item.quantity, item.is_checked or False)
        )
        cursor.execute("UPDATE shopping_lists SET updated_at = NOW() WHERE id = %s", (list_id,))
        conn.commit()
        item_id = next_id
        
        cursor.execute(
            """SELECT sli.id, sli.ingredient_id, sli.ingredient_name, 
                      sli.quantity, sli.is_checked, sli.created_at,
                      it.name as ingredient_display_name
               FROM shopping_list_items sli
               LEFT JOIN ingredients i ON sli.ingredient_id = i.id
               LEFT JOIN ingredient_translations it ON i.id = it.ingredient_id AND it.language_code = %s
               WHERE sli.id = %s""",
            (language, item_id,)
        )
        new_item = cursor.fetchone()
        
        return new_item
    except HTTPException:
        raise
    except Exception as e:
        conn.rollback()
        print(f"Lỗi khi thêm item vào shopping list: {e}")
        raise HTTPException(status_code=500, detail="Không thể thêm item vào danh sách")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.post("/shopping-lists/add-dish")
async def add_dish_to_shopping_list(
    data: AddDishToShoppingList,
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
        
        # Kiểm tra list thuộc về user
        cursor.execute(
            "SELECT id FROM shopping_lists WHERE id = %s AND user_id = %s",
            (data.list_id, user_id)
        )
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail="Không tìm thấy danh sách mua sắm")
        
        ingredients = get_dish_ingredients(data.dish_id, cursor, language)
        
        added_count = 0
        # Get initial max ID
        cursor.execute("SELECT MAX(id) FROM shopping_list_items")
        row = cursor.fetchone()
        next_id = (row['MAX(id)'] or 0) + 1

        for ing in ingredients:
            if ing.get('name'):
                cursor.execute(
                    """SELECT id FROM shopping_list_items 
                       WHERE list_id = %s AND ingredient_name = %s""",
                    (data.list_id, ing['name'])
                )
                if cursor.fetchone():
                    continue
            
            cursor.execute(
                """INSERT INTO shopping_list_items 
                   (id, list_id, ingredient_name, quantity, is_checked) 
                   VALUES (%s, %s, %s, %s, %s)""",
                (next_id, data.list_id, ing['name'], ing['quantity'], False)
            )
            next_id += 1
            added_count += 1
        
        cursor.execute("UPDATE shopping_lists SET updated_at = NOW() WHERE id = %s", (data.list_id,))
        conn.commit()

        # Build localized message based on language and added_count
        if added_count == 0:
            message = (
                "Tất cả nguyên liệu của món ăn này đã có trong danh sách mua sắm."
                if language == 'vi'
                else "All ingredients for this dish are already in the shopping list."
            )
        else:
            if language == 'vi':
                message = f"Đã thêm {added_count} nguyên liệu vào danh sách mua sắm"
            else:
                message = f"Added {added_count} ingredients to the shopping list"

        return {
            "message": message,
            "added_count": added_count
        }
    except HTTPException:
        raise
    except Exception as e:
        conn.rollback()
        print(f"Lỗi khi thêm món vào shopping list: {e}")
        raise HTTPException(status_code=500, detail="Không thể thêm món vào danh sách")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.put("/shopping-lists/{list_id}/items/{item_id}")
async def update_shopping_list_item(
    list_id: int,
    item_id: int,
    item: ShoppingListItemCreate,
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
        
        # Kiểm tra list thuộc về user
        cursor.execute(
            "SELECT id FROM shopping_lists WHERE id = %s AND user_id = %s",
            (list_id, user_id)
        )
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail="Không tìm thấy danh sách mua sắm")
        
        update_fields = []
        update_values = []
        
        if item.ingredient_name is not None:
            update_fields.append("ingredient_name = %s")
            update_values.append(item.ingredient_name)
        
        if item.quantity is not None:
            update_fields.append("quantity = %s")
            update_values.append(item.quantity)
        
        if item.is_checked is not None:
            update_fields.append("is_checked = %s")
            update_values.append(item.is_checked)
        
        if not update_fields:
            raise HTTPException(status_code=400, detail="Không có trường nào để cập nhật")
        
        update_values.append(item_id)
        update_values.append(list_id)
        
        query = f"""
            UPDATE shopping_list_items 
            SET {', '.join(update_fields)}
            WHERE id = %s AND list_id = %s
        """
        cursor.execute(query, tuple(update_values))
        cursor.execute("UPDATE shopping_lists SET updated_at = NOW() WHERE id = %s", (list_id,))
        conn.commit()
        
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Không tìm thấy item")
        
        cursor.execute(
        """SELECT sli.id, sli.ingredient_id, sli.ingredient_name, 
                  sli.quantity, sli.is_checked, sli.created_at,
                  it.name as ingredient_display_name
           FROM shopping_list_items sli
           LEFT JOIN ingredients i ON sli.ingredient_id = i.id
           LEFT JOIN ingredient_translations it ON i.id = it.ingredient_id AND it.language_code = %s
           WHERE sli.id = %s""",
        (language, item_id,)
        )
        updated_item = cursor.fetchone()
        
        return updated_item
    except HTTPException:
        raise
    except Exception as e:
        conn.rollback()
        print(f"Lỗi khi cập nhật item: {e}")
        raise HTTPException(status_code=500, detail="Không thể cập nhật item")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.delete("/shopping-lists/{list_id}/items/{item_id}")
async def delete_shopping_list_item(
    list_id: int,
    item_id: int,
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
        
        # Kiểm tra list thuộc về user
        cursor.execute(
            "SELECT id FROM shopping_lists WHERE id = %s AND user_id = %s",
            (list_id, user_id)
        )
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail="Không tìm thấy danh sách mua sắm")
        
        cursor.execute(
            "DELETE FROM shopping_list_items WHERE id = %s AND list_id = %s",
            (item_id, list_id)
        )
        cursor.execute("UPDATE shopping_lists SET updated_at = NOW() WHERE id = %s", (list_id,))
        conn.commit()
        
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Không tìm thấy item")
        
        return {"message": "Đã xóa item thành công"}
    except HTTPException:
        raise
    except Exception as e:
        conn.rollback()
        print(f"Lỗi khi xóa item: {e}")
        raise HTTPException(status_code=500, detail="Không thể xóa item")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.delete("/shopping-lists/{list_id}")
async def delete_shopping_list(
    list_id: int,
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
            "DELETE FROM shopping_lists WHERE id = %s AND user_id = %s",
            (list_id, user_id)
        )
        conn.commit()
        
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Không tìm thấy danh sách mua sắm")
        
        return {"message": "Đã xóa danh sách mua sắm thành công"}
    except HTTPException:
        raise
    except Exception as e:
        conn.rollback()
        print(f"Lỗi khi xóa shopping list: {e}")
        raise HTTPException(status_code=500, detail="Không thể xóa danh sách mua sắm")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

