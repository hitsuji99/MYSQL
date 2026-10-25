USE QuanLySinhVienA;

-- cập nhật email
UPDATE students SET email = 'e@gmail.com' WHERE student_id = 'SV005';
SELECT * FROM students;

-- cập nhật giới tính
UPDATE students SET gender = 'Nu' WHERE student_id = 'SV005';
SELECT * FROM students;

-- xóa sinh viên
DELETE FROM students WHERE student_id = 'SV003';
SELECT * FROM students;
