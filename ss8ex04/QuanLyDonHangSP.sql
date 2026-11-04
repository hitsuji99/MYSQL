DROP DATABASE IF EXISTS QuanLyDonHangSP;
CREATE DATABASE QuanLyDonHangSP;
USE QuanLyDonHangSP;

DELIMITER $$
CREATE PROCEDURE sp_check_order_value(IN p_total_amount DOUBLE)
BEGIN
    IF p_total_amount >= 5000000 THEN
        SELECT 'Don hang gia tri cao' AS message;
    ELSE
        SELECT 'Don hang binh thuong' AS message;
    END IF;
END $$
DELIMITER ;

CALL sp_check_order_value(7000000);   
CALL sp_check_order_value(5000000);   
CALL sp_check_order_value(2000000);   