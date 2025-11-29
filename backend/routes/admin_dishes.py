from fastapi import APIRouter, Depends, HTTPException, Query
from typing import Optional, Dict, Any, List
import mysql.connector

try:
    from ..database import get_db_connection
    from ..auth import get_current_admin_user
    from ..models import (
        DishUpdateRequest,
        DishTranslationUpdateRequest,
        IngredientCreateRequest,
        IngredientUpdateRequest,
        IngredientTranslationRequest,
        DishIngredientLinkRequest,
        InstructionCreateRequest,
        InstructionUpdateRequest,
        InstructionTranslationRequest,
        InstructionReorderRequest
    )
except ImportError:
    from backend.database import get_db_connection
    from backend.auth import get_current_admin_user
    from backend.models import (
        DishUpdateRequest,
        DishTranslationUpdateRequest,
        IngredientCreateRequest,
        IngredientUpdateRequest,
        IngredientTranslationRequest,
        DishIngredientLinkRequest,
        InstructionCreateRequest,
        InstructionUpdateRequest,
        InstructionTranslationRequest,
        InstructionReorderRequest
    )


router = APIRouter(prefix="/admin", tags=["Admin - Dishes"])


def _ensure_dish_exists(cursor, dish_id: int):
    cursor.execute(
        "SELECT id, class_id, image_url, video_url FROM dishes WHERE id = %s",
        (dish_id,)
    )
    dish = cursor.fetchone()
    if not dish:
        raise HTTPException(status_code=404, detail="Không tìm thấy món ăn")
    return dish


def _ensure_ingredient_exists(cursor, ingredient_id: int):
    cursor.execute(
        "SELECT id, name_key FROM ingredients WHERE id = %s",
        (ingredient_id,)
    )
    ingredient = cursor.fetchone()
    if not ingredient:
        raise HTTPException(status_code=404, detail="Không tìm thấy nguyên liệu")
    return ingredient


def _ensure_instruction(cursor, instruction_id: int, dish_id: Optional[int] = None):
    params = [instruction_id]
    query = "SELECT id, dish_id, step_number, image_url FROM instructions WHERE id = %s"
    if dish_id is not None:
        query += " AND dish_id = %s"
        params.append(dish_id)
    cursor.execute(query, params)
    instruction = cursor.fetchone()
    if not instruction:
        raise HTTPException(status_code=404, detail="Không tìm thấy bước hướng dẫn")
    return instruction


def _validate_language_code(language_code: str):
    lang = language_code.lower()
    if lang not in {"vi", "en"}:
        raise HTTPException(status_code=400, detail="Ngôn ngữ không được hỗ trợ")
    return lang


