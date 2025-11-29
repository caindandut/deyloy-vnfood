import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { Card, Row, Col, Spinner, Alert, ListGroup, Badge, Button, ProgressBar, Pagination } from 'react-bootstrap';
import { adminAnalyticsApi } from '../../services/api';
import { useTheme } from '../../contexts/ThemeContext';

const TrendChart = ({ data, color, emptyMessage, tooltipLabel }) => {
  const [hoveredIndex, setHoveredIndex] = useState(null);

  if (!data || data.length === 0) {
    return (
      <div className="text-center text-muted py-4">
        {emptyMessage}
      </div>
    );
  }

  const width = 620;
  const height = 280;
  const paddingX = 60;
  const paddingY = 50;
  const chartWidth = width - paddingX * 2;
  const chartHeight = height - paddingY * 2;
  
  const maxValue = Math.max(...data.map((item) => item.recognition_count), 1);
  const minValue = 0;
  const valueRange = maxValue - minValue || 1;

  // Calculate Y-axis tick values
  const yTicks = 5;
  const yTickValues = Array.from({ length: yTicks }, (_, i) => {
    return Math.round(minValue + (valueRange * i) / (yTicks - 1));
  });

  // Calculate column positions
  const columnWidth = Math.max((chartWidth / data.length) * 0.7, 8);
  const columnSpacing = (chartWidth - (columnWidth * data.length)) / (data.length + 1);

  // Date formatter for Vietnamese
  const dateFormatter = (dateStr) => {
    const date = new Date(dateStr);
    const day = date.getDate();
    const month = date.getMonth() + 1;
    return `${day} thg ${month}`;
  };

  // Show labels for first, middle, and last points, plus every 5th point
  const getLabelIndexes = () => {
    const indexes = new Set([0, data.length - 1]);
    if (data.length > 2) {
      indexes.add(Math.floor(data.length / 2));
    }
    // Add more labels if there are many points
    if (data.length > 10) {
      const step = Math.floor(data.length / 5);
      for (let i = step; i < data.length - 1; i += step) {
        indexes.add(i);
      }
    }
    return indexes;
  };

  const labelIndexes = getLabelIndexes();

  const handleMouseEnter = (index) => {
    setHoveredIndex(index);
  };

  const handleMouseLeave = () => {
    setHoveredIndex(null);
  };

  return (
    <div style={{ position: 'relative' }}>
      <svg 
        viewBox={`0 0 ${width} ${height}`} 
        width="100%" 
        height="280"
        style={{ overflow: 'visible' }}
      >
        <defs>
          <linearGradient id="columnGradient" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" stopColor={color} stopOpacity="1" />
            <stop offset="100%" stopColor={color} stopOpacity="0.7" />
          </linearGradient>
          <linearGradient id="columnGradientHover" x1="0%" y1="0%" x2="0%" y2="100%">
            <stop offset="0%" stopColor={color} stopOpacity="1" />
            <stop offset="100%" stopColor={color} stopOpacity="0.85" />
          </linearGradient>
          <filter id="columnShadow">
            <feGaussianBlur in="SourceAlpha" stdDeviation="2" result="blur"/>
            <feOffset in="blur" dx="0" dy="2" result="offsetBlur"/>
            <feComponentTransfer>
              <feFuncA type="linear" slope="0.3"/>
            </feComponentTransfer>
            <feMerge>
              <feMergeNode/>
              <feMergeNode in="SourceGraphic"/>
            </feMerge>
          </filter>
          <filter id="columnGlow">
            <feGaussianBlur stdDeviation="4" result="coloredBlur"/>
            <feMerge>
              <feMergeNode in="coloredBlur"/>
              <feMergeNode in="SourceGraphic"/>
            </feMerge>
          </filter>
        </defs>

        {/* Grid lines */}
        {yTickValues.map((tickValue, i) => {
          const y = height - paddingY - ((tickValue - minValue) / valueRange) * chartHeight;
          return (
            <g key={`grid-${i}`}>
              <line
                x1={paddingX}
                y1={y}
                x2={width - paddingX}
                y2={y}
                stroke="currentColor"
                strokeWidth="1"
                strokeOpacity="0.1"
                strokeDasharray="2,2"
              />
            </g>
          );
        })}

        {/* Y-axis labels */}
        {yTickValues.map((tickValue, i) => {
          const y = height - paddingY - ((tickValue - minValue) / valueRange) * chartHeight;
          return (
            <text
              key={`y-label-${i}`}
              x={paddingX - 10}
              y={y + 4}
              textAnchor="end"
              fill="currentColor"
              fontSize="11"
              opacity="0.6"
              fontWeight="500"
            >
              {tickValue.toLocaleString()}
            </text>
          );
        })}

        {/* Columns */}
        {data.map((item, index) => {
          const isHovered = hoveredIndex === index;
          const isLabeled = labelIndexes.has(index);
          const normalizedValue = (item.recognition_count - minValue) / valueRange;
          const baseColumnHeight = normalizedValue * chartHeight;
          const columnHeight = isHovered ? baseColumnHeight * 1.08 : baseColumnHeight;
          const hoverOffset = isHovered ? baseColumnHeight * 0.08 : 0;
          const x = paddingX + columnSpacing + index * (columnWidth + columnSpacing);
          const y = height - paddingY - columnHeight;
          
          return (
            <g key={`${item.date}-${index}`}>
              {/* Column rectangle */}
              <rect
                x={x}
                y={y - hoverOffset}
                width={columnWidth}
                height={columnHeight}
                fill={isHovered ? "url(#columnGradientHover)" : "url(#columnGradient)"}
                rx={columnWidth / 8}
                ry={columnWidth / 8}
                filter={isHovered ? "url(#columnGlow)" : "url(#columnShadow)"}
                style={{ 
                  cursor: 'pointer',
                  transition: 'all 0.3s ease'
                }}
                onMouseEnter={() => handleMouseEnter(index)}
                onMouseLeave={handleMouseLeave}
              />
              
              {/* Top highlight line */}
              <line
                x1={x}
                y1={y - hoverOffset}
                x2={x + columnWidth}
                y2={y - hoverOffset}
                stroke="rgba(255, 255, 255, 0.3)"
                strokeWidth="1.5"
                opacity={isHovered ? 1 : 0.5}
                style={{ transition: 'opacity 0.3s' }}
              />

              {/* Date labels */}
              {isLabeled && (
                <text
                  x={x + columnWidth / 2}
                  y={height - paddingY + 20}
                  textAnchor="middle"
                  fill="currentColor"
                  fontSize="11"
                  opacity="0.7"
                  fontWeight="500"
                >
                  {dateFormatter(item.date)}
                </text>
              )}

              {/* Value label on hover */}
              {isHovered && (
                <g>
                  {/* Background rectangle */}
                  <rect
                    x={x + columnWidth / 2 - 70}
                    y={y - hoverOffset - 65}
                    width="140"
                    height="58"
                    rx="10"
                    fill="rgba(0, 0, 0, 0.9)"
                    stroke={color}
                    strokeWidth="2"
                    style={{ filter: 'drop-shadow(0 6px 12px rgba(0, 0, 0, 0.4))' }}
                  />
                  {/* Label text */}
                  <text
                    x={x + columnWidth / 2}
                    y={y - hoverOffset - 38}
                    textAnchor="middle"
                    fill="#ffffff"
                    fontSize="13"
                    fontWeight="600"
                    opacity="0.95"
                  >
                    {tooltipLabel || 'Tổng lượt nhận diện'}
                  </text>
                  {/* Value text */}
                  <text
                    x={x + columnWidth / 2}
                    y={y - hoverOffset - 15}
                    textAnchor="middle"
                    fill="#ffffff"
                    fontSize="18"
                    fontWeight="700"
                  >
                    {item.recognition_count.toLocaleString()}
                  </text>
                </g>
              )}
            </g>
          );
        })}

        {/* Axis lines */}
        <line
          x1={paddingX}
          y1={height - paddingY}
          x2={width - paddingX}
          y2={height - paddingY}
          stroke="currentColor"
          strokeWidth="1.5"
          strokeOpacity="0.2"
        />
        <line
          x1={paddingX}
          y1={paddingY}
          x2={paddingX}
          y2={height - paddingY}
          stroke="currentColor"
          strokeWidth="1.5"
          strokeOpacity="0.2"
        />
      </svg>
    </div>
  );
};

