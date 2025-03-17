from pydantic import BaseModel
from typing import List
from datetime import datetime

class OrderItem(BaseModel):
    pizza_id: int
    quantity: int

class Order(BaseModel):
    id: int
    items: List[OrderItem]
    total_price: float = 0.0
    date: datetime = datetime.now()