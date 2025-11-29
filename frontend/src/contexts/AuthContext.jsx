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
  const [isAdmin, setIsAdmin] = useState(false);
  const [userRole, setUserRole] = useState('user');
  const [isActive, setIsActive] = useState(true);
  const [loading, setLoading] = useState(false);

  const resetAuthState = useCallback(() => {
    setIsLoggedIn(false);
    setCurrentUser(null);
    setIsAdmin(false);
    setUserRole('user');
    setIsActive(true);
  }, []);

  const checkLoginStatus = useCallback(async () => {
    const token = localStorage.getItem('token');
    if (!token) {
      resetAuthState();
      return;
    }

    try {
      const response = await authApi.checkAuth();
      if (response.data?.is_active === false) {
        localStorage.removeItem('token');
        resetAuthState();
        return;
      }
      setCurrentUser(response.data.username);
      setIsLoggedIn(true);
      setIsAdmin(Boolean(response.data.is_admin));
      setUserRole(response.data.role || 'user');
      setIsActive(response.data.is_active !== false);
    } catch (e) {
      localStorage.removeItem('token');
      resetAuthState();
    }
  }, [resetAuthState]);

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

      await checkLoginStatus();
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
    resetAuthState();
    toast.info(t('logoutSuccess'));
  };

  const value = {
    isLoggedIn,
    currentUser,
    isAdmin,
    userRole,
    isActive,
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