const formatDateTime = (value, language = 'vi') => {
  if (!value) return '--';
  const date = new Date(value);
  return new Intl.DateTimeFormat(language === 'vi' ? 'vi-VN' : 'en-US', {
    hour: '2-digit',
    minute: '2-digit',
    day: '2-digit',
    month: 'short'
  }).format(date);
};

const AnalyticsDashboard = () => {
  const { language, darkMode, t } = useTheme();
  const [analytics, setAnalytics] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [lastUpdated, setLastUpdated] = useState(null);
  const [activityPage, setActivityPage] = useState(1);
  const itemsPerPage = 10;

  const fetchAnalytics = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const response = await adminAnalyticsApi.getOverview(language);
      setAnalytics(response.data);
      setLastUpdated(new Date().toISOString());
    } catch (err) {
      console.error(err);
      setError(t('adminAnalyticsError') || 'Không thể tải thống kê.');
    } finally {
      setLoading(false);
    }
  }, [language, t]);

  useEffect(() => {
    fetchAnalytics();
  }, [fetchAnalytics]);

  const totalRecognitions = useMemo(() => analytics?.total_recognitions || 0, [analytics]);
  const totalUsers = useMemo(() => analytics?.total_users || 0, [analytics]);
  const topDishes = useMemo(() => (analytics?.recognitions_by_dish || []).slice(0, 5), [analytics]);
  const maxDishCount = useMemo(
    () => Math.max(...topDishes.map((item) => item.recognition_count || 0), 1),
    [topDishes]
  );
  const favoriteDish = useMemo(() => analytics?.most_favorited_dish || null, [analytics]);
  
  // Pagination for recent activity
  const recentActivity = useMemo(() => analytics?.recent_activity || [], [analytics]);
  const totalActivityPages = useMemo(() => Math.ceil(recentActivity.length / itemsPerPage), [recentActivity.length]);
  const paginatedActivity = useMemo(() => {
    const startIndex = (activityPage - 1) * itemsPerPage;
    const endIndex = startIndex + itemsPerPage;
    return recentActivity.slice(startIndex, endIndex);
  }, [recentActivity, activityPage]);
  
  // Reset to page 1 when analytics data changes
  useEffect(() => {
    setActivityPage(1);
  }, [analytics]);

  if (loading) {
    return (
      <div className="text-center py-5">
        <Spinner animation="border" role="status" className="mb-3" />
        <p className="text-muted mb-0">{t('loading') || 'Đang tải...'}</p>
      </div>
    );
  }

  if (error) {
    return (
      <Alert variant="danger">
        {error}
        <div className="mt-3">
          <Button variant="outline-danger" size="sm" onClick={fetchAnalytics}>
            {t('adminAnalyticsRetry') || 'Thử lại'}
          </Button>
        </div>
      </Alert>
    );
  }

  if (!analytics) {
    return (
      <div className="text-center text-muted py-4">
        {t('adminAnalyticsNoData') || 'Chưa có dữ liệu thống kê.'}
      </div>
    );
  }

  return (
    <div className="admin-analytics">
      <div className="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
        <div>
          <h3 className="fw-bold mb-1">{t('adminAnalyticsTitle') || 'Thống kê & báo cáo'}</h3>
          <p className="text-muted mb-0">
            {t('adminAnalyticsDescription') || 'Theo dõi lượt nhận diện, người dùng và xu hướng gần đây.'}
          </p>
        </div>
        <div className="d-flex align-items-center gap-3">
          <div className="text-muted small">
            {t('adminAnalyticsLastUpdated') || 'Cập nhật lần cuối'}: {formatDateTime(lastUpdated, language)}
          </div>
          <Button variant={darkMode ? 'outline-light' : 'outline-primary'} onClick={fetchAnalytics}>
            {t('adminRefreshList') || 'Tải lại'}
          </Button>
        </div>
      </div>

      <Row className="g-3 g-md-4 mb-4">
        <Col xl={3} md={6}>
          <Card className="h-100 shadow-sm">
            <Card.Body>
              <div className="text-muted small text-uppercase mb-2">
                {t('adminAnalyticsTotalRecognitions') || 'Tổng lượt nhận diện'}
              </div>
              <h2 className="fw-bold mb-0">{totalRecognitions.toLocaleString()}</h2>
            </Card.Body>
          </Card>
        </Col>
        <Col xl={3} md={6}>
          <Card className="h-100 shadow-sm">
            <Card.Body>
              <div className="text-muted small text-uppercase mb-2">
                {t('adminAnalyticsTotalUsers') || 'Người dùng đã đăng ký'}
              </div>
              <h2 className="fw-bold mb-0">{totalUsers.toLocaleString()}</h2>
            </Card.Body>
          </Card>
        </Col>
        <Col xl={3} md={6}>
          <Card className="h-100 shadow-sm">
            <Card.Body>
              <div className="text-muted small text-uppercase mb-2">
                {t('adminAnalyticsPopularDish') || 'Món ăn phổ biến nhất'}
              </div>
              {analytics?.most_popular_dish ? (
                <h5 className="fw-bold mb-0 text-truncate">
                  {analytics.most_popular_dish.dish_name}
                </h5>
              ) : (
                <div className="text-muted">{t('adminAnalyticsNoData') || 'Chưa có dữ liệu.'}</div>
              )}
            </Card.Body>
          </Card>
        </Col>
        <Col xl={3} md={6}>
          <Card className="h-100 shadow-sm">
            <Card.Body>
              <div className="text-muted small text-uppercase mb-2">
                {t('adminAnalyticsFavoriteDish') || 'Món ăn được yêu thích nhất'}
              </div>
              {favoriteDish ? (
                <>
                  <h5 className="fw-bold mb-1 text-truncate">{favoriteDish.dish_name}</h5>
                  <div className="text-muted">
                    {favoriteDish.favorite_count.toLocaleString()} {t('favoritesCountLabel') || 'lượt yêu thích'}
                  </div>
                </>
              ) : (
                <div className="text-muted">{t('adminAnalyticsNoData') || 'Chưa có dữ liệu.'}</div>
              )}
            </Card.Body>
          </Card>
        </Col>
      </Row>

      <Row className="g-3 g-md-4 mb-4">
        <Col lg={6}>
          <Card className="h-100 shadow-sm">
            <Card.Body>
              <h5 className="fw-bold mb-3">{t('adminAnalyticsRecognitionsByDish') || 'Lượt nhận diện theo món'}</h5>
              {topDishes.length === 0 ? (
                <div className="text-muted">{t('adminAnalyticsNoData') || 'Chưa có dữ liệu.'}</div>
              ) : (
                <ListGroup variant="flush">
                  {topDishes.map((dish, index) => (
                    <ListGroup.Item key={dish.dish_id} className="px-0">
                      <div className="d-flex align-items-center justify-content-between mb-2">
                        <div className="d-flex align-items-center gap-2">
                          <Badge bg="warning" text="dark">{index + 1}</Badge>
                          <span className="fw-semibold">{dish.dish_name}</span>
                        </div>
                        <span className="fw-bold">{dish.recognition_count.toLocaleString()}</span>
                      </div>
                      <ProgressBar
                        now={(dish.recognition_count / maxDishCount) * 100}
                        variant="warning"
                        style={{ height: '10px' }}
                      />
                    </ListGroup.Item>
                  ))}
                </ListGroup>
              )}
            </Card.Body>
          </Card>
        </Col>
        <Col lg={6}>
          <Card className="h-100 shadow-sm">
            <Card.Body>
              <h5 className="fw-bold mb-3">{t('adminAnalyticsTrendTitle') || 'Biểu đồ nhận diện 30 ngày'}</h5>
              <TrendChart
                data={analytics.recognition_trend}
                color="#ff6b2c"
                emptyMessage={t('adminAnalyticsNoData') || 'Chưa có dữ liệu.'}
                tooltipLabel={t('adminAnalyticsTotalRecognitions') || 'Tổng lượt nhận diện'}
              />
            </Card.Body>
          </Card>
        </Col>
      </Row>

      <Card className="shadow-sm">
        <Card.Body>
          <h5 className="fw-bold mb-3">{t('adminAnalyticsRecentActivity') || 'Hoạt động gần đây'}</h5>
          {recentActivity.length > 0 ? (
            <>
              <div className="table-responsive">
                <table className="table align-middle mb-0">
                  <thead>
                    <tr>
                      <th>{t('username') || 'Người dùng'}</th>
                      <th>{t('dish') || 'Món ăn'}</th>
                      <th>{t('recognizedAt') || 'Nhận diện lúc'}</th>
                    </tr>
                  </thead>
                  <tbody>
                    {paginatedActivity.map((item) => (
                      <tr key={item.history_id}>
                        <td className="fw-semibold">{item.username}</td>
                        <td>{item.dish_name}</td>
                        <td>{formatDateTime(item.recognized_at, language)}</td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
              {recentActivity.length > itemsPerPage && (
                <div className="d-flex justify-content-center mt-4">
                  <Pagination>
                    <Pagination.First
                      onClick={() => setActivityPage(1)}
                      disabled={activityPage === 1}
                    />
                    <Pagination.Prev
                      onClick={() => setActivityPage(prev => Math.max(1, prev - 1))}
                      disabled={activityPage === 1}
                    />
                    
                    {[...Array(totalActivityPages)].map((_, idx) => {
                      const pageNum = idx + 1;
                      if (
                        pageNum === 1 ||
                        pageNum === totalActivityPages ||
                        (pageNum >= activityPage - 1 && pageNum <= activityPage + 1)
                      ) {
                        return (
                          <Pagination.Item
                            key={pageNum}
                            active={pageNum === activityPage}
                            onClick={() => setActivityPage(pageNum)}
                          >
                            {pageNum}
                          </Pagination.Item>
                        );
                      } else if (pageNum === activityPage - 2 || pageNum === activityPage + 2) {
                        return <Pagination.Ellipsis key={pageNum} />;
                      }
                      return null;
                    })}
                    
                    <Pagination.Next
                      onClick={() => setActivityPage(prev => Math.min(totalActivityPages, prev + 1))}
                      disabled={activityPage === totalActivityPages}
                    />
                    <Pagination.Last
                      onClick={() => setActivityPage(totalActivityPages)}
                      disabled={activityPage === totalActivityPages}
                    />
                  </Pagination>
                </div>
              )}
            </>
          ) : (
            <div className="text-muted">{t('adminAnalyticsNoData') || 'Chưa có dữ liệu.'}</div>
          )}
        </Card.Body>
      </Card>
    </div>
  );
};

export default AnalyticsDashboard;


