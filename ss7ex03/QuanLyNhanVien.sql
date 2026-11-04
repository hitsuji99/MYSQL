DROP DATABASE IF EXISTS QuanLyNhanVien;
CREATE DATABASE QuanLyNhanVien;
USE QuanLyNhanVien;

CREATE TABLE employees (
    employee_id INT          NOT NULL AUTO_INCREMENT,   -- Ma nhan vien
    full_name   VARCHAR(100) NOT NULL,                  -- Ho ten
    department  VARCHAR(100),                           -- Phong ban
    salary      DOUBLE,                                 -- Luong
    PRIMARY KEY (employee_id)
);

CREATE INDEX idx_employees_department ON employees (department);