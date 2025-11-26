import React, { useMemo } from 'react';
import { Card, Button } from 'react-bootstrap';
import { useTheme } from '../../contexts/ThemeContext';

const RecognitionInfoPanel = ({ isLoggedIn, historyItems = [], historyLoading, onShowHistory }) => {
  const { t } = useTheme();
  const recentHistory = (historyItems || []).slice(0, 3);
  const tips = useMemo(
    () => [
      t('recognitionTip1') || 'Ảnh cần rõ nét, không bị mờ hoặc rung.',
      t('recognitionTip2') || 'Món ăn nên chiếm phần lớn khung hình, hạn chế vật thể khác.',
      t('recognitionTip3') || 'Ánh sáng đều, không bị ngược sáng hoặc quá tối.'
    ],
    [t]
  );

  return (
    <div className="recognition-insights">
      <Card className="info-card">
        <Card.Body>
          <div className="d-flex justify-content-between align-items-center mb-3">
            <div>
              <p className="label-text mb-1">{t('recentRecognitionLabel') || 'Lần nhận diện gần đây'}</p>
              <h5 className="serif-heading mb-0">{t('yourHistoryTitle') || 'Lịch sử của bạn'}</h5>
            </div>
            {isLoggedIn && (
              <Button
                variant="outline-light"
                size="sm"
                className="btn-ghost"
                onClick={() => onShowHistory && onShowHistory()}
              >
                {t('viewAll') || 'Xem tất cả'}
              </Button>
            )}
          </div>

          {!isLoggedIn && (
            <p className="text-muted small">
              {t('loginToSeeRecent') || 'Đăng nhập để xem các món bạn đã nhận diện gần đây.'}
            </p>
          )}

          {isLoggedIn && historyLoading && (
            <p className="text-muted small mb-0">
              {t('loadingHistory') || 'Đang tải lịch sử...'}
            </p>
          )}

          {isLoggedIn && !historyLoading && recentHistory.length === 0 && (
            <p className="text-muted small">
              {t('noHistoryYetShort') || 'Bạn chưa có lịch sử nào. Hãy nhận diện món đầu tiên!'}
            </p>
          )}

          {isLoggedIn && recentHistory.length > 0 && (
            <ul className="list-unstyled recognition-history">
              {recentHistory.map((item, index) => (
                <li key={`${item.id || item.name}-${index}`}>
                  <div className="history-entry">
                    <img
                      src={item.image_url || item.image || 'https://via.placeholder.com/80x80.png?text=Food'}
                      alt={item.name}
                      className="history-thumbnail"
                    />
                    <div>
                      <p className="mb-0 fw-semibold">{item.name}</p>
                      <small className="text-muted">
                        {item.recognized_at
                          ? new Date(item.recognized_at).toLocaleString()
                          : t('justSaved') || 'Vừa lưu'}
                      </small>
                    </div>
                  </div>
                </li>
              ))}
            </ul>
          )}
        </Card.Body>
      </Card>

      <Card className="info-card secondary">
        <Card.Body>
          <p className="label-text mb-1">{t('photoGuideLabel') || 'Ảnh nên như thế nào?'}</p>
          <h5 className="serif-heading mb-3">{t('photoTipsTitle') || 'Tip chọn ảnh chuẩn'}</h5>
          <ul className="list-unstyled tips-list">
            {tips.map((tip, index) => (
              <li key={`tip-${index}`}>
                <span>🍽️</span>
                <p className="mb-0">{tip}</p>
              </li>
            ))}
          </ul>
        </Card.Body>
      </Card>
    </div>
  );
};

export default RecognitionInfoPanel;

