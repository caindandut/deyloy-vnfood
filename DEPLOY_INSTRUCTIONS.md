# Hướng dẫn Deploy Backend lên Render

## Bước 1: Chuẩn bị Git
Bạn cần đẩy code lên GitHub để Render có thể lấy về và deploy.

1.  **Khởi tạo Git** (nếu chưa có):
    Mở terminal tại thư mục gốc `d:\DELOY`:
    ```bash
    git init
    git add .
    git commit -m "Initial commit for Render deployment"
    ```

2.  **Tạo Repository trên GitHub**:
    - Vào [github.com/new](https://github.com/new).
    - Đặt tên repo (ví dụ: `vnfood-backend`).
    - Chọn **Private** (để bảo mật thông tin).
    - Bấm **Create repository**.

3.  **Đẩy code lên GitHub**:
    Copy các lệnh mà GitHub hướng dẫn (phần "...or push an existing repository from the command line") và chạy trong terminal. Ví dụ:
    ```bash
    git remote add origin https://github.com/USERNAME/vnfood-backend.git
    git branch -M main
    git push -u origin main
    ```

## Bước 2: Deploy trên Render
1.  Truy cập [dashboard.render.com](https://dashboard.render.com/).
2.  Bấm nút **New +** và chọn **Blueprint**.
3.  Kết nối với tài khoản GitHub của bạn và chọn repo `vnfood-backend` vừa tạo.
4.  Render sẽ tự động đọc file `render.yaml` và thiết lập mọi thứ.
5.  Bấm **Apply** để bắt đầu deploy.

## Bước 3: Cấu hình Biến môi trường (Quan trọng)
Mặc dù tôi đã để mặc định trong code, nhưng để bảo mật tối đa, bạn nên cài đặt các biến môi trường trên Render:

1.  Vào phần **Environment** của service vừa tạo trên Render.
2.  Thêm các biến sau:
    - `DB_HOST`: `gateway01.ap-southeast-1.prod.aws.tidbcloud.com`
    - `DB_PORT`: `4000`
    - `DB_USER`: `VZpmDrzDCBNd3Xq.root`
    - `DB_PASSWORD`: `n7IoUj1s7rCXfDab`
    - `DB_NAME`: `vnfood`
    - `SECRET_KEY`: (Tự nghĩ ra một chuỗi ngẫu nhiên dài và khó đoán)

## Bước 4: Lấy URL Backend
Sau khi deploy xong (màu xanh lá cây), bạn sẽ thấy đường link dạng `https://vnfood-backend.onrender.com`.
Hãy copy link này để dùng cho Frontend.
