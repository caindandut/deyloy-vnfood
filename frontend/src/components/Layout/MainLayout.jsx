import React, { useState, useEffect, useCallback, useRef } from 'react';
import { Card, Row, Col } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';
import { useRecognition } from '../../hooks/useRecognition';
import { useHistory } from '../../hooks/useHistory';
import { toast } from 'react-toastify';

import Sidebar from './Sidebar';
import UploadTab from '../Recognition/UploadTab';
import WebcamTab from '../Recognition/WebcamTab';
import ResultCard from '../Recognition/ResultCard';
import RecognitionInfoPanel from '../Recognition/RecognitionInfoPanel';
import HistoryTab from '../History/HistoryTab';
import HistoryModal from '../History/HistoryModal';
import FavoritesTab from '../Favorites/FavoritesTab';
import FavoriteModal from '../Favorites/FavoriteModal';
import ShoppingListTab from '../Shopping/ShoppingListTab';
import VideoPlayer from '../Video/VideoPlayer';
import AdminDishManagement from '../Admin/DishManagement';
import AdminIngredientManagement from '../Admin/IngredientManagement';
import AdminInstructionManagement from '../Admin/InstructionManagement';
import AdminUserManagement from '../Admin/UserManagement';
import AnalyticsDashboard from '../Admin/AnalyticsDashboard';
import { useFavorites } from '../../hooks/useFavorites';

