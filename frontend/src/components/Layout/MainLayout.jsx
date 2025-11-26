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
import { useFavorites } from '../../hooks/useFavorites';

const MainLayout = ({ onNavigate, initialTab = 'upload', onTabChange }) => {
  const { isLoggedIn } = useAuth();
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

  const handleSaveToHistory = async () => {
    const success = await historyHook.saveToHistory(
      recognition.dishData,
      isLoggedIn,
      t,
      () => {
        if (activeTab === 'history') {
          historyHook.fetchHistory(isLoggedIn);
        }
      }
    );

    if (!success && !isLoggedIn) {
      onNavigate('login');
    }
  };

  const handleLoginRequest = () => {
    toast.warn(t('pleaseLoginToSave'));
    onNavigate('login');
  };



  const renderContent = () => {
    switch (activeTab) {
      case 'upload':
        return (
          <div className="warm-recognition-grid">
            <Row className="g-4">
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
      default:
        return null;
    }
  };

  return (
    <>
      <Row className="g-0" style={{ margin: 0 }}>
        <Col xs={12} md={3} lg={2} style={{ padding: 0 }}>
          <Sidebar activeTab={activeTab} onTabChange={handleTabChange} />
        </Col>
        <Col xs={12} md={9} lg={10} className="px-0">
          <div className="max-w-7xl mx-auto">
            <Card 
              className={`layout-card shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`} 
            >
              <Card.Body className="p-3 p-md-4">
                {(activeTab === 'upload' || activeTab === 'webcam') && (
                  <h3 className={`display-6 warm-heading fw-bold mb-4 ${darkMode ? 'text-white' : 'text-dark'}`}>
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
                onSaveToHistory={handleSaveToHistory}
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
          setVideoUrl(url);
          setVideoTitle(`${name} - ${t('videoInstructions') || 'Video hướng dẫn'}`);
          setShowVideo(true);
        }}
      />

      <FavoriteModal
        show={favoritesHook.showFavoriteModal}
        item={favoritesHook.selectedFavoriteItem}
        onClose={favoritesHook.closeFavoriteModal}
        onOpenVideo={(url, name) => {
          setVideoUrl(url);
          setVideoTitle(`${name} - ${t('videoInstructions') || 'Video hướng dẫn'}`);
          setShowVideo(true);
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