@router.get("/dishes")
async def list_dishes_for_admin(
    search: Optional[str] = Query(None, description="Tìm theo tên (VI/EN) hoặc class_id"),
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        where_clauses = ["1=1"]
        params = []
        if search:
            where_clauses.append("""
                (
                    dt_vi.name LIKE %s OR
                    dt_en.name LIKE %s OR
                    CAST(d.class_id AS CHAR) LIKE %s
                )
            """)
            like_pattern = f"%{search}%"
            params.extend([like_pattern, like_pattern, like_pattern])

        where_sql = " AND ".join(where_clauses)

        cursor.execute(
            f"""
            SELECT d.id, d.class_id, d.image_url, d.video_url,
                   dt_vi.name AS name_vi,
                   dt_en.name AS name_en
            FROM dishes d
            LEFT JOIN dish_translations dt_vi ON d.id = dt_vi.dish_id AND dt_vi.language_code = 'vi'
            LEFT JOIN dish_translations dt_en ON d.id = dt_en.dish_id AND dt_en.language_code = 'en'
            WHERE {where_sql}
            ORDER BY d.class_id ASC
            """,
            params
        )
        dishes = cursor.fetchall()
        return {"dishes": dishes}
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.get("/dishes/{dish_id}")
async def get_dish_detail_for_admin(
    dish_id: int,
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        dish = _ensure_dish_exists(cursor, dish_id)

        cursor.execute(
            """
            SELECT language_code, name, description, region_info
            FROM dish_translations
            WHERE dish_id = %s
            """,
            (dish_id,)
        )
        translation_rows = cursor.fetchall()
        translations: Dict[str, Any] = {}
        for row in translation_rows:
            translations[row["language_code"]] = {
                "name": row["name"],
                "description": row["description"],
                "region_info": row["region_info"]
            }

        return {"dish": dish, "translations": translations}
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/dishes/{dish_id}")
async def update_dish_base_info(
    dish_id: int,
    payload: DishUpdateRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    if payload.image_url is None and payload.video_url is None:
        raise HTTPException(status_code=400, detail="Không có dữ liệu để cập nhật")

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_dish_exists(cursor, dish_id)

        update_parts = []
        params = []
        if payload.image_url is not None:
            update_parts.append("image_url = %s")
            params.append(payload.image_url)
        if payload.video_url is not None:
            update_parts.append("video_url = %s")
            params.append(payload.video_url)

        params.append(dish_id)
        cursor.execute(
            f"UPDATE dishes SET {', '.join(update_parts)} WHERE id = %s",
            params
        )
        conn.commit()
        return {"message": "Đã cập nhật thông tin món ăn", "dish_id": dish_id}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/dishes/{dish_id}/translations/{language_code}")
async def upsert_dish_translation(
    dish_id: int,
    language_code: str,
    payload: DishTranslationUpdateRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    lang = language_code.lower()
    if lang not in {"vi", "en"}:
        raise HTTPException(status_code=400, detail="Ngôn ngữ không được hỗ trợ")

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_dish_exists(cursor, dish_id)

        cursor.execute(
            """
            INSERT INTO dish_translations (dish_id, language_code, name, description, region_info)
            VALUES (%s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
                name = VALUES(name),
                description = VALUES(description),
                region_info = VALUES(region_info)
            """,
            (dish_id, lang, payload.name, payload.description, payload.region_info)
        )
        conn.commit()
        return {"message": "Đã cập nhật bản dịch", "dish_id": dish_id, "language": lang}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


# ---------- INGREDIENT MANAGEMENT ----------

@router.get("/ingredients")
async def list_ingredients(
    search: Optional[str] = Query(None, description="Tìm theo name_key hoặc tên bản dịch"),
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        where = ["1=1"]
        params = []
        if search:
            like = f"%{search}%"
            where.append("""
                (
                    i.name_key LIKE %s OR
                    it_vi.name LIKE %s OR
                    it_en.name LIKE %s
                )
            """)
            params.extend([like, like, like])

        cursor.execute(
            f"""
            SELECT i.id, i.name_key,
                   it_vi.name AS name_vi,
                   it_en.name AS name_en,
                   (
                       SELECT COUNT(*) FROM dish_ingredients di
                       WHERE di.ingredient_id = i.id
                   ) AS usage_count
            FROM ingredients i
            LEFT JOIN ingredient_translations it_vi ON i.id = it_vi.ingredient_id AND it_vi.language_code = 'vi'
            LEFT JOIN ingredient_translations it_en ON i.id = it_en.ingredient_id AND it_en.language_code = 'en'
            WHERE {' AND '.join(where)}
            ORDER BY i.name_key ASC
            """,
            params
        )
        return {"ingredients": cursor.fetchall()}
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.post("/ingredients")
async def create_ingredient(
    payload: IngredientCreateRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    name_key = payload.name_key.strip()
    if not name_key:
        raise HTTPException(status_code=400, detail="name_key không được để trống")

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(
            "INSERT INTO ingredients (name_key) VALUES (%s)",
            (name_key,)
        )
        conn.commit()
        return {"message": "Đã tạo nguyên liệu", "ingredient_id": cursor.lastrowid}
    except mysql.connector.Error as err:
        conn.rollback()
        if err.errno == mysql.connector.errorcode.ER_DUP_ENTRY:
            raise HTTPException(status_code=400, detail="name_key đã tồn tại")
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/ingredients/{ingredient_id}")
async def update_ingredient(
    ingredient_id: int,
    payload: IngredientUpdateRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    name_key = payload.name_key.strip()
    if not name_key:
        raise HTTPException(status_code=400, detail="name_key không được để trống")

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_ingredient_exists(cursor, ingredient_id)
        cursor.execute(
            "UPDATE ingredients SET name_key = %s WHERE id = %s",
            (name_key, ingredient_id)
        )
        conn.commit()
        return {"message": "Đã cập nhật nguyên liệu", "ingredient_id": ingredient_id}
    except mysql.connector.Error as err:
        conn.rollback()
        if err.errno == mysql.connector.errorcode.ER_DUP_ENTRY:
            raise HTTPException(status_code=400, detail="name_key đã tồn tại")
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.delete("/ingredients/{ingredient_id}")
async def delete_ingredient(
    ingredient_id: int,
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_ingredient_exists(cursor, ingredient_id)
        cursor.execute(
            "SELECT COUNT(*) AS cnt FROM dish_ingredients WHERE ingredient_id = %s",
            (ingredient_id,)
        )
        usage = cursor.fetchone()
        if usage and usage["cnt"] > 0:
            raise HTTPException(status_code=400, detail="Nguyên liệu đang được sử dụng, không thể xóa")

        cursor.execute("DELETE FROM ingredients WHERE id = %s", (ingredient_id,))
        conn.commit()
        return {"message": "Đã xóa nguyên liệu", "ingredient_id": ingredient_id}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/ingredients/{ingredient_id}/translations/{language_code}")
async def upsert_ingredient_translation(
    ingredient_id: int,
    language_code: str,
    payload: IngredientTranslationRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    lang = _validate_language_code(language_code)

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_ingredient_exists(cursor, ingredient_id)
        cursor.execute(
            """
            INSERT INTO ingredient_translations (ingredient_id, language_code, name)
            VALUES (%s, %s, %s)
            ON DUPLICATE KEY UPDATE name = VALUES(name)
            """,
            (ingredient_id, lang, payload.name)
        )
        conn.commit()
        return {"message": "Đã cập nhật bản dịch nguyên liệu", "ingredient_id": ingredient_id, "language": lang}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


# ---------- DISH INGREDIENT LINKS ----------

@router.get("/dishes/{dish_id}/ingredients")
async def get_dish_ingredients(
    dish_id: int,
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_dish_exists(cursor, dish_id)
        cursor.execute(
            """
            SELECT di.ingredient_id, di.quantity,
                   it_vi.name AS name_vi,
                   it_en.name AS name_en,
                   i.name_key
            FROM dish_ingredients di
            JOIN ingredients i ON di.ingredient_id = i.id
            LEFT JOIN ingredient_translations it_vi ON i.id = it_vi.ingredient_id AND it_vi.language_code = 'vi'
            LEFT JOIN ingredient_translations it_en ON i.id = it_en.ingredient_id AND it_en.language_code = 'en'
            WHERE di.dish_id = %s
            ORDER BY di.ingredient_id ASC
            """,
            (dish_id,)
        )
        return {"items": cursor.fetchall()}
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.post("/dishes/{dish_id}/ingredients")
async def link_ingredient_to_dish(
    dish_id: int,
    payload: DishIngredientLinkRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    if not payload.quantity.strip():
        raise HTTPException(status_code=400, detail="Số lượng không được để trống")

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_dish_exists(cursor, dish_id)
        _ensure_ingredient_exists(cursor, payload.ingredient_id)
        cursor.execute(
            """
            INSERT INTO dish_ingredients (dish_id, ingredient_id, quantity)
            VALUES (%s, %s, %s)
            ON DUPLICATE KEY UPDATE quantity = VALUES(quantity)
            """,
            (dish_id, payload.ingredient_id, payload.quantity.strip())
        )
        conn.commit()
        return {"message": "Đã cập nhật nguyên liệu cho món", "dish_id": dish_id}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/dishes/{dish_id}/ingredients/{ingredient_id}")
async def update_dish_ingredient(
    dish_id: int,
    ingredient_id: int,
    payload: DishIngredientLinkRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    quantity = payload.quantity.strip()
    if not quantity:
        raise HTTPException(status_code=400, detail="Số lượng không được để trống")

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_dish_exists(cursor, dish_id)
        _ensure_ingredient_exists(cursor, ingredient_id)
        cursor.execute(
            """
            UPDATE dish_ingredients
            SET quantity = %s
            WHERE dish_id = %s AND ingredient_id = %s
            """,
            (quantity, dish_id, ingredient_id)
        )
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Nguyên liệu chưa được liên kết với món")
        conn.commit()
        return {"message": "Đã cập nhật số lượng nguyên liệu", "dish_id": dish_id}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.delete("/dishes/{dish_id}/ingredients/{ingredient_id}")
async def remove_dish_ingredient(
    dish_id: int,
    ingredient_id: int,
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_dish_exists(cursor, dish_id)
        cursor.execute(
            "DELETE FROM dish_ingredients WHERE dish_id = %s AND ingredient_id = %s",
            (dish_id, ingredient_id)
        )
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="Liên kết nguyên liệu không tồn tại")
        conn.commit()
        return {"message": "Đã xóa nguyên liệu khỏi món", "dish_id": dish_id}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


# ---------- INSTRUCTIONS MANAGEMENT ----------

@router.get("/dishes/{dish_id}/instructions")
async def get_instructions(
    dish_id: int,
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_dish_exists(cursor, dish_id)
        cursor.execute(
            """
            SELECT ins.id, ins.step_number, ins.image_url,
                   inst_vi.description AS description_vi,
                   inst_en.description AS description_en
            FROM instructions ins
            LEFT JOIN instruction_translations inst_vi ON ins.id = inst_vi.instruction_id AND inst_vi.language_code = 'vi'
            LEFT JOIN instruction_translations inst_en ON ins.id = inst_en.instruction_id AND inst_en.language_code = 'en'
            WHERE ins.dish_id = %s
            ORDER BY ins.step_number ASC, ins.id ASC
            """,
            (dish_id,)
        )
        return {"instructions": cursor.fetchall()}
    except mysql.connector.Error as err:
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.post("/dishes/{dish_id}/instructions")
async def create_instruction(
    dish_id: int,
    payload: InstructionCreateRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_dish_exists(cursor, dish_id)
        step_number = payload.step_number
        if step_number is None:
            cursor.execute(
                "SELECT COALESCE(MAX(step_number), 0) + 1 AS next_step FROM instructions WHERE dish_id = %s",
                (dish_id,)
            )
            row = cursor.fetchone()
            step_number = row["next_step"] if row else 1

        cursor.execute(
            """
            INSERT INTO instructions (dish_id, step_number, image_url)
            VALUES (%s, %s, %s)
            """,
            (dish_id, step_number, payload.image_url)
        )
        conn.commit()
        return {"message": "Đã thêm bước hướng dẫn", "instruction_id": cursor.lastrowid}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/dishes/{dish_id}/instructions/{instruction_id}")
async def update_instruction(
    dish_id: int,
    instruction_id: int,
    payload: InstructionUpdateRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    if payload.step_number is None and payload.image_url is None:
        raise HTTPException(status_code=400, detail="Không có dữ liệu để cập nhật")

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_instruction(cursor, instruction_id, dish_id)
        parts = []
        params = []
        if payload.step_number is not None:
            parts.append("step_number = %s")
            params.append(payload.step_number)
        if payload.image_url is not None:
            parts.append("image_url = %s")
            params.append(payload.image_url)

        params.extend([instruction_id, dish_id])
        cursor.execute(
            f"""
            UPDATE instructions
            SET {', '.join(parts)}
            WHERE id = %s AND dish_id = %s
            """,
            params
        )
        conn.commit()
        return {"message": "Đã cập nhật bước hướng dẫn", "instruction_id": instruction_id}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/dishes/{dish_id}/instructions/{instruction_id}/translations/{language_code}")
async def update_instruction_translation(
    dish_id: int,
    instruction_id: int,
    language_code: str,
    payload: InstructionTranslationRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    lang = _validate_language_code(language_code)

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_instruction(cursor, instruction_id, dish_id)
        cursor.execute(
            """
            INSERT INTO instruction_translations (instruction_id, language_code, description)
            VALUES (%s, %s, %s)
            ON DUPLICATE KEY UPDATE description = VALUES(description)
            """,
            (instruction_id, lang, payload.description)
        )
        conn.commit()
        return {"message": "Đã cập nhật bản dịch bước hướng dẫn", "instruction_id": instruction_id, "language": lang}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.put("/dishes/{dish_id}/instructions/reorder")
async def reorder_instructions(
    dish_id: int,
    payload: InstructionReorderRequest,
    admin_user: str = Depends(get_current_admin_user)
):
    if not payload.steps:
        raise HTTPException(status_code=400, detail="Danh sách bước rỗng")

    ids = [item.instruction_id for item in payload.steps]
    if len(ids) != len(set(ids)):
        raise HTTPException(status_code=400, detail="instruction_id bị trùng")

    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_dish_exists(cursor, dish_id)
        placeholders = ",".join(["%s"] * len(ids))
        cursor.execute(
            f"""
            SELECT id FROM instructions
            WHERE dish_id = %s AND id IN ({placeholders})
            """,
            [dish_id] + ids
        )
        found_ids = {row["id"] for row in cursor.fetchall()}
        missing = set(ids) - found_ids
        if missing:
            raise HTTPException(status_code=404, detail=f"Có bước không thuộc món: {missing}")

        for item in payload.steps:
            cursor.execute(
                "UPDATE instructions SET step_number = %s WHERE id = %s AND dish_id = %s",
                (item.step_number, item.instruction_id, dish_id)
            )
        conn.commit()
        return {"message": "Đã cập nhật thứ tự các bước"}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()


@router.delete("/dishes/{dish_id}/instructions/{instruction_id}")
async def delete_instruction(
    dish_id: int,
    instruction_id: int,
    admin_user: str = Depends(get_current_admin_user)
):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        _ensure_instruction(cursor, instruction_id, dish_id)
        cursor.execute(
            "DELETE FROM instructions WHERE id = %s AND dish_id = %s",
            (instruction_id, dish_id)
        )
        conn.commit()
        return {"message": "Đã xóa bước hướng dẫn", "instruction_id": instruction_id}
    except mysql.connector.Error as err:
        conn.rollback()
        raise HTTPException(status_code=500, detail=f"Lỗi database: {err.msg}")
    finally:
        cursor.close()
        conn.close()

