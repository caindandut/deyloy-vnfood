import React, { useEffect, useState, useMemo } from 'react';
import { Card, Row, Col, Form, Button, Spinner, Table, Badge, Modal, Nav, Tab } from 'react-bootstrap';
import { toast } from 'react-toastify';
import { adminUsersApi } from '../../services/api';
import { useTheme } from '../../contexts/ThemeContext';

const AdminUserManagement = () => {
  const { t, language, darkMode } = useTheme();
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(false);
  const [search, setSearch] = useState('');
  const [roleFilter, setRoleFilter] = useState('');
  const [statusFilter, setStatusFilter] = useState('');
  const [updatingUserId, setUpdatingUserId] = useState(null);
  
  // Modal state
  const [showModal, setShowModal] = useState(false);
  const [selectedUser, setSelectedUser] = useState(null);
  const [activeTab, setActiveTab] = useState('history');
  const [historyData, setHistoryData] = useState([]);
  const [favoritesData, setFavoritesData] = useState([]);
  const [shoppingListsData, setShoppingListsData] = useState([]);
  const [loadingDetails, setLoadingDetails] = useState(false);

  const fetchUsers = async () => {
    setLoading(true);
    try {
      const params = {};
      if (search.trim()) params.search = search.trim();
      if (roleFilter) params.role = roleFilter;
      if (statusFilter) params.status = statusFilter;
      const response = await adminUsersApi.getAll(params);
      setUsers(response.data?.users || []);
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminUserLoadError') || 'Không thể tải danh sách người dùng.';
      toast.error(message);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleApplyFilters = (event) => {
    event.preventDefault();
    fetchUsers();
  };

  const handleClearFilters = () => {
    setSearch('');
    setRoleFilter('');
    setStatusFilter('');
    fetchUsers();
  };

  const handleUpdateRole = async (userId, newRole) => {
    setUpdatingUserId(userId);
    try {
      await adminUsersApi.updateRole(userId, newRole);
      toast.success(t('adminUserRoleUpdated') || 'Đã cập nhật quyền người dùng');
      await fetchUsers();
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminUserRoleUpdateError') || 'Không thể cập nhật quyền.';
      toast.error(message);
      fetchUsers().catch(() => {});
    } finally {
      setUpdatingUserId(null);
    }
  };

  const handleToggleStatus = async (userId, isActive) => {
    setUpdatingUserId(userId);
    try {
      await adminUsersApi.updateStatus(userId, isActive);
      toast.success(t('adminUserStatusUpdated') || 'Đã cập nhật trạng thái');
      fetchUsers();
    } catch (error) {
      const message = error?.response?.data?.detail || t('adminUserStatusUpdateError') || 'Không thể cập nhật trạng thái.';
      toast.error(message);
    } finally {
      setUpdatingUserId(null);
    }
  };

  const handleViewUserDetails = async (user) => {
    setSelectedUser(user);
    setShowModal(true);
    setActiveTab('history');
    setHistoryData([]);
    setFavoritesData([]);
    setShoppingListsData([]);
    
    // Load initial tab data
    await loadUserDetails(user.id, 'history');
  };

  const loadUserDetails = async (userId, tab) => {
    setLoadingDetails(true);
    try {
      if (tab === 'history') {
        const response = await adminUsersApi.getHistory(userId, language);
        setHistoryData(response.data || []);
      } else if (tab === 'favorites') {
        const response = await adminUsersApi.getFavorites(userId, language);
        setFavoritesData(response.data || []);
      } else if (tab === 'shopping-lists') {
        const response = await adminUsersApi.getShoppingLists(userId, language);
        setShoppingListsData(response.data || []);
      }
    } catch (error) {
      const message = error?.response?.data?.detail || 'Không thể tải dữ liệu.';
      toast.error(message);
    } finally {
      setLoadingDetails(false);
    }
  };

  const handleTabSelect = (tab) => {
    setActiveTab(tab);
    if (selectedUser) {
      loadUserDetails(selectedUser.id, tab);
    }
  };

  const handleCloseModal = () => {
    setShowModal(false);
    setSelectedUser(null);
    setHistoryData([]);
    setFavoritesData([]);
    setShoppingListsData([]);
  };

  const renderRoleBadge = (role) => {
    const lower = (role || 'user').toLowerCase();
    const isAdmin = lower === 'admin';
    return (
      <Badge 
        style={{
          background: isAdmin 
            ? 'linear-gradient(135deg, #ffb347, #ff6b2c)' 
            : '#6c757d',
          color: '#fff',
          padding: '0.4rem 0.8rem',
          borderRadius: '999px',
          fontWeight: '500'
        }}
      >
        {isAdmin ? (t('adminRoleAdmin') || 'Admin') : (t('adminRoleUser') || 'User')}
      </Badge>
    );
  };

  const renderStatusBadge = (isActive) => {
    return (
      <Badge 
        style={{
          background: isActive 
            ? 'linear-gradient(135deg, #28a745, #20c997)' 
            : '#dc3545',
          color: '#fff',
          padding: '0.4rem 0.8rem',
          borderRadius: '999px',
          fontWeight: '500'
        }}
      >
        {isActive ? (t('adminStatusActive') || 'Hoạt động') : (t('adminStatusLocked') || 'Đã khóa')}
      </Badge>
    );
  };

  const tableContent = useMemo(() => {
    if (loading) {
      return (
        <tr>
          <td colSpan="6" className="text-center py-4">
            <Spinner animation="border" />
          </td>
        </tr>
      );
    }

    if (!users.length) {
      return (
        <tr>
          <td colSpan="6" className="text-center py-4 text-muted">
            {t('adminNoUsers') || 'Không có người dùng nào.'}
          </td>
        </tr>
      );
    }

    return users.map((user) => {
      const isUpdating = updatingUserId === user.id;
      return (
        <tr 
          key={user.id}
          style={{
            cursor: 'pointer',
            transition: 'all 0.2s ease'
          }}
          onMouseEnter={(e) => {
            e.currentTarget.style.backgroundColor = '#f8f9fa';
          }}
          onMouseLeave={(e) => {
            e.currentTarget.style.backgroundColor = 'transparent';
          }}
          onClick={() => handleViewUserDetails(user)}
        >
          <td style={{ fontWeight: 'normal' }}>{user.username}</td>
          <td>{renderRoleBadge(user.role)}</td>
          <td>{renderStatusBadge(user.is_active)}</td>
          <td>{new Date(user.created_at).toLocaleString()}</td>
          <td>
            <Form.Select
              size="sm"
              value={user.role}
              disabled={isUpdating}
              onChange={(e) => {
                e.stopPropagation();
                handleUpdateRole(user.id, e.target.value);
              }}
              onClick={(e) => {
                e.stopPropagation();
              }}
              onMouseDown={(e) => {
                e.stopPropagation();
              }}
              onFocus={(e) => {
                e.stopPropagation();
              }}
              className={darkMode ? 'bg-dark text-light' : ''}
              style={{
                borderRadius: '8px',
                border: '1px solid rgba(255, 107, 44, 0.3)',
                backgroundColor: darkMode ? '#2d2d2d' : '#fff',
                color: darkMode ? '#fff' : '#000',
                width: '100px',
                minWidth: '100px',
                maxWidth: '100px'
              }}
            >
              <option value="user" style={{ backgroundColor: darkMode ? '#2d2d2d' : '#fff', color: darkMode ? '#fff' : '#000' }}>{t('adminRoleUser') || 'User'}</option>
              <option value="admin" style={{ backgroundColor: darkMode ? '#2d2d2d' : '#fff', color: darkMode ? '#fff' : '#000' }}>{t('adminRoleAdmin') || 'Admin'}</option>
            </Form.Select>
          </td>
          <td>
            <div className="d-flex gap-2" onClick={(e) => e.stopPropagation()}>
              <Button
                size="sm"
                variant={user.is_active ? 'outline-danger' : 'outline-success'}
                disabled={isUpdating}
                onClick={() => handleToggleStatus(user.id, !user.is_active)}
                style={{ 
                  borderRadius: '8px', 
                  fontWeight: '500'
                }}
              >
                {user.is_active ? (t('adminLock') || 'Khóa') : (t('adminUnlock') || 'Mở khóa')}
              </Button>
            </div>
          </td>
        </tr>
      );
    });
  }, [users, loading, updatingUserId, t]);

  return (
    <div className="admin-user-management">
      <div className="mb-4">
        <h3 className="fw-bold mb-2">{t('adminUsersTab') || 'Quản lý người dùng'}</h3>
        <p className="text-muted mb-0">
          {t('adminUsersDescription') || 'Theo dõi danh sách người dùng, phân quyền và kiểm soát trạng thái tài khoản.'}
        </p>
      </div>

      <Row className="g-3 g-lg-4">
        <Col lg={12}>
          <Card className="shadow-sm mb-3" style={{ borderRadius: '1rem', border: '1px solid rgba(255, 107, 44, 0.15)' }}>
            <Card.Body>
              <Form onSubmit={handleApplyFilters}>
                <Row className="g-2">
                  <Col md={4}>
                    <Form.Label className="fw-semibold">Tìm kiếm người dùng</Form.Label>
                    <Form.Control
                      type="text"
                      placeholder="Nhập username..."
                      value={search}
                      onChange={(e) => setSearch(e.target.value)}
                      style={{ borderRadius: '8px', border: '1px solid rgba(255, 107, 44, 0.3)' }}
                    />
                  </Col>
                  <Col md={3}>
                    <Form.Label className="fw-semibold">Quyền</Form.Label>
                    <Form.Select 
                      value={roleFilter} 
                      onChange={(e) => setRoleFilter(e.target.value)}
                      style={{ borderRadius: '8px', border: '1px solid rgba(255, 107, 44, 0.3)' }}
                    >
                      <option value="">Tất cả quyền</option>
                      <option value="user">User</option>
                      <option value="admin">Admin</option>
                    </Form.Select>
                  </Col>
                  <Col md={3}>
                    <Form.Label className="fw-semibold">Trạng thái</Form.Label>
                    <Form.Select 
                      value={statusFilter} 
                      onChange={(e) => setStatusFilter(e.target.value)}
                      style={{ borderRadius: '8px', border: '1px solid rgba(255, 107, 44, 0.3)' }}
                    >
                      <option value="">Tất cả trạng thái</option>
                      <option value="active">Hoạt động</option>
                      <option value="inactive">Đã khóa</option>
                    </Form.Select>
                  </Col>
                  <Col md={2} className="d-flex align-items-end">
                    <Button type="submit" className="auth-primary-btn w-100" style={{ borderRadius: '8px', fontWeight: '500', whiteSpace: 'nowrap' }}>
                      Tìm kiếm
                    </Button>
                  </Col>
                </Row>
              </Form>
            </Card.Body>
          </Card>

          <Card className="shadow-sm" style={{ borderRadius: '1rem', border: '1px solid rgba(255, 107, 44, 0.15)' }}>
            <Card.Body className="p-0">
              <div className="table-responsive">
                <Table hover className="mb-0 align-middle">
                  <thead>
                    <tr style={{ 
                      background: 'linear-gradient(135deg, rgba(255, 179, 71, 0.1), rgba(255, 107, 44, 0.1))',
                      borderBottom: '2px solid rgba(255, 107, 44, 0.2)'
                    }}>
                      <th style={{ fontWeight: '600', color: '#ff6b2c', padding: '1rem', whiteSpace: 'nowrap' }}>{t('username') || 'Username'}</th>
                      <th style={{ fontWeight: '600', color: '#ff6b2c', padding: '1rem', whiteSpace: 'nowrap' }}>{t('adminRole') || 'Quyền'}</th>
                      <th style={{ fontWeight: '600', color: '#ff6b2c', padding: '1rem', whiteSpace: 'nowrap' }}>{t('status') || 'Trạng thái'}</th>
                      <th style={{ fontWeight: '600', color: '#ff6b2c', padding: '1rem', whiteSpace: 'nowrap' }}>{t('createdAt') || 'Ngày tạo'}</th>
                      <th style={{ fontWeight: '600', color: '#ff6b2c', padding: '1rem', whiteSpace: 'nowrap' }}>{t('adminChangeRole') || 'Phân quyền'}</th>
                      <th style={{ fontWeight: '600', color: '#ff6b2c', padding: '1rem', whiteSpace: 'nowrap' }}>{t('actions') || 'Hành động'}</th>
                    </tr>
                  </thead>
                  <tbody>{tableContent}</tbody>
                </Table>
              </div>
            </Card.Body>
          </Card>
        </Col>
      </Row>

      {/* User Details Modal */}
      <Modal 
        show={showModal} 
        onHide={handleCloseModal} 
        size="lg"
        centered
        style={{ zIndex: 1050 }}
      >
        <Modal.Header closeButton style={{ borderBottom: '2px solid rgba(255, 107, 44, 0.2)' }}>
          <Modal.Title style={{ color: '#ff6b2c', fontWeight: '600' }}>
            {selectedUser && (
              <div className="d-flex align-items-center gap-3">
                <div>
                  <div className="fw-bold">{selectedUser.username}</div>
                  <div className="d-flex gap-2 mt-1">
                    {renderRoleBadge(selectedUser.role)}
                    {renderStatusBadge(selectedUser.is_active)}
                  </div>
                </div>
              </div>
            )}
          </Modal.Title>
        </Modal.Header>
        <Modal.Body style={{ padding: 0 }}>
          <Tab.Container activeKey={activeTab} onSelect={handleTabSelect}>
            <Nav variant="tabs" style={{ borderBottom: '2px solid rgba(255, 107, 44, 0.2)', padding: '0 1rem' }}>
              <Nav.Item>
                <Nav.Link eventKey="history" style={{ color: activeTab === 'history' ? '#ff6b2c' : '#6c757d', fontWeight: activeTab === 'history' ? '600' : 'normal' }}>
                  Lịch sử nhận diện
                </Nav.Link>
              </Nav.Item>
              <Nav.Item>
                <Nav.Link eventKey="favorites" style={{ color: activeTab === 'favorites' ? '#ff6b2c' : '#6c757d', fontWeight: activeTab === 'favorites' ? '600' : 'normal' }}>
                  Món yêu thích
                </Nav.Link>
              </Nav.Item>
              <Nav.Item>
                <Nav.Link eventKey="shopping-lists" style={{ color: activeTab === 'shopping-lists' ? '#ff6b2c' : '#6c757d', fontWeight: activeTab === 'shopping-lists' ? '600' : 'normal' }}>
                  Danh sách mua sắm
                </Nav.Link>
              </Nav.Item>
            </Nav>
            <Tab.Content style={{ padding: '1.5rem', maxHeight: '60vh', overflowY: 'auto' }}>
              <Tab.Pane eventKey="history">
                {loadingDetails ? (
                  <div className="text-center py-4">
                    <Spinner animation="border" />
                  </div>
                ) : historyData.length === 0 ? (
                  <div className="text-center py-4 text-muted">
                    Không có lịch sử nhận diện
                  </div>
                ) : (
                  <div className="d-flex flex-column gap-3">
                    {historyData.map((item) => (
                      <Card key={item.history_id} style={{ border: '1px solid rgba(255, 107, 44, 0.2)', borderRadius: '8px' }}>
                        <Card.Body>
                          <div className="d-flex gap-3">
                            {item.image_url && (
                              <img 
                                src={item.image_url} 
                                alt={item.name || 'Dish'} 
                                style={{ width: '80px', height: '80px', objectFit: 'cover', borderRadius: '8px' }}
                              />
                            )}
                            <div className="flex-grow-1">
                              <h6 className="mb-1" style={{ color: '#ff6b2c', fontWeight: '600' }}>
                                {item.name || 'Món ăn'}
                              </h6>
                              <p className="text-muted small mb-0">
                                {new Date(item.recognized_at).toLocaleString()}
                              </p>
                            </div>
                          </div>
                        </Card.Body>
                      </Card>
                    ))}
                  </div>
                )}
              </Tab.Pane>
              <Tab.Pane eventKey="favorites">
                {loadingDetails ? (
                  <div className="text-center py-4">
                    <Spinner animation="border" />
                  </div>
                ) : favoritesData.length === 0 ? (
                  <div className="text-center py-4 text-muted">
                    Không có món yêu thích
                  </div>
                ) : (
                  <div className="d-flex flex-column gap-3">
                    {favoritesData.map((item) => (
                      <Card key={item.id} style={{ border: '1px solid rgba(255, 107, 44, 0.2)', borderRadius: '8px' }}>
                        <Card.Body>
                          <div className="d-flex gap-3">
                            {item.image_url && (
                              <img 
                                src={item.image_url} 
                                alt={item.name || 'Dish'} 
                                style={{ width: '80px', height: '80px', objectFit: 'cover', borderRadius: '8px' }}
                              />
                            )}
                            <div className="flex-grow-1">
                              <h6 className="mb-1" style={{ color: '#ff6b2c', fontWeight: '600' }}>
                                {item.name || 'Món ăn'}
                              </h6>
                              <p className="text-muted small mb-0">
                                Đã thêm: {new Date(item.created_at).toLocaleString()}
                              </p>
                            </div>
                          </div>
                        </Card.Body>
                      </Card>
                    ))}
                  </div>
                )}
              </Tab.Pane>
              <Tab.Pane eventKey="shopping-lists">
                {loadingDetails ? (
                  <div className="text-center py-4">
                    <Spinner animation="border" />
                  </div>
                ) : shoppingListsData.length === 0 ? (
                  <div className="text-center py-4 text-muted">
                    Không có danh sách mua sắm
                  </div>
                ) : (
                  <div className="d-flex flex-column gap-3">
                    {shoppingListsData.map((list) => (
                      <Card key={list.id} style={{ border: '1px solid rgba(255, 107, 44, 0.2)', borderRadius: '8px' }}>
                        <Card.Body>
                          <h6 className="mb-2" style={{ color: '#ff6b2c', fontWeight: '600' }}>
                            {list.name || 'Danh sách mua sắm'}
                          </h6>
                          <p className="text-muted small mb-2">
                            {list.item_count || 0} mục • {list.checked_count || 0} đã mua
                          </p>
                          {list.items && list.items.length > 0 && (
                            <div className="mt-2">
                              <div className="small text-muted mb-1">Các mục:</div>
                              <ul className="mb-0" style={{ fontSize: '0.85rem' }}>
                                {list.items.slice(0, 5).map((item) => (
                                  <li key={item.id}>
                                    {item.ingredient_display_name || item.ingredient_name} 
                                    {item.quantity && ` (${item.quantity})`}
                                    {item.is_checked && ' ✓'}
                                  </li>
                                ))}
                                {list.items.length > 5 && (
                                  <li className="text-muted">... và {list.items.length - 5} mục khác</li>
                                )}
                              </ul>
                            </div>
                          )}
                          <p className="text-muted small mb-0 mt-2">
                            Cập nhật: {new Date(list.updated_at).toLocaleString()}
                          </p>
                        </Card.Body>
                      </Card>
                    ))}
                  </div>
                )}
              </Tab.Pane>
            </Tab.Content>
          </Tab.Container>
        </Modal.Body>
        <Modal.Footer style={{ borderTop: '2px solid rgba(255, 107, 44, 0.2)' }}>
          <Button variant="secondary" onClick={handleCloseModal} style={{ borderRadius: '8px' }}>
            Đóng
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
};

export default AdminUserManagement;
