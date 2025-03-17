from fastapi import APIRouter, HTTPException
from .models import Pizza
from typing import List, Dict

router = APIRouter(prefix="/pizzas", tags=["Pizzas"])

# Memory Configuration
pizzas: Dict[int, Pizza] = {
    1: Pizza(id=1, name="Margarita", price=8.5, stock=10, ingredients=["Tomate", "Mozzarella", "Albahaca"]),
    2: Pizza(id=2, name="Pepperoni", price=9.0, stock=10, ingredients=["Tomate", "Mozzarella", "Pepperoni"]),
    3: Pizza(id=3, name="Cuatro Quesos", price=10.0, stock=10, ingredients=["Tomate", "Mozzarella", "Gorgonzola", "Parmesano", "Cheddar"]),
    4: Pizza(id=4, name="Hawaiana", price=9.5, stock=10, ingredients=["Tomate", "Mozzarella", "Jamón", "Piña"]),
    5: Pizza(id=5, name="BBQ Chicken", price=11.0, stock=10, ingredients=["Salsa BBQ", "Mozzarella", "Pollo", "Cebolla"]),
    6: Pizza(id=6, name="Vegetariana", price=9.0, stock=10, ingredients=["Tomate", "Mozzarella", "Pimientos", "Champiñones", "Aceitunas"]),
}

@router.get("/", response_model=List[Pizza], summary="Listar todas las pizzas", description="Devuelve una lista con todas las pizzas disponibles en la pizzería.")
def list_pizzas():
    return list(pizzas.values())

@router.get("/{pizza_id}", response_model=Pizza, summary="Obtener detalles de una pizza", description="Devuelve los detalles de una pizza específica por su ID.")
def get_pizza(pizza_id: int):
    if pizza_id not in pizzas:
        raise HTTPException(status_code=404, detail="Pizza no encontrada")
    return pizzas[pizza_id]

# Endpoints CRUD for pizzas
@router.post("/", response_model=Pizza, summary="Crear una nueva pizza", description="Añade una nueva pizza al menú con su nombre, precio, stock y lista de ingredientes.")
def create_pizza(pizza: Pizza):
    if pizza.id in pizzas:
        raise HTTPException(status_code=400, detail="El ID de la Pizza ya existe")
    pizzas[pizza.id] = pizza
    return pizza

@router.put("/{pizza_id}", response_model=Pizza, summary="Actualizar una pizza", description="Actualiza los datos de una pizza existente, incluyendo su nombre, precio, stock e ingredientes.")
def update_pizza(pizza_id: int, updated_pizza: Pizza):
    if pizza_id not in pizzas:
        raise HTTPException(status_code=404, detail="Pizza no encontrada")
    pizzas[pizza_id] = updated_pizza
    return updated_pizza

@router.delete("/{pizza_id}", summary="Eliminar una pizza", description="Elimina una pizza del menú por su ID.")
def delete_pizza(pizza_id: int):
    if pizza_id not in pizzas:
        raise HTTPException(status_code=404, detail="Pizza no encontrada")
    del pizzas[pizza_id]
    return {"message": "Pizza eliminada"}