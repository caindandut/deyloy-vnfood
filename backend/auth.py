from fastapi import HTTPException, Depends, Header
from fastapi.security import OAuth2PasswordBearer
from typing import Optional
# from passlib.context import CryptContext
from jose import JWTError, jwt
from datetime import datetime, timedelta, timezone

from .config import SECRET_KEY, ALGORITHM, ACCESS_TOKEN_EXPIRE_MINUTES
from .database import get_db_connection

import bcrypt

# pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto") # Removed passlib
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")


def _get_user_record(username: str):
    conn = get_db_connection()
    if not conn:
        return None
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(
            "SELECT id, username, role, is_active, created_at FROM users WHERE username = %s",
            (username,)
        )
        return cursor.fetchone()
    finally:
        cursor.close()
        conn.close()


def get_user_profile(username: str):
    return _get_user_record(username)


def is_admin_user(username: Optional[str]) -> bool:
    if not username:
        return False
    record = _get_user_record(username)
    if not record:
        return False
    return (record.get("role") or "").lower() == "admin"

def verify_password(plain_password, hashed_password):
    if isinstance(plain_password, str):
        plain_password = plain_password.encode('utf-8')
    if isinstance(hashed_password, str):
        hashed_password = hashed_password.encode('utf-8')
    return bcrypt.checkpw(plain_password, hashed_password)

def hash_password(password):
    if isinstance(password, str):
        password = password.encode('utf-8')
    return bcrypt.hashpw(password, bcrypt.gensalt()).decode('utf-8')

def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

async def get_current_user_optional(authorization: Optional[str] = Header(None)):
    if authorization is None:
        return None

    try:
        scheme, token = authorization.split()
        if scheme.lower() != 'bearer':
            return None
    except ValueError:
        return None

    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            return None
        return username
    except JWTError:
        return None

async def get_current_user_required(authorization: Optional[str] = Header(None)):
    username = await get_current_user_optional(authorization)
    if username is None:
        raise HTTPException(
            status_code=401,
            detail="Yêu cầu đăng nhập để thực hiện hành động này",
            headers={"WWW-Authenticate": "Bearer"},
        )
    record = _get_user_record(username)
    if record is None:
        raise HTTPException(
            status_code=401,
            detail="Tài khoản không tồn tại",
            headers={"WWW-Authenticate": "Bearer"},
        )
    if not record.get("is_active", True):
        raise HTTPException(
            status_code=403,
            detail="Tài khoản đã bị khóa",
            headers={"WWW-Authenticate": "Bearer"},
        )
    return username


async def get_current_admin_user(authorization: Optional[str] = Header(None)):
    username = await get_current_user_required(authorization)
    if not is_admin_user(username):
        raise HTTPException(
            status_code=403,
            detail="Tài khoản không có quyền admin"
        )
    return username

