import mysql.connector
import os
import sys

# Thêm thư mục hiện tại vào path để import config
sys.path.append(os.path.dirname(os.path.abspath(__file__)))

from config import DB_CONFIG

def split_sql_statements(sql_script):
    """
    Tách các câu lệnh SQL một cách thông minh, bỏ qua dấu ; nằm trong chuỗi ký tự.
    """
    statements = []
    current_statement = []
    in_single_quote = False
    in_double_quote = False
    in_backtick = False
    escaped = False
    
    for char in sql_script:
        current_statement.append(char)
        
        if escaped:
            escaped = False
            continue
            
        if char == '\\':
            escaped = True
            continue
            
        if char == "'" and not in_double_quote and not in_backtick:
            in_single_quote = not in_single_quote
        elif char == '"' and not in_single_quote and not in_backtick:
            in_double_quote = not in_double_quote
        elif char == '`' and not in_single_quote and not in_double_quote:
            in_backtick = not in_backtick
        elif char == ';' and not in_single_quote and not in_double_quote and not in_backtick:
            # Tìm thấy dấu chấm phẩy kết thúc lệnh
            # Loại bỏ dấu ; cuối cùng và thêm vào danh sách
            stmt = "".join(current_statement[:-1]).strip()
            if stmt:
                statements.append(stmt)
            current_statement = []
            
    # Thêm phần còn lại nếu có
    stmt = "".join(current_statement).strip()
    if stmt:
        statements.append(stmt)
        
    return statements

def migrate():
    print("--- BẮT ĐẦU MIGRATION LÊN TIDB (TỪ FILE vnfood.sql) ---")
    print("Đang kết nối tới database với cấu hình trong config.py...")
    
    try:
        # Kết nối tới database
        # use_pure=True giúp tránh lỗi C extension, nhưng ta sẽ tự tách lệnh để an toàn nhất
        conn = mysql.connector.connect(**DB_CONFIG, use_pure=True)
        cursor = conn.cursor()
        print("✅ Kết nối thành công!")
    except mysql.connector.Error as err:
        if err.errno == 1049: # Unknown database
            print(f"⚠️ Database '{DB_CONFIG['database']}' chưa tồn tại. Đang tiến hành tạo mới...")
            try:
                # Tạo config tạm không có database để kết nối
                temp_config = DB_CONFIG.copy()
                del temp_config['database']
                
                conn = mysql.connector.connect(**temp_config, use_pure=True)
                cursor = conn.cursor()
                
                # Tạo database
                cursor.execute(f"CREATE DATABASE IF NOT EXISTS {DB_CONFIG['database']}")
                conn.commit()
                print(f"✅ Đã tạo database '{DB_CONFIG['database']}' thành công!")
                
                # Kết nối lại vào database vừa tạo
                cursor.close()
                conn.close()
                conn = mysql.connector.connect(**DB_CONFIG, use_pure=True)
                cursor = conn.cursor()
                print("✅ Đã kết nối vào database mới tạo!")
                
            except Exception as e:
                print(f"❌ Lỗi khi tạo database: {e}")
                return
        else:
            print(f"❌ Lỗi kết nối: {err}")
            print("Gợi ý: Kiểm tra lại host, user, password, port và SSL trong config.py")
            return
    except Exception as e:
        print(f"❌ Lỗi kết nối không xác định: {e}")
        return

    # Đường dẫn tới file vnfood.sql
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    sql_file_path = os.path.join(base_dir, 'DB', 'vnfood.sql')
    
    if not os.path.exists(sql_file_path):
        print(f"❌ Không tìm thấy file: {sql_file_path}")
        return

    print(f"⏳ Đang đọc file: {sql_file_path}...")
    
    try:
        with open(sql_file_path, 'r', encoding='utf-8') as f:
            sql_script = f.read()
        
        if not sql_script.strip():
            print("⚠️ File SQL rỗng.")
            return

        print("⏳ Đang phân tích và tách các câu lệnh SQL (có thể mất vài giây)...")
        statements = split_sql_statements(sql_script)
        
        total_statements = len(statements)
        print(f"Tìm thấy {total_statements} câu lệnh. Đang thực thi...")

        success_count = 0
        error_count = 0
        
        # Tắt kiểm tra khóa ngoại để tránh lỗi khi insert dữ liệu không theo thứ tự (nếu cần)
        # cursor.execute("SET FOREIGN_KEY_CHECKS=0;") 

        for i, statement in enumerate(statements):
            if statement.strip():
                try:
                    cursor.execute(statement)
                    success_count += 1
                    if success_count % 10 == 0:
                        print(f"   ... Đã chạy {success_count}/{total_statements} lệnh")
                except mysql.connector.Error as err:
                    error_count += 1
                    # In lỗi nhưng không dừng chương trình
                    # Lọc bớt các lỗi "Already exists" để đỡ rối mắt
                    # 1050: Table exists
                    # 1062: Duplicate entry
                    # 1068: Multiple primary key defined (do bảng đã có PK rồi)
                    # 1826: Duplicate foreign key constraint name
                    if err.errno in [1050, 1062, 1068, 1826]: 
                        print(f"   ⚠️ [Bỏ qua] Lệnh {i+1}: Dữ liệu/Cấu trúc đã tồn tại ({err.errno}).")
                    else:
                        print(f"   ❌ Lỗi tại lệnh số {i+1}: {err}")

        conn.commit()
        print(f"\n✅ Đã hoàn tất!")
        print(f"   - Thành công: {success_count}")
        print(f"   - Lỗi/Bỏ qua: {error_count}")
        
    except Exception as e:
        print(f"❌ Lỗi không xác định: {e}")

    cursor.close()
    conn.close()
    print("--- KẾT THÚC ---")

if __name__ == "__main__":
    migrate()
