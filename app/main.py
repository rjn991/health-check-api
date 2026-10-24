from datetime import datetime, timezone

from fastapi import FastAPI

app = FastAPI(title="Platform Status API", version="1.0.0")


@app.get("/")
def home():
    return {
        "message": "Platform Status API is running"
    }


@app.get("/health")
def health():
    return {
        "status": "healthy",
        "timestamp": datetime.now(timezone.utc).isoformat()
    }
