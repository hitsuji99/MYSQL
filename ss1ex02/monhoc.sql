-- Quản lý môn học
CREATE DATABASE QuanLyMonHoc;
USE QuanLyMonHoc;

-- Bảng MonHoc
CREATE TABLE MonHoc (
    MaMon          VARCHAR(10) PRIMARY KEY,
    TenMon         VARCHAR(100),
    SoTinChi       INT,
    SoTietLyThuyet INT,
    SoTietThucHanh INT,
    MoTa           VARCHAR(255)
);

-- Dữ liệu mẫu
INSERT INTO MonHoc VALUES ('MH001', 'Cơ sở dữ liệu', 3, 30, 15, 'Thiết kế và truy vấn cơ sở dữ liệu');
INSERT INTO MonHoc VALUES ('MH002', 'Lập trình Java', 4, 30, 30, 'Lập trình hướng đối tượng với Java');

SELECT * FROM MonHoc;
