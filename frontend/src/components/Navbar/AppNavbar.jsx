import React, { useState } from 'react';
import { Navbar, Container, Nav, Button, Dropdown } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';
import MobileSidebar from './MobileSidebar';

const AppNavbar = ({ onNavigate, activeTab, onTabChange }) => {
  const { isLoggedIn, currentUser, logout } = useAuth();
  const { darkMode, language, toggleDarkMode, toggleLanguage, setLanguage, t } = useTheme();
  const [showMobileSidebar, setShowMobileSidebar] = useState(false);

  const handleLogout = () => {
    logout(t);
  };

  return (
    <>
      <Navbar
        expand="lg"
        className="warm-navbar shadow-sm"
        style={{
          padding: '0.85rem 0',
          background: 'linear-gradient(135deg, #ffe2c5, #ffba86)'
        }}
        variant="light"
      >
        <Container fluid className="px-2 px-md-3 px-lg-4">
          {/* Hamburger Menu Button - Mobile Only */}
          <Button
            variant="link"
            className="d-lg-none me-2 p-2 text-warm-dark"
            onClick={() => setShowMobileSidebar(true)}
            style={{ 
              border: 'none',
              fontSize: '1.5rem',
              lineHeight: 1,
              minWidth: 'auto',
              padding: '0.5rem',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              borderRadius: '0.5rem',
              transition: 'all 0.2s ease'
            }}
            onMouseEnter={(e) => {
              e.currentTarget.style.backgroundColor = 'rgba(255, 107, 44, 0.1)';
            }}
            onMouseLeave={(e) => {
              e.currentTarget.style.backgroundColor = 'transparent';
            }}
            aria-label="Open menu"
          >
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M3 12H21" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/>
              <path d="M3 6H21" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/>
              <path d="M3 18H21" stroke="currentColor" strokeWidth="2" strokeLinecap="round"/>
            </svg>
          </Button>

          <Navbar.Brand
            href="#"
            onClick={(e) => { e.preventDefault(); onNavigate('main'); }}
            className="d-none d-lg-flex align-items-center gap-1 gap-md-2 fw-bold"
            style={{ 
              cursor: 'pointer', 
              letterSpacing: '0.5px', 
              color: '#ff6b2c',
              fontSize: 'clamp(1rem, 4vw, 1.5rem)'
            }}
          >
            <span style={{ fontSize: 'clamp(1.5rem, 5vw, 2rem)' }}>🍜</span>
            <span>{t('appName')}</span>
          </Navbar.Brand>
          
          {/* Mobile Title - Show on mobile only, no icon */}
          <div className="d-lg-none flex-grow-1" style={{ marginLeft: '5rem' }}>
            <span 
              className="fw-bold"
              style={{ 
                fontSize: 'clamp(0.85rem, 2.5vw, 1rem)',
                color: '#ff6b2c',
                lineHeight: 1.2,
                display: 'block'
              }}
            >
              {t('appName')}
            </span>
          </div>
          <Navbar.Toggle aria-controls="basic-navbar-nav" className="border-0 d-none" />
        <Navbar.Collapse id="basic-navbar-nav" className="justify-content-end mt-2 mt-lg-0 d-none d-lg-flex">
          <Nav className="align-items-center flex-wrap">
            <Dropdown className="me-2 me-md-3 mb-2 mb-lg-0">
              <Dropdown.Toggle
                variant="outline-secondary"
                className="rounded-4 px-2 px-md-3 py-2 fw-medium transition-all warm-control"
                style={{ fontSize: 'clamp(0.8rem, 2.5vw, 0.95rem)' }}
              >
                {language === 'vi' ? t('vietnamese') : t('english')}
              </Dropdown.Toggle>
              <Dropdown.Menu
                style={{
                  backgroundColor: darkMode ? '#212529' : '#fff',
                  border: darkMode ? '1px solid #495057' : '1px solid #dee2e6'
                }}
              >
                <Dropdown.Item
                  onClick={() => {
                    if (language !== 'vi') {
                      setLanguage('vi');
                    }
                  }}
                  active={language === 'vi'}
                  style={{
                    backgroundColor: language === 'vi' ? (darkMode ? '#495057' : '#e9ecef') : 'transparent',
                    color: darkMode ? '#fff' : '#212529'
                  }}
                >
                  {t('vietnamese')}
                </Dropdown.Item>
                <Dropdown.Item
                  onClick={() => {
                    if (language !== 'en') {
                      setLanguage('en');
                    }
                  }}
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
            <Button
              variant="outline-secondary"
              onClick={toggleDarkMode}
              className="rounded-4 px-2 px-md-3 py-2 me-2 me-md-3 mb-2 mb-lg-0 transition-all warm-control"
              style={{ fontSize: 'clamp(0.9rem, 2.5vw, 1rem)' }}
            >
              {darkMode ? '☀️' : '🌙'}
            </Button>
            {isLoggedIn ? (
              <>
                <div className="d-none d-md-flex align-items-center gap-2 me-2 me-md-3 text-warm-dark fw-medium">
                  <span className="fs-5">👤</span>
                  <span className="d-none d-lg-inline">{t('hello')}, </span>
                  <strong className="fw-bold">{currentUser}</strong>
                  <span className="d-none d-lg-inline">!</span>
                </div>
                <Nav.Link
                  onClick={handleLogout}
                  className="rounded-4 px-2 px-md-3 py-2 fw-medium transition-all warm-control text-warm-dark mb-2 mb-lg-0"
                  style={{ fontSize: 'clamp(0.8rem, 2.5vw, 0.95rem)' }}
                >
                  {t('logout')}
                </Nav.Link>
              </>
            ) : (
              <>
                <Nav.Link
                  onClick={() => onNavigate('login')}
                  className="rounded-4 px-2 px-md-3 py-2 text-warm-dark fw-medium me-2 mb-2 mb-lg-0 transition-all"
                  style={{ fontSize: 'clamp(0.8rem, 2.5vw, 0.95rem)' }}
                >
                  {t('login')}
                </Nav.Link>
                <Nav.Link
                  onClick={() => onNavigate('register')}
                  className="rounded-4 px-3 px-md-4 py-2 text-white fw-bold transition-all warm-cta mb-2 mb-lg-0"
                  style={{ fontSize: 'clamp(0.8rem, 2.5vw, 0.95rem)' }}
                >
                  {t('register')}
                </Nav.Link>
              </>
            )}
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>

    {/* Mobile Sidebar */}
    <MobileSidebar
      show={showMobileSidebar}
      onHide={() => setShowMobileSidebar(false)}
      onNavigate={onNavigate}
      activeTab={activeTab}
      onTabChange={onTabChange}
    />
    </>
  );
};

export default AppNavbar;

