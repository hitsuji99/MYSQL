CREATE DATABASE QuanLySinhVienA;
USE QuanLySinhVienA;

CREATE TABLE students (
	student_id  VARCHAR(10) PRIMARY KEY,
    full_name 	VARCHAR(100),
    birth_date	DATE,
    gender 		VARCHAR(10),
    email 		VARCHAR(100)
);

INSERT INTO students VALUES ('SV001', 'Nguyen Van A', '2001-04-05', 'Nam', 'a@gmail.com');
INSERT INTO students VALUES ('SV002', 'Tran Thi B',   '2002-06-12', 'Nu',  'b@gmail.com');
INSERT INTO students VALUES ('SV003', 'Le Van C',     '2001-09-20', 'Nam', 'c@gmail.com');
INSERT INTO students VALUES ('SV004', 'Pham Thi D',   '2003-01-15', 'Nu',  'd@gmail.com');
INSERT INTO students VALUES ('SV005', 'Hoang Van E',  '2002-11-30', 'Nam', NULL);

SELECT * FROM students;

SELECT student_id, full_name, email FROM students;
