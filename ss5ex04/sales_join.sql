CREATE DATABASE QuanLyBanHang;
USE QuanLyBanHang;

CREATE TABLE customers (
    customer_id   VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100)
);

CREATE TABLE orders (
    order_id    VARCHAR(10) PRIMARY KEY,
    order_date  DATE,
    customer_id VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_id     VARCHAR(10),
    customer_id  VARCHAR(10),
    product_name VARCHAR(100),
    quantity     INT,
    price        INT,
    PRIMARY KEY (order_id, product_name),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES ('KH01', 'Nguyen Van A');
INSERT INTO customers VALUES ('KH02', 'Tran Thi B');
INSERT INTO customers VALUES ('KH03', 'Le Van C');

INSERT INTO orders VALUES ('DH01', '2026-10-01', 'KH01');
INSERT INTO orders VALUES ('DH02', '2026-10-05', 'KH02');
INSERT INTO orders VALUES ('DH03', '2026-10-10', 'KH01');
INSERT INTO orders VALUES ('DH04', '2026-10-15', 'KH03');

INSERT INTO order_items VALUES ('DH01', 'KH01', 'Laptop',     1, 15000000);
INSERT INTO order_items VALUES ('DH01', 'KH01', 'Chuot',      2,   200000);
INSERT INTO order_items VALUES ('DH02', 'KH02', 'Dien thoai', 1,  8000000);
INSERT INTO order_items VALUES ('DH02', 'KH02', 'Op lung',    2,   100000);
INSERT INTO order_items VALUES ('DH03', 'KH01', 'Tai nghe',   1,  2000000);
INSERT INTO order_items VALUES ('DH03', 'KH01', 'Ban phim',   1,  1500000);
INSERT INTO order_items VALUES ('DH04', 'KH03', 'Man hinh',   2,  5000000);
INSERT INTO order_items VALUES ('DH04', 'KH03', 'Loa',        1,  1000000);

SELECT orders.order_id, orders.order_date, customers.customer_name
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id;

SELECT orders.order_id, order_items.product_name, order_items.quantity, order_items.price
FROM orders
JOIN order_items ON orders.order_id = order_items.order_id;

SELECT order_id, SUM(quantity * price) AS total
FROM order_items
GROUP BY order_id;

SELECT order_id, SUM(quantity * price) AS total
FROM order_items
GROUP BY order_id
HAVING SUM(quantity * price) > 10000000;
