# src/dev_makefiles/api/v1/routes/items.py
from fastapi import APIRouter, Depends

from dev_makefiles.api.v1.dependencies.auth import get_current_user
from dev_makefiles.api.v1.models.item import Item, ItemCreate

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
