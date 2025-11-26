from fastapi import APIRouter, HTTPException, Query
from typing import Optional

try:
    from ..database import get_db_connection
    from ..utils.database_queries import get_dish_ingredients, get_dish_instructions
except ImportError:
    from backend.database import get_db_connection
    from backend.utils.database_queries import get_dish_ingredients, get_dish_instructions

router = APIRouter()

@router.get("/dishes")
async def get_dishes(
    search: Optional[str] = Query(None, description="Tìm kiếm theo tên hoặc mô tả"),
    ingredient: Optional[str] = Query(None, description="Lọc theo nguyên liệu (name_key)"),
    sort: Optional[str] = Query("name_asc", description="Sắp xếp: name_asc, name_desc, popular"),
    language: str = Query('vi', description="Ngôn ngữ"),
    page: int = Query(1, ge=1, description="Trang"),
    limit: int = Query(20, ge=1, le=100, description="Số lượng mỗi trang")
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")
    
    cursor = conn.cursor(dictionary=True)
    try:
        fallback_language = 'vi'
        name_expr = "COALESCE(dt.name, dt_fallback.name)"
        description_expr = "COALESCE(dt.description, dt_fallback.description)"
        region_expr = "COALESCE(dt.region_info, dt_fallback.region_info)"
        where_conditions = ["1=1"]
        where_params = []
        
        if search:
            where_conditions.append(f"({name_expr} LIKE %s OR {description_expr} LIKE %s)")
            search_pattern = f"%{search}%"
            where_params.extend([search_pattern, search_pattern])
        
        if ingredient:
            where_conditions.append("""
                d.id IN (
                    SELECT DISTINCT di.dish_id 
                    FROM dish_ingredients di 
                    JOIN ingredients i ON di.ingredient_id = i.id 
                    WHERE i.name_key = %s
                )
            """)
            where_params.append(ingredient)
        
        where_clause = " AND ".join(where_conditions)
        
        order_clause = f"{name_expr} ASC"
        if sort == "name_desc":
            order_clause = f"{name_expr} DESC"
        elif sort == "popular":
            order_clause = """
                (SELECT COUNT(*) FROM history h WHERE h.dish_id = d.id) DESC,
                COALESCE(dt.name, dt_fallback.name) ASC
            """
        
        offset = (page - 1) * limit
        
        query = f"""
            SELECT d.id, d.class_id, d.image_url, d.video_url,
                   {name_expr} AS name,
                   {description_expr} AS description,
                   {region_expr} AS region_info
            FROM dishes d
            LEFT JOIN dish_translations dt ON d.id = dt.dish_id AND dt.language_code = %s
            LEFT JOIN dish_translations dt_fallback ON d.id = dt_fallback.dish_id AND dt_fallback.language_code = %s
            WHERE {where_clause}
            ORDER BY {order_clause}
            LIMIT %s OFFSET %s
        """
        
        query_params = [language, fallback_language] + where_params + [limit, offset]
        cursor.execute(query, query_params)
        dishes = cursor.fetchall()
        
        count_query = f"""
            SELECT COUNT(DISTINCT d.id) as total
            FROM dishes d
            LEFT JOIN dish_translations dt ON d.id = dt.dish_id AND dt.language_code = %s
            LEFT JOIN dish_translations dt_fallback ON d.id = dt_fallback.dish_id AND dt_fallback.language_code = %s
            WHERE {where_clause}
        """
        count_params = [language, fallback_language] + where_params
        cursor.execute(count_query, count_params)
        total_result = cursor.fetchone()
        total = total_result['total'] if total_result else 0
        
        return {
            "dishes": dishes,
            "total": total,
            "page": page,
            "limit": limit,
            "total_pages": (total + limit - 1) // limit if limit > 0 else 0
        }
    except Exception as e:
        print(f"Lỗi khi lấy danh sách món ăn: {e}")
        raise HTTPException(status_code=500, detail="Không thể lấy danh sách món ăn")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.get("/dishes/{dish_id}")
async def get_dish_detail(
    dish_id: int,
    language: str = Query('vi', description="Ngôn ngữ")
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")
    
    cursor = conn.cursor(dictionary=True)
    try:
        fallback_language = 'vi'
        query_dish = """
            SELECT d.id, d.class_id, d.image_url, d.video_url,
                   COALESCE(dt.name, dt_fallback.name) AS name,
                   COALESCE(dt.description, dt_fallback.description) AS description,
                   COALESCE(dt.region_info, dt_fallback.region_info) AS region_info
            FROM dishes d
            LEFT JOIN dish_translations dt ON d.id = dt.dish_id AND dt.language_code = %s
            LEFT JOIN dish_translations dt_fallback ON d.id = dt_fallback.dish_id AND dt_fallback.language_code = %s
            WHERE d.id = %s
        """
        cursor.execute(query_dish, (language, fallback_language, dish_id))
        dish = cursor.fetchone()
        
        if not dish:
            raise HTTPException(status_code=404, detail="Không tìm thấy món ăn")
        
        ingredients = get_dish_ingredients(dish_id, cursor, language)
        instructions = get_dish_instructions(dish_id, cursor, language)
        
        return {
            "dish": dish,
            "ingredients": ingredients,
            "instructions": instructions
        }
    except HTTPException:
        raise
    except Exception as e:
        print(f"Lỗi khi lấy chi tiết món ăn: {e}")
        raise HTTPException(status_code=500, detail="Không thể lấy chi tiết món ăn")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()

@router.get("/ingredients")
async def get_ingredients(language: str = Query('vi', description="Ngôn ngữ")):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")
    
    cursor = conn.cursor(dictionary=True)
    try:
        query = """
            SELECT DISTINCT i.id, i.name_key, it.name
            FROM ingredients i
            LEFT JOIN ingredient_translations it ON i.id = it.ingredient_id AND it.language_code = %s
            WHERE it.name IS NOT NULL
            ORDER BY it.name ASC
        """
        cursor.execute(query, (language,))
        ingredients = cursor.fetchall()
        
        return ingredients
    except Exception as e:
        print(f"Lỗi khi lấy danh sách nguyên liệu: {e}")
        raise HTTPException(status_code=500, detail="Không thể lấy danh sách nguyên liệu")
    finally:
        if cursor: cursor.close()
        if conn: conn.close()
