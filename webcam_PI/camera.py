import cv2
import subprocess
import time
import logging
from fastapi import HTTPException
from config import logger, CAMERA_DEVICE, FRAME_WIDTH, FRAME_HEIGHT, FPS, JPEG_QUALITY, WARMUP_FRAMES, WEBCAM_CONFIG

cap_global = None

def run_v4l2_cmd(cmd_args):
    """Chạy lệnh v4l2-ctl để cấu hình webcam"""
    try:
        res = subprocess.run(
            ["v4l2-ctl"] + cmd_args,
            capture_output=True,
            text=True,
            check=False,
            timeout=5
        )
        if res.returncode != 0:
            logger.warning(f"v4l2-ctl command failed: {' '.join(cmd_args)}")
        return res.stdout + res.stderr
    except FileNotFoundError:
        logger.warning("v4l2-ctl not found (install v4l-utils)")
        return "v4l2-ctl not found"
    except subprocess.TimeoutExpired:
        logger.error(f"v4l2-ctl command timeout: {' '.join(cmd_args)}")
        return "timeout"
    except Exception as e:
        logger.error(f"Error running v4l2-ctl: {e}")
        return str(e)

def setup_webcam():
    """Cấu hình webcam với các tham số tối ưu cho độ nét và màu sắc cao"""
    logger.info("Đang cấu hình webcam với các tham số tối ưu...")

    try:
        for control, value in WEBCAM_CONFIG.items():
            run_v4l2_cmd(["-d", CAMERA_DEVICE, f"--set-ctrl={control}={value}"])

        logger.info("Hoàn thành cấu hình webcam!")
    except Exception as e:
        logger.error(f"Lỗi khi cấu hình webcam: {e}")

def get_video_capture():
    """Khởi tạo và cấu hình VideoCapture"""
    global cap_global

    try:
        if cap_global is None or not cap_global.isOpened():
            setup_webcam()

            cap_global = cv2.VideoCapture(0, cv2.CAP_V4L2)

            if not cap_global.isOpened():
                logger.error(f"Không thể mở webcam {CAMERA_DEVICE}")
                raise HTTPException(status_code=500, detail="Không thể mở webcam")

            cap_global.set(cv2.CAP_PROP_FRAME_WIDTH, FRAME_WIDTH)
            cap_global.set(cv2.CAP_PROP_FRAME_HEIGHT, FRAME_HEIGHT)
            cap_global.set(cv2.CAP_PROP_FPS, FPS)

            logger.info("Warming up camera...")
            for i in range(WARMUP_FRAMES):
                ret, _ = cap_global.read()
                if not ret:
                    logger.warning(f"Failed to read frame during warmup: {i}")
                time.sleep(0.03)

            logger.info("Webcam đã sẵn sàng!")

        return cap_global
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Lỗi khi khởi tạo VideoCapture: {e}")
        raise HTTPException(status_code=500, detail=f"Lỗi khi khởi tạo webcam: {str(e)}")

def release_camera():
    """Giải phóng webcam"""
    global cap_global
    if cap_global is not None:
        try:
            cap_global.release()
            logger.info("Đã giải phóng webcam.")
        except Exception as e:
            logger.error(f"Lỗi khi giải phóng webcam: {e}")
        finally:
            cap_global = None

