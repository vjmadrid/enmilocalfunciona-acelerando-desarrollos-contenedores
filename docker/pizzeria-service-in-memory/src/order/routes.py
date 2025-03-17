from fastapi import APIRouter, HTTPException
from typing import List, Dict
from .models import Order
from src.pizza.routes import pizzas
#from services import calculate_total_price

router = APIRouter(prefix="/orders", tags=["Orders"])

# Memory configuration
orders: Dict[int, Order] = {}

# Endpoints CRUD for orders
@router.get("/", response_model=List[Order], summary="Listar todos los pedidos", description="Devuelve una lista con todos los pedidos realizados.")
def list_orders():
    return list(orders.values())

@router.get("/{order_id}", response_model=Order, summary="Obtener detalles de un pedido", description="Devuelve los detalles de un pedido específico por su ID.")
def get_order(order_id: int):
    if order_id not in orders:
        raise HTTPException(status_code=404, detail="Pedido no encontrado")
    return orders[order_id]

@router.post("/", response_model=Order, summary="Crear un nuevo pedido", description="Crea un nuevo pedido con una lista de pizzas y sus cantidades.")
def create_order(order: Order):
    if order.id in orders:
        raise HTTPException(status_code=400, detail="El pedido ya existe")
    total_price = 0.0
    for item in order.items:
        if item.pizza_id not in pizzas:
            raise HTTPException(status_code=404, detail=f"Pizza {item.pizza_id} no encontrada")
        if pizzas[item.pizza_id].stock < item.quantity:
            raise HTTPException(status_code=400, detail=f"La pizza con {item.pizza_id} no tiene stock")
        pizzas[item.pizza_id].stock -= item.quantity
        total_price += pizzas[item.pizza_id].price * item.quantity
    order.total_price = total_price
    orders[order.id] = order
    return order

@router.delete("/orders/{order_id}", summary="Eliminar un pedido", description="Elimina un pedido de la pizzería por su ID.")
def delete_order(order_id: int):
    if order_id not in orders:
        raise HTTPException(status_code=404, detail="Pedido no encontrado")
    del orders[order_id]
    return {"message": "Pedido eliminado"}