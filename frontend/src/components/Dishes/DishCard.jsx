import React from 'react';
import { Card } from 'react-bootstrap';
import { useTheme } from '../../contexts/ThemeContext';

const DishCard = ({ dish, onClick }) => {
  const { darkMode } = useTheme();

  return (
    <Card
      className={`h-100 shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : 'bg-white border-0'}`}
      style={{
        cursor: 'pointer',
        borderRadius: '1.5rem',
        overflow: 'hidden'
      }}
      onClick={onClick}
    >
      <Card.Img
        variant="top"
        src={dish.image_url || 'https://via.placeholder.com/300x200.png?text=Ảnh+món+ăn'}
        alt={dish.name}
        className="img-cover"
        style={{
          height: 'clamp(180px, 30vw, 220px)'
        }}
      />
      <Card.Body className="p-3 p-md-4">
        <Card.Title className="fs-5 fw-semibold mb-0" style={{ fontSize: 'clamp(0.95rem, 2.5vw, 1.25rem)' }}>
          {dish.name}
        </Card.Title>
      </Card.Body>
    </Card>
  );
};

export default DishCard;
