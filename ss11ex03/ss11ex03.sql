-- [Cơ bản] Giao dịch Nạp tiền và Ghi lịch sử
DROP DATABASE IF EXISTS tsubasa_csdl_session11;
CREATE DATABASE tsubasa_csdl_session11;
USE tsubasa_csdl_session11;

-- Bảng accounts: thông tin tài khoản và số dư
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL DEFAULT 0
);

-- Bảng transactions: lưu lịch sử giao dịch
CREATE TABLE transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    amount DECIMAL(10, 2),
    log_message VARCHAR(255),
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
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

-- Stored Procedure deposit_with_logging: All-or-Nothing
DELIMITER //
CREATE PROCEDURE deposit_with_logging(
    IN p_account_id INT,
    IN p_amount DECIMAL(10, 2)
)
BEGIN
    -- Gặp bất kỳ lỗi SQL nào => Rollback toàn bộ
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Giao dịch thất bại! Đã hoàn tác toàn bộ thay đổi.' AS message;
    END;

    START TRANSACTION;

    -- Bước 1: Cộng tiền vào tài khoản
    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_account_id;

    -- Bước 2: Ghi lịch sử giao dịch
    INSERT INTO transactions (account_id, amount, log_message)
    VALUES (p_account_id, p_amount, 'Nạp tiền vào tài khoản');

    -- Suôn sẻ => lưu thay đổi
    COMMIT;
    SELECT 'Nạp tiền thành công' AS message;
END //
DELIMITER ;

-- Nạp 1.000.000 VNĐ cho tài khoản ID = 3
CALL deposit_with_logging(3, 1000000);

-- Kiểm tra kết quả (Mong đợi: balance = 1.000.000, có 1 dòng log)
SELECT * FROM accounts WHERE account_id = 3;
SELECT * FROM transactions;

-- (Thêm) Thử lỗi: tài khoản 99 không tồn tại => lỗi khóa ngoại => Rollback
CALL deposit_with_logging(99, 500000);
SELECT * FROM transactions; -- vẫn chỉ có 1 dòng log
