CREATE DATABASE QuanLyNhanVien;
USE QuanLyNhanVien;

CREATE TABLE employees (
    emp_id     VARCHAR(10) PRIMARY KEY,
    full_name  VARCHAR(100),
    department VARCHAR(50),
    salary     INT
);

INSERT INTO employees VALUES ('NV01', 'Nguyen Van A', 'IT',    15000000);
INSERT INTO employees VALUES ('NV02', 'Tran Thi B',   'IT',    18000000);
INSERT INTO employees VALUES ('NV03', 'Le Van C',     'IT',    12000000);
INSERT INTO employees VALUES ('NV04', 'Pham Thi D',   'IT',    14000000);
INSERT INTO employees VALUES ('NV05', 'Hoang Van E',  'Sales',  9000000);
INSERT INTO employees VALUES ('NV06', 'Vu Thi F',     'Sales', 10000000);

SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department;

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

SELECT department, COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 3;

SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 12000000;
