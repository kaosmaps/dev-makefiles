# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .create-module-api

define API_STRUCTURE
mkdir -p $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/{v1,v2}/{routes,models,dependencies}
touch $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/__init__.py \
      $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/__init__.py \
      $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v2/__init__.py
endef
export API_STRUCTURE

.create-module-api:
	@echo "Creating API structure and files..."
	@$(API_STRUCTURE)
	@echo "$$API_INIT_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/__init__.py
	@echo "$$API_V1_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/api.py
	@echo "$$API_V2_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v2/api.py
	@echo "$$API_USERS_ROUTE_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/routes/users.py
	@echo "$$API_ITEMS_ROUTE_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/routes/items.py
	@echo "$$API_USER_MODEL_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/models/user.py
	@echo "$$API_ITEM_MODEL_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/models/item.py
	@echo "$$API_AUTH_CONTENT" > $(TARGET_DIR)/$(SRC_DIR)/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/dependencies/auth.py

define API_INIT_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/__init__.py
from fastapi import FastAPI
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).core.config import settings
from .v1.api import api_router as api_router_v1
from .v2.api import api_router as api_router_v2

api_app = FastAPI(title=settings.PROJECT_NAME, openapi_url=f"{settings.API_V1_STR}/openapi.json")

api_app.include_router(api_router_v1, prefix=settings.API_V1_STR)
api_app.include_router(api_router_v2, prefix="/v2")

@api_app.get("/")
def root():
    return {"message": "Welcome to $(SAUBER_PACKAGE_NAME) API. See /docs for API documentation."}

__all__ = ["api_app"]
endef
export API_INIT_CONTENT

define API_V1_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/api.py
from fastapi import APIRouter
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).api.v1.routes import users, items

api_router = APIRouter()
api_router.include_router(users.router, prefix="/users", tags=["users"])
api_router.include_router(items.router, prefix="/items", tags=["items"])
endef
export API_V1_CONTENT

define API_V2_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v2/api.py
from fastapi import APIRouter

api_router = APIRouter()

@api_router.get("/")
def read_root():
    return {"message": "Welcome to API v2"}
endef
export API_V2_CONTENT

define API_USERS_ROUTE_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/routes/users.py
from fastapi import APIRouter, Depends

from $(subst -,_,$(SAUBER_PACKAGE_NAME)).api.v1.dependencies.auth import get_current_user
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).api.v1.models.user import User, UserCreate, UserUpdate

router = APIRouter()

@router.get("/", response_model=list[User])
def read_users():
    return [{"id": 1, "email": "user@example.com", "is_active": True}]

@router.post("/", response_model=User, status_code=201)
def create_user(user: UserCreate):
    return {"id": 1, **user.dict()}

@router.get("/me", response_model=User)
def read_user_me(current_user: User = Depends(get_current_user)):
    return current_user

@router.put("/me", response_model=User)
def update_user_me(user: UserUpdate, current_user: User = Depends(get_current_user)):
    return {**current_user.dict(), **user.dict(exclude_unset=True)}
endef
export API_USERS_ROUTE_CONTENT

define API_ITEMS_ROUTE_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/routes/items.py
from fastapi import APIRouter, Depends

from $(subst -,_,$(SAUBER_PACKAGE_NAME)).api.v1.dependencies.auth import get_current_user
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).api.v1.models.item import Item, ItemCreate

router = APIRouter()

@router.get("/", response_model=list[Item])
def read_items():
    return [{"id": 1, "name": "Example Item", "description": "This is an example item", "price": 9.99, "tax": 0.2}]

@router.post("/", response_model=Item, status_code=201)
def create_item(item: ItemCreate, current_user: dict = Depends(get_current_user)):
    return {"id": 1, **item.dict()}

@router.get("/{item_id}", response_model=Item)
def read_item(item_id: int):
    return {"id": item_id, "name": "Example Item", "description": "This is an example item", "price": 9.99, "tax": 0.2}
endef
export API_ITEMS_ROUTE_CONTENT

define API_USER_MODEL_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/models/user.py
from pydantic import BaseModel, ConfigDict

class UserBase(BaseModel):
    email: str
    is_active: bool = True

class UserCreate(UserBase):
    password: str

class UserUpdate(UserBase):
    password: str | None = None

class User(UserBase):
    id: int

    model_config = ConfigDict(from_attributes=True)
endef
export API_USER_MODEL_CONTENT

define API_ITEM_MODEL_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/models/item.py
from pydantic import BaseModel, ConfigDict

class ItemBase(BaseModel):
    name: str
    description: str | None = None
    price: float
    tax: float | None = None

class ItemCreate(ItemBase):
    pass

class Item(ItemBase):
    id: int

    model_config = ConfigDict(from_attributes=True)
endef
export API_ITEM_MODEL_CONTENT

define API_AUTH_CONTENT
# src/$(subst -,_,$(SAUBER_PACKAGE_NAME))/api/v1/dependencies/auth.py
from fastapi import Depends
from fastapi.security import OAuth2PasswordBearer
from $(subst -,_,$(SAUBER_PACKAGE_NAME)).api.v1.models.user import User

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

async def get_current_user(token: str = Depends(oauth2_scheme)):
    # This is a placeholder implementation. In a real app, you'd verify the token
    # and fetch the user from a database.
    user = User(id=1, email="user@example.com", is_active=True)
    return user
endef
export API_AUTH_CONTENT
