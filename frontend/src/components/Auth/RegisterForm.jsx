import React, { useState } from 'react';
import { Card, Form, Button, Spinner } from 'react-bootstrap';
import { useAuth } from '../../contexts/AuthContext';
import { useTheme } from '../../contexts/ThemeContext';

const RegisterForm = ({ onNavigate }) => {
  const { register, loading } = useAuth();
  const { darkMode, language, t } = useTheme();
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  const PasswordEyeIcon = ({ open }) => (
    <svg
      width="20"
      height="20"
      viewBox="0 0 24 24"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M2 12s4-7 10-7 10 7 10 7-4 7-10 7S2 12 2 12z"
        stroke="currentColor"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
      <circle
        cx="12"
        cy="12"
        r="3"
        stroke="currentColor"
        strokeWidth="1.5"
        fill="none"
      />
      {!open && (
        <path
          d="M4 4l16 16"
          stroke="currentColor"
          strokeWidth="1.5"
          strokeLinecap="round"
        />
      )}
    </svg>
  );

  const togglePasswordVisibility = () => setShowPassword((prev) => !prev);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const result = await register(username, password, t, language);
    if (result.success) {
      onNavigate('login');
    }
  };

  return (
    <Card className={`shadow-sm ${darkMode ? 'bg-dark text-light border-secondary' : ''}`} style={{ border: 'none', borderRadius: '12px' }}>
      <Card.Header className={`text-center border-0 pt-3 pt-md-4 pb-2 ${darkMode ? 'bg-dark' : 'bg-white'}`}>
        <h3 className="mb-0" style={{ fontWeight: '600', color: darkMode ? '#fff' : '#333', fontSize: 'clamp(1.25rem, 4vw, 1.75rem)' }}>{t('registerTitle')}</h3>
      </Card.Header>
      <Card.Body className="px-3 px-md-4 pb-3 pb-md-4">
        <Form onSubmit={handleSubmit}>
          <Form.Group className="mb-3">
            <Form.Label style={{ fontWeight: '500', fontSize: 'clamp(0.85rem, 2.5vw, 0.9rem)', color: darkMode ? '#ccc' : '#555' }}>{t('username')}</Form.Label>
            <Form.Control
              type="text"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              required
              className={darkMode ? 'bg-dark text-light border-secondary' : ''}
              style={{ borderRadius: '8px', padding: 'clamp(0.75rem, 2vw, 0.875rem) clamp(0.875rem, 2.5vw, 1rem)', border: darkMode ? '1.5px solid #555' : '1.5px solid #ddd', fontSize: 'clamp(0.9rem, 2.5vw, 1rem)' }}
            />
          </Form.Group>
          <Form.Group className="mb-3 mb-md-4">
            <Form.Label style={{ fontWeight: '500', fontSize: 'clamp(0.85rem, 2.5vw, 0.9rem)', color: darkMode ? '#ccc' : '#555' }}>{t('password')}</Form.Label>
            <div className="password-field-wrapper">
              <Form.Control
                type={showPassword ? 'text' : 'password'}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
                className={darkMode ? 'bg-dark text-light border-secondary' : ''}
                style={{ borderRadius: '8px', padding: 'clamp(0.75rem, 2vw, 0.875rem) clamp(0.875rem, 2.5vw, 1rem)', border: darkMode ? '1.5px solid #555' : '1.5px solid #ddd', fontSize: 'clamp(0.9rem, 2.5vw, 1rem)' }}
              />
              <button
                type="button"
                className={`password-toggle-btn ${darkMode ? 'dark' : ''}`}
                onClick={togglePasswordVisibility}
                aria-label={showPassword ? t('hidePassword') : t('showPassword')}
              >
                <PasswordEyeIcon open={showPassword} />
              </button>
            </div>
          </Form.Group>
          <div className="d-flex flex-column flex-sm-row gap-2 mb-3">
            <Button
              variant="primary"
              type="submit"
              disabled={loading}
              className="flex-fill auth-primary-btn"
              style={{ borderRadius: '8px', padding: 'clamp(0.75rem, 2vw, 0.875rem) 1rem', fontWeight: '500', fontSize: 'clamp(0.9rem, 2.5vw, 1rem)' }}
            >
              {loading ? <Spinner as="span" size="sm" /> : t('register')}
            </Button>
            <Button
              variant="outline-secondary"
              onClick={() => onNavigate('main')}
              style={{ borderRadius: '8px', padding: 'clamp(0.75rem, 2vw, 0.875rem) 1rem', fontWeight: '500', fontSize: 'clamp(0.9rem, 2.5vw, 1rem)' }}
            >
              {t('back')}
            </Button>
          </div>
          <div className="text-center">
            <p className={`mb-0 ${darkMode ? 'text-light' : 'text-muted'}`} style={{ fontSize: 'clamp(0.8rem, 2.5vw, 0.9rem)', opacity: darkMode ? 0.8 : 1, display: 'inline-flex', alignItems: 'center', gap: '4px', flexWrap: 'wrap', justifyContent: 'center' }}>
              <span>{t('haveAccount')}</span>
              <Button
                variant="link"
                className="p-0 text-decoration-none"
                onClick={() => onNavigate('login')}
                style={{ fontWeight: '500', color: darkMode ? '#6c9eff' : undefined, fontSize: 'clamp(0.8rem, 2.5vw, 0.9rem)', padding: 0, lineHeight: '1.5' }}
              >
                {t('login')}
              </Button>
            </p>
          </div>
        </Form>
      </Card.Body>
    </Card>
  );
};

export default RegisterForm;

