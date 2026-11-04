DROP DATABASE IF EXISTS BanHangView;
CREATE DATABASE BanHangView;
USE BanHangView;

CREATE TABLE customers (
    customer_id   INT          NOT NULL AUTO_INCREMENT,   -- Ma khach hang
    customer_name VARCHAR(100) NOT NULL,                  -- Ten khach hang
    PRIMARY KEY (customer_id)
);

CREATE TABLE orders (
    order_id    INT  NOT NULL AUTO_INCREMENT,   -- Ma don hang
    order_date  DATE NOT NULL,                  -- Ngay dat hang
    customer_id INT  NOT NULL,                  -- Ma khach hang (khoa ngoai)
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


INSERT INTO customers (customer_name) VALUES
('Nguyen Van A'), ('Tran Thi B');

INSERT INTO orders (order_date, customer_id) VALUES
('2026-11-01', 1), ('2026-11-02', 2), ('2026-11-03', 1);

CREATE VIEW v_order_info AS
SELECT o.order_id,
       o.order_date,
       c.customer_name
FROM   orders o
JOIN   customers c ON c.customer_id = o.customer_id;

-- check--
SELECT * FROM v_order_info;