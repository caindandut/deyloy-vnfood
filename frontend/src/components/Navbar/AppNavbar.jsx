import React from 'react';
import { Navbar, Container, Nav, Button, Dropdown } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';

const AppNavbar = ({ onNavigate }) => {
  const { isLoggedIn, currentUser, logout } = useAuth();
  const { darkMode, language, toggleDarkMode, toggleLanguage, setLanguage, t } = useTheme();

  const handleLogout = () => {
    logout(t);
  };

  return (
    <Navbar
      expand="lg"
      className="warm-navbar shadow-sm"
      style={{
        padding: '0.85rem 0',
        background: 'linear-gradient(135deg, #ffe2c5, #ffba86)'
      }}
      variant="light"
    >
      <Container fluid className="px-3 px-lg-4">
        <Navbar.Brand
          href="#"
          onClick={(e) => { e.preventDefault(); onNavigate('main'); }}
          className="d-flex align-items-center gap-2 fw-bold fs-4"
          style={{ cursor: 'pointer', letterSpacing: '0.5px', color: '#ff6b2c' }}
        >
          <span style={{ fontSize: '2rem' }}>🍜</span>
          {t('appName')}
        </Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav" className="justify-content-end">
          <Nav className="align-items-center">
            <Dropdown className="me-3">
              <Dropdown.Toggle
                variant="outline-secondary"
                className="rounded-4 px-3 py-2 fw-medium transition-all warm-control"
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
              className="rounded-4 px-3 py-2 me-3 transition-all warm-control"
            >
              {darkMode ? '☀️' : '🌙'}
            </Button>
            {isLoggedIn ? (
              <>
                <div className="d-flex align-items-center gap-2 me-3 text-warm-dark fw-medium">
                  <span className="fs-5">👤</span>
                  {t('hello')}, <strong className="fw-bold">{currentUser}</strong>!
                </div>
                <Nav.Link
                  onClick={handleLogout}
                  className="rounded-4 px-3 py-2 fw-medium transition-all warm-control text-warm-dark"
                >
                  {t('logout')}
                </Nav.Link>
              </>
            ) : (
              <>
                <Nav.Link
                  onClick={() => onNavigate('login')}
                  className="rounded-4 px-3 py-2 text-warm-dark fw-medium me-2 transition-all"
                >
                  {t('login')}
                </Nav.Link>
                <Nav.Link
                  onClick={() => onNavigate('register')}
                  className="rounded-4 px-4 py-2 text-white fw-bold transition-all warm-cta"
                >
                  {t('register')}
                </Nav.Link>
              </>
            )}
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
};

export default AppNavbar;

