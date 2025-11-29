import React, { useMemo } from 'react';
import { Nav } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';

const Sidebar = ({ activeTab, onTabChange }) => {
  const { isLoggedIn, isAdmin } = useAuth();
  const { darkMode, t } = useTheme();

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
    <div
      data-theme={darkMode ? 'dark' : 'light'}
      className={`sidebar-container sticky-top ${darkMode ? 'bg-dark border-end border-secondary' : 'bg-light border-end'}`}
    >
      <div className="sidebar-nav-wrapper pe-lg-3">
        <Nav className="sidebar-nav d-flex flex-column">
          {menuItems.map((item) => {
            const isActive = activeTab === item.key;
            const handleClick = (e) => {
              e.preventDefault();
              e.stopPropagation();
              if (!isActive) {
                onTabChange(item.key);
              }
            };
            
            return (
              <div
                key={item.key}
                onClick={handleClick}
                role="button"
                tabIndex={0}
                onKeyDown={(e) => {
                  if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    handleClick(e);
                  }
                }}
                className={`sidebar-item rounded-4 transition-all ${
                  isActive
                    ? 'sidebar-item-active text-white fw-semibold'
                    : `${darkMode ? 'text-secondary' : 'text-dark'} fw-medium`
                }`}
              >
                <span className="sidebar-item-icon" aria-hidden="true">{item.icon}</span>
                <span className="sidebar-item-label">{item.label}</span>
              </div>
            );
          })}
        </Nav>
      </div>
    </div>
  );
};

export default Sidebar;

