import axios from 'axios';
import { API_URL, PI_STREAM_URL } from '../utils/constants';

export const createApiInstance = () => {
  const token = localStorage.getItem('token');
  return axios.create({
    baseURL: API_URL,
    headers: {
      'Authorization': token ? `Bearer ${token}` : ''
    }
  });
};

export const authApi = {
  register: (username, password) =>
    axios.post(`${API_URL}/register`, { username, password }),

  login: (username, password) => {
    const formData = new FormData();
    formData.append('username', username);
    formData.append('password', password);
    return axios.post(`${API_URL}/login`, formData);
  },

  checkAuth: () =>
    createApiInstance().get('/me')
};

export const recognitionApi = {
  predict: (imageBlob, language) => {
    const formData = new FormData();
    formData.append('file', imageBlob, "capture.jpg");
    // Sử dụng createApiInstance() để gửi authorization header
    return createApiInstance().post(`/predict?language=${language}`, formData, {
      headers: { 'Content-Type': 'multipart/form-data' },
    });
  },

  captureFromPi: () => {
    return axios.get(`${API_URL}/capture_from_pi`, {
      responseType: 'blob'
    });
  }
};

export const historyApi = {
  getHistory: (language) =>
    createApiInstance().get(`/history?language=${language}`),

  saveHistory: (dishId) =>
    createApiInstance().post('/save_history', { dish_id: dishId }, {
      headers: { 'Content-Type': 'application/json' }
    })
};

export const favoritesApi = {
  add: (dishId) =>
    createApiInstance().post('/favorites', { dish_id: dishId }, {
      headers: { 'Content-Type': 'application/json' }
    }),

  remove: (dishId) =>
    createApiInstance().delete(`/favorites/${dishId}`),

  getAll: (language) =>
    createApiInstance().get(`/favorites?language=${language}`),

  check: (dishId) => {
    const token = localStorage.getItem('token');
    const headers = token ? { Authorization: `Bearer ${token}` } : {};
    return axios.get(`${API_URL}/favorites/check/${dishId}`, { headers });
  }
};

export const dishesApi = {
  getAll: (params) => axios.get(`${API_URL}/dishes`, { params }),
  getDetail: (dishId, language = 'vi') => axios.get(`${API_URL}/dishes/${dishId}?language=${language}`),
  getIngredients: (language = 'vi') => axios.get(`${API_URL}/ingredients?language=${language}`)
};

export const shoppingListApi = {
  create: (name) =>
    createApiInstance().post('/shopping-lists', { name }, {
      headers: { 'Content-Type': 'application/json' }
    }),
  
  getAll: (language = 'vi') =>
    createApiInstance().get(`/shopping-lists?language=${language}`),
  
  getDetail: (listId, language = 'vi') =>
    createApiInstance().get(`/shopping-lists/${listId}?language=${language}`),
  
  addItem: (listId, item, language = 'vi') =>
    createApiInstance().post(`/shopping-lists/${listId}/items?language=${language}`, item, {
      headers: { 'Content-Type': 'application/json' }
    }),
  
  addDish: (listId, dishId, language = 'vi') =>
    createApiInstance().post(`/shopping-lists/add-dish?language=${language}`, { list_id: listId, dish_id: dishId }, {
      headers: { 'Content-Type': 'application/json' }
    }),
  
  updateItem: (listId, itemId, item, language = 'vi') =>
    createApiInstance().put(`/shopping-lists/${listId}/items/${itemId}?language=${language}`, item, {
      headers: { 'Content-Type': 'application/json' }
    }),
  
  deleteItem: (listId, itemId) =>
    createApiInstance().delete(`/shopping-lists/${listId}/items/${itemId}`),
  
  deleteList: (listId) =>
    createApiInstance().delete(`/shopping-lists/${listId}`)
};

export const adminDishesApi = {
  getAll: (search) =>
    createApiInstance().get('/admin/dishes', {
      params: search ? { search } : {}
    }),
  getDetail: (dishId) =>
    createApiInstance().get(`/admin/dishes/${dishId}`),
  updateBaseInfo: (dishId, payload) =>
    createApiInstance().put(`/admin/dishes/${dishId}`, payload),
  updateTranslation: (dishId, language, payload) =>
    createApiInstance().put(`/admin/dishes/${dishId}/translations/${language}`, payload),
  getDishIngredients: (dishId) =>
    createApiInstance().get(`/admin/dishes/${dishId}/ingredients`),
  addDishIngredient: (dishId, payload) =>
    createApiInstance().post(`/admin/dishes/${dishId}/ingredients`, payload),
  updateDishIngredient: (dishId, ingredientId, payload) =>
    createApiInstance().put(`/admin/dishes/${dishId}/ingredients/${ingredientId}`, payload),
  deleteDishIngredient: (dishId, ingredientId) =>
    createApiInstance().delete(`/admin/dishes/${dishId}/ingredients/${ingredientId}`),
  getInstructions: (dishId) =>
    createApiInstance().get(`/admin/dishes/${dishId}/instructions`),
  createInstruction: (dishId, payload) =>
    createApiInstance().post(`/admin/dishes/${dishId}/instructions`, payload),
  updateInstruction: (dishId, instructionId, payload) =>
    createApiInstance().put(`/admin/dishes/${dishId}/instructions/${instructionId}`, payload),
  deleteInstruction: (dishId, instructionId) =>
    createApiInstance().delete(`/admin/dishes/${dishId}/instructions/${instructionId}`),
  updateInstructionTranslation: (dishId, instructionId, language, payload) =>
    createApiInstance().put(`/admin/dishes/${dishId}/instructions/${instructionId}/translations/${language}`, payload),
  reorderInstructions: (dishId, payload) =>
    createApiInstance().put(`/admin/dishes/${dishId}/instructions/reorder`, payload)
};

export const adminIngredientsApi = {
  list: (search) =>
    createApiInstance().get('/admin/ingredients', {
      params: search ? { search } : {}
    }),
  create: (payload) =>
    createApiInstance().post('/admin/ingredients', payload),
  update: (ingredientId, payload) =>
    createApiInstance().put(`/admin/ingredients/${ingredientId}`, payload),
  delete: (ingredientId) =>
    createApiInstance().delete(`/admin/ingredients/${ingredientId}`),
  updateTranslation: (ingredientId, language, payload) =>
    createApiInstance().put(`/admin/ingredients/${ingredientId}/translations/${language}`, payload)
};

export const adminUsersApi = {
  getAll: (params = {}) =>
    createApiInstance().get('/admin/users', { params }),
  updateRole: (userId, role) =>
    createApiInstance().put(`/admin/users/${userId}/role`, { role }),
  updateStatus: (userId, isActive) =>
    createApiInstance().put(`/admin/users/${userId}/status`, { is_active: isActive }),
  getStats: (userId) =>
    createApiInstance().get(`/admin/users/${userId}/stats`),
  getHistory: (userId, language = 'vi') =>
    createApiInstance().get(`/admin/users/${userId}/history?language=${language}`),
  getFavorites: (userId, language = 'vi') =>
    createApiInstance().get(`/admin/users/${userId}/favorites?language=${language}`),
  getShoppingLists: (userId, language = 'vi') =>
    createApiInstance().get(`/admin/users/${userId}/shopping-lists?language=${language}`)
};

export const adminAnalyticsApi = {
  getOverview: (language = 'vi') =>
    createApiInstance().get(`/admin/analytics?language=${language}`)
};

export { API_URL, PI_STREAM_URL };

