from pydantic import BaseModel
from typing import Optional, List

class UserCreate(BaseModel):
    username: str
    password: str

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: Optional[str] = None

class DishUpdateRequest(BaseModel):
    image_url: Optional[str] = None
    video_url: Optional[str] = None

class DishTranslationUpdateRequest(BaseModel):
    name: str
    description: Optional[str] = None
    region_info: Optional[str] = None

class IngredientCreateRequest(BaseModel):
    name_key: str

class IngredientUpdateRequest(BaseModel):
    name_key: str

class IngredientTranslationRequest(BaseModel):
    name: str

class DishIngredientLinkRequest(BaseModel):
    ingredient_id: int
    quantity: str

class InstructionCreateRequest(BaseModel):
    step_number: Optional[int] = None
    image_url: Optional[str] = None

class InstructionUpdateRequest(BaseModel):
    step_number: Optional[int] = None
    image_url: Optional[str] = None

class InstructionTranslationRequest(BaseModel):
    description: str

class InstructionOrderItem(BaseModel):
    instruction_id: int
    step_number: int

class InstructionReorderRequest(BaseModel):
    steps: List[InstructionOrderItem]

class UserRoleUpdateRequest(BaseModel):
    role: str

class UserStatusUpdateRequest(BaseModel):
    is_active: bool

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

