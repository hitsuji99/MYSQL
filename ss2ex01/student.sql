-- tạo bảng 
CREATE DATABASE QuanLyLopHoc;
USE QuanLyLopHoc;

CREATE TABLE students (
    student_id    VARCHAR(10) PRIMARY KEY,
    full_name     VARCHAR(100),
    date_of_birth DATE,
    gender        VARCHAR(10)
);