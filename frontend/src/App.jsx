
import React, { useState, useEffect, useRef } from 'react';
import { Container, Row, Col } from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

import { AuthProvider } from './contexts/AuthContext';
import { ThemeProvider } from './contexts/ThemeContext';

import AppNavbar from './components/Navbar/AppNavbar';
import LoginForm from './components/Auth/LoginForm';
import RegisterForm from './components/Auth/RegisterForm';
import MainLayout from './components/Layout/MainLayout';
import DishList from './components/Dishes/DishList';

function App() {
  const [currentView, setCurrentView] = useState('main');
  const [mainLayoutTab, setMainLayoutTab] = useState('upload');

  // Removed MutationObserver as it was interfering with normal Bootstrap modal behavior
  // Cleanup is now handled explicitly when needed

  // Cleanup modals only when switching between different views (dishes <-> main/login/register)
  const prevViewRef = useRef(currentView);
  useEffect(() => {
    const prevView = prevViewRef.current;
    // Only cleanup when switching away from 'dishes' view (where modals might be open)
    if (prevView === 'dishes' && currentView !== 'dishes') {
      // Aggressive cleanup when leaving dishes view
      const cleanupModals = () => {
        // Remove modal-open class
        if (document.body.classList.contains('modal-open')) {
          document.body.classList.remove('modal-open');
        }
        // Remove padding-right style
        if (document.body.style.paddingRight) {
          document.body.style.paddingRight = '';
        }
        // Remove all modal backdrops
        const backdrops = document.querySelectorAll('.modal-backdrop');
        backdrops.forEach(backdrop => backdrop.remove());
        // Also remove any modal elements that might be lingering
        const modals = document.querySelectorAll('.modal.show, .modal.fade.show');
        modals.forEach(modal => {
          modal.classList.remove('show');
          modal.style.display = 'none';
        });
      };
      
      // Cleanup immediately and with multiple delays to catch all cases
      cleanupModals();
      const timeout1 = setTimeout(cleanupModals, 50);
      const timeout2 = setTimeout(cleanupModals, 150);
      const timeout3 = setTimeout(cleanupModals, 300);
      
      prevViewRef.current = currentView;
      return () => {
        clearTimeout(timeout1);
        clearTimeout(timeout2);
        clearTimeout(timeout3);
      };
    }
    prevViewRef.current = currentView;
  }, [currentView]);

  const handleNavigate = (view, tab = null) => {
    // Only clean up modals when leaving dishes view
    if (currentView === 'dishes' && view !== 'dishes') {
      // Aggressive cleanup when leaving dishes view
      const cleanupModals = () => {
        // Remove modal-open class
        if (document.body.classList.contains('modal-open')) {
          document.body.classList.remove('modal-open');
        }
        // Remove padding-right style
        if (document.body.style.paddingRight) {
          document.body.style.paddingRight = '';
        }
        // Remove all modal backdrops
        const backdrops = document.querySelectorAll('.modal-backdrop');
        backdrops.forEach(backdrop => backdrop.remove());
        // Also remove any modal elements that might be lingering
        const modals = document.querySelectorAll('.modal.show, .modal.fade.show');
        modals.forEach(modal => {
          modal.classList.remove('show');
          modal.style.display = 'none';
        });
      };
      
      // Cleanup immediately
      cleanupModals();
      
      // Also cleanup after delays to catch any async cleanup
      setTimeout(cleanupModals, 50);
      setTimeout(cleanupModals, 150);
      setTimeout(cleanupModals, 300);
    }
    
    setCurrentView(view);
    if (tab && view === 'main') {
      setMainLayoutTab(tab);
    }
  };

  return (
    <ThemeProvider>
      <AuthProvider>
        <ToastContainer autoClose={3000} hideProgressBar />

        <AppNavbar 
          onNavigate={handleNavigate}
          activeTab={mainLayoutTab}
          onTabChange={(tab) => {
            if (currentView === 'main') {
              setMainLayoutTab(tab);
            }
          }}
        />

        <Container fluid className="px-0" style={{ maxWidth: '100%' }}>
          <Row className="g-0 m-0">
            {currentView === 'main' && (
              <Col xs={12} className="px-0">
                <MainLayout 
                  onNavigate={handleNavigate} 
                  initialTab={mainLayoutTab}
                  onTabChange={(tab) => {
                    if (currentView === 'main') {
                      setMainLayoutTab(tab);
                    }
                  }}
                />
              </Col>
            )}

            {currentView === 'login' && (
              <Col xs={12} sm={10} md={8} lg={6} xl={5} className="mx-auto px-3 px-md-4" style={{ marginTop: '1.5rem', marginBottom: '2rem' }}>
                <LoginForm onNavigate={handleNavigate} />
              </Col>
            )}

            {currentView === 'register' && (
              <Col xs={12} sm={10} md={8} lg={6} xl={5} className="mx-auto px-3 px-md-4" style={{ marginTop: '1.5rem', marginBottom: '2rem' }}>
                <RegisterForm onNavigate={handleNavigate} />
              </Col>
            )}

            {currentView === 'dishes' && (
              <Col xs={12} className="px-0">
                <DishList onNavigate={handleNavigate} />
              </Col>
            )}
          </Row>
        </Container>
      </AuthProvider>
    </ThemeProvider>
  );
}

export default App;

