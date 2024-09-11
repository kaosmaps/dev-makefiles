# src/dev_makefiles/api/v1/routes/users.py
from fastapi import APIRouter, Depends

from dev_makefiles.api.v1.dependencies.auth import get_current_user
from dev_makefiles.api.v1.models.user import User, UserCreate, UserUpdate

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
