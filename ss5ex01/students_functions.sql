CREATE DATABASE QuanLySinhVienHam;
USE QuanLySinhVienHam;

CREATE TABLE students (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name  VARCHAR(100),
    birth_year INT,
    gender     VARCHAR(10),
    score      FLOAT
);

INSERT INTO students VALUES ('SV001', 'nguyen van a', 2003, 'Nam', 7.85);
INSERT INTO students VALUES ('SV002', 'Tran thi b',   2004, 'Nu',  8.42);
INSERT INTO students VALUES ('SV003', 'le Van c',     2002, 'Nam', 6.37);
INSERT INTO students VALUES ('SV004', 'Pham Thi D',   2005, 'Nu',  9.15);
INSERT INTO students VALUES ('SV005', 'hoang van e',  2003, 'Nam', 5.68);

SELECT student_id, UPPER(full_name) FROM students;

SELECT full_name, YEAR(CURDATE()) - birth_year FROM students;

SELECT student_id, full_name, ROUND(score, 1) FROM students;

SELECT COUNT(*), MAX(score), MIN(score) FROM students;

SELECT full_name, YEAR(CURDATE()) - birth_year AS age FROM students;
SELECT COUNT(*) AS total_students, MAX(score) AS max_score, MIN(score) AS min_score FROM students;