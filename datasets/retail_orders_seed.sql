-- Dataset: Retail Orders (small practical dataset)
-- Status: UNTESTED starter dataset

CREATE DATABASE IF NOT EXISTS dbms_lab;
USE dbms_lab;

DROP TABLE IF EXISTS ds_orders;
DROP TABLE IF EXISTS ds_customers;

CREATE TABLE ds_customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(80) NOT NULL,
    city VARCHAR(60)
);

CREATE TABLE ds_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_total DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES ds_customers(customer_id)
);

INSERT INTO ds_customers VALUES
(1, 'Rina', 'Delhi'),
(2, 'Harsh', 'Pune'),
(3, 'Naveen', 'Bengaluru');

INSERT INTO ds_orders VALUES
(11, 1, 1499.00, '2026-02-10'),
(12, 1, 799.00, '2026-02-15'),
(13, 2, 2300.00, '2026-03-03'),
(14, 3, 450.00, '2026-03-08');
