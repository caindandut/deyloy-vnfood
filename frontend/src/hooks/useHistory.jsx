import { useState } from 'react';
import { toast } from 'react-toastify';
import { historyApi } from '../services/api';

export const useHistory = (language) => {
  const [history, setHistory] = useState([]);
  const [loading, setLoading] = useState(false);
  const [selectedHistoryItem, setSelectedHistoryItem] = useState(null);
  const [showHistoryModal, setShowHistoryModal] = useState(false);

  const fetchHistory = async (isLoggedIn) => {
    if (!isLoggedIn) return;

    setLoading(true);
    try {
      const response = await historyApi.getHistory(language);
      console.log('History data from API:', response.data);

      response.data.forEach((item, idx) => {
        console.log(`Item ${idx}:`, {
          name: item.name,
          hasIngredients: Array.isArray(item.ingredients),
          ingredientsLength: item.ingredients?.length,
          hasInstructions: Array.isArray(item.instructions),
          instructionsLength: item.instructions?.length
        });
      });

      setHistory(response.data);
    } catch (err) {
      toast.error(language === 'vi' ? "Không thể tải lịch sử." : "Unable to load history.");
    } finally {
      setLoading(false);
    }
  };

  const saveToHistory = async (dishData, isLoggedIn, t, onSuccess) => {
    if (!dishData) {
      toast.error(t('nothingToSave'));
      return;
    }

    if (!isLoggedIn) {
      toast.warn(t('pleaseLoginToSave'));
      return false;
    }

    if (history.some(item => item.dish_id === dishData.dish.id)) {
      toast.info(`${dishData.dish.name} ${t('alreadyInHistory') || 'đã có trong lịch sử.'}`);
      return false;
    }

    setLoading(true);
    try {
      await historyApi.saveHistory(dishData.dish.id);
      toast.success(`"${dishData.dish.name}" ${t('savedToHistory') || 'đã được lưu vào lịch sử thành công!'}`);

      if (onSuccess) {
        onSuccess();
      }

      return true;
    } catch (err) {
      const errorMsg = err.response?.data?.detail ||
        (language === 'vi' ? 'Không thể lưu vào lịch sử.' : 'Unable to save to history.');
      toast.error(errorMsg);
      return false;
    } finally {
      setLoading(false);
    }
  };

  const openHistoryModal = (item) => {
    console.log('Selected item:', item);
    setSelectedHistoryItem(item);
    setShowHistoryModal(true);
  };

  const closeHistoryModal = () => {
    setShowHistoryModal(false);
    setSelectedHistoryItem(null);
  };

  return {
    history,
    loading,
    selectedHistoryItem,
    showHistoryModal,
    fetchHistory,
    saveToHistory,
    openHistoryModal,
    closeHistoryModal
  };
};

