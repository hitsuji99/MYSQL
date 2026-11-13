-- [Cơ bản] Chuyển Tiền Giữa Hai Tài Khoản
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

-- Stored Procedure transfer_money
DELIMITER //
CREATE PROCEDURE transfer_money(
    IN p_sender_id INT,
    IN p_receiver_id INT,
    IN p_amount DECIMAL(10, 2)
)
BEGIN
    DECLARE v_balance DECIMAL(10, 2);

    -- Gặp lỗi SQL bất ngờ => Rollback
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Chuyển tiền thất bại! Đã xảy ra lỗi hệ thống.' AS message;
    END;

    START TRANSACTION;

    -- Kiểm tra người gửi có đủ tiền không
    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = p_sender_id
    FOR UPDATE;

    IF v_balance IS NULL OR v_balance < p_amount THEN
        ROLLBACK;
        SELECT 'Chuyển tiền thất bại! Số dư không đủ hoặc tài khoản không tồn tại.' AS message;
    ELSE
        -- Trừ tiền người gửi
        UPDATE accounts
        SET balance = balance - p_amount
        WHERE account_id = p_sender_id;

        -- Cộng tiền người nhận
        UPDATE accounts
        SET balance = balance + p_amount
        WHERE account_id = p_receiver_id;

        -- Không tìm thấy người nhận => hoàn tác
        IF ROW_COUNT() = 0 THEN
            ROLLBACK;
            SELECT 'Chuyển tiền thất bại! Tài khoản người nhận không tồn tại.' AS message;
        ELSE
            COMMIT;
            SELECT 'Chuyển tiền thành công!' AS message;
        END IF;
    END IF;
END //
DELIMITER ;

-- Thực hiện chuyển 300.000 từ ID 4 sang ID 5
CALL transfer_money(4, 5, 300000);

-- Kiểm tra kết quả (A còn 1.700.000, B có 300.000)
SELECT * FROM accounts WHERE account_id IN (4, 5);
