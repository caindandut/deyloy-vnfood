import React, { useEffect, useMemo, useState } from 'react';
import { Card, Row, Col, Form, Button, Spinner, ListGroup, Badge } from 'react-bootstrap';
import { toast } from 'react-toastify';
import { adminDishesApi, adminIngredientsApi } from '../../services/api';
import { useTheme } from '../../contexts/ThemeContext';

const formatDishIngredientRows = (rows = []) =>
  rows.map((row) => ({
    ...row,
    name_vi: row.name_vi || '',
    name_en: row.name_en || '',
    quantityDraft: row.quantity || ''
  }));

const AdminIngredientManagement = () => {
  const { t, darkMode } = useTheme();
  const [dishes, setDishes] = useState([]);
  const [dishSearch, setDishSearch] = useState('');
  const [loadingDishes, setLoadingDishes] = useState(false);
  const [selectedDishId, setSelectedDishId] = useState(null);
  const [dishIngredients, setDishIngredients] = useState([]);
  const [loadingDishIngredients, setLoadingDishIngredients] = useState(false);

  const [ingredients, setIngredients] = useState([]);
  const [ingredientSearch, setIngredientSearch] = useState('');
  const [loadingIngredients, setLoadingIngredients] = useState(false);

  const [linkForm, setLinkForm] = useState({ ingredient_id: '', quantity: '' });
  const [savingDishIngredient, setSavingDishIngredient] = useState(null);

  const fetchDishes = async (keyword = '') => {
    setLoadingDishes(true);
    try {
      const response = await adminDishesApi.getAll(keyword || undefined);
      const list = response.data?.dishes || [];
      setDishes(list);
      if (!selectedDishId && list.length) {
        setSelectedDishId(list[0].id);
      } else if (selectedDishId && list.every((dish) => dish.id !== selectedDishId)) {
        setSelectedDishId(list[0]?.id || null);
      }
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminListLoadError') || 'Không thể tải danh sách món ăn.';
      toast.error(message);
      setDishes([]);
      setSelectedDishId(null);
    } finally {
      setLoadingDishes(false);
    }
  };

  const fetchIngredients = async (keyword = '') => {
    setLoadingIngredients(true);
    try {
      const response = await adminIngredientsApi.list(keyword || undefined);
      setIngredients(response.data?.ingredients || []);
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminIngredientLoadError') || 'Không thể tải nguyên liệu.';
      toast.error(message);
    } finally {
      setLoadingIngredients(false);
    }
  };

  const fetchDishIngredients = async (dishId) => {
    if (!dishId) {
      setDishIngredients([]);
      setLoadingDishIngredients(false);
      return;
    }
    setLoadingDishIngredients(true);
    try {
      const response = await adminDishesApi.getDishIngredients(dishId);
      setDishIngredients(formatDishIngredientRows(response.data?.items || []));
    } catch (error) {
      const message =
        error?.response?.data?.detail || t('adminDishIngredientLoadError') || 'Không thể tải nguyên liệu của món.';
      toast.error(message);
      setDishIngredients([]);
    } finally {
      setLoadingDishIngredients(false);
    }
  };

  useEffect(() => {
    fetchDishes();
    fetchIngredients();
  }, []);

  useEffect(() => {
    // Only fetch if selectedDishId is valid and exists in dishes list
    if (selectedDishId && dishes.length > 0 && dishes.some(d => d.id === selectedDishId)) {
      fetchDishIngredients(selectedDishId);
    } else if (!selectedDishId) {
      setDishIngredients([]);
      setLoadingDishIngredients(false);
    } else if (selectedDishId && dishes.length > 0 && !dishes.some(d => d.id === selectedDishId)) {
      // If selectedDishId doesn't exist in dishes, reset it
      setSelectedDishId(null);
      setDishIngredients([]);
      setLoadingDishIngredients(false);
    }
  }, [selectedDishId, dishes]);

  const handleLinkIngredientSubmit = async (event) => {
    event.preventDefault();
    if (!selectedDishId) {
      toast.error(t('adminSelectDishFirst') || 'Hãy chọn món trước.');
      return;
    }
    if (!linkForm.ingredient_id) {
      toast.error(t('adminSelectIngredientFirst') || 'Vui lòng chọn nguyên liệu.');
      return;
    }
    if (!linkForm.quantity.trim()) {
      toast.error(t('adminQuantityRequired') || 'Vui lòng nhập số lượng.');
      return;
    }
    setSavingDishIngredient('create');
    try {
      await adminDishesApi.addDishIngredient(selectedDishId, {
        ingredient_id: Number(linkForm.ingredient_id),
        quantity: linkForm.quantity
      });
      toast.success(t('adminDishIngredientLinked') || 'Đã thêm nguyên liệu vào món');
      setLinkForm({ ingredient_id: '', quantity: '' });
      fetchDishIngredients(selectedDishId);
    } catch (error) {
      const message =
        error?.response?.data?.detail || t('adminDishIngredientUpdateError') || 'Không thể cập nhật nguyên liệu cho món.';
      toast.error(message);
    } finally {
      setSavingDishIngredient(null);
    }
  };

  const handleDishIngredientQuantityChange = (ingredientId, value) => {
    setDishIngredients((prev) =>
      prev.map((item) =>
        item.ingredient_id === ingredientId ? { ...item, quantityDraft: value } : item
      )
    );
  };

  const handleSaveDishIngredientQuantity = async (item) => {
    if (!item.quantityDraft.trim()) {
      toast.error(t('adminQuantityRequired') || 'Vui lòng nhập số lượng.');
      return;
    }
    setSavingDishIngredient(`update-${item.ingredient_id}`);
    try {
      await adminDishesApi.updateDishIngredient(selectedDishId, item.ingredient_id, {
        ingredient_id: item.ingredient_id,
        quantity: item.quantityDraft
      });
      toast.success(t('adminDishIngredientUpdated') || 'Đã cập nhật số lượng');
      fetchDishIngredients(selectedDishId);
    } catch (error) {
      const message =
        error?.response?.data?.detail || t('adminDishIngredientUpdateError') || 'Không thể cập nhật nguyên liệu.';
      toast.error(message);
    } finally {
      setSavingDishIngredient(null);
    }
  };

  const handleRemoveDishIngredient = async (ingredientId) => {
    if (!window.confirm(t('adminConfirmRemoveDishIngredient') || 'Xóa nguyên liệu khỏi món?')) {
      return;
    }
    setSavingDishIngredient(`delete-${ingredientId}`);
    try {
      await adminDishesApi.deleteDishIngredient(selectedDishId, ingredientId);
      toast.success(t('adminDishIngredientDeleted') || 'Đã xóa nguyên liệu khỏi món');
      fetchDishIngredients(selectedDishId);
    } catch (error) {
      const message =
        error?.response?.data?.detail || t('adminDishIngredientUpdateError') || 'Không thể xóa nguyên liệu khỏi món.';
      toast.error(message);
    } finally {
      setSavingDishIngredient(null);
    }
  };

  const renderDishList = useMemo(() => {
    if (loadingDishes) {
      return (
        <div className="py-4 text-center">
          <Spinner animation="border" />
        </div>
      );
    }

    if (!dishes.length) {
      return (
        <div className="text-muted text-center py-4">
          Không có món ăn nào.
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
                  {dish.name_vi || dish.name_en || 'Món ăn'}
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
  }, [dishes, loadingDishes, selectedDishId, t]);

  return (
    <div className="admin-ingredient-management">
      <div className="mb-4">
        <h3 className="fw-bold mb-2">Quản lý nguyên liệu</h3>
        <p className="text-muted mb-0">
          Liên kết nguyên liệu với từng món ăn, điều chỉnh số lượng và cập nhật nhanh.
        </p>
      </div>

      <Row className="g-3 g-lg-4">
        <Col lg={4}>
          <Card className={`h-100 shadow-sm d-flex flex-column ${darkMode ? 'bg-dark text-light' : ''}`} style={{ border: darkMode ? '1px solid rgba(255, 107, 44, 0.2)' : undefined }}>
            <Card.Header className={`${darkMode ? 'bg-dark border-secondary' : 'bg-white'} border-bottom`} style={{ position: 'sticky', top: 0, zIndex: 10 }}>
              <div className="d-flex justify-content-between align-items-center mb-3">
                <h5 className="mb-0 fw-semibold">Tìm kiếm món</h5>
                <Button 
                  variant="link" 
                  size="sm" 
                  onClick={() => fetchDishes(dishSearch.trim())}
                  className="p-0 text-decoration-none"
                  style={{ fontWeight: '500' }}
                  title="Tải lại danh sách"
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
                  fetchDishes(dishSearch.trim());
                }}
              >
                <Form.Group className="mb-0">
                  <div className="d-flex gap-2 flex-nowrap">
                    <Form.Control
                      type="text"
                      value={dishSearch}
                      placeholder="Tìm theo tên món hoặc class ID..."
                      onChange={(e) => setDishSearch(e.target.value)}
                      className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                      style={{ borderRadius: '8px' }}
                    />
                    <Button 
                      type="submit" 
                      className="auth-primary-btn flex-shrink-0"
                      style={{ borderRadius: '8px', padding: '0.5rem 1rem', fontWeight: '500', minWidth: 'auto' }}
                    >
                      Tìm kiếm
                    </Button>
                    {dishSearch && (
                      <Button
                        type="button"
                        variant="outline-secondary"
                        onClick={() => {
                          setDishSearch('');
                          fetchDishes('');
                        }}
                        className="flex-shrink-0"
                        style={{ borderRadius: '8px', padding: '0.5rem 1rem', fontWeight: '500', minWidth: 'auto' }}
                        title="Xóa"
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
                  Tìm thấy <strong className={darkMode ? 'text-light' : 'text-dark'}>{dishes.length}</strong> món ăn
                </span>
              </div>
              <div className="list-wrapper flex-grow-1" style={{ maxHeight: 'calc(100vh - 300px)', overflowY: 'auto', minHeight: '200px' }}>
                {renderDishList}
              </div>
            </Card.Body>
          </Card>
        </Col>

        <Col lg={8}>
          {selectedDishId && dishes.length > 0 && dishes.some(d => d.id === selectedDishId) ? (
            <Card className={`shadow-sm h-100 ${darkMode ? 'bg-dark text-light' : ''}`} style={{ border: darkMode ? '1px solid rgba(255, 107, 44, 0.2)' : undefined }}>
              <Card.Header className={`${darkMode ? 'bg-dark border-secondary' : 'bg-white'} border-bottom`}>
                <div className="d-flex justify-content-between align-items-center">
                  <div>
                    <h5 className="mb-1 fw-semibold">
                      {dishes.find(d => d.id === selectedDishId)?.name_vi || 
                       dishes.find(d => d.id === selectedDishId)?.name_en || 
                       'Nguyên liệu của món'}
                    </h5>
                    <small className="text-muted">
                      Liên kết nguyên liệu và cập nhật số lượng.
                    </small>
                  </div>
                  <Button
                    variant="link"
                    size="sm"
                    onClick={() => {
                      fetchDishIngredients(selectedDishId);
                      fetchIngredients(ingredientSearch.trim());
                    }}
                    className="p-0 text-decoration-none"
                    style={{ fontWeight: '500' }}
                    title="Tải lại"
                  >
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                      <path d="M3 12a9 9 0 0 1 9-9 9.75 9.75 0 0 1 6.74 2.74L21 8" />
                      <path d="M21 3v5h-5" />
                      <path d="M21 12a9 9 0 0 1-9 9 9.75 9.75 0 0 1-6.74-2.74L3 16" />
                      <path d="M3 21v-5h5" />
                    </svg>
                  </Button>
                </div>
              </Card.Header>
              <Card.Body>
                <div className="mb-4">
                  <Form.Label className="fw-semibold mb-2">Kho nguyên liệu</Form.Label>
                  <Form
                    className="mb-3"
                    onSubmit={(e) => {
                      e.preventDefault();
                      fetchIngredients(ingredientSearch.trim());
                    }}
                  >
                    <div className="d-flex gap-2 flex-nowrap">
                      <Form.Control
                        type="text"
                        placeholder="Tìm theo tên nguyên liệu..."
                        value={ingredientSearch}
                        onChange={(e) => setIngredientSearch(e.target.value)}
                        className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                        style={{ borderRadius: '8px' }}
                      />
                      <Button 
                        type="submit" 
                        className="auth-primary-btn flex-shrink-0"
                        style={{ borderRadius: '8px', padding: '0.5rem 1rem', fontWeight: '500', minWidth: 'auto' }}
                      >
                        Tìm kiếm
                      </Button>
                      {ingredientSearch && (
                        <Button
                          type="button"
                          variant="outline-secondary"
                          onClick={() => {
                            setIngredientSearch('');
                            fetchIngredients('');
                          }}
                          className="flex-shrink-0"
                          style={{ borderRadius: '8px', padding: '0.5rem 1rem', fontWeight: '500', minWidth: 'auto' }}
                          title="Xóa"
                        >
                          ✕
                        </Button>
                      )}
                    </div>
                  </Form>
                </div>

                <Card className={`border mb-4 ${darkMode ? 'border-secondary' : ''}`} style={{ borderRadius: '12px', background: darkMode ? '#1a1a1a' : '#f8f9fa' }}>
                  <Card.Body className="p-3">
                    <Form.Label className="fw-semibold mb-3">Thêm nguyên liệu mới</Form.Label>
                    <Form onSubmit={handleLinkIngredientSubmit}>
                      <Row className="g-2">
                        <Col md={6}>
                          <Form.Select
                            value={linkForm.ingredient_id}
                            onChange={(e) => setLinkForm((prev) => ({ ...prev, ingredient_id: e.target.value }))}
                            className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                            style={{ borderRadius: '8px' }}
                          >
                            <option value="" style={{ backgroundColor: darkMode ? '#2d2d2d' : '#fff', color: darkMode ? '#fff' : '#000' }}>Chọn nguyên liệu...</option>
                            {ingredients.map((ingredient) => (
                              <option key={ingredient.id} value={ingredient.id} style={{ backgroundColor: darkMode ? '#2d2d2d' : '#fff', color: darkMode ? '#fff' : '#000' }}>
                                {ingredient.name_vi || ingredient.name_en || 'Nguyên liệu'}
                              </option>
                            ))}
                          </Form.Select>
                        </Col>
                        <Col md={4}>
                          <Form.Control
                            type="text"
                            placeholder="Số lượng"
                            value={linkForm.quantity}
                            onChange={(e) => setLinkForm((prev) => ({ ...prev, quantity: e.target.value }))}
                            className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                            style={{ borderRadius: '8px' }}
                          />
                        </Col>
                        <Col md={2}>
                          <Button 
                            type="submit" 
                            className="w-100 auth-primary-btn"
                            disabled={savingDishIngredient === 'create'}
                            style={{ borderRadius: '8px', fontWeight: '500' }}
                          >
                            {savingDishIngredient === 'create' && (
                              <Spinner animation="border" size="sm" className="me-1" />
                            )}
                            Thêm
                          </Button>
                        </Col>
                      </Row>
                    </Form>
                  </Card.Body>
                </Card>

                <div className="mb-3">
                  <h6 className="fw-semibold mb-3">
                    Nguyên liệu hiện tại
                    <Badge bg="secondary" className="ms-2">{dishIngredients.length}</Badge>
                  </h6>
                </div>

                {loadingDishIngredients ? (
                  <div className="py-4 text-center">
                    <Spinner animation="border" />
                  </div>
                ) : dishIngredients.length ? (
                  <div className="d-flex flex-column gap-2">
                    {dishIngredients.map((item) => {
                      const savingUpdate = savingDishIngredient === `update-${item.ingredient_id}`;
                      const savingDelete = savingDishIngredient === `delete-${item.ingredient_id}`;
                      return (
                        <Card key={item.ingredient_id} className={`border ${darkMode ? 'border-secondary' : ''}`} style={{ borderRadius: '8px', backgroundColor: darkMode ? '#1a1a1a' : undefined }}>
                          <Card.Body className="p-3">
                            <Row className="g-2 align-items-center">
                              <Col md={4}>
                                <div className="fw-semibold">
                                  {item.name_vi || item.name_en || 'Nguyên liệu'}
                                </div>
                              </Col>
                              <Col md={4}>
                                <Form.Control
                                  value={item.quantityDraft}
                                  onChange={(e) => handleDishIngredientQuantityChange(item.ingredient_id, e.target.value)}
                                  placeholder="Số lượng"
                                  className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                                  style={{ borderRadius: '8px' }}
                                />
                              </Col>
                              <Col md={4} className="d-flex gap-2 justify-content-end">
                                <Button
                                  size="sm"
                                  className="auth-primary-btn"
                                  onClick={() => handleSaveDishIngredientQuantity(item)}
                                  disabled={savingUpdate}
                                  style={{ borderRadius: '8px', fontWeight: '500', padding: '0.5rem 1rem' }}
                                >
                                  {savingUpdate && <Spinner animation="border" size="sm" className="me-1" />}
                                  Lưu
                                </Button>
                                <Button
                                  size="sm"
                                  variant="outline-danger"
                                  onClick={() => handleRemoveDishIngredient(item.ingredient_id)}
                                  disabled={savingDelete}
                                  style={{ borderRadius: '8px', fontWeight: '500', padding: '0.5rem 1rem' }}
                                >
                                  {savingDelete ? <Spinner animation="border" size="sm" /> : 'Xóa'}
                                </Button>
                              </Col>
                            </Row>
                          </Card.Body>
                        </Card>
                      );
                    })}
                  </div>
                ) : (
                  <Card className={`border ${darkMode ? 'border-secondary' : ''}`} style={{ borderRadius: '8px', backgroundColor: darkMode ? '#1a1a1a' : undefined }}>
                    <Card.Body className="text-center py-4">
                      <p className="text-muted mb-0">
                        Chưa có nguyên liệu nào cho món này.
                      </p>
                    </Card.Body>
                  </Card>
                )}
              </Card.Body>
            </Card>
          ) : (
            <Card className={`shadow-sm h-100 ${darkMode ? 'bg-dark text-light' : ''}`} style={{ border: darkMode ? '1px solid rgba(255, 107, 44, 0.2)' : undefined }}>
              <Card.Body className="d-flex align-items-center justify-content-center text-center">
                <div>
                  <h5>Chọn món để quản lý nguyên liệu</h5>
                  <p className="text-muted mb-0">
                    Hãy chọn một món ở danh sách bên trái để bắt đầu.
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

export default AdminIngredientManagement;

