-- Experiment 10: Stored Procedures, Functions and Triggers
-- Aim:
-- Build reusable SQL logic and automatic actions for insert/update events.
--
-- Concept:
-- Stored procedures group statements, functions return values, and triggers react to DML events.
--
-- Status:
-- Starter lab file. Queries are educational examples and are UNTESTED in this repository.
-- This script uses MySQL delimiter syntax.

USE dbms_lab;

DROP TABLE IF EXISTS fee_payment;
DROP TABLE IF EXISTS fee_audit;

CREATE TABLE fee_payment (
    payment_id INT PRIMARY KEY,
    student_id INT,
    amount DECIMAL(10,2),
    paid_on DATE
);

CREATE TABLE fee_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    payment_id INT,
    log_message VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE PROCEDURE add_fee_payment(
    IN p_payment_id INT,
    IN p_student_id INT,
    IN p_amount DECIMAL(10,2),
    IN p_paid_on DATE
)
BEGIN
    INSERT INTO fee_payment (payment_id, student_id, amount, paid_on)
    VALUES (p_payment_id, p_student_id, p_amount, p_paid_on);
END $$

CREATE FUNCTION payment_with_tax(p_amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_amount * 1.18;
END $$

CREATE TRIGGER trg_fee_payment_insert
AFTER INSERT ON fee_payment
FOR EACH ROW
BEGIN
    INSERT INTO fee_audit (payment_id, log_message)
    VALUES (NEW.payment_id, CONCAT('Payment inserted for student: ', NEW.student_id));
END $$

DELIMITER ;

CALL add_fee_payment(1, 101, 5000.00, '2026-01-05');
SELECT payment_id, amount, payment_with_tax(amount) AS amount_with_tax FROM fee_payment;
SELECT * FROM fee_audit;

-- Database-specific note:
-- PostgreSQL uses CREATE FUNCTION ... LANGUAGE plpgsql and trigger functions,
-- while MySQL uses DELIMITER with BEGIN ... END blocks as shown above.
