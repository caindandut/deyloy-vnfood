import { useState, useRef } from 'react';
import { recognitionApi } from '../services/api';
import { toast } from 'react-toastify';

const MIN_CONFIDENCE = 65;

export const useRecognition = (language) => {
  const [selectedFile, setSelectedFile] = useState(null);
  const [dishData, setDishData] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [streamError, setStreamError] = useState(false);

  const [capturedImageBlob, setCapturedImageBlob] = useState(null);
  const [capturedImagePreview, setCapturedImagePreview] = useState(null);
  const videoStreamRef = useRef(null);
  const canvasRef = useRef(null);

  const handleFileChange = (eventOrFile) => {
    const file = eventOrFile?.target?.files?.[0] || eventOrFile;
    if (file) {
      setSelectedFile(file);
      const previewUrl = URL.createObjectURL(file);
      setCapturedImagePreview(previewUrl);
      setCapturedImageBlob(file);
      setDishData(null);
      setError('');
    }
  };

  const clearSelection = () => {
    if (capturedImagePreview) {
      URL.revokeObjectURL(capturedImagePreview);
    }
    setCapturedImagePreview(null);
    setCapturedImageBlob(null);
    setSelectedFile(null);
    setDishData(null);
    setError('');
  };

  const sendImageToPredictAPI = async (imageBlob) => {
    if (!imageBlob) {
      setError(language === 'vi' ? 'Không có ảnh để nhận diện!' : 'No image to recognize!');
      return;
    }
    setLoading(true);
    setError('');
    setDishData(null);

    try {
      const response = await recognitionApi.predict(imageBlob, language);
      console.log('Recognition response:', response.data);

      const dish = response.data?.dish;
      const confidence = typeof response.data?.confidence === 'number'
        ? response.data.confidence
        : null;
      if (!dish || !dish.id) {
        const failMessage = language === 'vi'
          ? 'Nhận diện thất bại. Vui lòng chụp lại món ăn rõ hơn.'
          : 'Recognition failed. Please capture the dish again.';
        setDishData(null);
        setError(failMessage);
        toast.error(failMessage);
        return;
      }

      if (confidence !== null && confidence < MIN_CONFIDENCE) {
        const lowConfidenceMsg = language === 'vi'
          ? 'Ảnh không rõ món ăn. Vui lòng chụp lại gần và rõ hơn.'
          : 'Low confidence result. Please capture the dish more clearly.';
        setDishData(null);
        setError(lowConfidenceMsg);
        toast.error(lowConfidenceMsg);
        return;
      }

      setDishData(response.data);

      // Fallback: avoid showing "null" when translation name is missing
      const dishName = dish.name && dish.name !== 'null' ? dish.name : null;
      const successMessage = language === 'vi'
        ? (dishName ? `Nhận diện thành công: ${dishName}` : 'Nhận diện thành công')
        : (dishName ? `Recognition successful: ${dishName}` : 'Recognition successful');
      toast.success(successMessage);
    } catch (err) {
      const errorMsg = err.response?.data?.detail ||
        (language === 'vi' ? 'Nhận diện thất bại! Vui lòng thử lại.' : 'Recognition failed! Please try again.');
      setError(errorMsg);
      toast.error(errorMsg);
    } finally {
      setLoading(false);
    }
  };

  const handleUpload = () => {
    sendImageToPredictAPI(selectedFile);
  };

  const handleCaptureFrame = () => {
    if (videoStreamRef.current && canvasRef.current) {
      const videoElement = videoStreamRef.current;
      const canvas = canvasRef.current;
      canvas.width = videoElement.naturalWidth || videoElement.width || 640;
      canvas.height = videoElement.naturalHeight || videoElement.height || 480;

      try {
        const context = canvas.getContext('2d');
        context.drawImage(videoElement, 0, 0, canvas.width, canvas.height);
        canvas.toBlob((blob) => {
          if (blob) {
            setCapturedImageBlob(blob);
            if (capturedImagePreview) {
              URL.revokeObjectURL(capturedImagePreview);
            }
            setCapturedImagePreview(URL.createObjectURL(blob));
            setDishData(null);
            setError('');
          } else {
            setError("Không thể tạo ảnh Blob từ canvas.");
          }
        }, 'image/jpeg', 0.9);
      } catch (e) {
        console.error("Lỗi khi vẽ ảnh lên canvas (Tainted Canvas?):", e);
        setError("Lỗi khi chụp ảnh từ stream. Đảm bảo backend đã gửi header CORS.");
      }
    } else {
      setError("Không thể truy cập stream video để chụp.");
    }
  };

  const handleRecognizeCaptured = () => {
    sendImageToPredictAPI(capturedImageBlob);
  };

  const resetCapture = () => {
    setCapturedImageBlob(null);
    if (capturedImagePreview) URL.revokeObjectURL(capturedImagePreview);
    setCapturedImagePreview(null);
    setError('');
    setDishData(null);
  };

  const resetAll = () => {
    setCapturedImageBlob(null);
    if (capturedImagePreview) URL.revokeObjectURL(capturedImagePreview);
    setCapturedImagePreview(null);
    setSelectedFile(null);
    setError('');
    setDishData(null);
  };

  return {
    selectedFile,
    dishData,
    loading,
    error,
    streamError,
    capturedImageBlob,
    capturedImagePreview,
    videoStreamRef,
    canvasRef,
    handleFileChange,
    handleUpload,
    handleCaptureFrame,
    handleRecognizeCaptured,
    resetCapture,
    resetAll,
    setDishData,
    setError,
    setStreamError,
    clearSelection
  };
};

