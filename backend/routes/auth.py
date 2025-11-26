from fastapi import APIRouter, HTTPException, Depends
from fastapi.security import OAuth2PasswordRequestForm
import mysql.connector

try:
    from ..models import UserCreate, Token
    from ..database import get_db_connection
    from ..auth import (
        hash_password, 
        verify_password, 
        create_access_token, 
        get_current_user_required,
        ACCESS_TOKEN_EXPIRE_MINUTES
    )
except ImportError:
    from backend.models import UserCreate, Token
    from backend.database import get_db_connection
    from backend.auth import (
        hash_password, 
        verify_password, 
        create_access_token, 
        get_current_user_required,
        ACCESS_TOKEN_EXPIRE_MINUTES
    )
from datetime import timedelta

router = APIRouter()

@router.post("/register")
async def register(user: UserCreate):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM users WHERE username = %s", (user.username,))
    if cursor.fetchone():
        cursor.close()
        conn.close()
        raise HTTPException(status_code=400, detail="Tên đăng nhập đã tồn tại")

    hashed_pass = hash_password(user.password)

    try:
        # Manual ID generation because TiDB migration might have missed AUTO_INCREMENT
        cursor.execute("SELECT MAX(id) FROM users")
        row = cursor.fetchone()
        next_id = (row['MAX(id)'] or 0) + 1
        
        cursor.execute("INSERT INTO users (id, username, hashed_password) VALUES (%s, %s, %s)", (next_id, user.username, hashed_pass))
        conn.commit()
    except mysql.connector.Error as err:
        print(f"Lỗi khi đăng ký: {err}")
        raise HTTPException(status_code=500, detail="Lỗi server khi tạo tài khoản")
    finally:
        cursor.close()
        conn.close()

    return {"message": "Tạo tài khoản thành công"}

@router.post("/login", response_model=Token)
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    conn = get_db_connection()
    if not conn:
        raise HTTPException(status_code=500, detail="Không thể kết nối database")
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM users WHERE username = %s", (form_data.username,))
    user_db = cursor.fetchone()
    cursor.close()
    conn.close()

    if not user_db or not verify_password(form_data.password, user_db['hashed_password']):
        raise HTTPException(status_code=401, detail="Sai tên đăng nhập hoặc mật khẩu")

    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user_db['username']}, expires_delta=access_token_expires
    )

    return {"access_token": access_token, "token_type": "bearer"}

@router.get("/me")
async def read_users_me(current_user: str = Depends(get_current_user_required)):
    return {"username": current_user}

