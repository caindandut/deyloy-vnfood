import uvicorn
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from config import logger
from camera import get_video_capture, release_camera
from routes import video_feed, capture, health

app = FastAPI(
    title="Raspberry Pi Webcam Service",
    description="Service điều khiển webcam, stream video và capture ảnh",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.get("/video_feed")(video_feed)
app.get("/capture")(capture)
app.get("/health")(health)

@app.on_event("shutdown")
async def shutdown_event():
    """Giải phóng webcam khi server shutdown"""
    release_camera()

@app.on_event("startup")
async def startup_event():
    """Khởi tạo webcam khi server startup"""
    logger.info("Khởi động Raspberry Pi Webcam Service...")
    try:
        get_video_capture()
    except Exception as e:
        logger.warning(f"Không thể khởi tạo webcam lúc startup: {e}")
        logger.info("Webcam sẽ được khởi tạo khi có request đầu tiên")

if __name__ == "__main__":
    print("=" * 60)
    print("Raspberry Pi Webcam Service")
    print("Service chỉ điều khiển webcam, stream và capture")
    print("Backend chính chạy trên laptop để giảm tải CPU")
    print("=" * 60)
    uvicorn.run(
        app,
        host="0.0.0.0",
        port=8000,
        log_level="info"
    )
