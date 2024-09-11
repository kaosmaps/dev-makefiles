# src/dev_makefiles/api/v1/api.py
from fastapi import APIRouter
from dev_makefiles.api.v1.routes import users, items

api_router = APIRouter()
api_router.include_router(users.router, prefix="/users", tags=["users"])
api_router.include_router(items.router, prefix="/items", tags=["items"])
