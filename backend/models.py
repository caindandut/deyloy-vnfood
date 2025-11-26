from pydantic import BaseModel
from typing import Optional

class UserCreate(BaseModel):
    username: str
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: Optional[str] = None

class SaveHistoryRequest(BaseModel):
    dish_id: int

class FavoriteCreate(BaseModel):
    dish_id: int

class FavoriteResponse(BaseModel):
    id: int
    dish_id: int
    created_at: str

class ShoppingListCreate(BaseModel):
    name: Optional[str] = "Danh sách mua sắm"

class ShoppingListItemCreate(BaseModel):
    ingredient_id: Optional[int] = None
    ingredient_name: Optional[str] = None
    quantity: str = ""
    is_checked: Optional[bool] = False

class AddDishToShoppingList(BaseModel):
    list_id: int
    dish_id: int

