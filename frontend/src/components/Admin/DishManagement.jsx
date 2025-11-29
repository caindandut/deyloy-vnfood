import React, { useEffect, useMemo, useState } from 'react';
import { Card, Row, Col, Form, Button, Spinner, ListGroup, Badge, Nav, Tab } from 'react-bootstrap';
import { toast } from 'react-toastify';
import { adminDishesApi } from '../../services/api';
import { useTheme } from '../../contexts/ThemeContext';

const emptyTranslation = { name: '', description: '', region_info: '' };

const AdminDishManagement = () => {
  const { t, darkMode } = useTheme();
  const [dishes, setDishes] = useState([]);
  const [loadingList, setLoadingList] = useState(false);
  const [loadingDetail, setLoadingDetail] = useState(false);
  const [searchValue, setSearchValue] = useState('');
  const [selectedDishId, setSelectedDishId] = useState(null);
  const [baseForm, setBaseForm] = useState({ image_url: '', video_url: '' });
  const [translations, setTranslations] = useState({
    vi: { ...emptyTranslation },
    en: { ...emptyTranslation }
  });
  const [savingBase, setSavingBase] = useState(false);
  const [savingTranslation, setSavingTranslation] = useState({ vi: false, en: false });
  const [currentDishMeta, setCurrentDishMeta] = useState(null);
  const [activeTab, setActiveTab] = useState('base');

  const fetchDishes = async (keyword = '') => {
    setLoadingList(true);
    try {
      const response = await adminDishesApi.getAll(keyword || undefined);
      const list = response.data?.dishes || [];
      setDishes(list);
      if (!selectedDishId && list.length > 0) {
        setSelectedDishId(list[0].id);
      } else if (list.length === 0) {
        setSelectedDishId(null);
      }
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminListLoadError') || 'Không thể tải danh sách món ăn.';
      toast.error(message);
    } finally {
      setLoadingList(false);
    }
  };

  const fetchDishDetail = async (dishId) => {
    if (!dishId) {
      return;
    }
    setLoadingDetail(true);
    try {
      const response = await adminDishesApi.getDetail(dishId);
      const dish = response.data?.dish || {};
      const translationMap = response.data?.translations || {};
      setCurrentDishMeta(dish);
      setBaseForm({
        image_url: dish.image_url || '',
        video_url: dish.video_url || ''
      });
      setTranslations({
        vi: { ...emptyTranslation, ...(translationMap.vi || {}) },
        en: { ...emptyTranslation, ...(translationMap.en || {}) }
      });
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminDetailLoadError') || 'Không thể tải chi tiết món ăn.';
      toast.error(message);
    } finally {
      setLoadingDetail(false);
    }
  };

  useEffect(() => {
    fetchDishes();
  }, []);

  useEffect(() => {
    if (selectedDishId) {
      fetchDishDetail(selectedDishId);
      setActiveTab('base'); // Reset to base tab when selecting new dish
    } else {
      // reset translations handled via fetch
    }
  }, [selectedDishId]);

  const handleBaseSubmit = async (event) => {
    event.preventDefault();
    if (!selectedDishId) return;
    setSavingBase(true);
    try {
      await adminDishesApi.updateBaseInfo(selectedDishId, baseForm);
      toast.success(t('adminDishUpdated') || 'Đã cập nhật thông tin món ăn');
      fetchDishDetail(selectedDishId);
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminDishUpdateError') || 'Không thể cập nhật món ăn.';
      toast.error(message);
    } finally {
      setSavingBase(false);
    }
  };

  const handleTranslationSubmit = async (lang, event) => {
    event.preventDefault();
    if (!selectedDishId) return;
    setSavingTranslation((prev) => ({ ...prev, [lang]: true }));
    try {
      await adminDishesApi.updateTranslation(selectedDishId, lang, translations[lang]);
      toast.success(t('adminTranslationUpdated') || 'Đã cập nhật bản dịch');
      fetchDishDetail(selectedDishId);
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminTranslationUpdateError') || 'Không thể cập nhật bản dịch.';
      toast.error(message);
    } finally {
      setSavingTranslation((prev) => ({ ...prev, [lang]: false }));
    }
  };

  const dishListContent = useMemo(() => {
    if (loadingList) {
      return (
        <div className="d-flex justify-content-center py-4">
          <Spinner animation="border" />
        </div>
      );
    }

    if (!dishes.length) {
      return (
        <div className="py-4 text-center text-muted">
          {t('adminNoDishes') || t('noDishesFound') || 'Không có món ăn nào.'}
        </div>
      );
    }

    return (
      <ListGroup variant="flush" className="admin-dish-list">
        {dishes.map((dish) => {
          const isActive = selectedDishId === dish.id;
          return (
            <ListGroup.Item
              key={dish.id}
              action
              onClick={() => setSelectedDishId(dish.id)}
              className="d-flex justify-content-between align-items-start"
              style={{
                background: isActive 
                  ? 'linear-gradient(135deg, #ffb347, #ff6b2c)' 
                  : 'transparent',
                color: isActive ? '#fff' : 'inherit',
                border: isActive ? 'none' : '1px solid transparent',
                borderRadius: '8px',
                marginBottom: '4px',
                cursor: 'pointer',
                transition: 'all 0.2s ease',
                boxShadow: isActive ? '0 4px 12px rgba(255, 107, 44, 0.25)' : 'none'
              }}
              onMouseEnter={(e) => {
                if (!isActive) {
                  e.currentTarget.style.backgroundColor = darkMode ? '#2d2d2d' : '#f8f9fa';
                }
              }}
              onMouseLeave={(e) => {
                if (!isActive) {
                  e.currentTarget.style.backgroundColor = 'transparent';
                }
              }}
            >
              <div>
                <div className="fw-semibold" style={{ color: isActive ? '#fff' : 'inherit' }}>
                  {dish.name_vi || dish.name_en || t('dish')}
                </div>
                <small style={{ color: isActive ? 'rgba(255, 255, 255, 0.9)' : '#6c757d' }}>
                  ID: {dish.id} · Class: {dish.class_id}
                </small>
              </div>
              <Badge 
                style={{
                  background: isActive ? 'rgba(255, 255, 255, 0.25)' : '#6c757d',
                  color: isActive ? '#fff' : '#fff',
                  border: isActive ? '1px solid rgba(255, 255, 255, 0.3)' : 'none'
                }}
              >
                #{dish.class_id}
              </Badge>
            </ListGroup.Item>
          );
        })}
      </ListGroup>
    );
  }, [dishes, loadingList, selectedDishId, t]);

  return (
    <div className="admin-dishes-management">
      <div className="mb-4">
        <h3 className="fw-bold mb-2">{t('adminDishes') || 'Quản lý món ăn'}</h3>
        <p className="text-muted mb-0">
          {t('adminDishesDescription') || 'Cập nhật mô tả, hình ảnh, video và bản dịch cho các món đã được AI huấn luyện.'}
        </p>
      </div>

      <Row className="g-3 g-lg-4">
        <Col lg={4}>
          <Card className={`h-100 shadow-sm d-flex flex-column ${darkMode ? 'bg-dark text-light' : ''}`} style={{ border: darkMode ? '1px solid rgba(255, 107, 44, 0.2)' : undefined }}>
            <Card.Header className={`${darkMode ? 'bg-dark border-secondary' : 'bg-white'} border-bottom`} style={{ position: 'sticky', top: 0, zIndex: 10 }}>
              <div className="d-flex justify-content-between align-items-center mb-3">
                <h5 className="mb-0 fw-semibold">{t('adminSearch') || t('searchDishes') || 'Tìm kiếm'}</h5>
                <Button 
                  variant="link" 
                  size="sm" 
                  onClick={() => fetchDishes(searchValue.trim())}
                  className="p-0 text-decoration-none"
                  style={{ fontWeight: '500' }}
                  title={t('adminRefreshList') || t('refresh') || 'Tải lại danh sách'}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                    <path d="M3 12a9 9 0 0 1 9-9 9.75 9.75 0 0 1 6.74 2.74L21 8" />
                    <path d="M21 3v5h-5" />
                    <path d="M21 12a9 9 0 0 1-9 9 9.75 9.75 0 0 1-6.74-2.74L3 16" />
                    <path d="M3 21v-5h5" />
                  </svg>
                </Button>
              </div>
              <Form
                onSubmit={(e) => {
                  e.preventDefault();
                  fetchDishes(searchValue.trim());
                }}
              >
                <Form.Group className="mb-0">
                  <div className="d-flex gap-2 flex-nowrap">
                    <Form.Control
                      type="text"
                      value={searchValue}
                      placeholder={t('adminSearchPlaceholder') || 'Tìm theo tên hoặc class ID...'}
                      onChange={(e) => setSearchValue(e.target.value)}
                      className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                      style={{ borderRadius: '8px' }}
                    />
                    <Button 
                      type="submit" 
                      className="auth-primary-btn flex-shrink-0"
                      style={{ borderRadius: '8px', padding: '0.5rem 1rem', fontWeight: '500', minWidth: 'auto' }}
                    >
                      {t('adminSearch') || 'Tìm'}
                    </Button>
                    {searchValue && (
                      <Button
                        type="button"
                        variant="outline-secondary"
                        onClick={() => {
                          setSearchValue('');
                          fetchDishes('');
                        }}
                        className="flex-shrink-0"
                        style={{ borderRadius: '8px', padding: '0.5rem 1rem', fontWeight: '500', minWidth: 'auto' }}
                        title={t('adminResetFilters') || 'Xóa'}
                      >
                        ✕
                      </Button>
                    )}
                  </div>
                </Form.Group>
              </Form>
            </Card.Header>
            <Card.Body className="flex-grow-1 d-flex flex-column" style={{ overflow: 'hidden' }}>
              <div className="d-flex justify-content-between align-items-center mb-3">
                <span className="fw-semibold text-muted">
                  {t('found')} <strong className={darkMode ? 'text-light' : 'text-dark'}>{dishes.length}</strong> {t('dishes')}
                </span>
              </div>
              <div className="list-wrapper flex-grow-1" style={{ maxHeight: 'calc(100vh - 300px)', overflowY: 'auto', minHeight: '200px' }}>
                {dishListContent}
              </div>
            </Card.Body>
          </Card>
        </Col>

        <Col lg={8}>
          {selectedDishId ? (
            <Card className={`shadow-sm h-100 ${darkMode ? 'bg-dark text-light' : ''}`} style={{ border: darkMode ? '1px solid rgba(255, 107, 44, 0.2)' : undefined }}>
              <Card.Header className={`${darkMode ? 'bg-dark border-secondary' : 'bg-white'} border-bottom`}>
                <div className="d-flex justify-content-between align-items-center">
                  <div>
                    <h5 className="mb-1 fw-semibold">
                      {currentDishMeta?.name_vi || currentDishMeta?.name_en || t('dish') || 'Món ăn'}
                    </h5>
                    <small className="text-muted">ID: {currentDishMeta?.id} · Class: {currentDishMeta?.class_id}</small>
                  </div>
                  {loadingDetail && <Spinner animation="border" size="sm" />}
                </div>
              </Card.Header>
              <Card.Body>
                <Tab.Container activeKey={activeTab} onSelect={(k) => setActiveTab(k || 'base')}>
                  <Nav variant="tabs" className="mb-4" style={{ borderBottom: darkMode ? '2px solid #495057' : '2px solid #e9ecef' }}>
                    <Nav.Item>
                      <Nav.Link 
                        eventKey="base" 
                        className="fw-semibold"
                        style={{ 
                          color: activeTab === 'base' ? '#ff6b2c' : '#6c757d',
                          borderBottom: activeTab === 'base' ? '3px solid #ff6b2c' : '3px solid transparent',
                          marginBottom: '-2px',
                          transition: 'all 0.2s ease'
                        }}
                      >
                        {t('adminBaseInfo') || 'Thông tin cơ bản'}
                      </Nav.Link>
                    </Nav.Item>
                    <Nav.Item>
                      <Nav.Link 
                        eventKey="vi" 
                        className="fw-semibold"
                        style={{ 
                          color: activeTab === 'vi' ? '#ff6b2c' : '#6c757d',
                          borderBottom: activeTab === 'vi' ? '3px solid #ff6b2c' : '3px solid transparent',
                          marginBottom: '-2px',
                          transition: 'all 0.2s ease'
                        }}
                      >
                        {t('adminTranslation') || 'Bản dịch'} - {t('vietnamese') || 'Tiếng Việt'}
                      </Nav.Link>
                    </Nav.Item>
                    <Nav.Item>
                      <Nav.Link 
                        eventKey="en" 
                        className="fw-semibold"
                        style={{ 
                          color: activeTab === 'en' ? '#ff6b2c' : '#6c757d',
                          borderBottom: activeTab === 'en' ? '3px solid #ff6b2c' : '3px solid transparent',
                          marginBottom: '-2px',
                          transition: 'all 0.2s ease'
                        }}
                      >
                        {t('adminTranslation') || 'Bản dịch'} - {t('english') || 'English'}
                      </Nav.Link>
                    </Nav.Item>
                  </Nav>

                  <Tab.Content>
                    <Tab.Pane eventKey="base">
                      <Form onSubmit={handleBaseSubmit}>
                        <Row className="g-3">
                          <Col xs={12}>
                            <Form.Group>
                              <Form.Label className="fw-semibold">{t('adminImageUrl') || 'Ảnh (URL)'}</Form.Label>
                              <Form.Control
                                type="text"
                                value={baseForm.image_url}
                                onChange={(e) => setBaseForm((prev) => ({ ...prev, image_url: e.target.value }))}
                                placeholder="https://example.com/image.jpg"
                                className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                              />
                              {baseForm.image_url && (
                                <div className="mt-2">
                                  <img 
                                    src={baseForm.image_url} 
                                    alt="Preview" 
                                    style={{ maxWidth: '100%', maxHeight: '200px', borderRadius: '8px', objectFit: 'cover' }}
                                    onError={(e) => { e.target.style.display = 'none'; }}
                                  />
                                </div>
                              )}
                            </Form.Group>
                          </Col>
                          <Col xs={12}>
                            <Form.Group>
                              <Form.Label className="fw-semibold">{t('adminVideoUrl') || 'Video (URL)'}</Form.Label>
                              <Form.Control
                                type="text"
                                value={baseForm.video_url}
                                onChange={(e) => setBaseForm((prev) => ({ ...prev, video_url: e.target.value }))}
                                placeholder="https://youtube.com/..."
                                className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                              />
                              {baseForm.video_url && (
                                <small className="text-muted d-block mt-1">
                                  {baseForm.video_url.includes('youtube.com') || baseForm.video_url.includes('youtu.be') 
                                    ? '✓ Link YouTube hợp lệ' 
                                    : '⚠ Vui lòng kiểm tra link video'}
                                </small>
                              )}
                            </Form.Group>
                          </Col>
                        </Row>
                        <div className="mt-4">
                          <Button 
                            type="submit" 
                            className="auth-primary-btn"
                            disabled={savingBase}
                            style={{ borderRadius: '8px', padding: '0.75rem 1.5rem', fontWeight: '500' }}
                          >
                            {savingBase ? <Spinner size="sm" animation="border" className="me-2" /> : null}
                            {t('adminSaveChanges') || 'Lưu thay đổi'}
                          </Button>
                        </div>
                      </Form>
                    </Tab.Pane>

                    {['vi', 'en'].map((lang) => (
                      <Tab.Pane key={lang} eventKey={lang}>
                        <div className="mb-3">
                          <small className="text-muted">
                            {t('adminTranslationsNote') || 'Các thay đổi sẽ hiển thị với người dùng sau khi lưu.'}
                          </small>
                        </div>
                        <Form onSubmit={(event) => handleTranslationSubmit(lang, event)}>
                          <Form.Group className="mb-3">
                            <Form.Label className="fw-semibold">{t('adminName') || t('dish') || 'Tên món'}</Form.Label>
                            <Form.Control
                              type="text"
                              value={translations[lang].name}
                              onChange={(e) =>
                                setTranslations((prev) => ({
                                  ...prev,
                                  [lang]: { ...prev[lang], name: e.target.value }
                                }))
                              }
                              required
                              className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                            />
                          </Form.Group>
                          <Form.Group className="mb-3">
                            <Form.Label className="fw-semibold">{t('adminDescriptionField') || t('steps') || 'Mô tả'}</Form.Label>
                            <Form.Control
                              as="textarea"
                              rows={6}
                              value={translations[lang].description}
                              onChange={(e) =>
                                setTranslations((prev) => ({
                                  ...prev,
                                  [lang]: { ...prev[lang], description: e.target.value }
                                }))
                              }
                              style={{ resize: 'vertical' }}
                              className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                            />
                          </Form.Group>
                          <Form.Group className="mb-3">
                            <Form.Label className="fw-semibold">{t('adminRegionInfo') || t('regionalSpecialty') || 'Vùng miền'}</Form.Label>
                            <Form.Control
                              type="text"
                              value={translations[lang].region_info}
                              onChange={(e) =>
                                setTranslations((prev) => ({
                                  ...prev,
                                  [lang]: { ...prev[lang], region_info: e.target.value }
                                }))
                              }
                              placeholder={lang === 'vi' ? 'Ví dụ: Miền Trung, Miền Nam...' : 'Example: Central, Southern...'}
                              className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                            />
                          </Form.Group>
                          <div className="mt-4 d-flex justify-content-between align-items-center">
                            <Button 
                              type="submit" 
                              className="auth-primary-btn"
                              disabled={savingTranslation[lang]}
                              style={{ borderRadius: '8px', padding: '0.75rem 1.5rem', fontWeight: '500' }}
                            >
                              {savingTranslation[lang] ? <Spinner size="sm" animation="border" className="me-2" /> : null}
                              {t('adminSaveChanges') || 'Lưu thay đổi'}
                            </Button>
                            {savingTranslation[lang] && (
                              <small className="text-muted">Đang lưu...</small>
                            )}
                          </div>
                        </Form>
                      </Tab.Pane>
                    ))}
                  </Tab.Content>
                </Tab.Container>
              </Card.Body>
            </Card>
          ) : (
            <Card className={`shadow-sm h-100 ${darkMode ? 'bg-dark text-light' : ''}`} style={{ border: darkMode ? '1px solid rgba(255, 107, 44, 0.2)' : undefined }}>
              <Card.Body className="d-flex align-items-center justify-content-center text-center">
                <div>
                  <h5>{t('adminSelectDish') || 'Chọn món ăn để chỉnh sửa'}</h5>
                  <p className="text-muted mb-0">
                    {t('adminSelectDishHint') || 'Hãy chọn một món trong danh sách bên trái để bắt đầu chỉnh sửa.'}
                  </p>
                </div>
              </Card.Body>
            </Card>
          )}
        </Col>
      </Row>
    </div>
  );
};

export default AdminDishManagement;

