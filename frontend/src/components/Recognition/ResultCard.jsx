import React, { useState, useEffect } from 'react';
import {
  Card,
  Button,
  Spinner,
  Alert,
  ListGroup,
  Image,
  Badge,
  Row,
  Col,
  Accordion
} from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';
import { favoritesApi } from '../../services/api';
import VideoPlayer from '../Video/VideoPlayer';
import AddToShoppingList from '../Shopping/AddToShoppingList';

const ResultCard = ({ loading, error, dishData, onSaveToHistory, onLoginRequest, onToggleFavorite }) => {
  const { isLoggedIn } = useAuth();
  const { darkMode, language, t } = useTheme();
  const [isFavorite, setIsFavorite] = useState(false);
  const [checkingFavorite, setCheckingFavorite] = useState(false);
  const [showVideo, setShowVideo] = useState(false);
  const [showAddToShoppingList, setShowAddToShoppingList] = useState(false);

  useEffect(() => {
    const checkFavorite = async () => {
      if (!dishData || !dishData.dish || !dishData.dish.id) {
        setIsFavorite(false);
        return;
      }

      setCheckingFavorite(true);
      try {
        const response = await favoritesApi.check(dishData.dish.id);
        setIsFavorite(response.data.is_favorite);
      } catch (err) {
        setIsFavorite(false);
      } finally {
        setCheckingFavorite(false);
      }
    };

    checkFavorite();
  }, [dishData]);

  if (loading) {
    return (
      <div className="text-center mt-4">
        <Spinner animation="border" variant="primary" />
        <p>{t('processing')}</p>
      </div>
    );
  }

  if (error) {
    return <Alert variant="danger" className="mt-3">{error}</Alert>;
  }

  if (!dishData) return null;

  const sectionSurfaceClass = `result-section ${
    darkMode ? 'result-section-dark text-light' : 'result-section-light'
  }`;

  // Fallbacks when translation for current language is missing
  const dishName =
    (dishData.dish && dishData.dish.name && dishData.dish.name !== 'null')
      ? dishData.dish.name
      : (language === 'vi' ? 'Tên món chưa có bản dịch' : 'Dish name not available');

  const dishDescription =
    (dishData.dish && dishData.dish.description && dishData.dish.description !== 'null')
      ? dishData.dish.description
      : (language === 'vi'
          ? 'Mô tả món ăn chưa có trong ngôn ngữ này.'
          : 'Description for this dish is not available in this language yet.');

  const handleFavoriteClick = () => {
    if (onToggleFavorite) {
      onToggleFavorite(dishData.dish.id, dishData.dish.name, isFavorite, (newState) => {
        setIsFavorite(newState);
      });
    }
  };

  return (
    <Card
      className={`mt-4 shadow-sm recognition-result-card ${
        darkMode ? 'bg-dark text-light border-secondary' : 'result-card-warm border-0'
      }`}
      style={{
        borderRadius: '1.5rem',
        overflow: 'hidden'
      }}
    >
      <Card.Header
        as="div"
        className={`result-banner-header border-0 p-4 p-lg-5 text-white ${
          darkMode ? 'result-banner-header-dark' : ''
        }`}
      >
        <div className="result-banner">
          <div className="result-banner__media">
              <Image
              src={dishData.dish.image_url || 'https://via.placeholder.com/300.png?text=Dish+image'}
              alt={dishName}
              roundedCircle
              className="result-banner__image"
            />
          </div>
          <div className="result-banner__body">
            <div className="result-banner__info">
              <div className="d-flex flex-column flex-lg-row gap-3 align-items-start align-items-lg-center">
                <div className="flex-grow-1">
                  <p className="result-banner__label text-uppercase fw-semibold mb-1">
                    {t('recognizedDishLabel') || 'Món ăn đã nhận diện'}
                  </p>
                  <h3 className="result-banner__title mb-2">{dishName}</h3>
                </div>
                {dishData.confidence !== undefined && dishData.confidence !== null && (
                  <Badge
                    bg={dishData.confidence >= 90 ? 'success' : dishData.confidence >= 70 ? 'warning' : 'danger'}
                    className="px-3 py-2 rounded-pill text-uppercase"
                  >
                    <span className="fw-bold">{dishData.confidence}%</span>
                    <span className="ms-1">{t('confidence')}</span>
                  </Badge>
                )}
              </div>

              <div className="result-action-group d-flex gap-3 flex-wrap mt-4">
                {isLoggedIn ? (
                  <>
                    <Button
                      variant="light"
                      size="sm"
                      onClick={onSaveToHistory}
                      className="rounded-4 px-3 py-2 fw-medium transition-all"
                    >
                      🔖 {t('saveToHistory')}
                    </Button>
                    <Button
                      variant={isFavorite ? 'danger' : 'outline-light'}
                      size="sm"
                      onClick={handleFavoriteClick}
                      disabled={checkingFavorite}
                      className="rounded-4 px-3 py-2 fw-medium transition-all"
                    >
                      {isFavorite ? '❤️' : '🤍'} {isFavorite ? t('removeFavorite') : t('addFavorite')}
                    </Button>
                    <Button
                      variant="outline-light"
                      size="sm"
                      onClick={() => setShowAddToShoppingList(true)}
                      className="rounded-4 px-3 py-2 fw-medium transition-all"
                    >
                      🛒 {t('addToShoppingList') || 'Thêm vào danh sách mua sắm'}
                    </Button>
                  </>
                ) : (
                  <>
                    <Button variant="light" size="sm" onClick={onLoginRequest} className="rounded-4 px-3 py-2">
                      🔖 {t('loginToSave')}
                    </Button>
                    <Button variant="light" size="sm" onClick={onLoginRequest} className="rounded-4 px-3 py-2">
                      🤍 {t('loginToFavorite')}
                    </Button>
                    <Button variant="light" size="sm" onClick={onLoginRequest} className="rounded-4 px-3 py-2">
                      🛒 {t('loginToAddShoppingList') || 'Đăng nhập để thêm vào danh sách mua sắm'}
                    </Button>
                  </>
                )}
              </div>
            </div>
          </div>
        </div>
      </Card.Header>

      <Card.Body className="p-4 p-lg-5">
        <Row className="g-5">
          <Col lg={7}>
            <section className={`${sectionSurfaceClass} mb-4`}>
              <h4 className="fw-bold mb-3">{t('dishOverview') || 'Tổng quan món ăn'}</h4>
              <p className="fs-5 mb-4">{dishDescription}</p>

              {dishData.dish.region_info && (
                <div className="region-highlight mb-4">
                  <span className="region-highlight__label">
                    {t('regionalSpecialty') || 'Đặc sản vùng miền'}
                  </span>
                  <p className="mb-0">{dishData.dish.region_info}</p>
                </div>
              )}

              {dishData.dish.video_url && (
                <Button
                  variant="warning"
                  size="lg"
                  onClick={() => {
                    setShowVideo(true);
                  }}
                  className="video-cta-btn warm-video-btn border-0 d-flex align-items-center justify-content-center gap-3 rounded-5 fw-bold fs-5 py-3 w-100"
                >
                  <span style={{ fontSize: '1.8rem' }}>▶️</span>
                  <span>{t('watchVideo') || 'Xem video hướng dẫn nấu món ăn'}</span>
                </Button>
              )}
            </section>

            <section className={sectionSurfaceClass}>
              <div className="d-flex align-items-center justify-content-between mb-3">
                <h4 className="fw-bold mb-0">{t('steps')}</h4>
                <span className="text-muted">
                  {dishData.instructions.length} {t('stepCountLabel') || 'bước'}
                </span>
              </div>
              <Accordion alwaysOpen>
                {dishData.instructions
                  .filter((step, index, self) =>
                    index === self.findIndex(s => s.step_number === step.step_number)
                  )
                  .map((step, index) => (
                    <Accordion.Item
                      eventKey={`${step.step_number}-${index}`}
                      key={`step-${dishData.dish.id}-${step.step_number}-${index}`}
                    >
                      <Accordion.Header>
                        {t('step')} {step.step_number}
                      </Accordion.Header>
                      <Accordion.Body>
                        <p className="mb-3">{step.description}</p>
                        {step.image_url && (
                          <Image
                            src={step.image_url}
                            rounded
                            fluid
                            alt={`Ảnh minh họa bước ${step.step_number}`}
                            className="rounded-4"
                            style={{ maxWidth: '100%', height: 'auto' }}
                          />
                        )}
                      </Accordion.Body>
                    </Accordion.Item>
                  ))}
              </Accordion>
            </section>
          </Col>

          <Col lg={5}>
            <section className={sectionSurfaceClass}>
              <div className="d-flex align-items-center justify-content-between mb-3">
                <h4 className="fw-bold mb-0">{t('ingredients')}</h4>
                <Badge bg="light" text="dark" className="text-uppercase fw-semibold">
                  {dishData.ingredients.length} {t('ingredientCountLabel') || 'nguyên liệu'}
                </Badge>
              </div>
              <ListGroup variant="flush" className="result-ingredients-list">
                {dishData.ingredients.map((item, index) => (
                  <ListGroup.Item
                    key={`ingredient-${dishData.dish.id}-${index}-${item.name}`}
                    className={`result-ingredient-item ${darkMode ? 'result-ingredient-item-dark' : ''}`}
                  >
                    <strong className="fw-semibold">{item.name}</strong>
                    <span className="text-muted">{item.quantity || '-'}</span>
                  </ListGroup.Item>
                ))}
              </ListGroup>
            </section>
          </Col>
        </Row>
      </Card.Body>

      <VideoPlayer
        show={showVideo}
        videoUrl={dishData.dish.video_url}
        title={`${dishData.dish.name} - ${t('videoInstructions') || 'Video hướng dẫn'}`}
        onClose={() => {
          setShowVideo(false);
        }}
      />

      <AddToShoppingList
        show={showAddToShoppingList}
        onClose={() => setShowAddToShoppingList(false)}
        dishData={dishData}
        onSuccess={() => {
          setShowAddToShoppingList(false);
        }}
        autoClose={true}
      />
    </Card>
  );
};

export default ResultCard;

