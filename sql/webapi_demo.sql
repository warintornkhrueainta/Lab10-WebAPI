CREATE DATABASE IF NOT EXISTS webapi_demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE webapi_demo;

CREATE TABLE IF NOT EXISTS products (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  sku VARCHAR(32) NOT NULL UNIQUE,
  name VARCHAR(150) NOT NULL,
  brand VARCHAR(80) NOT NULL,
  category VARCHAR(80) NOT NULL,
  price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
  stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
  warranty_months TINYINT UNSIGNED NOT NULL DEFAULT 12,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 🔹 ข้อมูลตัวอย่าง (20 รายการ)
INSERT INTO products (sku, name, brand, category, price, stock, warranty_months) VALUES
('TV-32A1', 'ทีวี 32 นิ้ว HD', 'Panaphonic', 'ทีวี', 4990.00, 12, 24),
('TV-55U2', 'ทีวี 55 นิ้ว 4K', 'Sangsung', 'ทีวี', 16990.00, 7, 24),
('FR-250S', 'ตู้เย็น 2 ประตู 250L', 'Hitano', 'ตู้เย็น', 8990.00, 10, 36),
('AC-12000', 'แอร์ 12000 BTU อินเวอร์เตอร์', 'Daika', 'แอร์', 13990.00, 6, 60),
('WM-8KG', 'เครื่องซักผ้า 8 กก.', 'Toshiha', 'เครื่องซักผ้า', 6990.00, 9, 24),
('MW-23L', 'ไมโครเวฟ 23 ลิตร', 'Panaphonic', 'ไมโครเวฟ', 2490.00, 20, 12),
('VA-1000', 'เครื่องดูดฝุ่น 1000W', 'Sangsung', 'เครื่องใช้ในบ้าน', 1590.00, 15, 12),
('IH-2000', 'เตาแม่เหล็กไฟฟ้า 2000W', 'Sharpix', 'เครื่องครัว', 1290.00, 25, 12),
('AR-5L', 'หม้อทอดไร้น้ำมัน 5 ลิตร', 'SmartCook', 'เครื่องครัว', 1790.00, 18, 12),
('FR-180S', 'ตู้เย็น 1 ประตู 180L', 'Toshiha', 'ตู้เย็น', 6490.00, 8, 24),
('WM-10KG', 'เครื่องซักผ้า 10 กก.', 'Hitano', 'เครื่องซักผ้า', 8990.00, 5, 36),
('AC-9000', 'แอร์ 9000 BTU', 'Daika', 'แอร์', 11990.00, 12, 48),
('TV-65U3', 'ทีวี 65 นิ้ว 4K', 'Panaphonic', 'ทีวี', 25990.00, 4, 24),
('FR-300S', 'ตู้เย็น 300L', 'Hitano', 'ตู้เย็น', 9990.00, 9, 36),
('MW-30L', 'ไมโครเวฟ 30 ลิตร', 'Sharpix', 'ไมโครเวฟ', 2990.00, 14, 12),
('IH-2500', 'เตาแม่เหล็กไฟฟ้า 2500W', 'Sharpix', 'เครื่องครัว', 1490.00, 20, 12),
('AR-3L', 'หม้อทอดไร้น้ำมัน 3 ลิตร', 'SmartCook', 'เครื่องครัว', 1590.00, 15, 12),
('VA-2000', 'เครื่องดูดฝุ่น 2000W', 'Sangsung', 'เครื่องใช้ในบ้าน', 1990.00, 10, 12),
('WM-7KG', 'เครื่องซักผ้า 7 กก.', 'Toshiha', 'เครื่องซักผ้า', 5990.00, 13, 24),
('FR-150S', 'ตู้เย็น 150L', 'Daika', 'ตู้เย็น', 5990.00, 11, 24);
