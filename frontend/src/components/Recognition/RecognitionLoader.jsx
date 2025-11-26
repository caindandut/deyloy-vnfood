import React from 'react';
import { useTheme } from '../../contexts/ThemeContext';

const RecognitionLoader = ({ message }) => {
  const { t } = useTheme();

  return (
    <div className="warm-loader" role="status" aria-live="polite">
      <div className="warm-loader-bowl">
        <span role="img" aria-label="noodle bowl">🍜</span>
      </div>
      <div className="warm-loader-chopsticks" aria-hidden="true" />
      <p className="warm-loader-text">
        {message || t('processing') || 'Đang xử lý món ăn...'}
      </p>
    </div>
  );
};

export default RecognitionLoader;



