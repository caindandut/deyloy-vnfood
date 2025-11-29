import React, { useMemo, useState } from 'react';
import { Offcanvas, Nav, Button, Dropdown } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';

const MobileSidebar = ({ show, onHide, onNavigate, activeTab, onTabChange }) => {
  const { isLoggedIn, currentUser, logout, isAdmin } = useAuth();
  const { darkMode, language, toggleDarkMode, setLanguage, t } = useTheme();

  const modeText = darkMode ? t('lightMode') : t('darkMode');
  const modeIcon = darkMode ? '☀️' : '🌙';

  const handleLogout = () => {
    logout(t);
    onHide();
  };

  const handleTabClick = (key) => {
    if (onTabChange) {
      onTabChange(key);
    }
    if (key === 'dishes') {
      onNavigate('dishes');
    } else if (['upload', 'webcam', 'history', 'favorites', 'shopping', 'admin-dishes', 'admin-ingredients', 'admin-instructions', 'admin-users', 'admin-analytics'].includes(key)) {
      onNavigate('main', key);
    }
    onHide();
  };

  const menuItems = useMemo(() => {
    const items = [
      { key: 'upload', icon: '📤', label: t('uploadImage') },
      { key: 'webcam', icon: '📸', label: t('recognize') },
      { key: 'dishes', icon: '🍜', label: t('browseDishes') },
    ];

    if (isLoggedIn) {
      items.push(
        { key: 'history', icon: '📚', label: t('history') },
        { key: 'favorites', icon: '❤️', label: t('favorites') },
        { key: 'shopping', icon: '🛒', label: t('shoppingList') || 'Danh sách mua sắm' }
      );
    }

    if (isAdmin) {
      items.push(
        { key: 'admin-dishes', icon: '🛠️', label: t('adminDishes') || 'Quản lý món' },
        { key: 'admin-ingredients', icon: '🥕', label: t('adminIngredientsTab') || 'Quản lý nguyên liệu' },
        { key: 'admin-instructions', icon: '📘', label: t('adminInstructionsTab') || 'Quản lý hướng dẫn' },
        { key: 'admin-users', icon: '👥', label: t('adminUsersTab') || 'Quản lý người dùng' },
        { key: 'admin-analytics', icon: '📈', label: t('adminAnalyticsTab') || 'Thống kê' }
      );
    }
    
    return items;
  }, [isLoggedIn, isAdmin, t]);

  return (
    <Offcanvas
      show={show}
      onHide={onHide}
      placement="start"
      className={`mobile-sidebar ${darkMode ? 'bg-dark text-light' : 'bg-light'}`}
      style={{ width: '320px' }}
    >
      <Offcanvas.Header className="border-bottom pb-3">
        <Offcanvas.Title className="d-flex align-items-center gap-2 fw-bold" style={{ fontSize: '1.1rem', color: '#ff6b2c' }}>
          <span style={{ fontSize: '1.5rem' }}>🍜</span>
          <span>{t('appName')}</span>
        </Offcanvas.Title>
        <button
          type="button"
          className="btn-close"
          onClick={onHide}
          aria-label="Close"
          style={darkMode ? { filter: 'invert(1)' } : {}}
        />
      </Offcanvas.Header>

      <Offcanvas.Body className="d-flex flex-column p-0">
        {/* Menu Items */}
        <div className="mobile-sidebar-menu px-3 py-2">
          <Nav className="flex-column gap-2">
            {menuItems.map((item) => {
              const isActive = activeTab === item.key;
              return (
                <Nav.Link
                  key={item.key}
                  onClick={() => handleTabClick(item.key)}
                  className={`mobile-sidebar-item rounded-4 p-3 d-flex align-items-center gap-3 transition-all ${
                    isActive
                      ? 'mobile-sidebar-item-active text-white fw-semibold'
                      : `${darkMode ? 'text-light' : 'text-dark'} fw-medium`
                  }`}
                  style={{
                    background: isActive
                      ? 'linear-gradient(135deg, #ff9770, #ff5200)'
                      : 'transparent',
                    cursor: 'pointer'
                  }}
                >
                  <span className="mobile-sidebar-icon" style={{ fontSize: '1.5rem' }}>
                    {item.icon}
                  </span>
                  <span className="mobile-sidebar-label text-nowrap" style={{ fontSize: '0.85rem' }}>
                    {item.label}
                  </span>
                </Nav.Link>
              );
            })}
          </Nav>
        </div>

        <hr className="my-3" style={{ borderColor: darkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(255, 153, 66, 0.3)', margin: '0.75rem 0' }} />

        {/* Settings Section */}
        <div className="px-3 py-2">
          {/* Language Selector - Dropdown */}
          <Dropdown className="mb-2">
            <Dropdown.Toggle
              variant="light"
              className="w-100 d-flex align-items-center justify-content-between rounded-3 py-2 px-3 mobile-language-dropdown"
              style={{
                backgroundColor: '#fff',
                border: '1px solid #e0e0e0',
                color: '#333',
                fontWeight: '500',
                fontSize: '1rem',
                boxShadow: 'none'
              }}
            >
              <span>{language === 'vi' ? t('vietnamese') : t('english')}</span>
            </Dropdown.Toggle>
            <Dropdown.Menu
              className="w-100"
              style={{
                backgroundColor: darkMode ? '#212529' : '#fff',
                border: darkMode ? '1px solid #495057' : '1px solid #dee2e6'
              }}
            >
              <Dropdown.Item
                onClick={() => setLanguage('vi')}
                active={language === 'vi'}
                style={{
                  backgroundColor: language === 'vi' ? (darkMode ? '#495057' : '#e9ecef') : 'transparent',
                  color: darkMode ? '#fff' : '#212529'
                }}
              >
                {t('vietnamese')}
              </Dropdown.Item>
              <Dropdown.Item
                onClick={() => setLanguage('en')}
                active={language === 'en'}
                style={{
                  backgroundColor: language === 'en' ? (darkMode ? '#495057' : '#e9ecef') : 'transparent',
                  color: darkMode ? '#fff' : '#212529'
                }}
              >
                {t('english')}
              </Dropdown.Item>
            </Dropdown.Menu>
          </Dropdown>

          {/* Dark Mode Toggle */}
          <Button
            variant="light"
            onClick={toggleDarkMode}
            className="w-100 rounded-3 py-2 px-3 d-flex align-items-center gap-2 mb-2"
            style={{
              backgroundColor: '#fff',
              border: '1px solid #e0e0e0',
              color: '#333',
              fontWeight: '500',
              fontSize: '1rem',
              justifyContent: 'flex-start',
              boxShadow: 'none'
            }}
          >
            <span style={{ fontSize: '1.1rem', color: '#ff8f3f' }}>{modeIcon}</span>
            <span>{modeText}</span>
          </Button>
        </div>

        <hr className="my-3" style={{ borderColor: darkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(255, 153, 66, 0.3)', margin: '0.75rem 0' }} />

        {/* Auth Section */}
        <div className="px-3 py-2 mt-auto">
          {isLoggedIn ? (
            <div className="d-flex flex-column gap-2">
              <div 
                className="d-flex align-items-center gap-2 p-2 rounded-3 mb-2"
                style={{
                  backgroundColor: darkMode ? 'rgba(255, 255, 255, 0.1)' : 'rgba(255, 255, 255, 0.5)'
                }}
              >
                <span className="fs-4">👤</span>
                <div className="flex-grow-1">
                  <div className={`small ${darkMode ? 'text-light' : 'text-muted'}`}>{t('hello') || 'Xin chào'}</div>
                  <div className="fw-bold">{currentUser}</div>
                </div>
              </div>
              <Button
                variant="outline-danger"
                onClick={handleLogout}
                className="w-100 rounded-3 py-2 fw-semibold"
              >
                {t('logout')}
              </Button>
            </div>
          ) : (
            <div className="d-flex flex-column gap-2">
              <Button
                onClick={() => {
                  onNavigate('login');
                  onHide();
                }}
                className="w-100 rounded-3 py-2 fw-semibold"
                style={{
                  backgroundColor: '#007bff',
                  border: '1px solid #007bff',
                  color: '#fff',
                  fontSize: '1rem',
                  boxShadow: 'none'
                }}
              >
                {t('login')}
              </Button>
              <Button
                onClick={() => {
                  onNavigate('register');
                  onHide();
                }}
                className="w-100 rounded-3 py-2 fw-bold"
                style={{
                  background: 'linear-gradient(180deg, #ff8f3f, #ff5f00)',
                  border: 'none',
                  color: '#fff',
                  fontSize: '1rem',
                  boxShadow: 'none'
                }}
              >
                {t('register')}
              </Button>
            </div>
          )}
        </div>
      </Offcanvas.Body>
    </Offcanvas>
  );
};

export default MobileSidebar;

