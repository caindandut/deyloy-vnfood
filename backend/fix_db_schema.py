import mysql.connector
import os

# Cấu hình kết nối TiDB (Hardcoded để đảm bảo chạy đúng vào DB đích)
DB_CONFIG = {
    "host": "gateway01.ap-southeast-1.prod.aws.tidbcloud.com",
    "port": 4000,
    "user": "VZpmDrzDCBNd3Xq.root",
    "password": "n7IoUj1s7rCXfDab",
    "database": "vnfood",
    "ssl_ca": "isrgrootx1.pem",
    "ssl_disabled": False
}

def fix_schema():
    print("Đang kết nối đến TiDB...")
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        print("Kết nối thành công!")

        tables_to_fix = [
            "users",
            "dishes",
            "favorites",
            "history",
            "ingredients",
            "instructions",
            "shopping_lists",
            "shopping_list_items"
        ]

        for table in tables_to_fix:
            print(f"Đang sửa bảng '{table}'...")
            try:
                # Lệnh này sẽ thêm thuộc tính AUTO_INCREMENT cho cột id
                sql = f"ALTER TABLE {table} MODIFY id INT NOT NULL AUTO_INCREMENT;"
                cursor.execute(sql)
                conn.commit()
                print(f" -> Đã sửa xong bảng '{table}'")
            except mysql.connector.Error as err:
                print(f" -> Lỗi khi sửa bảng '{table}': {err}")

        print("\nHoàn tất sửa lỗi Database!")
        cursor.close()
        conn.close()

    except Exception as e:
        print(f"Lỗi kết nối: {e}")

if __name__ == "__main__":
    fix_schema()
