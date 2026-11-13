-- [Thực hành] Luyện tập các loại Trigger với CSDL Ecommerce
DROP DATABASE IF EXISTS tsubasa_csdl_session12;
CREATE DATABASE tsubasa_csdl_session12;
USE tsubasa_csdl_session12;

-- =====================================================
-- CÀI ĐẶT MÔI TRƯỜNG: 6 bảng theo sơ đồ
-- =====================================================
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    stock_quantity INT NOT NULL DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) DEFAULT 0,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Credit Card', 'PayPal', 'Bank Transfer', 'Cash') NOT NULL,
    status ENUM('Pending', 'Completed', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

-- Dữ liệu mẫu
INSERT INTO customers (name, email, phone, address) VALUES
('Nguyễn Văn An', 'an@example.com', '0901000001', 'Hà Nội'),
('Trần Thị Bình', 'binh@example.com', '0901000002', 'Đà Nẵng'),
('Lê Văn Cường', 'cuong@example.com', '0901000003', 'TP. Hồ Chí Minh');

INSERT INTO products (name, price, description) VALUES
('Laptop', 15000000.00, 'Laptop văn phòng'),
('Chuột', 200000.00, 'Chuột không dây'),
('Bàn phím', 500000.00, 'Bàn phím cơ'),
('Tai nghe', 800000.00, 'Tai nghe bluetooth');

INSERT INTO inventory (product_id, stock_quantity) VALUES
(1, 5),
(2, 50),
(3, 20),
(4, 10);

INSERT INTO orders (customer_id, status) VALUES
(1, 'Pending'),    -- order 1
(2, 'Completed'),  -- order 2 (đã thanh toán)
(3, 'Pending');    -- order 3

INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(2, 0, 'Credit Card', 'Completed');

-- =====================================================
-- 1. Trigger BEFORE INSERT
-- Kiểm tra tồn kho trước khi thêm sản phẩm vào order_items
-- =====================================================
DELIMITER //
CREATE TRIGGER trg_before_insert_order_items
BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE v_stock INT;

    SELECT stock_quantity INTO v_stock
    FROM inventory
    WHERE product_id = NEW.product_id;

    IF v_stock IS NULL OR v_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Không đủ số lượng tồn kho';
    END IF;
END //

-- =====================================================
-- 2. Trigger AFTER INSERT
-- Cập nhật total_amount của orders sau khi thêm sản phẩm
-- (đồng thời trừ tồn kho để AFTER DELETE hoàn trả lại cho khớp)
-- =====================================================
CREATE TRIGGER trg_after_insert_order_items
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE orders
    SET total_amount = total_amount + NEW.quantity * NEW.price
    WHERE order_id = NEW.order_id;

    UPDATE inventory
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END //

-- =====================================================
-- 3. Trigger BEFORE UPDATE
-- Kiểm tra tồn kho trước khi cập nhật số lượng trong order_items
-- =====================================================
CREATE TRIGGER trg_before_update_order_items
BEFORE UPDATE ON order_items
FOR EACH ROW
BEGIN
    DECLARE v_stock INT;

    SELECT stock_quantity INTO v_stock
    FROM inventory
    WHERE product_id = NEW.product_id;

    -- Cùng sản phẩm: số lượng cũ đã bị trừ khỏi kho nên được tính lại vào
    IF NEW.product_id = OLD.product_id THEN
        SET v_stock = v_stock + OLD.quantity;
    END IF;

    IF v_stock IS NULL OR v_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Không đủ số lượng tồn kho để cập nhật';
    END IF;
END //

-- =====================================================
-- 4. Trigger AFTER UPDATE
-- Cập nhật lại total_amount khi số lượng hoặc giá thay đổi
-- =====================================================
CREATE TRIGGER trg_after_update_order_items
AFTER UPDATE ON order_items
FOR EACH ROW
BEGIN
    IF OLD.quantity <> NEW.quantity
       OR OLD.price <> NEW.price
       OR OLD.product_id <> NEW.product_id THEN

        UPDATE orders
        SET total_amount = total_amount
                           - OLD.quantity * OLD.price
                           + NEW.quantity * NEW.price
        WHERE order_id = NEW.order_id;

        -- Điều chỉnh tồn kho theo số lượng mới
        UPDATE inventory
        SET stock_quantity = stock_quantity + OLD.quantity
        WHERE product_id = OLD.product_id;

        UPDATE inventory
        SET stock_quantity = stock_quantity - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END //

-- =====================================================
-- 5. Trigger BEFORE DELETE
-- Không cho xóa đơn hàng có trạng thái Completed
-- =====================================================
CREATE TRIGGER trg_before_delete_orders
BEFORE DELETE ON orders
FOR EACH ROW
BEGIN
    IF OLD.status = 'Completed' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Không thể xóa đơn hàng đã thanh toán (Completed)';
    END IF;
END //

-- =====================================================
-- 6. Trigger AFTER DELETE
-- Hoàn trả số lượng sản phẩm vào kho khi xóa khỏi order_items
-- =====================================================
CREATE TRIGGER trg_after_delete_order_items
AFTER DELETE ON order_items
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET stock_quantity = stock_quantity + OLD.quantity
    WHERE product_id = OLD.product_id;

    -- Trừ tiền sản phẩm bị xóa khỏi tổng đơn hàng
    UPDATE orders
    SET total_amount = total_amount - OLD.quantity * OLD.price
    WHERE order_id = OLD.order_id;
END //
DELIMITER ;

-- Xem danh sách trigger đã tạo
SHOW TRIGGERS;

-- =====================================================
-- KIỂM TRA CÁC TRƯỜNG HỢP THÀNH CÔNG
-- =====================================================
-- AFTER INSERT: thêm sản phẩm => total_amount tăng, tồn kho giảm
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 15000000.00),  -- 2 Laptop
(1, 2, 3, 200000.00),    -- 3 Chuột
(3, 3, 1, 500000.00);    -- 1 Bàn phím
SELECT * FROM orders;     -- order 1: 30.600.000, order 3: 500.000
SELECT * FROM inventory;  -- Laptop: 3, Chuột: 47, Bàn phím: 19

