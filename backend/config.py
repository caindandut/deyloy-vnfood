import os
from dotenv import load_dotenv

# Load biến môi trường từ file .env nếu có (cho môi trường local)
load_dotenv()

SECRET_KEY = os.getenv("SECRET_KEY", "day-la-khoa-bi-mat-rat-manh-cua-toi-hay-thay-doi-no")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60 * 24 * 7

DB_CONFIG = {
    'host': os.getenv("DB_HOST", "gateway01.ap-southeast-1.prod.aws.tidbcloud.com"),
    'port': int(os.getenv("DB_PORT", 4000)),
    'user': os.getenv("DB_USER", "VZpmDrzDCBNd3Xq.root"),
    'password': os.getenv("DB_PASSWORD", "n7IoUj1s7rCXfDab"),
    'database': os.getenv("DB_NAME", "vnfood"),
    'ssl_ca': os.path.join(os.path.dirname(os.path.abspath(__file__)), 'isrgrootx1.pem'),
    'ssl_disabled': False
    # 'host': os.getenv("DB_HOST", "localhost"),
    # 'port': int(os.getenv("DB_PORT", 3306)),
    # 'user': os.getenv("DB_USER", "root"),
    # 'password': os.getenv("DB_PASSWORD", "Ledangkhanh@2005"),
    # 'database': os.getenv("DB_NAME", "vnfood"),
    # 'ssl_ca': None,
    # 'ssl_disabled': True
}

PI_ADDRESS = "192.168.1.5" # 172.20.10.9
PI_API_URL = f"http://{PI_ADDRESS}:8000"

BLUR_THRESHOLD = 100.0
CONFIDENCE_THRESHOLD = 0.7

MODEL_PATH = "model_traced.pt"

