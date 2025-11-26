import React from 'react';
import { Card, Button, Spinner, Image, Row, Col } from 'react-bootstrap';
import { useTheme } from '../../contexts/ThemeContext';
import { PI_STREAM_URL } from '../../services/api';

const WebcamTab = ({
  videoStreamRef,
  canvasRef,
  capturedImagePreview,
  capturedImageBlob,
  loading,
  handleCaptureFrame,
  handleRecognizeCaptured,
  resetCapture,
  setError,
  streamError,
  setStreamError
}) => {
  const { darkMode, t } = useTheme();
  const tips = [
    t('webcamTipDistance') || 'Đưa món ăn lại gần (20-30cm) để thấy rõ chi tiết.',
    t('webcamTipLighting') || 'Đảm bảo ánh sáng đều, tránh ngược sáng.',
    t('webcamTipCenter') || 'Đặt món vào giữa khung hình và giữ tay chắc.'
  ];

  return (
    <Row className="g-3 g-md-4 webcam-layout">
      <Col xs={12} lg={8}>
        <div
          className={`webcam-feed-wrapper ${darkMode ? 'dark' : ''}`}
        >
          <div className="webcam-status-chip">
            {streamError
              ? (t('cameraOffline') || 'Không thấy tín hiệu camera')
              : capturedImagePreview
                ? (t('frameReady') || 'Ảnh đã chụp sẵn sàng')
                : (t('cameraLive') || 'Camera đang hoạt động')}
          </div>
          {!streamError && (
            <Image
              ref={videoStreamRef}
              src={`${PI_STREAM_URL}/video_feed`}
              alt="Live webcam feed"
              fluid
              rounded
              crossOrigin="anonymous"
              className={`w-100 img-contain ${capturedImagePreview ? 'd-none' : 'd-block'}`}
              style={{ maxHeight: 'clamp(250px, 50vh, 480px)' }}
              onError={(e) => {
                e.target.style.display = 'none';
                setError('Không thể tải video stream. Kiểm tra kết nối và webcam trên Pi.');
                setStreamError(true);
              }}
              onLoad={() => {
                setStreamError(false);
                if (!capturedImagePreview) setError('');
              }}
            />
          )}
          {streamError && (
            <div className="webcam-placeholder text-center text-muted w-100">
              <p className="mb-2 fw-semibold">{t('cameraOffline') || 'Không thể kết nối webcam'}</p>
              <p className="mb-0 small">{t('cameraOfflineHelp') || 'Kiểm tra Raspberry Pi hoặc cấp quyền truy cập camera'}</p>
            </div>
          )}
          {capturedImagePreview && (
            <Image
              src={capturedImagePreview}
              alt="Captured frame"
              fluid
              rounded
              className="w-100 img-contain rounded-4"
              style={{ maxHeight: 'clamp(250px, 50vh, 480px)' }}
            />
          )}
          <canvas ref={canvasRef} className="d-none" />
        </div>
      </Col>

      <Col xs={12} lg={4}>
        <Card className={`webcam-sidecard h-100 ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white'}`}>
          <Card.Body className="d-flex flex-column h-100 p-3 p-md-4">
            <div className="d-flex align-items-center justify-content-between mb-3">
              <div className="flex-grow-1">
                <p className="text-uppercase small fw-semibold text-muted mb-1">
                  {t('cameraStatus') || 'Trạng thái'}
                </p>
                <h5 className="mb-0" style={{ fontSize: 'clamp(0.95rem, 2.5vw, 1.25rem)' }}>
                  {streamError
                    ? (t('cameraOffline') || 'Không thấy tín hiệu camera')
                    : capturedImagePreview
                      ? (t('frameReady') || 'Ảnh đã chụp sẵn sàng')
                      : (t('cameraLive') || 'Camera đang hoạt động')}
                </h5>
              </div>
              <span className={`status-dot ${streamError ? 'status-offline' : capturedImagePreview ? 'status-ready' : 'status-live'}`} />
            </div>

            {capturedImagePreview && (
              <div className="mb-3 mb-md-4">
                <Image
                  src={capturedImagePreview}
                  alt="Captured thumbnail"
                  fluid
                  rounded
                  className="border rounded-4"
                />
              </div>
            )}

            <div className="d-grid gap-2 mb-3 mb-md-4">
              {streamError ? (
                <Button variant="outline-danger" disabled className="rounded-4 py-2 fw-semibold">
                  {t('cameraOffline') || 'Không thấy tín hiệu camera'}
                </Button>
              ) : !capturedImageBlob ? (
                <Button
                  variant="primary"
                  onClick={handleCaptureFrame}
                  disabled={loading}
                  className="rounded-4 py-2 fw-semibold orange-btn"
                >
                  📸 {t('capture')}
                </Button>
              ) : (
                <>
                  <Button
                    variant="outline-secondary"
                    onClick={resetCapture}
                    disabled={loading}
                    className="rounded-4 py-2 fw-semibold"
                  >
                    🔄 {t('recapture')}
                  </Button>
                  <Button
                    variant="primary"
                    onClick={handleRecognizeCaptured}
                    disabled={loading}
                    className="rounded-4 py-2 fw-semibold shadow-sm orange-btn"
                  >
                    {loading ? (
                      <>
                        <Spinner as="span" size="sm" className="me-2" />
                        {t('recognizing')}
                      </>
                    ) : (
                      `🔍 ${t('recognizeThis')}`
                    )}
                  </Button>
                </>
              )}
            </div>

            <div className="webcam-tips mt-auto">
              <p className="text-uppercase small fw-semibold text-muted mb-2">
                {t('cameraTipsLabel') || 'Mẹo chụp nhanh'}
              </p>
              <ul className="webcam-tip-list">
                {tips.map((tip, index) => (
                  <li key={`webcam-tip-${index}`} style={{ fontSize: 'clamp(0.85rem, 2vw, 0.95rem)' }}>{tip}</li>
                ))}
              </ul>
            </div>
          </Card.Body>
        </Card>
      </Col>
    </Row>
  );
};

export default WebcamTab;

