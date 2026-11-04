DROP DATABASE IF EXISTS QuanLySinhVienView;
CREATE DATABASE QuanLySinhVienView;
USE QuanLySinhVienView;
CREATE TABLE students (
    student_id  VARCHAR(10)  NOT NULL,   
    full_name   VARCHAR(100) NOT NULL,   
    birth_year  INT,                     
    class_name  VARCHAR(50),             
    address     VARCHAR(255),            
    PRIMARY KEY (student_id)
);
INSERT INTO students (student_id, full_name, birth_year, class_name, address) VALUES
('SV001', 'Nguyen Van A',  2004, 'CNTT01', 'Ha Noi'),
('SV002', 'Nguyen Van B',  2005, 'CNTT01', 'Da Nang'),
('SV003', 'Nguyen Van C', 2004, 'CNTT02', 'TP. Ho Chi Minh');
-- tao view--
CREATE VIEW v_student_basic AS
SELECT student_id,
       full_name,
       class_name
FROM   students;
-- check --
SELECT * FROM v_student_basic;

