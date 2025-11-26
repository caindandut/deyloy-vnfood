import React from 'react';
import { Form, Dropdown, Button } from 'react-bootstrap';
import { useTheme } from '../../contexts/ThemeContext';

const DishFilters = ({ 
  ingredients, 
  selectedIngredient, 
  sortBy, 
  onIngredientChange, 
  onSortChange,
  onClearFilters 
}) => {
  const { darkMode, t } = useTheme();

  const sortOptions = [
    { value: 'name_asc', label: t('sortNameAsc') || 'Tên A-Z' },
    { value: 'name_desc', label: t('sortNameDesc') || 'Tên Z-A' },
    { value: 'popular', label: t('sortPopular') || 'Phổ biến' }
  ];

  return (
    <div className="d-flex flex-wrap gap-3 mb-4 align-items-center">
      <Dropdown>
        <Dropdown.Toggle
          variant={selectedIngredient ? "primary" : "outline-secondary"}
          style={{
            borderRadius: '8px',
            minWidth: '200px'
          }}
        >
          {selectedIngredient 
            ? ingredients.find(ing => ing.name_key === selectedIngredient)?.name || t('ingredient') || 'Nguyên liệu'
            : t('filterByIngredient') || 'Lọc theo nguyên liệu'}
        </Dropdown.Toggle>
        <Dropdown.Menu
          style={{
            maxHeight: '300px',
            overflowY: 'auto',
            backgroundColor: darkMode ? '#212529' : '#fff'
          }}
        >
          <Dropdown.Item
            onClick={() => onIngredientChange(null)}
            active={!selectedIngredient}
            style={{
              backgroundColor: !selectedIngredient ? (darkMode ? '#495057' : '#e9ecef') : 'transparent',
              color: darkMode ? '#fff' : '#212529'
            }}
          >
            {t('allIngredients') || 'Tất cả nguyên liệu'}
          </Dropdown.Item>
          <Dropdown.Divider />
          {ingredients.map((ing) => (
            <Dropdown.Item
              key={ing.id}
              onClick={() => onIngredientChange(ing.name_key)}
              active={selectedIngredient === ing.name_key}
              style={{
                backgroundColor: selectedIngredient === ing.name_key ? (darkMode ? '#495057' : '#e9ecef') : 'transparent',
                color: darkMode ? '#fff' : '#212529'
              }}
            >
              {ing.name}
            </Dropdown.Item>
          ))}
        </Dropdown.Menu>
      </Dropdown>

      <Dropdown>
        <Dropdown.Toggle
          variant="outline-secondary"
          style={{
            borderRadius: '8px',
            minWidth: '150px'
          }}
        >
          {sortOptions.find(opt => opt.value === sortBy)?.label || t('sort') || 'Sắp xếp'}
        </Dropdown.Toggle>
        <Dropdown.Menu
          style={{
            backgroundColor: darkMode ? '#212529' : '#fff'
          }}
        >
          {sortOptions.map((option) => (
            <Dropdown.Item
              key={option.value}
              onClick={() => onSortChange(option.value)}
              active={sortBy === option.value}
              style={{
                backgroundColor: sortBy === option.value ? (darkMode ? '#495057' : '#e9ecef') : 'transparent',
                color: darkMode ? '#fff' : '#212529'
              }}
            >
              {option.label}
            </Dropdown.Item>
          ))}
        </Dropdown.Menu>
      </Dropdown>

      {(selectedIngredient || sortBy !== 'name_asc') && (
        <Button
          variant="outline-danger"
          size="sm"
          onClick={onClearFilters}
          style={{
            borderRadius: '8px'
          }}
        >
          {t('clearFilters') || 'Xóa bộ lọc'}
        </Button>
      )}
    </div>
  );
};

export default DishFilters;
