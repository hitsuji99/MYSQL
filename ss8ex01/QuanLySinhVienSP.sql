DROP DATABASE IF EXISTS QuanLySinhVienSP;
CREATE DATABASE QuanLySinhVienSP;
USE QuanLySinhVienSP;

CREATE TABLE students (
    student_id VARCHAR(10)  NOT NULL,   -- Ma sinh vien
    full_name  VARCHAR(100) NOT NULL,   -- Ho ten
    class_name VARCHAR(50),             -- Lop hoc
    PRIMARY KEY (student_id)
);

INSERT INTO students VALUES
('SV001', 'Nguyen Van An',  'CNTT01'),
('SV002', 'Tran Thi Binh',  'CNTT01'),
('SV003', 'Le Hoang Cuong', 'CNTT02');

DELIMITER $$
CREATE PROCEDURE sp_get_all_students()
BEGIN
    SELECT student_id, full_name, class_name
    FROM   students;
END $$
DELIMITER ;

CALL sp_get_all_students();