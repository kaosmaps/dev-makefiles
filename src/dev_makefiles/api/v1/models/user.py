# src/dev_makefiles/api/v1/models/user.py
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
