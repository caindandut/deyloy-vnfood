import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { toast } from 'react-toastify';
import { authApi } from '../services/api';

const AuthContext = createContext();

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (!context) {
    throw new Error('useAuth must be used within AuthProvider');
  }
  return context;
};

export const AuthProvider = ({ children }) => {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [currentUser, setCurrentUser] = useState(null);
  const [loading, setLoading] = useState(false);

  const checkLoginStatus = useCallback(async () => {
    const token = localStorage.getItem('token');
    if (token) {
      try {
        const response = await authApi.checkAuth();
        setCurrentUser(response.data.username);
        setIsLoggedIn(true);
      } catch (e) {
        localStorage.removeItem('token');
        setIsLoggedIn(false);
      }
    }
  }, []);

  useEffect(() => {
    checkLoginStatus();
  }, [checkLoginStatus]);

  const register = async (username, password, t, language) => {
    setLoading(true);
    try {
      await authApi.register(username, password);
      toast.success(t('registerSuccess') + (language === 'vi' ? ". Vui lòng đăng nhập." : ". Please login."));
      return { success: true };
    } catch (err) {
      const errorMsg = err.response?.data?.detail || (language === 'vi' ? 'Đăng ký thất bại.' : 'Registration failed.');
      toast.error(errorMsg);
      return { success: false, error: errorMsg };
    } finally {
      setLoading(false);
    }
  };

  const login = async (username, password, t, language) => {
    setLoading(true);
    try {
      const response = await authApi.login(username, password);
      const token = response.data.access_token;
      localStorage.setItem('token', token);

      setCurrentUser(username);
      setIsLoggedIn(true);
      toast.success(t('loginSuccess'));
      return { success: true };
    } catch (err) {
      const errorMsg = err.response?.data?.detail || (language === 'vi' ? 'Đăng nhập thất bại.' : 'Login failed.');
      toast.error(errorMsg);
      return { success: false, error: errorMsg };
    } finally {
      setLoading(false);
    }
  };

  const logout = (t) => {
    localStorage.removeItem('token');
    setIsLoggedIn(false);
    setCurrentUser(null);
    toast.info(t('logoutSuccess'));
  };

  const value = {
    isLoggedIn,
    currentUser,
    loading,
    register,
    login,
    logout
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};

