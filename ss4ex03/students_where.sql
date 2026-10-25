USE QuanLySinhVienA;

SELECT student_id, full_name, birth_date FROM students
WHERE birth_date BETWEEN '2003-01-01' AND '2005-12-31';

SELECT student_id, full_name, birth_date FROM students
WHERE gender IN ('Nam', 'Nu');

SELECT student_id, full_name, birth_date FROM students
WHERE student_id IN ('SV001', 'SV004', 'SV005');
