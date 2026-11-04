DROP DATABASE IF EXISTS QuanLySanPhamSP;
CREATE DATABASE QuanLySanPhamSP;
USE QuanLySanPhamSP;

CREATE TABLE products (
    product_id   INT          NOT NULL AUTO_INCREMENT,   -- Ma san pham
    product_name VARCHAR(255) NOT NULL,                  -- Ten san pham
    price        DOUBLE       NOT NULL,                  -- Gia ban
    category     VARCHAR(100),                           -- Loai san pham
    PRIMARY KEY (product_id)
);

INSERT INTO products (product_name, price, category) VALUES
('iPhone 15',          22990000, 'Phone'),
('Samsung Galaxy S24', 19990000, 'Phone'),
('Dell Inspiron 15',   15490000, 'Laptop'),
('Chuot Logitech',       350000, 'Phu kien');


DELIMITER $$
CREATE PROCEDURE sp_get_products_by_category(IN p_category VARCHAR(100))
BEGIN
    SELECT product_id, product_name, price, category
    FROM   products
    WHERE  category = p_category;
END $$
DELIMITER ;

CALL sp_get_products_by_category('Phone');