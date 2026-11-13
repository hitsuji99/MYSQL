-- [Cơ bản] Tạo Stored Procedure Rút Tiền
DROP DATABASE IF EXISTS tsubasa_csdl_session11;
CREATE DATABASE tsubasa_csdl_session11;
USE tsubasa_csdl_session11;

-- Bảng accounts: thông tin tài khoản và số dư
CREATE TABLE accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL DEFAULT 0
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

-- Stored Procedure withdraw_money: Update trước - Kiểm tra sau
DELIMITER //
CREATE PROCEDURE withdraw_money(
    IN p_account_id INT,
    IN p_amount DECIMAL(10, 2)
)
BEGIN
    DECLARE v_balance DECIMAL(10, 2);

    -- 1. Bắt đầu giao dịch
    START TRANSACTION;

    -- 2. Trừ tiền trong tài khoản
    UPDATE accounts
    SET balance = balance - p_amount
    WHERE account_id = p_account_id;

    -- 3. Kiểm tra số dư hiện tại
    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = p_account_id;

    -- 4. Điều kiện
    IF v_balance < 0 THEN
        ROLLBACK;
        SELECT 'Giao dịch thất bại! Số dư không đủ. Tài khoản vẫn được giữ nguyên.' AS message;
    ELSE
        COMMIT;
        SELECT 'Rút tiền thành công' AS message;
    END IF;
END //
DELIMITER ;

-- Trường hợp 1 (Thất bại): rút 500.000 từ tài khoản có 300.000
CALL withdraw_money(2, 500000);
-- Mong muốn: vẫn còn 300.000
SELECT * FROM accounts WHERE account_id = 2;

-- Trường hợp 2 (Thành công): rút 100.000
CALL withdraw_money(2, 100000);
-- Mong muốn: còn 200.000
SELECT * FROM accounts WHERE account_id = 2;
