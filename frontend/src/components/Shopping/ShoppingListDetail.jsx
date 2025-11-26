import React, { useState, useEffect } from 'react';
import { Button, Form, Card, Row, Col, ProgressBar } from 'react-bootstrap';
import { useTheme } from '../../contexts/ThemeContext';
import { shoppingListApi } from '../../services/api';
import { toast } from 'react-toastify';

const ShoppingListDetail = ({ list, onBack, onRefresh, onMetadataChange = () => {} }) => {
  const { darkMode, t, language } = useTheme();
  const [items, setItems] = useState(list.items || []);
  const [quantityDrafts, setQuantityDrafts] = useState(() =>
    (list.items || []).reduce((acc, item) => {
      acc[item.id] = item.quantity || '';
      return acc;
    }, {})
  );
  const [lastUpdated, setLastUpdated] = useState(list.updated_at || null);

  useEffect(() => {
    setItems(list.items || []);
    setQuantityDrafts(
      (list.items || []).reduce((acc, item) => {
        acc[item.id] = item.quantity || '';
        return acc;
      }, {})
    );
    setLastUpdated(list.updated_at || null);
  }, [list.id]);

  const updateLocalTimestamp = (explicitTimestamp) => {
    const now = explicitTimestamp || new Date().toISOString();
    setLastUpdated(now);
    return now;
  };

  const emitMetadata = (updatedItems, updatedAt) => {
    const checked = updatedItems.filter((i) => i.is_checked).length;
    const total = updatedItems.length;
    onMetadataChange({
      id: list.id,
      updated_at: updatedAt,
      items: updatedItems,
      checked_count: checked,
      item_count: total
    });
  };

  const refreshListDetail = async () => {
    try {
      const response = await shoppingListApi.getDetail(list.id, language);
      const freshItems = response.data.items || [];
      setItems(freshItems);
      setQuantityDrafts(
        freshItems.reduce((acc, item) => {
          acc[item.id] = item.quantity || '';
          return acc;
        }, {})
      );
      const updatedAt = updateLocalTimestamp(response.data.updated_at);
      emitMetadata(freshItems, updatedAt);
    } catch (err) {
      console.error('Lỗi khi đồng bộ danh sách:', err);
    }
  };

  const handleToggleCheck = async (item) => {
    const newCheckedState = !item.is_checked;
    const optimisticItems = items.map(i => 
      i.id === item.id ? { ...i, is_checked: newCheckedState } : i
    );
    setItems(optimisticItems);
    
    const updatedAt = updateLocalTimestamp();
    
    emitMetadata(optimisticItems, updatedAt);
    
    try {
      const response = await shoppingListApi.updateItem(list.id, item.id, {
        is_checked: newCheckedState,
        ingredient_name: item.ingredient_name,
        quantity: item.quantity
      });
    } catch (err) {
      console.error('Lỗi khi cập nhật item:', err);
      toast.error(t('unableToUpdateItem') || 'Không thể cập nhật item');
      
      setItems(items);
      const revertedAt = updateLocalTimestamp();
      emitMetadata(items, revertedAt);
    }
  };

  const handleUpdateQuantity = async (item, newQuantity) => {
    if (newQuantity === (item.quantity || '')) {
      return;
    }

    try {
      const response = await shoppingListApi.updateItem(list.id, item.id, {
        ingredient_name: item.ingredient_name,
        quantity: newQuantity,
        is_checked: item.is_checked
      });
      
      await refreshListDetail();
      if (onRefresh) onRefresh();
    } catch (err) {
      console.error('Lỗi khi cập nhật số lượng:', err);
      toast.error(t('unableToUpdateItem') || 'Không thể cập nhật item');
    }
  };


  const handleDeleteItem = async (itemId) => {
    try {
      await shoppingListApi.deleteItem(list.id, itemId);
      await refreshListDetail();
      if (onRefresh) onRefresh();
      toast.success(t('itemDeleted') || 'Đã xóa item');
    } catch (err) {
      console.error('Lỗi khi xóa item:', err);
      toast.error(err.response?.data?.detail || t('unableToDeleteItem') || 'Không thể xóa item');
    }
  };

  const checkedCount = items.filter(i => i.is_checked).length;
  const totalCount = items.length;
  const remainingCount = Math.max(totalCount - checkedCount, 0);
  const progress = totalCount === 0 ? 0 : Math.round((checkedCount / totalCount) * 100);
  const formattedLastUpdated = lastUpdated
    ? new Date(lastUpdated).toLocaleString(language === 'vi' ? 'vi-VN' : 'en-US', {
        day: '2-digit',
        month: '2-digit',
        year: 'numeric',
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit'
      })
    : '-';

  return (
    <>
      <div className="d-flex justify-content-between align-items-start mb-4 flex-wrap gap-3">
        <div className="d-flex align-items-center gap-3">
          <Button
            variant="outline-secondary"
            onClick={onBack}
            className="rounded-4 px-3 py-2"
          >
            ← {t('back') || 'Quay lại'}
          </Button>
          <div>
            <p className={`mb-1 text-uppercase fw-semibold ${darkMode ? 'text-secondary' : 'text-muted'}`}>
              {t('shoppingList') || 'Danh sách mua sắm'}
            </p>
            <h4 className={`display-6 fw-bold mb-0 ${darkMode ? 'text-white' : 'text-dark'}`}>
              {list.name}
            </h4>
          </div>
        </div>
        <div className="text-end">
          <small className={darkMode ? 'text-secondary' : 'text-muted'}>
            {t('completed') || 'đã mua'}
          </small>
          <h5 className="fw-bold mb-1">{checkedCount}/{totalCount}</h5>
          <small className={darkMode ? 'text-secondary' : 'text-muted'}>
            {(t('updatedAt') || 'Cập nhật gần nhất')}: {formattedLastUpdated}
          </small>
        </div>
      </div>

      <Row className="g-4">
        <Col lg={8}>
          <Card className={`shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`} style={{ borderRadius: '1.2rem' }}>
            <Card.Body className="p-4">
              {items.length === 0 ? (
                <div className="text-center py-5">
                  <p className={`fs-4 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
                    {t('noItemsInList') || 'Danh sách trống. Hãy thêm nguyên liệu!'}
                  </p>
                </div>
              ) : (
                <div className="d-flex flex-column gap-3">
                  {items.map((item) => (
                    <Card
                      key={item.id}
                      className={`shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`}
                      style={{
                        borderRadius: '1rem',
                        textDecoration: item.is_checked ? 'line-through' : 'none',
                        opacity: item.is_checked ? 0.6 : 1
                      }}
                    >
                      <Card.Body className="p-4">
                        <div className="d-flex align-items-center gap-3">
                          <Form.Check
                            type="checkbox"
                            checked={item.is_checked || false}
                            onChange={() => handleToggleCheck(item)}
                            className="fs-5"
                          />
                          <div className="flex-grow-1">
                            <strong className="fs-5 fw-semibold">
                              {item.ingredient_display_name || item.ingredient_name}
                            </strong>
                            {item.quantity && (
                              <span className={`ms-2 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
                                ({item.quantity})
                              </span>
                            )}
                          </div>
                          <div className="d-flex gap-2 align-items-center">
                            <Form.Control
                              type="text"
                              size="sm"
                              value={quantityDrafts[item.id] ?? ''}
                              onChange={(e) => {
                                const value = e.target.value;
                                setQuantityDrafts((prev) => ({
                                  ...prev,
                                  [item.id]: value
                                }));
                              }}
                              onBlur={(e) => {
                                const value = e.target.value;
                                if (value !== (item.quantity || '')) {
                                  handleUpdateQuantity(item, value);
                                }
                              }}
                              placeholder={t('quantity') || 'Số lượng'}
                              className={`rounded-4 ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border'}`}
                              style={{ width: '120px' }}
                            />
                            <Button
                              variant="outline-danger"
                              size="sm"
                              onClick={() => handleDeleteItem(item.id)}
                              className="rounded-4 px-3"
                            >
                              🗑️
                            </Button>
                          </div>
                        </div>
                      </Card.Body>
                    </Card>
                  ))}
                </div>
              )}
            </Card.Body>
          </Card>
        </Col>
        <Col lg={4}>
          <Card className={`shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`} style={{ borderRadius: '1.2rem' }}>
            <Card.Body className="p-4 d-flex flex-column gap-4">
              <div>
                <p className="text-uppercase fw-semibold small mb-2">
                  {t('shoppingListOverview') || 'Tổng quan danh sách'}
                </p>
                <ProgressBar now={progress} variant={progress === 100 ? "success" : "warning"} style={{ height: '10px' }} />
                <div className="d-flex justify-content-between mt-2">
                  <small className={darkMode ? 'text-secondary' : 'text-muted'}>
                    {t('checked') || 'Đã mua'}
                  </small>
                  <small className="fw-semibold">{progress}%</small>
                </div>
              </div>
              <div className="d-flex flex-column gap-3">
                <div className="d-flex justify-content-between">
                  <div>
                    <small className={darkMode ? 'text-secondary' : 'text-muted'}>
                      {t('totalIngredients') || 'Tổng số nguyên liệu'}
                    </small>
                    <h5 className="mb-0">{totalCount}</h5>
                  </div>
                  <div>
                    <small className={darkMode ? 'text-secondary' : 'text-muted'}>
                      {t('completed') || 'Đã mua'}
                    </small>
                    <h5 className="mb-0 text-success">{checkedCount}</h5>
                  </div>
                </div>
                <div>
                  <small className={darkMode ? 'text-secondary' : 'text-muted'}>
                    {t('remainingItems') || 'Còn lại'}
                  </small>
                  <h5 className="mb-0 text-warning">{remainingCount}</h5>
                </div>
              </div>
              <div>
                  <small className={darkMode ? 'text-secondary' : 'text-muted'}>
                    {t('updatedAt') || 'Cập nhật gần nhất'}
                  </small>
                  <p className="mb-0 fw-semibold">
                    {formattedLastUpdated}
                  </p>
              </div>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </>
  );
};

export default ShoppingListDetail;

