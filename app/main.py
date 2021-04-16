from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from core.config import settings


app = FastAPI(title=settings.PROJECT_NAME)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def ok():
    return "OK"

@app.get("/healthz")
async def ok():
    return "OK"
