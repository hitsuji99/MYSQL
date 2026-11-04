DROP DATABASE IF EXISTS QuanLySanPhamIndex;
CREATE DATABASE QuanLySanPhamIndex;
USE QuanLySanPhamIndex;

CREATE TABLE products (
    product_id   INT          NOT NULL AUTO_INCREMENT,   -- Ma san pham
    product_name VARCHAR(255) NOT NULL,                  -- Ten san pham
    category     VARCHAR(100),                           -- Loai san pham
    price        DOUBLE,                                 -- Gia ban
    PRIMARY KEY (product_id)
);

CREATE INDEX idx_products_category_price ON products (category, price);