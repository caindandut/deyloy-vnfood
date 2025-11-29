import React, { useState, useEffect, useMemo } from 'react';
import { Button, Spinner, Card, Badge, Row, Col, ProgressBar, Form } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';
import { shoppingListApi } from '../../services/api';
import { toast } from 'react-toastify';
import ShoppingListDetail from './ShoppingListDetail';

const ShoppingListTab = () => {
  const { isLoggedIn } = useAuth();
  const { darkMode, t, language } = useTheme();
  const [lists, setLists] = useState([]);
  const [loading, setLoading] = useState(false);
  const [selectedList, setSelectedList] = useState(null);
  const [showDetail, setShowDetail] = useState(false);
  const [searchTerm, setSearchTerm] = useState('');

  const normalizedSearch = searchTerm.trim().toLowerCase();

  const filteredLists = useMemo(() => {
    if (!normalizedSearch) return lists || [];
    return (lists || []).filter((list) =>
      list?.name?.toLowerCase().includes(normalizedSearch)
    );
  }, [lists, normalizedSearch]);

  const searchActive = normalizedSearch.length > 0;

  useEffect(() => {
    if (isLoggedIn) {
      fetchLists();
    }
  }, [isLoggedIn, language]);

  const fetchLists = async () => {
    setLoading(true);
    try {
      const response = await shoppingListApi.getAll(language);
      setLists(response.data);
    } catch (err) {
      console.error('Lỗi khi lấy danh sách mua sắm:', err);
      toast.error(t('unableToLoadShoppingLists') || 'Không thể tải danh sách mua sắm');
    } finally {
      setLoading(false);
    }
  };


  const handleDeleteList = async (listId, listName) => {
    try {
      await shoppingListApi.deleteList(listId);
      toast.success(t('shoppingListDeleted') || 'Đã xóa danh sách mua sắm');
      fetchLists();
      if (selectedList?.id === listId) {
        setSelectedList(null);
        setShowDetail(false);
      }
    } catch (err) {
      console.error('Lỗi khi xóa danh sách:', err);
      toast.error(err.response?.data?.detail || t('unableToDeleteShoppingList') || 'Không thể xóa danh sách mua sắm');
    }
  };

  const handleViewList = async (list) => {
    try {
      const response = await shoppingListApi.getDetail(list.id, language);
      setSelectedList(response.data);
      setShowDetail(true);
    } catch (err) {
      console.error('Lỗi khi lấy chi tiết danh sách:', err);
      toast.error(t('unableToLoadShoppingList') || 'Không thể tải chi tiết danh sách');
    }
  };

  if (!isLoggedIn) {
    return (
      <div className="text-center py-5">
        <p>{t('pleaseLogin')}</p>
        <Button variant="primary">{t('login')}</Button>
      </div>
    );
  }

  const handleListMetadataChange = (metadata) => {
    if (!metadata?.id) return;

    setLists((prev) =>
      prev.map((list) => {
        if (list.id !== metadata.id) return list;
        return {
          ...list,
          updated_at: metadata.updated_at || list.updated_at,
          checked_count:
            typeof metadata.checked_count === 'number' ? metadata.checked_count : list.checked_count,
          item_count: typeof metadata.item_count === 'number' ? metadata.item_count : list.item_count
        };
      })
    );

    setSelectedList((prev) => {
      if (!prev || prev.id !== metadata.id) return prev;
      return {
        ...prev,
        updated_at: metadata.updated_at || prev.updated_at,
        items: metadata.items || prev.items
      };
    });
  };

  if (showDetail && selectedList) {
    return (
      <ShoppingListDetail
        list={selectedList}
        onBack={() => {
          setShowDetail(false);
          setSelectedList(null);
          // Refresh lists to get the latest updated_at from server
          fetchLists();
        }}
        onRefresh={fetchLists}
        onMetadataChange={handleListMetadataChange}
      />
    );
  }

  return (
    <>
      <div className="mb-5">
        <h4 className={`display-6 fw-bold mb-3 ${darkMode ? 'text-white' : 'text-dark'}`}>
          {t('shoppingLists') || '🛒 Danh sách mua sắm'}
        </h4>
        <p className={`fs-5 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
          {t('shoppingListDescription') || 'Danh sách mua sắm được tạo tự động khi bạn nhận diện món ăn và thêm vào danh sách mua sắm.'}
        </p>
      </div>

      {loading && (
        <div className="text-center py-5">
          <Spinner animation="border" variant="primary" />
          <p className="mt-3 text-muted">{t('loading') || 'Đang tải...'}</p>
        </div>
      )}

      <div className="history-search mb-3">
        <Form.Control
          type="text"
          placeholder={t('searchShoppingLists') || 'Tìm kiếm danh sách mua sắm...'}
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          className={`rounded-pill px-3 py-2 history-search-input ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border'}`}
        />
      </div>

      {!loading && filteredLists.length === 0 && (
        <div className="text-center py-5">
          <p className={`fs-4 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
            {searchActive
              ? (t('noSearchResults') || 'Không tìm thấy kết quả')
              : (t('noShoppingLists') || 'Chưa có danh sách mua sắm nào. Hãy nhận diện món ăn và thêm vào danh sách mua sắm!')}
          </p>
          {searchActive && (
            <p className={darkMode ? 'text-secondary' : 'text-muted'}>
              {t('tryDifferentKeyword') || 'Hãy thử từ khóa khác hoặc xóa tìm kiếm.'}
            </p>
          )}
        </div>
      )}

      {!loading && filteredLists.length > 0 && (
        <Row className="g-4">
          {filteredLists.map((list) => {
            const totalItems = list.item_count || 0;
            const checkedItems = list.checked_count || 0;
            const progress = totalItems === 0 ? 0 : Math.round((checkedItems / totalItems) * 100);
            const updatedLabel = list.updated_at
              ? (() => {
                  // MySQL DATETIME is timezone-naive, stored in server's local time (Asia/Ho_Chi_Minh)
                  // Parse the string directly without timezone conversion
                  let dateStr = list.updated_at;
                  
                  // Check if it already has timezone info (Z or timezone offset like +07:00)
                  const hasTimezone = dateStr.includes('Z') || 
                                      /[+-]\d{2}:?\d{2}$/.test(dateStr) ||
                                      /[+-]\d{4}$/.test(dateStr);
                  
                  let date;
                  if (!hasTimezone) {
                    // MySQL format: "YYYY-MM-DD HH:MM:SS" - treat as local time (Asia/Ho_Chi_Minh)
                    // Replace space with T for ISO format, then add +07:00 for Asia/Ho_Chi_Minh
                    dateStr = dateStr.replace(' ', 'T') + '+07:00';
                    date = new Date(dateStr);
                  } else {
                    date = new Date(dateStr);
                  }
                  
                  // If invalid, try parsing as-is
                  if (isNaN(date.getTime())) {
                    // Fallback: parse as local time string
                    const parts = list.updated_at.split(' ');
                    if (parts.length === 2) {
                      const [datePart, timePart] = parts;
                      const [year, month, day] = datePart.split('-');
                      const [hour, minute, second] = timePart.split(':');
                      date = new Date(parseInt(year), parseInt(month) - 1, parseInt(day), 
                                     parseInt(hour), parseInt(minute), parseInt(second || 0));
                    } else {
                      date = new Date(list.updated_at);
                    }
                  }
                  
                  // Format using local timezone (Asia/Ho_Chi_Minh)
                  return date.toLocaleString(
                    language === 'vi' ? 'vi-VN' : 'en-US',
                    {
                      day: '2-digit',
                      month: '2-digit',
                      year: 'numeric',
                      hour: '2-digit',
                      minute: '2-digit',
                      second: '2-digit',
                      timeZone: 'Asia/Ho_Chi_Minh'
                    }
                  );
                })()
              : '-';

            return (
              <Col key={list.id} xs={12} md={6} xl={4}>
                <Card
                  className={`shopping-list-card shadow-sm h-100 ${
                    darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'
                  }`}
                  style={{ borderRadius: '1.2rem' }}
                >
                  <Card.Body className="p-4 d-flex flex-column gap-4">
                    <div>
                      <div className="d-flex align-items-start justify-content-between">
                        <div>
                          <small className="text-uppercase opacity-75">
                            {t('shoppingList') || 'Danh sách mua sắm'}
                          </small>
                          <h5 className="fw-bold mt-2 mb-1">{list.name}</h5>
                        </div>
                        <span role="img" aria-label="list" style={{ fontSize: '2rem' }}>
                          🧺
                        </span>
                      </div>
                      <p className={`mb-0 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
                        {(t('updatedAt') || 'Cập nhật gần nhất')}: {updatedLabel}
                      </p>
                    </div>

                    <div className="d-flex flex-column gap-3">
                      <div className="d-flex gap-2 flex-wrap">
                        <Badge
                          bg={darkMode ? 'secondary' : 'light'}
                          text={darkMode ? 'light' : 'dark'}
                          className="rounded-pill px-3 py-2"
                        >
                          {totalItems} {t('ingredients') || 'nguyên liệu'}
                        </Badge>
                        <Badge bg="success" className="rounded-pill px-3 py-2">
                          {checkedItems} {t('completed') || 'đã mua'}
                        </Badge>
                      </div>
                      <div>
                        <div className="d-flex justify-content-between mb-1">
                          <small className={darkMode ? 'text-secondary' : 'text-muted'}>
                            {t('checked') || 'Đã mua'}
                          </small>
                          <small className="fw-semibold">{progress}%</small>
                        </div>
                        <ProgressBar now={progress} variant={progress === 100 ? "success" : "warning"} style={{ height: '8px' }} />
                      </div>
                    </div>

                    <div className="d-flex gap-2 mt-auto">
                      <Button
                        variant="primary"
                        size="sm"
                        onClick={() => handleViewList(list)}
                        className="rounded-4 px-3 py-2 flex-grow-1 orange-btn"
                      >
                        {t('view') || 'Xem'}
                      </Button>
                      <Button
                        variant="outline-danger"
                        size="sm"
                        onClick={() => handleDeleteList(list.id, list.name)}
                        className="rounded-4 px-3 py-2"
                      >
                        🗑️
                      </Button>
                    </div>
                  </Card.Body>
                </Card>
              </Col>
            );
          })}
        </Row>
      )}
    </>
  );
};

export default ShoppingListTab;

