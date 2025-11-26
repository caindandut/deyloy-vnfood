def get_food_details(class_id, cursor, language_code='vi'):
    from fastapi import HTTPException
    
    query_dish = """
        SELECT d.id, d.class_id, d.image_url, d.video_url, dt.name, dt.description, dt.region_info
        FROM dishes d
        LEFT JOIN dish_translations dt ON d.id = dt.dish_id AND dt.language_code = %s
        WHERE d.class_id = %s
    """
    cursor.execute(query_dish, (language_code, class_id))
    dish = cursor.fetchone()
    if not dish:
        raise HTTPException(status_code=404, detail=f"Không tìm thấy món ăn với class_id = {class_id}")
    dish_id = dish['id']

    query_ingredients = """
        SELECT it.name, di.quantity 
        FROM dish_ingredients di 
        JOIN ingredients i ON di.ingredient_id = i.id
        LEFT JOIN ingredient_translations it ON i.id = it.ingredient_id AND it.language_code = %s
        WHERE di.dish_id = %s
    """
    cursor.execute(query_ingredients, (language_code, dish_id))
    ingredients = cursor.fetchall()

    query_instructions = """
        SELECT DISTINCT ins.step_number, inst.description, ins.image_url 
        FROM instructions ins
        LEFT JOIN instruction_translations inst ON ins.id = inst.instruction_id AND inst.language_code = %s
        WHERE ins.dish_id = %s 
        ORDER BY ins.step_number ASC
    """
    cursor.execute(query_instructions, (language_code, dish_id))
    instructions = cursor.fetchall()

    return { "dish": dish, "ingredients": ingredients, "instructions": instructions }

def get_dish_ingredients(dish_id, cursor, language_code='vi'):
    query_ingredients = """
        SELECT it.name, di.quantity 
        FROM dish_ingredients di 
        JOIN ingredients i ON di.ingredient_id = i.id
        LEFT JOIN ingredient_translations it ON i.id = it.ingredient_id AND it.language_code = %s
        WHERE di.dish_id = %s
    """
    cursor.execute(query_ingredients, (language_code, dish_id))
    return cursor.fetchall()

def get_dish_instructions(dish_id, cursor, language_code='vi'):
    query_instructions = """
        SELECT DISTINCT ins.step_number, inst.description, ins.image_url
        FROM instructions ins
        LEFT JOIN instruction_translations inst ON ins.id = inst.instruction_id AND inst.language_code = %s
        WHERE ins.dish_id = %s 
        ORDER BY ins.step_number ASC
    """
    cursor.execute(query_instructions, (language_code, dish_id))
    return cursor.fetchall()

