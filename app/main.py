from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from pathlib import Path
from core.config import settings
from loguru import logger
import sys

logger.remove()
logger.add(sys.stdout, format="{time} {level} {message}")

app = FastAPI(title=settings.PROJECT_NAME)

app.add_middleware(
    CORSMiddleware,
    allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def ok(request: Request):
    logger.debug("OK")
    return "OK"

@app.get("/healthz")
async def ok():
    return "OK"
