import React, { useEffect, useMemo, useState } from 'react';
import { Card, Row, Col, Form, Button, Spinner, ListGroup, Badge } from 'react-bootstrap';
import { toast } from 'react-toastify';
import { adminDishesApi } from '../../services/api';
import { useTheme } from '../../contexts/ThemeContext';

const mapInstructionRows = (rows = []) =>
  rows.map((item) => ({
    ...item,
    step_number_input: item.step_number ?? '',
    image_url_input: item.image_url || '',
    description_vi: item.description_vi || '',
    description_en: item.description_en || ''
  }));

const AdminInstructionManagement = () => {
  const { t, darkMode } = useTheme();
  const [dishes, setDishes] = useState([]);
  const [dishSearch, setDishSearch] = useState('');
  const [loadingDishes, setLoadingDishes] = useState(false);
  const [selectedDishId, setSelectedDishId] = useState(null);

  const [instructions, setInstructions] = useState([]);
  const [loadingInstructions, setLoadingInstructions] = useState(false);
  const [newInstructionForm, setNewInstructionForm] = useState({ 
    step_number: '', 
    image_url: '', 
    description_vi: '', 
    description_en: '' 
  });
  const [savingInstructionId, setSavingInstructionId] = useState(null);

  const fetchDishes = async (keyword = '') => {
    setLoadingDishes(true);
    try {
      const response = await adminDishesApi.getAll(keyword || undefined);
      const list = response.data?.dishes || [];
      setDishes(list);
      if (!selectedDishId && list.length) {
        setSelectedDishId(list[0].id);
      } else if (list.every((dish) => dish.id !== selectedDishId)) {
        setSelectedDishId(list[0]?.id || null);
      }
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminListLoadError') || 'Không thể tải danh sách món ăn.';
      toast.error(message);
    } finally {
      setLoadingDishes(false);
    }
  };

  const fetchInstructions = async (dishId) => {
    if (!dishId) {
      setInstructions([]);
      return;
    }
    setLoadingInstructions(true);
    try {
      const response = await adminDishesApi.getInstructions(dishId);
      setInstructions(mapInstructionRows(response.data?.instructions || []));
    } catch (error) {
      const message =
        error?.response?.data?.detail || t('adminInstructionLoadError') || 'Không thể tải hướng dẫn.';
      toast.error(message);
    } finally {
      setLoadingInstructions(false);
    }
  };

  useEffect(() => {
    fetchDishes();
  }, []);

  useEffect(() => {
    if (selectedDishId) {
      fetchInstructions(selectedDishId);
    } else {
      setInstructions([]);
    }
  }, [selectedDishId]);

  const handleInstructionFieldChange = (instructionId, field, value) => {
    setInstructions((prev) =>
      prev.map((item) => (item.id === instructionId ? { ...item, [field]: value } : item))
    );
  };

  const handleSaveInstruction = async (instruction) => {
    if (!selectedDishId) return;
    const payload = {};
    if (instruction.step_number_input === '' || Number.isNaN(Number(instruction.step_number_input))) {
      toast.error(t('adminStepNumberRequired') || 'Số thứ tự phải là số.');
      return;
    }
    const parsedStep = Number(instruction.step_number_input);
    if (parsedStep !== instruction.step_number) {
      payload.step_number = parsedStep;
    }
    if ((instruction.image_url || '') !== instruction.image_url_input) {
      payload.image_url = instruction.image_url_input;
    }

    setSavingInstructionId(instruction.id);
    try {
      if (Object.keys(payload).length) {
        await adminDishesApi.updateInstruction(selectedDishId, instruction.id, payload);
      }
      await adminDishesApi.updateInstructionTranslation(selectedDishId, instruction.id, 'vi', {
        description: instruction.description_vi || ''
      });
      await adminDishesApi.updateInstructionTranslation(selectedDishId, instruction.id, 'en', {
        description: instruction.description_en || ''
      });
      toast.success(t('adminInstructionUpdated') || 'Đã lưu bước hướng dẫn');
      fetchInstructions(selectedDishId);
    } catch (error) {
      const message =
        error?.response?.data?.detail || t('adminInstructionUpdateError') || 'Không thể lưu bước hướng dẫn.';
      toast.error(message);
    } finally {
      setSavingInstructionId(null);
    }
  };

  const handleDeleteInstruction = async (instructionId) => {
    setSavingInstructionId(instructionId);
    try {
      await adminDishesApi.deleteInstruction(selectedDishId, instructionId);
      toast.success(t('adminInstructionDeleted') || 'Đã xóa bước hướng dẫn');
      fetchInstructions(selectedDishId);
    } catch (error) {
      const message =
        error?.response?.data?.detail || t('adminInstructionDeleteError') || 'Không thể xóa bước hướng dẫn.';
      toast.error(message);
    } finally {
      setSavingInstructionId(null);
    }
  };

  const handleCreateInstruction = async (event) => {
    event.preventDefault();
    if (!selectedDishId) {
      toast.error(t('adminSelectDishFirst') || 'Hãy chọn món trước.');
      return;
    }
    const payload = {};
    if (newInstructionForm.step_number) {
      if (Number.isNaN(Number(newInstructionForm.step_number))) {
        toast.error(t('adminStepNumberRequired') || 'Số thứ tự phải là số.');
        return;
      }
      payload.step_number = Number(newInstructionForm.step_number);
    }
    if (newInstructionForm.image_url) {
      payload.image_url = newInstructionForm.image_url;
    }
    setSavingInstructionId('new');
    try {
      const response = await adminDishesApi.createInstruction(selectedDishId, payload);
      const newInstructionId = response.data?.instruction_id;
      
      // Tạo translations cho bước mới
      if (newInstructionId) {
        if (newInstructionForm.description_vi) {
          await adminDishesApi.updateInstructionTranslation(selectedDishId, newInstructionId, 'vi', {
            description: newInstructionForm.description_vi
          });
        }
        if (newInstructionForm.description_en) {
          await adminDishesApi.updateInstructionTranslation(selectedDishId, newInstructionId, 'en', {
            description: newInstructionForm.description_en
          });
        }
      }
      
      toast.success(t('adminInstructionCreated') || 'Đã thêm bước hướng dẫn');
      setNewInstructionForm({ step_number: '', image_url: '', description_vi: '', description_en: '' });
      fetchInstructions(selectedDishId);
    } catch (error) {
      const message =
        error?.response?.data?.detail || t('adminInstructionCreateError') || 'Không thể thêm bước hướng dẫn.';
      toast.error(message);
    } finally {
      setSavingInstructionId(null);
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
  }, [dishes, loadingDishes, selectedDishId, t]);

  return (
    <div className="admin-instruction-management">
      <div className="mb-4">
        <h3 className="fw-bold mb-2">{t('adminInstructionsTab') || 'Quản lý hướng dẫn nấu ăn'}</h3>
        <p className="text-muted mb-0">
          {t('adminInstructionTabDescription') ||
            'Thêm, chỉnh sửa, dịch và sắp xếp các bước hướng dẫn nấu ăn cho từng món.'}
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
                  onClick={() => fetchDishes(dishSearch.trim())}
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
                  fetchDishes(dishSearch.trim());
                }}
              >
                <Form.Group className="mb-0">
                  <div className="d-flex gap-2 flex-nowrap">
                    <Form.Control
                      type="text"
                      value={dishSearch}
                      placeholder={t('adminSearchPlaceholder') || 'Tìm theo tên hoặc class ID...'}
                      onChange={(e) => setDishSearch(e.target.value)}
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
                {renderDishList}
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
                      {dishes.find(d => d.id === selectedDishId)?.name_vi || 
                       dishes.find(d => d.id === selectedDishId)?.name_en || 
                       t('adminInstructions') || 'Hướng dẫn nấu ăn'}
                    </h5>
                    <small className="text-muted">
                      ID: {dishes.find(d => d.id === selectedDishId)?.id} · Class: {dishes.find(d => d.id === selectedDishId)?.class_id}
                    </small>
                  </div>
                  <Button
                    variant="link"
                    size="sm"
                    onClick={() => fetchInstructions(selectedDishId)}
                    className="p-0 text-decoration-none"
                    style={{ fontWeight: '500' }}
                    title={t('adminRefreshList') || t('refresh') || 'Tải lại'}
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

                  <Form onSubmit={handleCreateInstruction} className={`border rounded-3 p-3 mb-3 ${darkMode ? 'border-secondary' : ''}`} style={{ backgroundColor: darkMode ? '#1a1a1a' : undefined }}>
                    <Row className="g-3">
                      <Col md={3}>
                        <Form.Label className="fw-semibold mb-2">{t('step')}</Form.Label>
                        <Form.Control
                          type="number"
                          min="1"
                          value={newInstructionForm.step_number}
                          onChange={(e) => setNewInstructionForm((prev) => ({ ...prev, step_number: e.target.value }))}
                          placeholder="1"
                          className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                          style={{ borderRadius: '8px' }}
                        />
                      </Col>
                      <Col md={9}>
                        <Form.Label className="fw-semibold mb-2">{t('adminImageUrl') || 'Ảnh (URL)'}</Form.Label>
                        <Form.Control
                          type="text"
                          value={newInstructionForm.image_url}
                          onChange={(e) => setNewInstructionForm((prev) => ({ ...prev, image_url: e.target.value }))}
                          placeholder="https://example.com/step.jpg"
                          className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                          style={{ borderRadius: '8px' }}
                        />
                      </Col>
                      <Col md={6}>
                        <Form.Label className="fw-semibold mb-2">{t('vietnamese') || 'Tiếng Việt'}</Form.Label>
                        <Form.Control
                          as="textarea"
                          rows={3}
                          value={newInstructionForm.description_vi}
                          onChange={(e) => setNewInstructionForm((prev) => ({ ...prev, description_vi: e.target.value }))}
                          placeholder="Nhập mô tả bước bằng tiếng Việt..."
                          className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                          style={{ borderRadius: '8px', resize: 'vertical' }}
                        />
                      </Col>
                      <Col md={6}>
                        <Form.Label className="fw-semibold mb-2">{t('english') || 'English'}</Form.Label>
                        <Form.Control
                          as="textarea"
                          rows={3}
                          value={newInstructionForm.description_en}
                          onChange={(e) => setNewInstructionForm((prev) => ({ ...prev, description_en: e.target.value }))}
                          placeholder="Enter step description in English..."
                          className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                          style={{ borderRadius: '8px', resize: 'vertical' }}
                        />
                      </Col>
                      <Col md={12} className="d-flex justify-content-end">
                        <Button 
                          type="submit" 
                          className="auth-primary-btn" 
                          size="sm"
                          disabled={savingInstructionId === 'new'}
                          style={{ borderRadius: '8px', padding: '0.5rem 1rem', fontWeight: '500' }}
                        >
                          {savingInstructionId === 'new' && (
                            <Spinner animation="border" size="sm" className="me-2" />
                          )}
                          {t('add') || 'Thêm'}
                        </Button>
                      </Col>
                    </Row>
                  </Form>

                  {loadingInstructions ? (
                    <div className="py-4 text-center">
                      <Spinner animation="border" />
                    </div>
                  ) : instructions.length ? (
                    instructions.map((instruction, index) => {
                      const isSaving = savingInstructionId === instruction.id;
                      return (
                        <div key={instruction.id} className={`border rounded-3 p-3 mb-3 ${darkMode ? 'border-secondary' : ''}`} style={{ backgroundColor: darkMode ? '#1a1a1a' : undefined }}>
                          <Row className="g-3">
                            <Col md={3}>
                              <Form.Label className="small text-muted">{t('step')}</Form.Label>
                              <Form.Control
                                type="number"
                                min="1"
                                value={instruction.step_number_input}
                                onChange={(e) =>
                                  handleInstructionFieldChange(instruction.id, 'step_number_input', e.target.value)
                                }
                                className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                              />
                            </Col>
                            <Col md={9}>
                              <Form.Label className="small text-muted">{t('adminImageUrl') || 'Ảnh (URL)'}</Form.Label>
                              <Form.Control
                                type="text"
                                value={instruction.image_url_input}
                                onChange={(e) =>
                                  handleInstructionFieldChange(instruction.id, 'image_url_input', e.target.value)
                                }
                                className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                              />
                            </Col>
                            <Col md={6}>
                              <Form.Label className="small text-muted">{t('vietnamese')}</Form.Label>
                              <Form.Control
                                as="textarea"
                                rows={3}
                                value={instruction.description_vi}
                                onChange={(e) =>
                                  handleInstructionFieldChange(instruction.id, 'description_vi', e.target.value)
                                }
                                className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                              />
                            </Col>
                            <Col md={6}>
                              <Form.Label className="small text-muted">{t('english')}</Form.Label>
                              <Form.Control
                                as="textarea"
                                rows={3}
                                value={instruction.description_en}
                                onChange={(e) =>
                                  handleInstructionFieldChange(instruction.id, 'description_en', e.target.value)
                                }
                                className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                              />
                            </Col>
                          </Row>
                          <div className="d-flex flex-wrap gap-2 justify-content-end mt-3">
                            <Button
                              size="sm"
                              className="auth-primary-btn"
                              onClick={() => handleSaveInstruction(instruction)}
                              disabled={isSaving}
                              style={{ borderRadius: '8px', padding: '0.5rem 1rem', fontWeight: '500' }}
                            >
                              {isSaving && <Spinner animation="border" size="sm" className="me-1" />}
                              {t('adminSave') || 'Lưu'}
                            </Button>
                            <Button
                              size="sm"
                              variant="outline-danger"
                              onClick={() => handleDeleteInstruction(instruction.id)}
                              disabled={isSaving}
                              style={{ borderRadius: '8px', padding: '0.5rem 1rem', fontWeight: '500' }}
                            >
                              {t('delete')}
                            </Button>
                          </div>
                        </div>
                      );
                    })
                  ) : (
                    <div className="text-center text-muted py-4">
                      {t('adminNoInstructions') || 'Chưa có bước hướng dẫn nào cho món này.'}
                    </div>
                  )}
              </Card.Body>
            </Card>
          ) : (
            <Card className={`shadow-sm h-100 ${darkMode ? 'bg-dark text-light' : ''}`} style={{ border: darkMode ? '1px solid rgba(255, 107, 44, 0.2)' : undefined }}>
              <Card.Body className="d-flex align-items-center justify-content-center text-center">
                <div>
                  <h5>{t('adminSelectDish') || 'Chọn món để quản lý hướng dẫn'}</h5>
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

export default AdminInstructionManagement;

