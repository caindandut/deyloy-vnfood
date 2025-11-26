import React from 'react';
import { Modal, Button } from 'react-bootstrap';
import { useTheme } from '../../contexts/ThemeContext';

const VideoPlayer = ({ show, videoUrl, onClose, title }) => {
  const { darkMode, t } = useTheme();

  if (!videoUrl) return null;

  const getYouTubeVideoId = (url) => {
    if (!url) return null;
    
    const patterns = [
      /(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)/,
      /^([a-zA-Z0-9_-]{11})$/
    ];

    for (const pattern of patterns) {
      const match = url.match(pattern);
      if (match && match[1]) {
        return match[1];
      }
    }
    
    return null;
  };

  const videoId = getYouTubeVideoId(videoUrl);
  const embedUrl = videoId 
    ? `https://www.youtube.com/embed/${videoId}?autoplay=1&rel=0`
    : null;

  if (!embedUrl) {
    return (
      <Modal show={show} onHide={onClose} size="lg" centered>
        <Modal.Header 
          closeButton 
          className={darkMode ? 'bg-dark text-light border-secondary' : ''}
        >
          <Modal.Title>{title || t('videoInstructions') || 'Video hướng dẫn'}</Modal.Title>
        </Modal.Header>
        <Modal.Body className={darkMode ? 'bg-dark text-light' : ''}>
          <p>{t('invalidVideoUrl') || 'URL video không hợp lệ'}</p>
        </Modal.Body>
        <Modal.Footer className={darkMode ? 'bg-dark border-secondary' : ''}>
          <Button variant="secondary" onClick={onClose}>
            {t('close') || 'Đóng'}
          </Button>
        </Modal.Footer>
      </Modal>
    );
  }

  return (
    <Modal 
      show={show} 
      onHide={onClose} 
      size="lg" 
      centered
      className={darkMode ? 'dark-modal' : ''}
    >
      <Modal.Header 
        closeButton 
        className={darkMode ? 'bg-dark text-light border-secondary' : ''}
      >
        <Modal.Title>{title || t('videoInstructions') || 'Video hướng dẫn'}</Modal.Title>
      </Modal.Header>
      <Modal.Body 
        className={darkMode ? 'bg-dark text-light' : ''}
        style={{ padding: 0 }}
      >
        <div style={{ position: 'relative', paddingBottom: '56.25%', height: 0, overflow: 'hidden' }}>
          <iframe
            style={{
              position: 'absolute',
              top: 0,
              left: 0,
              width: '100%',
              height: '100%',
              border: 'none'
            }}
            src={embedUrl}
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowFullScreen
            title={title || 'Video hướng dẫn'}
          />
        </div>
      </Modal.Body>
      <Modal.Footer className={darkMode ? 'bg-dark border-secondary' : ''}>
        <Button variant="secondary" onClick={onClose}>
          {t('close') || 'Đóng'}
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default VideoPlayer;

