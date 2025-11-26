import React, { useEffect, useState, useMemo } from 'react';
import { Modal, Button, Image } from 'react-bootstrap';
import { toast } from 'react-toastify';
import { useTheme } from '../../contexts/ThemeContext';
import { useAuth } from '../../contexts/AuthContext';
import { favoritesApi } from '../../services/api';
import AddToShoppingList from '../Shopping/AddToShoppingList';

const DishDetail = ({ show, dishData, onClose, onOpenVideo }) => {
  const { darkMode, language, t } = useTheme();
  const { isLoggedIn } = useAuth();
  const [isFavorite, setIsFavorite] = useState(false);
  const [checkingFavorite, setCheckingFavorite] = useState(false);
  const [showAddToShoppingList, setShowAddToShoppingList] = useState(false);

  const safeDishData = useMemo(() => {
    if (!dishData || !dishData.dish) return null;
    return {
      dish: {
        ...dishData.dish,
        name: dishData.dish.name || (language === 'vi' ? 'Món ăn' : 'Dish'),
        description: dishData.dish.description || '',
        region_info: dishData.dish.region_info || ''
      },
      ingredients: Array.isArray(dishData.ingredients) ? dishData.ingredients : [],
      instructions: Array.isArray(dishData.instructions) ? dishData.instructions : []
    };
  }, [dishData, language]);

  useEffect(() => {
    const checkFavorite = async () => {
      if (!show || !safeDishData?.dish?.id || !isLoggedIn) {
        setIsFavorite(false);
        return;
      }

      setCheckingFavorite(true);
      try {
        const response = await favoritesApi.check(safeDishData.dish.id);
        setIsFavorite(response.data.is_favorite);
      } catch (err) {
        setIsFavorite(false);
      } finally {
        setCheckingFavorite(false);
      }
    };

    checkFavorite();
  }, [show, safeDishData, isLoggedIn]);

  const handleToggleFavorite = async () => {
    if (!safeDishData?.dish?.id) return;

    if (!isLoggedIn) {
      toast.warn(t('pleaseLoginToFavorite') || 'Vui lòng đăng nhập để thêm vào yêu thích');
      return;
    }

    setCheckingFavorite(true);
    try {
      if (isFavorite) {
        await favoritesApi.remove(safeDishData.dish.id);
        setIsFavorite(false);
        toast.success(`"${safeDishData.dish.name}" ${t('removedFromFavorites') || 'đã được xóa khỏi yêu thích'}`);
      } else {
        await favoritesApi.add(safeDishData.dish.id);
        setIsFavorite(true);
        toast.success(`"${safeDishData.dish.name}" ${t('addedToFavorites') || 'đã được thêm vào yêu thích'}`);
      }
    } catch (err) {
      toast.error(err.response?.data?.detail || t('unableToAddFavorite') || 'Có lỗi xảy ra');
    } finally {
      setCheckingFavorite(false);
    }
  };

  const uniqueInstructions = useMemo(() => {
    if (!safeDishData) return [];
    return safeDishData.instructions.filter((step, index, self) => index === self.findIndex((s) => s.step_number === step.step_number));
  }, [safeDishData]);

  if (!safeDishData) return null;

  return (
    <>
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
          <Modal.Title>{safeDishData.dish.name}</Modal.Title>
        </Modal.Header>
        <Modal.Body
          className={darkMode ? 'bg-dark text-light' : ''}
          style={{ maxHeight: '80vh', overflowY: 'auto' }}
        >
          <div className={`dish-detail ${darkMode ? 'dish-detail-dark' : ''}`}>
            <div className="dish-detail-hero">
              <div className="dish-detail-image-card">
                <Image
                  src={safeDishData.dish.image_url || 'https://via.placeholder.com/600x300.png?text=Ảnh+món+ăn'}
                  fluid
                  rounded
                  className="dish-detail-image"
                  alt={safeDishData.dish.name}
                />
              </div>
              <div className="dish-detail-info">
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

                {safeDishData.dish.description && (
                  <p className="dish-detail-description">{safeDishData.dish.description}</p>
                )}

                {safeDishData.dish.region_info && (
                  <div className="region-highlight mt-3">
                    <div className="region-highlight__label">
                      {t('regionalSpecialty') || 'Đặc sản vùng miền'}
                    </div>
                    <p className="mb-0">
                      {safeDishData.dish.region_info}
                    </p>
                  </div>
                )}

                <div className="dish-detail-meta">
                <div className="dish-detail-meta-card">
                  <span>{t('totalIngredients') || 'Tổng số nguyên liệu'}</span>
                  <strong>{safeDishData.ingredients.length}</strong>
                </div>
                <div className="dish-detail-meta-card">
                  <span>{t('totalSteps') || 'Tổng số bước'}</span>
                  <strong>{uniqueInstructions.length}</strong>
                </div>
                </div>

                {safeDishData.dish.video_url && (
                <Button
                  variant="primary"
                  size="lg"
                  onClick={() => {
                    if (onOpenVideo) {
                      onOpenVideo(safeDishData.dish.video_url, safeDishData.dish.name);
                      onClose?.();
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
                  {safeDishData.ingredients.length > 0 ? (
                    safeDishData.ingredients.map((ing, idx) => (
                      <div className="dish-ingredient-row" key={`dish-detail-ingredient-${safeDishData.dish.id}-${idx}`}>
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
                      <div key={`dish-detail-step-${safeDishData.dish.id}-${step.step_number}-${idx}`} className="dish-step">
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
      </Modal>

      <AddToShoppingList
        show={showAddToShoppingList}
        onClose={() => setShowAddToShoppingList(false)}
        dishData={safeDishData}
        onSuccess={() => {
          setShowAddToShoppingList(false);
        }}
      />
    </>
  );
};

export default DishDetail;


