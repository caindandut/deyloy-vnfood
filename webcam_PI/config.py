import logging

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger(__name__)

CAMERA_DEVICE = "/dev/video0"
FRAME_WIDTH = 640
FRAME_HEIGHT = 480
FPS = 10
JPEG_QUALITY = 95
WARMUP_FRAMES = 10
MAX_RETRIES = 3
MAX_STREAM_ERRORS = 10

WEBCAM_CONFIG = {
    "white_balance_automatic": 0,
    "white_balance_temperature": 4500,
    "auto_exposure": 1,
    "exposure_time_absolute": 200,
    "gain": 12,
    "sharpness": 14,
    "contrast": 55,
    "saturation": 75,
    "gamma": 120,
    "brightness": 128,
    "backlight_compensation": 1
}

