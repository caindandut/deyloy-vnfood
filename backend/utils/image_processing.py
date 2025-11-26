import torch
from torchvision import transforms
from PIL import Image
import io
import numpy as np
import cv2
try:
    from ..config import BLUR_THRESHOLD, CONFIDENCE_THRESHOLD, MODEL_PATH
except ImportError:
    from backend.config import BLUR_THRESHOLD, CONFIDENCE_THRESHOLD, MODEL_PATH

print("Đang tải model PyTorch...")
model = torch.jit.load(MODEL_PATH, map_location="cpu")
model.eval()
print("Đã tải xong model PyTorch!")

transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize([0.485, 0.456, 0.406], [0.229, 0.224, 0.225])
])

def is_image_blurry(image_bytes: bytes, threshold: float = BLUR_THRESHOLD):
    try:
        data = np.frombuffer(image_bytes, dtype=np.uint8)
        image = cv2.imdecode(data, cv2.IMREAD_COLOR)
        gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
        variance = cv2.Laplacian(gray, cv2.CV_64F).var()
        print(f"DEBUG: Độ mờ của ảnh (Laplacian Variance) = {variance}")
        return variance < threshold
    except Exception as e:
        print(f"Lỗi khi kiểm tra độ mờ: {e}")
        return False

def predict_pytorch(image_bytes: bytes):
    try:
        if is_image_blurry(image_bytes):
            return (-3, 0.0)

        image = Image.open(io.BytesIO(image_bytes)).convert("RGB")
        img_t = transform(image).unsqueeze(0)
        with torch.no_grad():
            outputs = model(img_t)
            probs = torch.nn.functional.softmax(outputs, dim=1)
            confidence, predicted_idx = torch.max(probs, 1)
            class_id = predicted_idx.item()
            confidence_score = confidence.item()
            print(f"DEBUG: Model dự đoán class_id = {class_id} với độ tin cậy {confidence_score:.2f}")
            if confidence_score < CONFIDENCE_THRESHOLD:
                return (-2, confidence_score)
        return (class_id, confidence_score)
    except Exception as e:
        print(f"Lỗi trong quá trình dự đoán: {e}")
        return (-1, 0.0)

