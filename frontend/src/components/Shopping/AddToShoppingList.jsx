import React, { useState, useEffect } from 'react';
import { Modal, Button, Form, ListGroup } from 'react-bootstrap';
import { useTheme } from '../../contexts/ThemeContext';
import { shoppingListApi } from '../../services/api';
import { toast } from 'react-toastify';

const AddToShoppingList = ({ show, onClose, dishData, onSuccess }) => {
  const { darkMode, t, language } = useTheme();
  const [newListName, setNewListName] = useState('');

  useEffect(() => {
    if (show && dishData && dishData.dish) {
      setNewListName(dishData.dish.name);
    }
  }, [show, dishData]);

  const handleAdd = async () => {
    if (!dishData || !dishData.dish) {
      toast.error(t('noDishSelected') || 'Không có món ăn được chọn');
      return;
    }

    const listName = (newListName || dishData.dish.name).trim();
    if (!listName) {
      toast.warn(t('pleaseEnterListName') || 'Vui lòng nhập tên danh sách');
      return;
    }

    try {
      const listsResponse = await shoppingListApi.getAll(language);
      const existingList = (listsResponse.data || []).find(
        (list) => list.name && list.name.trim().toLowerCase() === listName.toLowerCase()
      );

      let targetListId;
      if (existingList) {
        targetListId = existingList.id;
      } else {
        const createResponse = await shoppingListApi.create(listName);
        targetListId = createResponse.data.id;
      }

      const addResponse = await shoppingListApi.addDish(targetListId, dishData.dish.id, language);

      toast.success(
        addResponse.data.message ||
          t('ingredientsAdded') ||
          'Đã thêm nguyên liệu vào danh sách mua sắm'
      );
      if (onSuccess) onSuccess();
      onClose();
    } catch (err) {
      console.error('Lỗi khi tạo danh sách và thêm nguyên liệu:', err);
      toast.error(err.response?.data?.detail || t('unableToAddDish') || 'Không thể tạo danh sách và thêm nguyên liệu');
    }
  };

  if (!dishData || !dishData.dish) return null;

  return (
    <Modal show={show} onHide={onClose} size="lg" centered>
      <Modal.Header
        closeButton
        className={darkMode ? 'bg-dark text-light border-secondary' : ''}
      >
        <Modal.Title>
          {t('addToShoppingList') || '🛒 Thêm vào danh sách mua sắm'}
        </Modal.Title>
      </Modal.Header>
      <Modal.Body className={darkMode ? 'bg-dark text-light' : ''}>
        <div className="mb-4">
          <h6 className="fw-bold mb-3">{t('dish') || 'Món ăn'}: {dishData.dish.name}</h6>
          <p className={`mb-3 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
            {t('ingredientsWillBeAdded') || 'Các nguyên liệu sau sẽ được thêm vào danh sách:'}
          </p>
          {dishData.ingredients && dishData.ingredients.length > 0 && (
            <div className={`p-3 rounded-4 ${darkMode ? 'bg-dark border border-secondary' : 'bg-light border'}`}>
              {dishData.ingredients.slice(0, 5).map((ing, idx) => (
                <div key={idx} className="mb-2">
                  • <strong>{ing.name}:</strong> {ing.quantity || '-'}
                </div>
              ))}
              {dishData.ingredients.length > 5 && (
                <div className="mt-2">
                  ... và {dishData.ingredients.length - 5} nguyên liệu khác
                </div>
              )}
            </div>
          )}
        </div>

        <hr className={`my-4 ${darkMode ? 'border-secondary' : 'border'}`} />

        <div className="mb-4">
          <p className={`mb-3 ${darkMode ? 'text-secondary' : 'text-muted'}`}>
            {t('createListWithDishName') || `Tạo danh sách mới với tên: "${dishData.dish.name}"`}
          </p>
          <Form.Group>
            <Form.Label className={`fw-medium mb-2 ${darkMode ? 'text-secondary' : 'text-dark'}`}>
              {t('listName') || 'Tên danh sách:'}
            </Form.Label>
            <Form.Control
              type="text"
              value={newListName || dishData.dish.name}
              onChange={(e) => setNewListName(e.target.value)}
              className={`rounded-4 p-3 ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white text-dark border'}`}
            />
            <Form.Text className={`small ${darkMode ? 'text-secondary' : 'text-muted'}`}>
              {t('youCanEditListName') || 'Bạn có thể sửa tên danh sách nếu muốn'}
            </Form.Text>
          </Form.Group>
        </div>
      </Modal.Body>
      <Modal.Footer className={`p-4 ${darkMode ? 'bg-dark border-secondary' : 'bg-white border-top'}`}>
        <Button variant="secondary" onClick={onClose} className="rounded-4 px-4 py-2">
          {t('cancel') || 'Hủy'}
        </Button>
        <Button variant="primary" onClick={handleAdd} className="rounded-4 px-4 py-2 orange-btn">
          {t('add') || 'Thêm'}
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default AddToShoppingList;

