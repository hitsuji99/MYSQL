-- Quản lý thư viện (N - N)
CREATE DATABASE QuanLyThuVien;
USE QuanLyThuVien;

-- Bảng DocGia
CREATE TABLE DocGia (
    MaDG        VARCHAR(10) PRIMARY KEY,
    HoTen       VARCHAR(100),
    NgaySinh    DATE,
    DiaChi      VARCHAR(255),
    SoDienThoai VARCHAR(15)
);

-- Bảng Sach
CREATE TABLE Sach (
    MaSach     VARCHAR(10) PRIMARY KEY,
    TenSach    VARCHAR(200),
    TacGia     VARCHAR(100),
    NhaXuatBan VARCHAR(100),
    NamXuatBan INT
);

-- Bảng MuonSach (mượn sách)
CREATE TABLE MuonSach (
    MaDG     VARCHAR(10),
    MaSach   VARCHAR(10),
    NgayMuon DATE,
    NgayTra  DATE,
    PRIMARY KEY (MaDG, MaSach, NgayMuon),
    FOREIGN KEY (MaDG) REFERENCES DocGia(MaDG),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);

-- Dữ liệu mẫu
INSERT INTO DocGia VALUES ('DG01', 'Nguyễn Văn An', '2000-05-10', 'Hà Nội',  '0912345678');
INSERT INTO DocGia VALUES ('DG02', 'Trần Thị Bình', '1998-09-20', 'Đà Nẵng', '0987654321');

INSERT INTO Sach VALUES ('S01', 'Dế Mèn phiêu lưu ký', 'Tô Hoài',        'Kim Đồng', 2019);
INSERT INTO Sach VALUES ('S02', 'Số đỏ',               'Vũ Trọng Phụng', 'Văn học',  2020);

INSERT INTO MuonSach VALUES ('DG01', 'S01', '2026-10-01', '2026-10-15');
INSERT INTO MuonSach VALUES ('DG01', 'S02', '2026-10-01', NULL);
INSERT INTO MuonSach VALUES ('DG02', 'S01', '2026-10-16', NULL);

SELECT * FROM DocGia;
SELECT * FROM Sach;
SELECT * FROM MuonSach;
