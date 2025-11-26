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
  const [currentListId, setCurrentListId] = useState(list.id);

  useEffect(() => {
    // If switching to a different list, always update
    if (list.id !== currentListId) {
      setCurrentListId(list.id);
      setItems(list.items || []);
      setQuantityDrafts(
        (list.items || []).reduce((acc, item) => {
          acc[item.id] = item.quantity || '';
          return acc;
        }, {})
      );
      setLastUpdated(list.updated_at || null);
      return;
    }

    // Same list - update items but preserve lastUpdated if it's newer
    setItems(list.items || []);
    setQuantityDrafts(
      (list.items || []).reduce((acc, item) => {
        acc[item.id] = item.quantity || '';
        return acc;
      }, {})
    );
    
    // Only update lastUpdated if the new value is newer than current
    setLastUpdated(prev => {
      if (!list.updated_at) return prev;
      if (!prev) return list.updated_at;
      const prevTime = new Date(prev).getTime();
      const newTime = new Date(list.updated_at).getTime();
      return newTime > prevTime ? list.updated_at : prev;
    });
  }, [list.id, list.items, list.updated_at, currentListId]);

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

  const refreshListDetail = async (forceUseServerTime = false) => {
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
      // If forceUseServerTime is true (after update), always use server time
      // Otherwise, keep newer timestamp to prevent reverting to old time
      setLastUpdated(prev => {
        if (!response.data.updated_at) {
          emitMetadata(freshItems, prev);
          return prev;
        }
        if (forceUseServerTime || !prev) {
          emitMetadata(freshItems, response.data.updated_at);
          return response.data.updated_at;
        }
        const prevTime = new Date(prev).getTime();
        const serverTime = new Date(response.data.updated_at).getTime();
        const updatedAt = serverTime > prevTime ? response.data.updated_at : prev;
        emitMetadata(freshItems, updatedAt);
        return updatedAt;
      });
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
    
    // Use current lastUpdated for optimistic update, will be replaced by server time
    const tempUpdatedAt = lastUpdated || new Date().toISOString();
    emitMetadata(optimisticItems, tempUpdatedAt);
    
    try {
      await shoppingListApi.updateItem(list.id, item.id, {
        is_checked: newCheckedState,
        ingredient_name: item.ingredient_name,
        quantity: item.quantity
      });
      
      // Wait a moment for database to commit, then refresh to get server's updated_at
      // This ensures we get the correct timestamp from the database
      await new Promise(resolve => setTimeout(resolve, 200));
      // Force use server time after update
      await refreshListDetail(true);
    } catch (err) {
      console.error('Lỗi khi cập nhật item:', err);
      toast.error(t('unableToUpdateItem') || 'Không thể cập nhật item');
      
      // Revert to original state
      setItems(items);
      emitMetadata(items, lastUpdated);
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
    ? (() => {
        // MySQL DATETIME is timezone-naive, typically stored in UTC or server local time
        // If the string doesn't have timezone info (no Z or +/-), treat as UTC
        let dateStr = lastUpdated;
        // Check if it already has timezone info (Z or timezone offset like +07:00)
        const hasTimezone = dateStr.includes('Z') || 
                            /[+-]\d{2}:?\d{2}$/.test(dateStr) ||
                            /[+-]\d{4}$/.test(dateStr);
        if (!hasTimezone) {
          // MySQL format: "YYYY-MM-DD HH:MM:SS" - append Z to treat as UTC
          // Replace space with T for ISO format, then add Z
          dateStr = dateStr.replace(' ', 'T') + 'Z';
        }
        const date = new Date(dateStr);
        // If still invalid, try parsing as-is (might be in local time)
        if (isNaN(date.getTime())) {
          return new Date(lastUpdated).toLocaleString(language === 'vi' ? 'vi-VN' : 'en-US', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit',
            second: '2-digit',
            timeZone: 'Asia/Ho_Chi_Minh'
          });
        }
        return date.toLocaleString(language === 'vi' ? 'vi-VN' : 'en-US', {
          day: '2-digit',
          month: '2-digit',
          year: 'numeric',
          hour: '2-digit',
          minute: '2-digit',
          second: '2-digit',
          timeZone: 'Asia/Ho_Chi_Minh'
        });
      })()
    : '-';

  return (
    <>
      {/* Header Section */}
      <div className="mb-3 mb-md-4">
        <div className="d-flex align-items-center gap-2 gap-md-3 mb-3">
          <Button
            variant="outline-secondary"
            onClick={onBack}
            className="rounded-4 px-2 px-md-3 py-2 flex-shrink-0"
            style={{ fontSize: 'clamp(0.85rem, 2.5vw, 1rem)' }}
          >
            ← {t('back') || 'Quay lại'}
          </Button>
          <div className="flex-grow-1 min-w-0">
            <p className={`mb-1 text-uppercase fw-semibold small ${darkMode ? 'text-secondary' : 'text-muted'}`} style={{ fontSize: 'clamp(0.7rem, 2vw, 0.85rem)' }}>
              {t('shoppingList') || 'Danh sách mua sắm'}
            </p>
            <h4 className={`fw-bold mb-0 ${darkMode ? 'text-white' : 'text-dark'}`} style={{ fontSize: 'clamp(1.1rem, 3vw, 1.5rem)' }}>
              {list.name}
            </h4>
          </div>
        </div>
        <div className="d-flex justify-content-between align-items-center flex-wrap gap-2">
          <div>
            <small className={`d-block ${darkMode ? 'text-secondary' : 'text-muted'}`} style={{ fontSize: 'clamp(0.75rem, 2vw, 0.9rem)' }}>
              {t('completed') || 'đã mua'}
            </small>
            <h5 className="fw-bold mb-0" style={{ fontSize: 'clamp(1.25rem, 4vw, 1.75rem)' }}>{checkedCount}/{totalCount}</h5>
          </div>
          <div className="text-end text-md-start">
            <small className={`d-block ${darkMode ? 'text-secondary' : 'text-muted'}`} style={{ fontSize: 'clamp(0.7rem, 2vw, 0.85rem)' }}>
              {(t('updatedAt') || 'Cập nhật gần nhất')}: {formattedLastUpdated}
            </small>
          </div>
        </div>
      </div>

      {/* Overview Card - Moved to top */}
      <Row className="g-3 g-md-4 mb-3 mb-md-4">
        <Col xs={12}>
          <Card className={`shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`} style={{ borderRadius: '1.2rem' }}>
            <Card.Body className="p-3 p-md-4 d-flex flex-column gap-3 gap-md-4">
              <div>
                <p className="text-uppercase fw-semibold small mb-2" style={{ fontSize: 'clamp(0.7rem, 2vw, 0.85rem)' }}>
                  {t('shoppingListOverview') || 'Tổng quan danh sách'}
                </p>
                <ProgressBar now={progress} variant={progress === 100 ? "success" : "warning"} style={{ height: '10px' }} />
                <div className="d-flex justify-content-between mt-2">
                  <small className={darkMode ? 'text-secondary' : 'text-muted'} style={{ fontSize: 'clamp(0.75rem, 2vw, 0.9rem)' }}>
                    {t('checked') || 'Đã mua'}
                  </small>
                  <small className="fw-semibold" style={{ fontSize: 'clamp(0.75rem, 2vw, 0.9rem)' }}>{progress}%</small>
                </div>
              </div>
              <div className="d-flex flex-column gap-2 gap-md-3">
                <div className="d-flex justify-content-between">
                  <div>
                    <small className={`d-block ${darkMode ? 'text-secondary' : 'text-muted'}`} style={{ fontSize: 'clamp(0.75rem, 2vw, 0.9rem)' }}>
                      {t('totalIngredients') || 'Tổng số nguyên liệu'}
                    </small>
                    <h5 className="mb-0" style={{ fontSize: 'clamp(1.25rem, 4vw, 1.75rem)' }}>{totalCount}</h5>
                  </div>
                  <div className="text-end">
                    <small className={`d-block ${darkMode ? 'text-secondary' : 'text-muted'}`} style={{ fontSize: 'clamp(0.75rem, 2vw, 0.9rem)' }}>
                      {t('completed') || 'Đã mua'}
                    </small>
                    <h5 className="mb-0 text-success" style={{ fontSize: 'clamp(1.25rem, 4vw, 1.75rem)' }}>{checkedCount}</h5>
                  </div>
                </div>
                <div>
                  <small className={`d-block ${darkMode ? 'text-secondary' : 'text-muted'}`} style={{ fontSize: 'clamp(0.75rem, 2vw, 0.9rem)' }}>
                    {t('remainingItems') || 'Còn lại'}
                  </small>
                  <h5 className="mb-0 text-warning" style={{ fontSize: 'clamp(1.25rem, 4vw, 1.75rem)' }}>{remainingCount}</h5>
                </div>
              </div>
              <div>
                  <small className={`d-block ${darkMode ? 'text-secondary' : 'text-muted'}`} style={{ fontSize: 'clamp(0.75rem, 2vw, 0.9rem)' }}>
                    {t('updatedAt') || 'Cập nhật gần nhất'}
                  </small>
                  <p className="mb-0 fw-semibold" style={{ fontSize: 'clamp(0.85rem, 2.5vw, 1rem)' }}>
                    {formattedLastUpdated}
                  </p>
              </div>
            </Card.Body>
          </Card>
        </Col>
      </Row>

      {/* Ingredients List */}
      <Row className="g-3 g-md-4">
        <Col xs={12}>
          <Card className={`shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`} style={{ borderRadius: '1.2rem' }}>
            <Card.Body className="p-3 p-md-4">
              {items.length === 0 ? (
                <div className="text-center py-5">
                  <p className={`fs-4 ${darkMode ? 'text-secondary' : 'text-muted'}`} style={{ fontSize: 'clamp(1rem, 3vw, 1.5rem)' }}>
                    {t('noItemsInList') || 'Danh sách trống. Hãy thêm nguyên liệu!'}
                  </p>
                </div>
              ) : (
                <div className="d-flex flex-column gap-2 gap-md-3">
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
                      <Card.Body className="p-3 p-md-4">
                        <div className="d-flex align-items-center gap-2 gap-md-3 flex-wrap">
                          <Form.Check
                            type="checkbox"
                            checked={item.is_checked || false}
                            onChange={() => handleToggleCheck(item)}
                            className="fs-5 flex-shrink-0"
                            style={{ marginTop: '0.25rem' }}
                          />
                          <div className="flex-grow-1 min-w-0">
                            <strong className="fw-semibold d-block" style={{ fontSize: 'clamp(0.95rem, 2.5vw, 1.25rem)' }}>
                              {item.ingredient_display_name || item.ingredient_name}
                              {item.quantity && (
                                <span className={`ms-2 ${darkMode ? 'text-secondary' : 'text-muted'}`} style={{ fontSize: 'clamp(0.85rem, 2vw, 1rem)', fontWeight: 'normal' }}>
                                  ({item.quantity})
                                </span>
                              )}
                            </strong>
                          </div>
                          <div className="d-flex gap-2 align-items-center flex-shrink-0 w-100 w-md-auto">
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
                              className={`rounded-4 flex-grow-1 flex-md-grow-0 ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border'}`}
                              style={{ 
                                width: '100%',
                                maxWidth: '120px',
                                fontSize: 'clamp(0.85rem, 2vw, 0.95rem)'
                              }}
                            />
                            <Button
                              variant="outline-danger"
                              size="sm"
                              onClick={() => handleDeleteItem(item.id)}
                              className="rounded-4 px-2 px-md-3 flex-shrink-0"
                              style={{ minWidth: '44px' }}
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
      </Row>
    </>
  );
};

export default ShoppingListDetail;

