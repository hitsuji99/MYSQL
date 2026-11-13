DROP DATABASE IF EXISTS tsubasa_csdl_session09;
CREATE DATABASE tsubasa_csdl_session09;
USE tsubasa_csdl_session09;

-- 1. Tạo bảng customers
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- 2. Thêm dữ liệu mẫu
INSERT INTO customers (customer_name, email, phone, address) VALUES
('Alice', 'alice@example.com', '1234567890', '123 Main St'),
('Bob', 'bob@example.com', '1234567891', '456 Elm St'),
('Carol', 'carol@example.com', '1234567892', '789 Oak St'),
('David', 'david@example.com', '1234567893', '135 Pine St'),
('Eva', 'eva@example.com', '1234567894', '246 Maple St'),
('Frank', 'frank@example.com', '1234567895', '369 Cedar St'),
('Grace', 'grace@example.com', '1234567896', '159 Birch St'),
('Hannah', 'hannah@example.com', '1234567897', '753 Willow St'),
('Ian', 'ian@example.com', '1234567898', '852 Ash St'),
('Jane', 'jane@example.com', '1234567899', '951 Cherry St'),
('Ken', 'ken@example.com', '1234567800', '258 Palm St'),
('Liam', 'liam@example.com', '1234567801', '369 Spruce St'),
('Mia', 'mia@example.com', '1234567802', '147 Fir St'),
('Noah', 'noah@example.com', '1234567803', '258 Larch St'),
('Olivia', 'olivia@example.com', '1234567804', '369 Redwood St'),
('Paul', 'paul@example.com', '1234567805', '654 Poplar St'),
('Quinn', 'quinn@example.com', '1234567806', '987 Magnolia St'),
('Rita', 'rita@example.com', '1234567807', '321 Willow St'),
('Sam', 'sam@example.com', '1234567808', '654 Hickory St'),
('Tina', 'tina@example.com', '1234567809', '987 Acacia St');

-- 3. TRƯỚC khi tạo index
--    Kết quả mong đợi: type = ALL, key = NULL, rows = 20, Extra = Using where
EXPLAIN SELECT * FROM customers WHERE email = 'tina@example.com';

-- 4. Tạo Unique Index cho cột email (email không được trùng)
CREATE UNIQUE INDEX idx_email ON customers (email);

-- 5. Tạo Index thường (Non-Unique) cho cột phone
CREATE INDEX idx_phone ON customers (phone);

-- 6. SAU khi tạo index
--    Kết quả mong đợi: type = const, key = idx_email, key_len = 402, rows = 1
EXPLAIN SELECT * FROM customers WHERE email = 'tina@example.com';

-- 7. Kiểm tra index phone
--    Kết quả mong đợi: type = ref, key = idx_phone
EXPLAIN SELECT * FROM customers WHERE phone = '1234567809';

-- 8. Xem danh sách index của bảng
SHOW INDEX FROM customers;	