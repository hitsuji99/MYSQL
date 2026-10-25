-- Tạo database
CREATE DATABASE QuanLySinhVien;

-- Chọn database để làm việc
USE QuanLySinhVien;

-- Tạo bảng SinhVien
CREATE TABLE SinhVien (
    MaSV        VARCHAR(10) PRIMARY KEY,   -- Mã sinh viên (khóa chính)
    HoTen       VARCHAR(100),              -- Tên sinh viên
    NgaySinh    DATE,                      -- Ngày sinh
    GioiTinh    VARCHAR(10),               -- Giới tính
    DiaChi      VARCHAR(255),              -- Địa chỉ
    SoDienThoai VARCHAR(15),               -- Số điện thoại
    Email       VARCHAR(100),              -- Email
    NgayNhapHoc DATE                       -- Ngày nhập học
);

-- Thêm dữ liệu mẫu
INSERT INTO SinhVien VALUES ('SV001', 'Nguyễn Văn An', '2004-03-15', 'Nam', 'Hà Nội', '0912345678', 'an@gmail.com', '2022-09-05');

-- Xem dữ liệu
SELECT * FROM SinhVien;
