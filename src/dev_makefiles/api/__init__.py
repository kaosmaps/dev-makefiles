# src/dev_makefiles/api/__init__.py
from fastapi import FastAPI
from dev_makefiles.core.config import settings
from .v1.api import api_router as api_router_v1
from .v2.api import api_router as api_router_v2

api_app = FastAPI(title=settings.PROJECT_NAME, openapi_url=f"{settings.API_V1_STR}/openapi.json")

api_app.include_router(api_router_v1, prefix=settings.API_V1_STR)
api_app.include_router(api_router_v2, prefix="/v2")

@api_app.get("/")
def root():
    return {"message": "Welcome to dev-makefiles API. See /docs for API documentation."}

__all__ = ["api_app"]
