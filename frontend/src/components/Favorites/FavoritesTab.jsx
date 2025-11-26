import React, { useState, useMemo } from 'react';
import { Button, Spinner, Card, Image, Form } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';

const FavoritesTab = ({ favorites, loading, onItemClick, onRemoveFavorite }) => {
  const { isLoggedIn } = useAuth();
  const { darkMode, t } = useTheme();
  const [searchTerm, setSearchTerm] = useState('');

  const normalizedSearch = searchTerm.trim().toLowerCase();

  const filteredFavorites = useMemo(() => {
    if (!normalizedSearch) return favorites || [];
    return (favorites || []).filter((item) =>
      item?.name?.toLowerCase().includes(normalizedSearch)
    );
  }, [favorites, normalizedSearch]);

  const searchActive = normalizedSearch.length > 0;

  if (!isLoggedIn) {
    return (
      <div className="text-center py-5">
        <p>{t('pleaseLogin')}</p>
        <Button variant="primary" onClick={() => window.location.hash = 'login'}>{t('login')}</Button>
      </div>
    );
  }

  return (
    <>
      {loading && (
        <div className="text-center py-5">
          <Spinner animation="border" variant="primary" />
        </div>
      )}
      {!loading && (
        <div className="favorites-page">
          <section className={`favorites-hero ${darkMode ? 'favorites-hero-dark' : ''}`}>
            <div>
              <p className="favorites-eyebrow mb-2">{t('favoritesHeroLabel') || 'Bộ sưu tập yêu thích'}</p>
              <h2 className={`fw-bold mb-0 ${darkMode ? 'text-white' : 'text-dark'}`}>
                {t('favoritesHeroTitle') || 'Những món ăn bạn yêu thích'}
              </h2>
            </div>
          </section>

          <div className="history-search mb-3">
            <Form.Control
              type="text"
              placeholder={t('searchFavorites') || 'Tìm kiếm món ăn yêu thích...'}
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className={`rounded-pill px-3 py-2 history-search-input ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border'}`}
            />
          </div>

          {filteredFavorites.length === 0 ? (
            <div className="text-center py-5 favorites-empty">
              <p className="mb-3 fs-1">{searchActive ? '🔍' : '❤️'}</p>
              <p className={`fs-4 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
                {searchActive ? (t('noSearchResults') || 'Không tìm thấy kết quả') : t('noFavorites')}
              </p>
              <p className={darkMode ? 'text-secondary' : 'text-muted'}>
                {searchActive
                  ? (t('tryDifferentKeyword') || 'Hãy thử từ khóa khác hoặc xóa tìm kiếm.')
                  : (t('favoritesEmptySubtitle') || 'Nhận diện món ăn và nhấn yêu thích để xuất hiện tại đây.')}
              </p>
            </div>
          ) : (
            <div className="d-flex flex-column gap-3">
              {filteredFavorites.map((item) => (
                <Card
                  key={item.id}
                  className={`shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`}
                  style={{ borderRadius: '1rem' }}
                >
                  <Card.Body className="p-4">
                    <div className="d-flex align-items-center gap-4">
                      <Image
                        src={item.image_url}
                        thumbnail
                        className="img-cover rounded-4"
                        style={{ width: '100px', height: '100px', minWidth: '100px' }}
                      />
                      <div className="flex-grow-1">
                        <h5 className="fw-bold mb-2">{item.name}</h5>
                        <small className={`opacity-75 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
                          {t('addedAt')} {new Date(item.created_at).toLocaleString()}
                        </small>
                      </div>
                      <div className="d-flex gap-2">
                        <Button
                          variant="primary"
                          size="sm"
                          onClick={() => onItemClick(item)}
                          className="rounded-4 px-3 py-2 orange-btn"
                        >
                          {t('viewDetail')}
                        </Button>
                        <Button
                          variant="outline-danger"
                          size="sm"
                          onClick={() => onRemoveFavorite(item.dish_id)}
                          className="rounded-4 px-3 py-2"
                        >
                          ❤️ {t('remove')}
                        </Button>
                      </div>
                    </div>
                  </Card.Body>
                </Card>
              ))}
            </div>
          )}
        </div>
      )}
    </>
  );
};

export default FavoritesTab;

