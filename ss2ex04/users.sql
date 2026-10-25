-- tạo bảng người dùng
CREATE DATABASE QuanLyTaiKhoan;
USE QuanLyTaiKhoan;

CREATE TABLE users (
    user_id  VARCHAR(10) PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255) NOT NULL,
    status   VARCHAR(10) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'INACTIVE'))
);
