from fastapi import APIRouter

router = APIRouter()

@router.get("/isAlive")
def is_alive():
    return {"status": "alive"}

@router.get("/version")
def get_version():
    return {"version": "1.0"}