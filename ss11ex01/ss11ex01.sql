-- [Cơ bản] Gửi tiền vào tài khoản
DROP DATABASE IF EXISTS tsubasa_csdl_session11;
CREATE DATABASE tsubasa_csdl_session11;
USE tsubasa_csdl_session11;

-- Bảng accounts: thông tin tài khoản và số dư
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL DEFAULT 0
);

-- Bảng transactions: lịch sử giao dịch
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    from_account_id INT NOT NULL,
    to_account_id INT NOT NULL,
    amount DECIMAL(10, 2),
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (from_account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (to_account_id) REFERENCES accounts(account_id)
);

-- Thêm 10 tài khoản
INSERT INTO accounts (customer_name, balance) VALUES
('Nguyễn Văn Bình', 500000.00),
('Nguyễn Văn Hảo', 300000.00),
('Nguyễn Văn An', 0.00),
('Nguyễn Văn Tâm', 2000000.00),
('Nguyễn Văn Tứ', 0.00),
('Trần Thị Lan', 1500000.00),
('Lê Văn Hùng', 750000.00),
('Phạm Thị Mai', 1200000.00),
('Hoàng Văn Nam', 900000.00),
('Đỗ Thị Thảo', 2500000.00);

-- Kiểm tra số dư TRƯỚC giao dịch (account_id = 1: 500.000)
SELECT * FROM accounts WHERE account_id = 1;

-- Bắt đầu transaction
START TRANSACTION;

-- Cộng thêm 1.000.000 VNĐ vào tài khoản có account_id = 1
UPDATE accounts
SET balance = balance + 1000000
WHERE account_id = 1;

-- Không có lỗi => lưu thay đổi
COMMIT;

-- Kiểm tra số dư SAU giao dịch (account_id = 1: 1.500.000)
SELECT * FROM accounts WHERE account_id = 1;
