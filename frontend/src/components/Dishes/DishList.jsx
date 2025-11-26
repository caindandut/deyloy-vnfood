import React, { useState, useEffect, useCallback } from 'react';
import { Row, Col, Form, Spinner, Alert, Pagination, Card, Button, Badge } from 'react-bootstrap';
import { useTheme } from '../../contexts/ThemeContext';
import { dishesApi } from '../../services/api';
import Sidebar from '../Layout/Sidebar';
import DishCard from './DishCard';
import DishDetail from './DishDetail';
import VideoPlayer from '../Video/VideoPlayer';

const DishList = ({ onNavigate }) => {
  const { darkMode, language, t } = useTheme();
  const [dishes, setDishes] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  
  const [searchTerm, setSearchTerm] = useState('');
  const [debouncedSearch, setDebouncedSearch] = useState('');
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);
  
  const [selectedDish, setSelectedDish] = useState(null);
  const [showDetail, setShowDetail] = useState(false);
  const [showVideo, setShowVideo] = useState(false);
  const [videoUrl, setVideoUrl] = useState(null);
  const [videoTitle, setVideoTitle] = useState('');
  const hasSearchTerm = searchTerm.trim().length > 0;
  const totalDisplay = total > 0 ? total : 25;

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedSearch(searchTerm);
      setPage(1);
    }, 500);

    return () => clearTimeout(timer);
  }, [searchTerm]);

  useEffect(() => {
    fetchDishes();
  }, [debouncedSearch, page, language]);

  const fetchDishes = async () => {
    setLoading(true);
    setError(null);
    try {
      const params = {
        language,
        page,
        limit: 12
      };
      
      if (debouncedSearch) {
        params.search = debouncedSearch;
      }

      const response = await dishesApi.getAll(params);
      setDishes(response.data.dishes);
      setTotal(response.data.total);
      setTotalPages(response.data.total_pages);
    } catch (err) {
      setError(err.response?.data?.detail || 'Không thể tải danh sách món ăn');
      console.error('Lỗi khi lấy danh sách món ăn:', err);
    } finally {
      setLoading(false);
    }
  };

  const handleDishClick = async (dish) => {
    try {
      setLoading(true);
      const response = await dishesApi.getDetail(dish.id, language);
      setSelectedDish(response.data);
      setShowDetail(true);
    } catch (err) {
      console.error('Lỗi khi lấy chi tiết món ăn:', err);
    } finally {
      setLoading(false);
    }
  };


  const handlePageChange = (newPage) => {
    setPage(newPage);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const handleSidebarNavigation = (key) => {
    if (!onNavigate) return;
    
    if (showDetail) {
      setShowDetail(false);
      setSelectedDish(null);
    }
    if (showVideo) {
      setShowVideo(false);
      setVideoUrl(null);
      setVideoTitle('');
    }
    
    if (key === 'dishes') {
      return;
    } else if (key === 'upload' || key === 'webcam' || key === 'history' || key === 'favorites' || key === 'shopping') {
      onNavigate('main', key);
    } else {
      onNavigate(key);
    }
  };

  return (
    <>
      <Row className="g-0" style={{ margin: 0 }}>
        <Col xs={12} md={3} lg={2} style={{ padding: 0 }}>
          <Sidebar activeTab="dishes" onTabChange={handleSidebarNavigation} />
        </Col>
        <Col xs={12} md={9} lg={10} className="px-0">
          <section className={`dishes-section ${darkMode ? 'dishes-section-dark' : ''}`}>
            <div className="dishes-section-inner">
              <header className={`dishes-header ${darkMode ? 'dishes-header-dark' : ''}`}>
                <div className="dishes-heading-group">
                  <h2 className={`display-5 fw-bold mb-3 ${darkMode ? 'text-white' : 'text-dark'}`}>
                    {t('dishesTitle') || 'Khám phá món ăn phổ biến Việt Nam với 25 món ăn'}
                  </h2>
                  <p className={`fs-5 ${darkMode ? 'text-light' : 'text-muted'}`}>
                    {t('dishesDescription') || 'Hệ thống AI có thể nhận diện được 25 món ăn truyền thống Việt Nam. Khám phá công thức chi tiết, nguyên liệu và hướng dẫn từng bước cho từng món ăn!'}
                  </p>
                </div>
              </header>

              <Card
                className={`dishes-content-card shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`}
              >
                <Card.Body className="p-4 p-md-5">
                  <div className="dishes-toolbar mb-4">
                    <Form.Group className="flex-grow-1">
                      <Form.Control
                        type="text"
                        placeholder={t('searchDishes') || 'Tìm kiếm món ăn...'}
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                        className={`rounded-pill px-4 py-3 ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border'}`}
                        style={{ fontSize: '1rem' }}
                      />
                    </Form.Group>
                    <div className="dishes-toolbar-meta">
                      <Badge bg="light" text="dark" className="dishes-count-pill">
                        {t('found') || 'Tìm thấy'} <strong className="mx-1">{total}</strong> {t('dishes') || 'món ăn'}
                      </Badge>
                      {hasSearchTerm && (
                        <Button
                          variant={darkMode ? 'outline-light' : 'outline-secondary'}
                          size="sm"
                          className="dishes-reset-btn"
                          onClick={() => setSearchTerm('')}
                        >
                          {t('clearSearch') || 'Xóa tìm kiếm'}
                        </Button>
                      )}
                    </div>
                  </div>

                  {loading && dishes.length === 0 && (
                    <div className="text-center py-5">
                      <Spinner animation="border" variant="primary" />
                      <p className="mt-3">{t('loading') || 'Đang tải...'}</p>
                    </div>
                  )}

                  {error && (
                    <Alert variant="danger" className="mt-3">
                      {error}
                    </Alert>
                  )}

                  {!loading && !error && dishes.length === 0 && (
                    <div className="text-center py-5">
                      <p style={{ fontSize: '1.2rem', color: darkMode ? '#ccc' : '#666' }}>
                        {t('noDishesFound') || 'Không tìm thấy món ăn nào'}
                      </p>
                    </div>
                  )}

                  {!loading && !error && dishes.length > 0 && (
                    <>
                      <Row className="g-4">
                        {dishes.map((dish) => (
                          <Col key={dish.id} xs={12} sm={6} md={4} lg={3}>
                            <DishCard dish={dish} onClick={() => handleDishClick(dish)} />
                          </Col>
                        ))}
                      </Row>

                      {totalPages > 1 && (
                        <div className="d-flex justify-content-center mt-4">
                          <Pagination>
                            <Pagination.First
                              onClick={() => handlePageChange(1)}
                              disabled={page === 1}
                            />
                            <Pagination.Prev
                              onClick={() => handlePageChange(page - 1)}
                              disabled={page === 1}
                            />
                            
                            {[...Array(totalPages)].map((_, idx) => {
                              const pageNum = idx + 1;
                              if (
                                pageNum === 1 ||
                                pageNum === totalPages ||
                                (pageNum >= page - 1 && pageNum <= page + 1)
                              ) {
                                return (
                                  <Pagination.Item
                                    key={pageNum}
                                    active={pageNum === page}
                                    onClick={() => handlePageChange(pageNum)}
                                  >
                                    {pageNum}
                                  </Pagination.Item>
                                );
                              } else if (pageNum === page - 2 || pageNum === page + 2) {
                                return <Pagination.Ellipsis key={pageNum} />;
                              }
                              return null;
                            })}
                            
                            <Pagination.Next
                              onClick={() => handlePageChange(page + 1)}
                              disabled={page === totalPages}
                            />
                            <Pagination.Last
                              onClick={() => handlePageChange(totalPages)}
                              disabled={page === totalPages}
                            />
                          </Pagination>
                        </div>
                      )}
                    </>
                  )}
                </Card.Body>
              </Card>
            </div>
          </section>
        </Col>
      </Row>

      <DishDetail
        show={showDetail}
        dishData={selectedDish}
        onClose={() => {
          setShowDetail(false);
          setSelectedDish(null);
        }}
        onOpenVideo={(url, name) => {
          setVideoUrl(url);
          setVideoTitle(`${name} - ${t('videoInstructions') || 'Video hướng dẫn'}`);
          setShowVideo(true);
        }}
      />

      <VideoPlayer
        show={showVideo}
        videoUrl={videoUrl}
        title={videoTitle}
        onClose={() => {
          setShowVideo(false);
          setVideoUrl(null);
          setVideoTitle('');
        }}
      />
    </>
  );
};

export default DishList;

