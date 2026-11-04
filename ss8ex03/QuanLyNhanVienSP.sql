DROP DATABASE IF EXISTS QuanLyNhanVienSP;
CREATE DATABASE QuanLyNhanVienSP;
USE QuanLyNhanVienSP;

CREATE TABLE employees (
    employee_id INT          NOT NULL AUTO_INCREMENT,   -- Ma nhan vien
    full_name   VARCHAR(100) NOT NULL,                  -- Ho ten
    salary      DOUBLE       NOT NULL,                  -- Luong
    PRIMARY KEY (employee_id)
);

INSERT INTO employees (full_name, salary) VALUES
('Nguyen Van A',  10000000),
('Tran Thi B',  15000000),
('Le Hoang C', 20000000);

DELIMITER $$
CREATE PROCEDURE sp_get_avg_salary()
BEGIN
    DECLARE v_avg_salary DOUBLE;            -- 1. Khai bao bien

    SELECT AVG(salary) INTO v_avg_salary    -- 2. Gan gia tri tu truy van
    FROM   employees;

    SELECT v_avg_salary AS avg_salary;      -- 3. Hien thi bien
END $$
DELIMITER ;

CALL sp_get_avg_salary();