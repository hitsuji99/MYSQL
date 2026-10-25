CREATE DATABASE QuanLySinhVienTheoLop;
USE QuanLySinhVienTheoLop;

CREATE TABLE classes (
	class_id VARCHAR(10) PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    course 		VARCHAR(20),
    teacher 	VARCHAR(100)
);
-- sinh vien 
CREATE TABLE students (
	student_id VARCHAR(10) PRIMARY KEY,
    full_name  VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender		VARCHAR(10),
    email 		VARCHAR(100),
    class_id 	VARCHAR(10) NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);