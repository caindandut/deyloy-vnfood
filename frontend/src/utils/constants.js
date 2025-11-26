// Sử dụng biến môi trường VITE_API_BASE_URL nếu có (khi deploy), ngược lại dùng localhost
export const BACKEND_URL = import.meta.env.VITE_API_BASE_URL || "http://localhost:8001";

export const PI_ADDRESS = "172.20.10.9"; //172.20.10.9
export const PI_STREAM_URL = `http://${PI_ADDRESS}:8000`;

export const API_URL = BACKEND_URL;

