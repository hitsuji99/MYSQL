-- Quản lý sinh viên và lớp (1 - N)
CREATE DATABASE QuanLySinhVienLop;
USE QuanLySinhVienLop;

-- Bảng Lop
CREATE TABLE Lop (
    MaLop      VARCHAR(10) PRIMARY KEY,
    TenLop     VARCHAR(100),
    KhoaHoc    VARCHAR(20),
    GiaoVienCN VARCHAR(100)
);

-- Bảng SinhVien
CREATE TABLE SinhVien (
    MaSV     VARCHAR(10) PRIMARY KEY,
    HoTen    VARCHAR(100),
    NgaySinh DATE,
    GioiTinh VARCHAR(10),
    DiaChi   VARCHAR(255),
    MaLop    VARCHAR(10),
    FOREIGN KEY (MaLop) REFERENCES Lop(MaLop)
);

-- Dữ liệu mẫu
INSERT INTO Lop VALUES ('L01', 'Công nghệ thông tin 1', '2022-2026', 'Nguyễn Văn Hùng');
INSERT INTO Lop VALUES ('L02', 'Kế toán 1', '2022-2026', 'Trần Thị Lan');

INSERT INTO SinhVien VALUES ('SV001', 'Nguyễn Văn An',  '2004-03-15', 'Nam', 'Hà Nội',  'L01');
INSERT INTO SinhVien VALUES ('SV002', 'Trần Thị Bình',  '2004-07-22', 'Nữ',  'Đà Nẵng', 'L01');
INSERT INTO SinhVien VALUES ('SV003', 'Lê Hoàng Cường', '2003-11-02', 'Nam', 'Huế',     'L02');

SELECT * FROM Lop;
SELECT * FROM SinhVien;
