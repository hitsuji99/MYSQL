DROP DATABASE IF EXISTS QuanLySanPham;
CREATE DATABASE QuanLySanPham;
USE QuanLySanPham;

CREATE TABLE categories (
    id   INT          NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE products (
    id          INT          NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    price       DOUBLE       NOT NULL,
    category_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO categories (name) VALUES
('Phone'), ('Laptop');

INSERT INTO products (name, price, category_id) VALUES
('iPhone 15', 22990000, 1),
('Samsung Galaxy S24', 19990000, 1),
('Dell Inspiron 15', 15490000, 2);

-- them 3 san pham --
INSERT INTO products (name, price, category_id) VALUES
('Xiaomi Note', 5000000, 1),
('Samsung Galaxy A55', 10000000, 1),
('HP Pavilion', 30000000, 2);

-- cap nhat gia --
UPDATE products SET price = 25000000 WHERE id = 1;

-- xoa san pham --
DELETE FROM products WHERE id = 3;

-- hien thi gia giam dan --
SELECT p.id, p.name, p.price, c.name AS category_name
FROM products p
LEFT JOIN categories c ON c.id = p.category_id
ORDER BY p.price DESC;

-- thong ke theo danh muc --
SELECT c.id, c.name AS category_name, COUNT(p.id) AS product_count
FROM categories c
LEFT JOIN products p ON p.category_id = c.id
GROUP BY c.id, c.name;