# src/dev_makefiles/api/v2/api.py
from fastapi import APIRouter

api_router = APIRouter()

@api_router.get("/")
def read_root():
    return {"message": "Welcome to API v2"}
