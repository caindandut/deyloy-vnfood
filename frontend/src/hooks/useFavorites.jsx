import { useState, useEffect } from 'react';
import { toast } from 'react-toastify';
import { favoritesApi } from '../services/api';
import { translations } from '../utils/translations';

export const useFavorites = (language, isLoggedIn) => {
  const [favorites, setFavorites] = useState([]);
  const [loading, setLoading] = useState(false);
  const [selectedFavoriteItem, setSelectedFavoriteItem] = useState(null);
  const [showFavoriteModal, setShowFavoriteModal] = useState(false);

  const fetchFavorites = async () => {
    if (!isLoggedIn) return;

    setLoading(true);
    try {
      const response = await favoritesApi.getAll(language);
      setFavorites(response.data);
    } catch (err) {
      toast.error(translations[language]?.unableToLoadFavorites || "Unable to load favorites.");
    } finally {
      setLoading(false);
    }
  };

  const addFavorite = async (dishId, dishName, onSuccess) => {
    if (!isLoggedIn) {
      toast.warn(translations[language]?.pleaseLoginToFavorite || 'Please login to add to favorites');
      return false;
    }

    setLoading(true);
    try {
      await favoritesApi.add(dishId);
      const t = translations[language] || translations.en;
      toast.success(`"${dishName}" ${t.addedToFavorites}`);
      
      if (onSuccess) {
        onSuccess();
      }
      
      return true;
    } catch (err) {
      const t = translations[language] || translations.en;
      const errorMsg = err.response?.data?.detail || t.unableToAddFavorite;
      toast.error(errorMsg);
      return false;
    } finally {
      setLoading(false);
    }
  };

  const removeFavorite = async (dishId, dishName, onSuccess) => {
    if (!isLoggedIn) return false;

    setLoading(true);
    try {
      await favoritesApi.remove(dishId);
      const t = translations[language] || translations.en;
      toast.success(`"${dishName}" ${t.removedFromFavorites}`);
      
      setFavorites(prev => prev.filter(fav => fav.dish_id !== dishId));
      
      if (onSuccess) {
        onSuccess();
      }
      
      return true;
    } catch (err) {
      const t = translations[language] || translations.en;
      const errorMsg = err.response?.data?.detail || t.unableToRemoveFavorite;
      toast.error(errorMsg);
      return false;
    } finally {
      setLoading(false);
    }
  };

  const openFavoriteModal = (item) => {
    setSelectedFavoriteItem(item);
    setShowFavoriteModal(true);
  };

  const closeFavoriteModal = () => {
    setShowFavoriteModal(false);
    setSelectedFavoriteItem(null);
  };

  useEffect(() => {
    if (isLoggedIn) {
      fetchFavorites();
    } else {
      setFavorites([]);
    }
  }, [isLoggedIn, language]);

  return {
    favorites,
    loading,
    selectedFavoriteItem,
    showFavoriteModal,
    fetchFavorites,
    addFavorite,
    removeFavorite,
    openFavoriteModal,
    closeFavoriteModal
  };
};

