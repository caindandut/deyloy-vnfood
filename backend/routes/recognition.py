from fastapi import APIRouter, File, UploadFile, HTTPException, Depends
from typing import Optional

try:
    from ..database import get_db_connection
    from ..auth import get_current_user_optional
    from ..utils.image_processing import predict_pytorch
    from ..utils.database_queries import get_food_details
except ImportError:
    from backend.database import get_db_connection
    from backend.auth import get_current_user_optional
    from backend.utils.image_processing import predict_pytorch
    from backend.utils.database_queries import get_food_details

router = APIRouter()

@router.post("/predict")
async def predict(
    file: UploadFile = File(...),
    language: str = 'vi',
    current_user: Optional[str] = Depends(get_current_user_optional)
):
    try:
        from ..config import BLUR_THRESHOLD
    except ImportError:
        from backend.config import BLUR_THRESHOLD
    
    image_bytes = await file.read()
    class_id, confidence_score = predict_pytorch(image_bytes)

    if class_id == -1:
         raise HTTPException(status_code=500, detail="Lỗi xử lý ảnh hoặc dự đoán.")
    if class_id == -2 or class_id == -3:
         if class_id == -2: print("LỖI: Độ tin cậy thấp (< 0.5)")
         if class_id == -3: print(f"LỖI: Ảnh quá mờ (Variance < {BLUR_THRESHOLD})")
         raise HTTPException(status_code=400, detail="Nhận diện thất bại. Vui lòng chụp ảnh lại.")

    conn = get_db_connection()
    if not conn:
         raise HTTPException(status_code=500, detail="Không thể kết nối database")

    cursor = conn.cursor(dictionary=True)
    try:
        result = get_food_details(class_id, cursor, language)
        result['confidence'] = round(confidence_score * 100, 2)
        
        # Tự động lưu vào history nếu user đã đăng nhập
        if current_user:
            try:
                dish_id = result['dish']['id']
                cursor.execute("SELECT id FROM users WHERE username = %s", (current_user,))
                user_db = cursor.fetchone()
                if user_db:
                    user_id = user_db['id']
                    # Tự động lưu vào history (không cần user phải click "Lưu")
                    # Check xem đã có trong vòng 10 giây gần đây chưa để tránh duplicate khi nhận diện liên tục
                    cursor.execute(
                        """
                        SELECT id FROM history 
                        WHERE user_id = %s AND dish_id = %s 
                        AND recognized_at >= DATE_SUB(NOW(), INTERVAL 10 SECOND)
                        LIMIT 1
                        """,
                        (user_id, dish_id)
                    )
                    recent_entry = cursor.fetchone()
                    
                    if not recent_entry:
                        # Chưa có trong 10 giây gần đây, lưu mới
                        cursor.execute("SELECT MAX(id) FROM history")
                        row = cursor.fetchone()
                        next_id = (row['MAX(id)'] or 0) + 1
                        cursor.execute(
                            "INSERT INTO history (id, user_id, dish_id) VALUES (%s, %s, %s)",
                            (next_id, user_id, dish_id)
                        )
                        conn.commit()
            except Exception as e:
                # Don't fail the request if logging fails, just print error
                print(f"Lỗi khi tự động lưu vào history: {e}")
                conn.rollback()
        
        return result

    except HTTPException as e:
         raise e
    except Exception as e:
         print(f"Lỗi truy vấn database: {e}")
         raise HTTPException(status_code=500, detail="Lỗi truy vấn database.")
    finally:
         if cursor: cursor.close()
         if conn: conn.close()

@router.get("/capture_from_pi")
async def capture_from_pi():
    import httpx
    try:
        from ..config import PI_API_URL
    except ImportError:
        from backend.config import PI_API_URL
    
    try:
        async with httpx.AsyncClient(timeout=10.0) as client:
            response = await client.get(f"{PI_API_URL}/capture")
            if response.status_code == 200:
                from fastapi.responses import Response
                return Response(
                    content=response.content,
                    media_type="image/jpeg",
                    headers={
                        "Access-Control-Allow-Origin": "*",
                        "Content-Disposition": "inline; filename=capture.jpg"
                    }
                )
            else:
                raise HTTPException(
                    status_code=response.status_code,
                    detail=f"Lỗi khi capture từ Raspberry Pi: {response.text}"
                )
    except httpx.TimeoutException:
        raise HTTPException(status_code=504, detail="Raspberry Pi không phản hồi (timeout)")
    except httpx.ConnectError:
        raise HTTPException(status_code=503, detail="Không thể kết nối đến Raspberry Pi")
    except Exception as e:
        print(f"Lỗi khi gọi Raspberry Pi capture: {e}")
        raise HTTPException(status_code=500, detail=f"Lỗi khi capture: {str(e)}")

