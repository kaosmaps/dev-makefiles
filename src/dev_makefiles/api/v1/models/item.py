# src/dev_makefiles/api/v1/models/item.py
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
