"""A simple webapp API"""
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    """Root HTTP address"""
    return { "message": "Hello, world!" }

# pylint: disable=invalid-name
@app.get("/items/{item_id}")
def read_item(item_id: int, q: str = None):
    """Just returns the item_id and query parameter q"""
    return {"item_id": item_id, "q": q}
