# Hướng dẫn Deploy Frontend lên Vercel

## Bước 1: Cập nhật Code
Tôi đã sửa code để Frontend nhận diện URL Backend thông qua biến môi trường. Bạn cần đẩy thay đổi này lên GitHub:

1.  Mở terminal tại thư mục gốc `d:\DELOY`:
    ```bash
    git add .
    git commit -m "Update frontend config for Vercel"
    git push
    ```

## Bước 2: Deploy trên Vercel
1.  Truy cập [vercel.com](https://vercel.com/) và đăng nhập bằng GitHub.
2.  Bấm nút **Add New...** -> **Project**.
3.  Chọn repo `deyloy-vnfood` của bạn và bấm **Import**.

## Bước 3: Cấu hình Project (Quan trọng)
Tại màn hình "Configure Project", bạn hãy chỉnh các thông số sau:

1.  **Framework Preset**: Chọn **Vite**.
2.  **Root Directory**: Bấm **Edit** và chọn thư mục `frontend`.
3.  **Environment Variables**:
    - Bấm mở rộng phần này.
    - Thêm biến sau:
      - **Name**: `VITE_API_BASE_URL`
      - **Value**: `https://deyloy-vnfood.onrender.com` (Link backend của bạn)
    - Bấm **Add**.

## Bước 4: Deploy
1.  Bấm nút **Deploy**.
2.  Chờ khoảng 1-2 phút.
3.  Khi màn hình pháo hoa hiện ra, bấm vào ảnh màn hình trang web để truy cập Frontend của bạn.

Chúc mừng! Bạn đã hoàn thành việc đưa dự án lên Internet!
