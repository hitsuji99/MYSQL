CREATE DATABASE QuanLySanPham;
USE QuanLySanPham;

CREATE TABLE products (
    product_id   VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(100),
    category     VARCHAR(50),
    price        INT
);

INSERT INTO products VALUES ('SP01', 'Laptop Dell',     'Laptop',    25000000);
INSERT INTO products VALUES ('SP02', 'Laptop Asus',     'Laptop',    18000000);
INSERT INTO products VALUES ('SP03', 'Macbook Air',     'Laptop',    32000000);
INSERT INTO products VALUES ('SP04', 'iPhone 15',       'Phone',     28000000);
INSERT INTO products VALUES ('SP05', 'Samsung A55',     'Phone',     15000000);
INSERT INTO products VALUES ('SP06', 'Xiaomi Redmi',    'Phone',      7000000);
INSERT INTO products VALUES ('SP07', 'Chuot Logitech',  'Accessory',   300000);
INSERT INTO products VALUES ('SP08', 'Ban phim co',     'Accessory',  1200000);
INSERT INTO products VALUES ('SP09', 'Tai nghe Sony',   'Accessory',  2500000);

SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products);

SELECT * FROM products p
WHERE price = (SELECT MAX(price) FROM products WHERE category = p.category);

SELECT * FROM products
WHERE category IN (SELECT category FROM products WHERE price > 20000000);
