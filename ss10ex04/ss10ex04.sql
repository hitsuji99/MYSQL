-- [Cơ bản] Trigger after update – Ghi nhật ký thay đổi
DROP DATABASE IF EXISTS tsubasa_csdl_session09_salary;
CREATE DATABASE tsubasa_csdl_session09_salary;
USE tsubasa_csdl_session09_salary;

-- 1. Tạo bảng employees
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10, 2),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);

-- 2. Tạo bảng salary_log
CREATE TABLE salary_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- 3. Thêm 10 nhân viên
INSERT INTO employees (first_name, last_name, salary, email, phone_number) VALUES
('An', 'Nguyễn', 10000000.00, 'an.nguyen@example.com', '0901000001'),
('Bình', 'Trần', 12000000.00, 'binh.tran@example.com', '0901000002'),
('Chi', 'Lê', 9500000.00, 'chi.le@example.com', '0901000003'),
('Dũng', 'Phạm', 15000000.00, 'dung.pham@example.com', '0901000004'),
('Hà', 'Hoàng', 11000000.00, 'ha.hoang@example.com', '0901000005'),
('Hùng', 'Vũ', 13000000.00, 'hung.vu@example.com', '0901000006'),
('Lan', 'Đặng', 9000000.00, 'lan.dang@example.com', '0901000007'),
('Minh', 'Bùi', 17000000.00, 'minh.bui@example.com', '0901000008'),
('Nam', 'Đỗ', 14000000.00, 'nam.do@example.com', '0901000009'),
('Thảo', 'Ngô', 10500000.00, 'thao.ngo@example.com', '0901000010');

-- 4. Trigger trg_after_update_salary: chạy SAU KHI UPDATE bảng employees
DELIMITER //
CREATE TRIGGER trg_after_update_salary
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    -- Chỉ ghi log khi lương thay đổi
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO salary_log (employee_id, old_salary, new_salary, change_date)
        VALUES (OLD.id, OLD.salary, NEW.salary, NOW());
    END IF;
END //
DELIMITER ;

-- 5. Kiểm tra (câu lệnh UPDATE giữ nguyên, trigger tự ghi log)
UPDATE employees SET salary = 11000000.00 WHERE id = 1;
UPDATE employees SET salary = salary * 1.1 WHERE id IN (2, 3);
UPDATE employees SET phone_number = '0999999999' WHERE id = 4; -- không đổi lương => không ghi log

SELECT * FROM employees;
SELECT * FROM salary_log;
