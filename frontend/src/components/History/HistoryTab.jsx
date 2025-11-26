import React, { useMemo, useState } from 'react';
import { Button, Spinner, Card, Image, Badge, Form } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';

const groupHistoryByDate = (items) => {
  const groups = items.reduce((acc, item) => {
    const date = new Date(item.recognized_at);
    if (Number.isNaN(date.getTime())) {
      return acc;
    }

    const key = date.toISOString().split('T')[0];
    if (!acc[key]) {
      acc[key] = [];
    }
    acc[key].push(item);
    return acc;
  }, {});

  return Object.entries(groups)
    .sort((a, b) => new Date(b[0]) - new Date(a[0]))
    .map(([dateKey, items]) => ({ dateKey, items }));
};

const formatRelativeDate = (dateString, language = 'vi') => {
  const date = new Date(dateString);
  const today = new Date();
  const diffTime = today - date;
  const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));

  if (diffDays === 0) return language === 'vi' ? 'Hôm nay' : 'Today';
  if (diffDays === 1) return language === 'vi' ? 'Hôm qua' : 'Yesterday';
  if (diffDays < 7) return language === 'vi' ? `Cách đây ${diffDays} ngày` : `${diffDays} days ago`;

  return date.toLocaleDateString(language === 'vi' ? 'vi-VN' : 'en-US', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  });
};

const HistoryTab = ({ history, loading, onItemClick }) => {
  const { isLoggedIn } = useAuth();
  const { darkMode, t, language } = useTheme();
  const [searchTerm, setSearchTerm] = useState('');

  const normalizedSearch = searchTerm.trim().toLowerCase();

  const filteredHistory = useMemo(() => {
    if (!normalizedSearch) return history || [];
    return (history || []).filter((item) =>
      item?.name?.toLowerCase().includes(normalizedSearch)
    );
  }, [history, normalizedSearch]);

  const searchActive = normalizedSearch.length > 0;

  const groupedHistory = useMemo(() => groupHistoryByDate(filteredHistory), [filteredHistory]);

  if (!isLoggedIn) {
    return (
      <div className="text-center py-5">
        <p>{t('pleaseLogin')}</p>
        <Button variant="primary" onClick={() => window.location.hash = 'login'}>{t('login')}</Button>
      </div>
    );
  }

  return (
    <div className="history-page">
      <section className={`history-hero ${darkMode ? 'history-hero-dark' : ''}`}>
        <h2 className={`fw-bold mb-0 ${darkMode ? 'text-white' : 'text-dark'}`}>
          {t('historyHeroTitle') || 'Lịch sử nhận diện gần đây'}
        </h2>
      </section>

      <div className="history-search">
        <Form.Control
          type="text"
          placeholder={t('searchHistory') || 'Tìm kiếm món ăn...'}
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className={`rounded-pill px-3 py-2 history-search-input ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border'}`}
        />
      </div>

      {loading && (
        <div className="text-center py-5">
          <Spinner animation="border" variant="primary" />
        </div>
      )}

      {!loading && filteredHistory.length === 0 && (
        <div className="history-empty text-center py-5">
          <div className="history-empty-icon mb-4" aria-hidden="true">🕵️‍♀️</div>
          <p className={`fs-4 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
            {searchActive ? (t('historyNoResults') || 'Không tìm thấy kết quả phù hợp') : t('noHistory')}
          </p>
          <p className={darkMode ? 'text-secondary' : 'text-muted'}>
            {searchActive
              ? (t('historyNoResultsSubtitle') || 'Hãy thử từ khóa khác hoặc xóa tìm kiếm.')
              : (t('historyEmptySubtitle') || 'Bạn chưa nhận diện món ăn nào. Hãy bắt đầu bằng cách tải ảnh lên hoặc dùng webcam.')}
          </p>
          {!searchActive && (
            <Button variant="primary" className="rounded-pill px-4 py-2 orange-btn">
              {t('recognizeNow') || 'Nhận diện ngay'}
            </Button>
          )}
        </div>
      )}

      {!loading && filteredHistory.length > 0 && (
        <div className="history-groups">
          {groupedHistory.map(({ dateKey, items }) => {
            const groupCountText = language === 'vi' ? `${items.length} món ăn` : `${items.length} dishes`;

            return (
              <div key={dateKey} className="history-group">
              <div className="history-group-header">
                <h5 className="mb-1">{formatRelativeDate(dateKey, language)}</h5>
                  <p className="text-muted mb-0">{groupCountText}</p>
              </div>
              <div className="history-list">
                {items.map((item) => (
                  <Card
                    key={item.history_id}
                    className={`history-card shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`}
                    onClick={() => onItemClick(item)}
                  >
                    <Card.Body className="p-3 p-md-4">
                      <div className="history-card-content">
                        <Image
                          src={item.image_url}
                          thumbnail
                          className="img-cover rounded-4 history-card-thumb"
                        />
                        <div className="history-card-body">
                          <div className="history-card-header">
                            <h5 className="fw-semibold mb-1">{item.name}</h5>
                            <Badge bg="light" text="dark" className="history-card-badge">
                              {new Date(item.recognized_at).toLocaleTimeString(language === 'vi' ? 'vi-VN' : 'en-US', {
                                hour: '2-digit',
                                minute: '2-digit'
                              })}
                            </Badge>
                          </div>
                          <p className={`mb-2 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
                            {t('recognizedAt')} {new Date(item.recognized_at).toLocaleString(language === 'vi' ? 'vi-VN' : 'en-US')}
                          </p>
                          <div className="history-card-actions">
                            <Button
                              variant="primary"
                              size="sm"
                              className="history-detail-btn rounded-pill px-3 py-1 orange-btn"
                              onClick={(e) => {
                                e.stopPropagation();
                                onItemClick(item);
                              }}
                            >
                              {t('viewDetail') || 'Xem chi tiết'}
                            </Button>
                            <div className="history-card-tags">
                              {item.is_favorite && <Badge bg="danger" className="rounded-pill">{t('favorites')}</Badge>}
                              {item.added_to_shopping_list && <Badge bg="success" className="rounded-pill">{t('shoppingList')}</Badge>}
                            </div>
                          </div>
                        </div>
                      </div>
                    </Card.Body>
                  </Card>
                ))}
              </div>
            </div>
            );
          })}
        </div>
      )}
    </div>
  );
};

export default HistoryTab;

