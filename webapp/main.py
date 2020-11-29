"""A simple webapp API"""
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def root():
    """Root HTTP address"""
    return { "message": "Hello, world!" }
