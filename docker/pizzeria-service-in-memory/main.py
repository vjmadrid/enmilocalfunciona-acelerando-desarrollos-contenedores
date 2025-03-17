from fastapi import FastAPI
import uvicorn
from src.management import routes as management_routes
from src.pizza import routes as pizza_routes
from src.order import routes as order_routes


app = FastAPI(title="Pizzería API", description="Una API en memoria que simula una pizzería online", version="1.0")

# Include routes
app.include_router(management_routes.router)
app.include_router(pizza_routes.router)
app.include_router(order_routes.router)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)