-- [Cơ bản] Tự động kiểm tra số lượng sản phẩm trước khi insert
DROP DATABASE IF EXISTS InventoryManagement;
CREATE DATABASE InventoryManagement;
USE InventoryManagement;

-- 1. Tạo bảng
-- Products: chứa thông tin về sản phẩm
CREATE TABLE Products (
    productID INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100),
    quantity INT
);

-- InventoryChanges: ghi lại các thay đổi về số lượng hàng trong kho
CREATE TABLE InventoryChanges (
    changeID INT AUTO_INCREMENT PRIMARY KEY,
    productID INT NOT NULL,
    oldQuantity INT,
    newQuantity INT,
    changeDate DATETIME,
    FOREIGN KEY (productID) REFERENCES Products(productID)
);

-- 2. Trigger BeforeInsertProduct: không cho thêm sản phẩm có quantity < 0
DELIMITER //
CREATE TRIGGER BeforeInsertProduct
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    IF NEW.quantity < 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Số lượng sản phẩm không được nhỏ hơn 0';
    END IF;
END //
DELIMITER ;

-- 3. Kiểm tra
-- Thêm sản phẩm hợp lệ => thành công
INSERT INTO Products (productName, quantity) VALUES
('Laptop', 10),
('Chuột', 0);
SELECT * FROM Products;

-- Thêm sản phẩm có quantity < 0 => báo lỗi, không chèn được:
-- Error Code: 1644. Số lượng sản phẩm không được nhỏ hơn 0
INSERT INTO Products (productName, quantity) VALUES ('Bàn phím', -5);
