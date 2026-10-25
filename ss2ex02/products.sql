-- tạo bảng sản phẩm
CREATE DATABASE QuanLyCuaHang;
USE QuanLyCuaHang;

CREATE TABLE products (
    product_id     VARCHAR(10) PRIMARY KEY,
    product_name   VARCHAR(100),
    price          DECIMAL(10, 2),
    stock_quantity INT
);
