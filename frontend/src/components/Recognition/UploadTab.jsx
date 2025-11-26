import React, { useCallback } from 'react';
import { Button, Image } from 'react-bootstrap';
import { useDropzone } from 'react-dropzone';
import { useTheme } from '../../contexts/ThemeContext';
import RecognitionLoader from './RecognitionLoader';

const UploadTab = ({
  selectedFile,
  capturedImagePreview,
  loading,
  handleFileChange,
  handleUpload,
  onResetSelection
}) => {
  const { darkMode, t } = useTheme();

  const onDrop = useCallback((acceptedFiles) => {
    if (acceptedFiles && acceptedFiles.length > 0) {
      handleFileChange(acceptedFiles[0]);
    }
  }, [handleFileChange]);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: { 'image/*': [] },
    multiple: false
  });

  return (
    <div className="upload-pane">
      {!selectedFile && (
        <div
          {...getRootProps({
            className: `upload-dropzone ${isDragActive ? 'active' : ''} ${darkMode ? 'dark' : 'light'}`
          })}
        >
          <input {...getInputProps()} />
          <div className="upload-dropzone-icon" aria-hidden="true">📷</div>
          <p className="upload-dropzone-title">
            {t('uploadDropPrompt') || 'Kéo thả ảnh vào đây hoặc'}
            <span className="highlight-text">
              {' '}
              {t('uploadDropClick') || 'nhấn để chọn'}
            </span>
          </p>
          <small className="text-muted">
            {t('uploadFormatHint') || 'Hỗ trợ JPG, PNG, HEIC - tối đa 10MB'}
          </small>
        </div>
      )}

      {capturedImagePreview && (
        <div className="upload-preview mt-3 position-relative">
          <button
            type="button"
            className="reset-upload-btn"
            aria-label={t('resetSelection') || 'Chọn ảnh khác'}
            onClick={onResetSelection}
          >
            ✕
          </button>
          <Image
            src={capturedImagePreview}
            alt={t('previewImageAlt') || 'Ảnh xem trước'}
            fluid
            className="upload-preview-img rounded-2xl"
          />
        </div>
      )}

      <Button
        variant="primary"
        onClick={handleUpload}
        disabled={!selectedFile || loading}
        className="mt-4 orange-btn"
      >
        {loading ? (t('recognizing') || 'Đang nhận diện...') : (t('recognize') || 'Nhận diện')}
      </Button>

      {loading && (
        <div className="mt-4">
          <RecognitionLoader message={t('processing') || 'Đang nhận diện món ăn…'} />
        </div>
      )}
    </div>
  );
};

export default UploadTab;
