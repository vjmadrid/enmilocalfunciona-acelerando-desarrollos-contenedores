from pydantic import BaseModel
from typing import List

class Pizza(BaseModel):
    id: int
    name: str
    price: float
    stock: int
    ingredients: List[str]
