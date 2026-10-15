-- Experiment 04: GROUP BY, HAVING and ORDER BY
-- Aim:
-- Summarize data per category and filter grouped results.
--
-- Concept:
-- GROUP BY creates groups, HAVING filters groups, ORDER BY sorts final output.
--
-- Status:
-- Starter lab file. Queries are educational examples and are UNTESTED in this repository.

USE dbms_lab;

DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    category VARCHAR(30),
    amount DECIMAL(10,2)
);

INSERT INTO sales (sale_id, category, amount) VALUES
(1, 'Books', 450.00),
(2, 'Books', 600.00),
(3, 'Stationery', 220.00),
(4, 'Stationery', 300.00),
(5, 'Electronics', 1500.00);

SELECT
    category,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_amount
FROM sales
GROUP BY category
HAVING SUM(amount) >= 700
ORDER BY total_amount DESC;

-- Illustrative output example (UNTESTED):
-- +-------------+--------------+--------------+
-- | category    | total_orders | total_amount |
-- +-------------+--------------+--------------+
-- | Electronics |            1 |      1500.00 |
-- | Books       |            2 |      1050.00 |
-- +-------------+--------------+--------------+
