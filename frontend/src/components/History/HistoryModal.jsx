import React, { useState, useEffect, useMemo } from 'react';
import { Modal, Button, Image } from 'react-bootstrap';
import { useTheme } from '../../contexts/ThemeContext';
import { useAuth } from '../../contexts/AuthContext';
import { favoritesApi } from '../../services/api';
import { toast } from 'react-toastify';
import { translations } from '../../utils/translations';
import AddToShoppingList from '../Shopping/AddToShoppingList';

const HistoryModal = ({ show, item, onClose, onOpenVideo }) => {
  const { darkMode, language, t } = useTheme();
  const { isLoggedIn } = useAuth();
  const [isFavorite, setIsFavorite] = useState(false);
  const [checkingFavorite, setCheckingFavorite] = useState(false);
  const [showAddToShoppingList, setShowAddToShoppingList] = useState(false);

  const ingredients = useMemo(() => (Array.isArray(item?.ingredients) ? item.ingredients : []), [item]);
  const uniqueInstructions = useMemo(() => {
    if (!Array.isArray(item?.instructions)) return [];
    return item.instructions.filter(
      (step, index, self) => index === self.findIndex((s) => s.step_number === step.step_number)
    );
  }, [item]);

  useEffect(() => {
    const checkFavorite = async () => {
      if (!item || !item.dish_id || !isLoggedIn) {
        setIsFavorite(false);
        return;
      }

      setCheckingFavorite(true);
      try {
        const response = await favoritesApi.check(item.dish_id);
        setIsFavorite(response.data.is_favorite);
      } catch (err) {
        setIsFavorite(false);
      } finally {
        setCheckingFavorite(false);
      }
    };

    if (show && item) {
      checkFavorite();
    }
  }, [show, item, isLoggedIn]);

  const handleToggleFavorite = async () => {
    if (!isLoggedIn) {
      toast.warn(translations[language]?.pleaseLoginToFavorite || 'Vui lòng đăng nhập');
      return;
    }

    if (!item || !item.dish_id) return;

    setCheckingFavorite(true);
    try {
      if (isFavorite) {
        await favoritesApi.remove(item.dish_id);
        setIsFavorite(false);
        toast.success(`"${item.name}" ${translations[language]?.removedFromFavorites || 'đã được xóa khỏi yêu thích'}`);
      } else {
        await favoritesApi.add(item.dish_id);
        setIsFavorite(true);
        toast.success(`"${item.name}" ${translations[language]?.addedToFavorites || 'đã được thêm vào yêu thích'}`);
      }
    } catch (err) {
      toast.error(err.response?.data?.detail || 'Có lỗi xảy ra');
    } finally {
      setCheckingFavorite(false);
    }
  };

  const convertHistoryItemToDishData = () => {
    if (!item) return null;
    return {
      dish: {
        id: item.dish_id,
        name: item.name,
        image_url: item.image_url,
        description: item.description,
        region_info: item.region_info
      },
      ingredients: item.ingredients || [],
      instructions: item.instructions || []
    };
  };

  if (!item) return null;

  return (
    <Modal
      show={show}
      onHide={onClose}
      size="xl"
      centered
    >
      <Modal.Header
        closeButton
        className={darkMode ? 'bg-dark text-light border-secondary' : ''}
      >
        <Modal.Title>{item.name}</Modal.Title>
      </Modal.Header>
      <Modal.Body className={darkMode ? 'bg-dark text-light' : ''} style={{ maxHeight: '80vh', overflowY: 'auto' }}>
        <div className={`dish-detail ${darkMode ? 'dish-detail-dark' : ''}`}>
          <div className="dish-detail-hero">
            <div className="dish-detail-image-card">
              <Image
                src={item.image_url || 'https://via.placeholder.com/600x300.png?text=Ảnh+món+ăn'}
                fluid
                rounded
                className="dish-detail-image"
                alt={item.name}
              />
            </div>
            <div className="dish-detail-info">
              <p className="text-muted small mb-2">
                {t('recognizedAt')} {new Date(item.recognized_at).toLocaleString(language === 'vi' ? 'vi-VN' : 'en-US')}
              </p>
              <div className="dish-detail-actions">
                {isLoggedIn ? (
                  <>
                    <Button
                      variant={isFavorite ? 'danger' : 'outline-danger'}
                      size="sm"
                      onClick={handleToggleFavorite}
                      disabled={checkingFavorite}
                      className="rounded-4 px-3 py-2 fw-medium transition-all"
                    >
                      {isFavorite ? '❤️' : '🤍'} {isFavorite ? t('removeFavorite') : t('addFavorite')}
                    </Button>
                    <Button
                      variant="outline-success"
                      size="sm"
                      onClick={() => setShowAddToShoppingList(true)}
                      className="rounded-4 px-3 py-2 fw-medium transition-all"
                    >
                      🛒 {t('addToShoppingList') || 'Thêm vào danh sách mua sắm'}
                    </Button>
                  </>
                ) : (
                  <>
                    <Button
                      variant="outline-secondary"
                      size="sm"
                      onClick={() => toast.warn(t('pleaseLoginToFavorite') || 'Vui lòng đăng nhập để thêm vào yêu thích')}
                      className="rounded-4 px-3 py-2"
                    >
                      🤍 {t('loginToFavorite') || 'Đăng nhập để yêu thích'}
                    </Button>
                    <Button
                      variant="outline-secondary"
                      size="sm"
                      onClick={() => toast.warn(t('loginToAddShoppingList') || 'Đăng nhập để thêm vào danh sách mua sắm')}
                      className="rounded-4 px-3 py-2"
                    >
                      🛒 {t('loginToAddShoppingList') || 'Đăng nhập để thêm DS mua sắm'}
                    </Button>
                  </>
                )}
              </div>

              {item.description && <p className="dish-detail-description">{item.description}</p>}

              {item.region_info && (
                <div className="region-highlight mt-3">
                  <div className="region-highlight__label">
                    {t('regionalSpecialty') || 'Đặc sản vùng miền'}
                  </div>
                  <p className="mb-0">{item.region_info}</p>
                </div>
              )}

              <div className="dish-detail-meta">
                <div className="dish-detail-meta-card">
                  <span>{t('totalIngredients') || 'Tổng số nguyên liệu'}</span>
                  <strong>{ingredients.length}</strong>
                </div>
                <div className="dish-detail-meta-card">
                  <span>{t('totalSteps') || 'Tổng số bước'}</span>
                  <strong>{uniqueInstructions.length}</strong>
                </div>
              </div>

              {item.video_url && (
                <Button
                  variant="primary"
                  size="lg"
                  onClick={() => {
                    if (onOpenVideo && item.video_url) {
                      onOpenVideo(item.video_url, item.name);
                      onClose();
                    }
                  }}
                  className="video-cta-btn warm-video-btn border-0 d-flex align-items-center justify-content-center gap-3 rounded-5 fw-bold fs-6 py-3"
                  style={{
                    width: '100%'
                  }}
                >
                  <span style={{ fontSize: '1.3rem' }}>▶️</span>
                  <span>{t('watchVideo') || 'Xem video hướng dẫn nấu món ăn'}</span>
                </Button>
              )}
            </div>
          </div>

          <div className="dish-detail-content">
            <section className="dish-detail-section">
              <header>
                <h5 className="mb-2">{t('ingredients')}</h5>
                <p className="text-muted mb-0">
                  {t('ingredientsWillBeAdded') || 'Các nguyên liệu cần chuẩn bị chi tiết'}.
                </p>
              </header>
              <div className="dish-detail-card">
                {ingredients.length > 0 ? (
                  ingredients.map((ing, idx) => (
                    <div className="dish-ingredient-row" key={`history-ingredient-${item.history_id}-${idx}-${ing.name}`}>
                      <div>
                        <strong>{ing.name}</strong>
                        {ing.description && <p className="mb-0 text-muted small">{ing.description}</p>}
                      </div>
                      <span className="text-muted">{ing.quantity || '-'}</span>
                    </div>
                  ))
                ) : (
                  <p className="text-muted mb-0">
                    {language === 'vi' ? 'Đang tải nguyên liệu...' : 'Loading ingredients...'}
                  </p>
                )}
              </div>
            </section>

            <section className="dish-detail-section">
              <header className="mb-3">
                <h5 className="mb-1">{t('steps')}</h5>
                <p className="text-muted mb-0">
                  {t('stepsSubtitle') || 'Thực hiện theo từng bước để hoàn thiện món ăn.'}
                </p>
              </header>
              <div className="dish-detail-card dish-detail-steps">
                {uniqueInstructions.length > 0 ? (
                  uniqueInstructions.map((step, idx) => (
                    <div key={`history-step-${item.history_id}-${step.step_number}-${idx}`} className="dish-step">
                      <div className="dish-step-number">{step.step_number}</div>
                      <div className="dish-step-body">
                        <h6 className="fw-semibold">{t('step')} {step.step_number}</h6>
                        <p>{step.description}</p>
                        {step.image_url && (
                          <Image
                            src={step.image_url}
                            rounded
                            fluid
                            alt={`${t('step')} ${step.step_number}`}
                            className="mt-2"
                            style={{ maxHeight: '260px', objectFit: 'cover' }}
                          />
                        )}
                      </div>
                    </div>
                  ))
                ) : (
                  <p className="text-muted mb-0">
                    {language === 'vi' ? 'Đang tải các bước thực hiện...' : 'Loading steps...'}
                  </p>
                )}
              </div>
            </section>
          </div>
        </div>
      </Modal.Body>
      <Modal.Footer className={darkMode ? 'bg-dark border-secondary' : ''}>
        <Button variant="secondary" onClick={onClose}>
          {t('back')}
        </Button>
      </Modal.Footer>

      <AddToShoppingList
        show={showAddToShoppingList}
        onClose={() => setShowAddToShoppingList(false)}
        dishData={convertHistoryItemToDishData()}
        onSuccess={() => {
          setShowAddToShoppingList(false);
        }}
        autoClose={true}
      />
    </Modal>
  );
};

export default HistoryModal;