const MainLayout = ({ onNavigate, initialTab = 'upload', onTabChange }) => {
  const { isLoggedIn, isAdmin } = useAuth();
  const { darkMode, language, t } = useTheme();
  const [activeTab, setActiveTab] = useState(initialTab);
  const [showVideo, setShowVideo] = useState(false);
  const [videoUrl, setVideoUrl] = useState(null);
  const [videoTitle, setVideoTitle] = useState('');
  const activeTabRef = useRef(initialTab);

  const recognition = useRecognition(language);
  const historyHook = useHistory(language);
  const favoritesHook = useFavorites(language, isLoggedIn);

  const prevInitialTabRef = useRef(initialTab);
  const isInternalChangeRef = useRef(false);
  
  // Cleanup any lingering modal states when MainLayout mounts
  // This ensures no modal state from dishes view carries over
  useEffect(() => {
    const cleanupModals = () => {
      if (document.body.classList.contains('modal-open')) {
        document.body.classList.remove('modal-open');
      }
      if (document.body.style.paddingRight) {
        document.body.style.paddingRight = '';
      }
      const backdrops = document.querySelectorAll('.modal-backdrop');
      backdrops.forEach(backdrop => backdrop.remove());
      const modals = document.querySelectorAll('.modal.show, .modal.fade.show');
      modals.forEach(modal => {
        modal.classList.remove('show');
        modal.style.display = 'none';
      });
    };
    
    // Cleanup on mount and after a short delay
    cleanupModals();
    const timeoutId = setTimeout(cleanupModals, 100);
    
    return () => clearTimeout(timeoutId);
  }, []); // Only run on mount
  
  useEffect(() => {
    if (isInternalChangeRef.current) {
      isInternalChangeRef.current = false;
      prevInitialTabRef.current = initialTab;
      return;
    }
    
    if (initialTab && initialTab !== prevInitialTabRef.current && initialTab !== activeTabRef.current) {
      prevInitialTabRef.current = initialTab;
      activeTabRef.current = initialTab;
      setActiveTab(initialTab);
      
      if (initialTab === 'history' && isLoggedIn) {
        historyHook.fetchHistory(isLoggedIn);
      }
      if (initialTab === 'favorites' && isLoggedIn) {
        favoritesHook.fetchFavorites();
      }
    }
  }, [initialTab, isLoggedIn]);

  useEffect(() => {
    activeTabRef.current = activeTab;
  }, [activeTab]);

  const hasInitialFetchedRef = useRef(false);
  
  useEffect(() => {
    if (isLoggedIn && !hasInitialFetchedRef.current) {
      hasInitialFetchedRef.current = true;
      historyHook.fetchHistory(isLoggedIn);
      favoritesHook.fetchFavorites();
    }
    
    if (!isLoggedIn) {
      hasInitialFetchedRef.current = false;
    }
  }, [isLoggedIn]);



  useEffect(() => {
    const currentTab = activeTabRef.current;
    if (currentTab === 'history' && isLoggedIn) {
      historyHook.fetchHistory(isLoggedIn);
    }
    if (currentTab === 'favorites' && isLoggedIn) {
      favoritesHook.fetchFavorites();
    }
  }, [language]);

  const handleTabChange = useCallback((k) => {
    if (k === activeTabRef.current) {
      return;
    }

    if (k === 'dishes') {
      if (onNavigate) {
        onNavigate('dishes');
      }
      return;
    }
    
    activeTabRef.current = k;
    setActiveTab(k);
    isInternalChangeRef.current = true;
    
    if (onTabChange) {
      onTabChange(k);
    }
    
    if (k === 'upload' || k === 'webcam') {
      recognition.resetAll();
    }

    if (k === 'history' && isLoggedIn) {
      historyHook.fetchHistory(isLoggedIn);
    }
    if (k === 'favorites' && isLoggedIn) {
      favoritesHook.fetchFavorites();
    }
  }, [isLoggedIn, onNavigate, recognition, historyHook, favoritesHook, onTabChange]);

  const handleLoginRequest = () => {
    toast.warn(t('pleaseLoginToSave'));
    onNavigate('login');
  };



  const renderContent = () => {
    switch (activeTab) {
      case 'upload':
        return (
          <div className="warm-recognition-grid">
            <Row className="g-3 g-md-4">
              <Col xs={12} lg={7}>
                <UploadTab
                  selectedFile={recognition.selectedFile}
                  capturedImagePreview={recognition.capturedImagePreview}
                  loading={recognition.loading}
                  handleFileChange={recognition.handleFileChange}
                  handleUpload={recognition.handleUpload}
                  onResetSelection={recognition.clearSelection}
                />
              </Col>
              <Col xs={12} lg={5}>
                <RecognitionInfoPanel
                  isLoggedIn={isLoggedIn}
                  historyItems={historyHook.history}
                  historyLoading={historyHook.loading}
                  onShowHistory={() => handleTabChange('history')}
                />
              </Col>
            </Row>
          </div>
        );
      case 'webcam':
        return (
          <WebcamTab
            videoStreamRef={recognition.videoStreamRef}
            canvasRef={recognition.canvasRef}
            capturedImagePreview={recognition.capturedImagePreview}
            capturedImageBlob={recognition.capturedImageBlob}
            loading={recognition.loading}
            handleCaptureFrame={recognition.handleCaptureFrame}
            handleRecognizeCaptured={recognition.handleRecognizeCaptured}
            resetCapture={recognition.resetCapture}
            setError={recognition.setError}
            streamError={recognition.streamError}
            setStreamError={recognition.setStreamError}
          />
        );
      case 'history':
        return (
          <HistoryTab
            history={historyHook.history}
            loading={historyHook.loading}
            onItemClick={historyHook.openHistoryModal}
          />
        );
      case 'favorites':
        return (
          <FavoritesTab
            favorites={favoritesHook.favorites}
            loading={favoritesHook.loading}
            onItemClick={favoritesHook.openFavoriteModal}
            onRemoveFavorite={async (dishId) => {
              const item = favoritesHook.favorites.find(f => f.dish_id === dishId);
              await favoritesHook.removeFavorite(dishId, item?.name || '', () => {
                if (activeTab === 'favorites') {
                  favoritesHook.fetchFavorites();
                }
              });
            }}
          />
        );
      case 'shopping':
        return <ShoppingListTab />;
      case 'admin-dishes':
        return isAdmin ? (
          <AdminDishManagement />
        ) : (
          <div className="py-5 text-center">
            <h5 className="fw-bold mb-2">{t('adminNotAuthorized') || 'Bạn không có quyền truy cập'}</h5>
            <p className="text-muted mb-0">
              {t('adminLoginAsPrivileged') || 'Vui lòng đăng nhập bằng tài khoản admin để tiếp tục.'}
            </p>
          </div>
        );
      case 'admin-ingredients':
        return isAdmin ? (
          <AdminIngredientManagement />
        ) : (
          <div className="py-5 text-center">
            <h5 className="fw-bold mb-2">{t('adminNotAuthorized') || 'Bạn không có quyền truy cập'}</h5>
            <p className="text-muted mb-0">
              {t('adminLoginAsPrivileged') || 'Vui lòng đăng nhập bằng tài khoản admin để tiếp tục.'}
            </p>
          </div>
        );
      case 'admin-instructions':
        return isAdmin ? (
          <AdminInstructionManagement />
        ) : (
          <div className="py-5 text-center">
            <h5 className="fw-bold mb-2">{t('adminNotAuthorized') || 'Bạn không có quyền truy cập'}</h5>
            <p className="text-muted mb-0">
              {t('adminLoginAsPrivileged') || 'Vui lòng đăng nhập bằng tài khoản admin để tiếp tục.'}
            </p>
          </div>
        );
      case 'admin-users':
        return isAdmin ? (
          <AdminUserManagement />
        ) : (
          <div className="py-5 text-center">
            <h5 className="fw-bold mb-2">{t('adminNotAuthorized') || 'Bạn không có quyền truy cập'}</h5>
            <p className="text-muted mb-0">
              {t('adminLoginAsPrivileged') || 'Vui lòng đăng nhập bằng tài khoản admin để tiếp tục.'}
            </p>
          </div>
        );
      case 'admin-analytics':
        return isAdmin ? (
          <AnalyticsDashboard />
        ) : (
          <div className="py-5 text-center">
            <h5 className="fw-bold mb-2">{t('adminNotAuthorized') || 'Bạn không có quyền truy cập'}</h5>
            <p className="text-muted mb-0">
              {t('adminLoginAsPrivileged') || 'Vui lòng đăng nhập bằng tài khoản admin để tiếp tục.'}
            </p>
          </div>
        );
      default:
        return null;
    }
  };

  return (
    <>
      <Row className="g-0" style={{ margin: 0 }}>
        <Col xs={12} md={12} lg={2} style={{ padding: 0 }} className="d-none d-lg-block">
          <Sidebar activeTab={activeTab} onTabChange={handleTabChange} />
        </Col>
        <Col xs={12} md={12} lg={10} className="px-0 px-lg-3">
          <div className="max-w-7xl mx-auto">
            <Card 
              className={`layout-card shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`} 
            >
              <Card.Body className="p-3 p-md-4 p-lg-5">
                {(activeTab === 'upload' || activeTab === 'webcam') && (
                  <h3 className={`display-6 warm-heading fw-bold mb-3 mb-md-4 ${darkMode ? 'text-white' : 'text-dark'}`}>
                    {activeTab === 'upload' ? (t('recognizeFromFile') || 'Nhận diện từ File') : (t('recognizeFromWebcam') || 'Nhận diện từ Webcam')}
                  </h3>
                )}
                {renderContent()}
              </Card.Body>
            </Card>

            {activeTab === 'upload' || activeTab === 'webcam' ? (
              <ResultCard
                loading={recognition.loading}
                error={recognition.error}
                dishData={recognition.dishData}
                onLoginRequest={handleLoginRequest}
                onToggleFavorite={async (dishId, dishName, currentIsFavorite, onStateChange) => {
                  if (!isLoggedIn) {
                    onNavigate('login');
                    return;
                  }

                  if (currentIsFavorite) {
                    await favoritesHook.removeFavorite(dishId, dishName, () => {
                      if (activeTab === 'favorites') {
                        favoritesHook.fetchFavorites();
                      }
                      if (onStateChange) onStateChange(false);
                    });
                  } else {
                    await favoritesHook.addFavorite(dishId, dishName, () => {
                      if (activeTab === 'favorites') {
                        favoritesHook.fetchFavorites();
                      }
                      if (onStateChange) onStateChange(true);
                    });
                  }
                }}
              />
            ) : null}
          </div>
        </Col>
      </Row>

      <HistoryModal
        show={historyHook.showHistoryModal}
        item={historyHook.selectedHistoryItem}
        onClose={historyHook.closeHistoryModal}
        onOpenVideo={(url, name) => {
          // Close parent modal first to prevent modal stacking issues
          historyHook.closeHistoryModal();
          // Small delay to let the modal close animation complete
          setTimeout(() => {
            setVideoUrl(url);
            setVideoTitle(`${name} - ${t('videoInstructions') || 'Video hướng dẫn'}`);
            setShowVideo(true);
          }, 300);
        }}
      />

      <FavoriteModal
        show={favoritesHook.showFavoriteModal}
        item={favoritesHook.selectedFavoriteItem}
        onClose={favoritesHook.closeFavoriteModal}
        onOpenVideo={(url, name) => {
          // Close parent modal first to prevent modal stacking issues
          favoritesHook.closeFavoriteModal();
          // Small delay to let the modal close animation complete
          setTimeout(() => {
            setVideoUrl(url);
            setVideoTitle(`${name} - ${t('videoInstructions') || 'Video hướng dẫn'}`);
            setShowVideo(true);
          }, 300);
        }}
      />

      <VideoPlayer
        show={showVideo}
        videoUrl={videoUrl}
        title={videoTitle}
        onClose={() => {
          setShowVideo(false);
          setVideoUrl(null);
          setVideoTitle('');
        }}
      />
    </>
  );
};

export default MainLayout;

