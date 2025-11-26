import cv2
import time
import logging
from fastapi import HTTPException
from fastapi.responses import StreamingResponse, Response
from camera import get_video_capture, release_camera
from config import logger, JPEG_QUALITY, MAX_RETRIES, MAX_STREAM_ERRORS

def get_video_stream():
    """Generator trả về multipart JPEG frames với chất lượng cao"""
    cap = get_video_capture()
    jpeg_quality = [int(cv2.IMWRITE_JPEG_QUALITY), JPEG_QUALITY]

    logger.info("Bắt đầu stream video...")
    frame_count = 0
    error_count = 0

    try:
        while True:
            ret, frame = cap.read()
            if not ret:
                error_count += 1
                logger.warning(f"Không thể đọc frame (lỗi {error_count}/{MAX_STREAM_ERRORS})")

                if error_count >= MAX_STREAM_ERRORS:
                    logger.error("Quá nhiều lỗi đọc frame. Dừng stream.")
                    break

                time.sleep(0.1)
                continue

            error_count = 0
            frame_count += 1

            (flag, encodedImage) = cv2.imencode(".jpg", frame, jpeg_quality)
            if not flag:
                logger.warning("Không thể encode frame thành JPEG")
                continue

            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' +
                   bytearray(encodedImage) + b'\r\n')

            if frame_count % 100 == 0:
                logger.debug(f"Đã stream {frame_count} frames")

    except GeneratorExit:
        logger.info("Client đã ngắt kết nối stream")
    except Exception as e:
        logger.error(f"Lỗi trong video stream: {e}")
    finally:
        logger.info(f"Kết thúc stream (tổng {frame_count} frames)")

async def video_feed():
    """API endpoint để stream video từ webcam"""
    logger.info("Yêu cầu stream video...")
    try:
        headers = {"Access-Control-Allow-Origin": "*"}
        return StreamingResponse(
            get_video_stream(),
            media_type="multipart/x-mixed-replace; boundary=frame",
            headers=headers
        )
    except Exception as e:
        logger.error(f"Lỗi khi tạo video stream: {e}")
        raise HTTPException(status_code=500, detail=f"Lỗi khi stream video: {str(e)}")

async def capture():
    """API endpoint để chụp ảnh từ webcam và trả về dưới dạng JPEG"""
    logger.info("Yêu cầu capture ảnh...")
    try:
        cap = get_video_capture()

        ret, frame = None, None

        for attempt in range(MAX_RETRIES):
            ret, frame = cap.read()
            if ret:
                break
            logger.warning(f"Không thể đọc frame (lần thử {attempt + 1}/{MAX_RETRIES})")
            time.sleep(0.1)

        if not ret or frame is None:
            raise HTTPException(
                status_code=500,
                detail="Không thể đọc frame từ webcam sau nhiều lần thử"
            )

        jpeg_quality = [int(cv2.IMWRITE_JPEG_QUALITY), JPEG_QUALITY]
        (flag, encodedImage) = cv2.imencode(".jpg", frame, jpeg_quality)

        if not flag:
            raise HTTPException(status_code=500, detail="Không thể encode ảnh")

        logger.info("Capture ảnh thành công")

        return Response(
            content=bytearray(encodedImage),
            media_type="image/jpeg",
            headers={
                "Access-Control-Allow-Origin": "*",
                "Content-Disposition": "inline; filename=capture.jpg",
                "Cache-Control": "no-cache, no-store, must-revalidate"
            }
        )
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Lỗi khi capture: {e}")
        raise HTTPException(status_code=500, detail=f"Lỗi khi capture ảnh: {str(e)}")

async def health():
    """API endpoint để kiểm tra trạng thái service"""
    try:
        cap = get_video_capture()
        if cap and cap.isOpened():
            ret, _ = cap.read()
            if ret:
                return {
                    "status": "ok",
                    "webcam": "connected",
                    "service": "Raspberry Pi Webcam Service"
                }
            else:
                return {
                    "status": "warning",
                    "webcam": "opened_but_cannot_read",
                    "service": "Raspberry Pi Webcam Service"
                }
        else:
            return {
                "status": "error",
                "webcam": "not_connected",
                "service": "Raspberry Pi Webcam Service"
            }
    except Exception as e:
        logger.error(f"Health check error: {e}")
        return {
            "status": "error",
            "message": str(e),
            "service": "Raspberry Pi Webcam Service"
        }

