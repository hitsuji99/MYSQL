-- [Cơ bản] Ghi lại thay đổi số lượng sản phẩm
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

-- 3. Trigger AfterProductUpdate: ghi lại thay đổi số lượng vào InventoryChanges
DELIMITER //
CREATE TRIGGER AfterProductUpdate
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    -- Chỉ ghi lại khi số lượng thực sự thay đổi
    IF OLD.quantity <> NEW.quantity THEN
        INSERT INTO InventoryChanges (productID, oldQuantity, newQuantity, changeDate)
        VALUES (OLD.productID, OLD.quantity, NEW.quantity, NOW());
    END IF;
END //
DELIMITER ;

-- 4. Kiểm tra
UPDATE Products SET quantity = 15 WHERE productID = 1;
UPDATE Products SET quantity = 45 WHERE productID = 2;
UPDATE Products SET productName = 'Chuột không dây' WHERE productID = 2; -- không đổi số lượng => không ghi

SELECT * FROM Products;
SELECT * FROM InventoryChanges;
