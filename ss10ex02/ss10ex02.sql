-- [Cơ bản] Không cho phép xóa sản phẩm theo điều kiện
DROP DATABASE IF EXISTS InventoryManagement;
CREATE DATABASE InventoryManagement;
USE InventoryManagement;

-- 1. Tạo bảng
CREATE TABLE Products (
    productID INT AUTO_INCREMENT PRIMARY KEY,
    productName VARCHAR(100),
    quantity INT
);

CREATE TABLE InventoryChanges (
    changeID INT AUTO_INCREMENT PRIMARY KEY,
    productID INT NOT NULL,
    oldQuantity INT,
    newQuantity INT,
    changeDate DATETIME,
    FOREIGN KEY (productID) REFERENCES Products(productID)
);

-- 2. Dữ liệu mẫu
INSERT INTO Products (productName, quantity) VALUES
('Laptop', 10),
('Chuột', 50),
('Bàn phím', 30),
('Màn hình', 5);

-- 3. Trigger BeforeProductDelete: không cho xóa sản phẩm có số lượng > 10
DELIMITER //
CREATE TRIGGER BeforeProductDelete
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    IF OLD.quantity > 10 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Không thể xóa sản phẩm có số lượng lớn hơn 10';
    END IF;
END //
DELIMITER ;

-- 4. Kiểm tra
-- Xóa sản phẩm có số lượng <= 10 => xóa thành công
DELETE FROM Products WHERE productID = 4; -- Màn hình, quantity = 5
SELECT * FROM Products;

-- Xóa sản phẩm có số lượng > 10 => báo lỗi:
-- Error Code: 1644. Không thể xóa sản phẩm có số lượng lớn hơn 10
DELETE FROM Products WHERE productID = 2; -- Chuột, quantity = 50