-- AFTER UPDATE: đổi số lượng Chuột 3 -> 5 => total_amount và tồn kho cập nhật
UPDATE order_items SET quantity = 5 WHERE order_item_id = 2;
SELECT * FROM orders WHERE order_id = 1;  -- 31.000.000
SELECT * FROM inventory WHERE product_id = 2;  -- 45

-- AFTER DELETE: xóa Bàn phím khỏi order 3 => hoàn trả kho
DELETE FROM order_items WHERE order_item_id = 3;
SELECT * FROM inventory WHERE product_id = 3;  -- 20
SELECT * FROM orders WHERE order_id = 3;  -- 0

-- BEFORE DELETE: xóa đơn Pending => được phép
DELETE FROM orders WHERE order_id = 3;
SELECT * FROM orders;

-- =====================================================
-- KIỂM TRA CÁC TRƯỜNG HỢP BÁO LỖI (SQLSTATE '45000')
-- Mỗi câu dưới đây sẽ báo lỗi => bôi đen và chạy từng câu (Ctrl + Enter)
-- =====================================================
-- BEFORE INSERT: Laptop chỉ còn 3 => thêm 10 cái bị chặn
INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (1, 1, 10, 15000000.00);

-- BEFORE UPDATE: tăng Laptop lên 100 cái => bị chặn
UPDATE order_items SET quantity = 100 WHERE order_item_id = 1;

-- BEFORE DELETE: đơn hàng 2 đã Completed => không được xóa
DELETE FROM orders WHERE order_id = 2;

-- =====================================================
-- XÓA TRIGGER
-- =====================================================
DROP TRIGGER IF EXISTS trg_before_insert_order_items;
DROP TRIGGER IF EXISTS trg_after_insert_order_items;
DROP TRIGGER IF EXISTS trg_before_update_order_items;
DROP TRIGGER IF EXISTS trg_after_update_order_items;
DROP TRIGGER IF EXISTS trg_before_delete_orders;
DROP TRIGGER IF EXISTS trg_after_delete_order_items;

SHOW TRIGGERS;
