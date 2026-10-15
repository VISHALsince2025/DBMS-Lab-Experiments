-- Experiment 08: Transactions and ACID Properties
-- Aim:
-- Demonstrate atomic updates with transaction control statements.
--
-- Concept:
-- ACID: Atomicity, Consistency, Isolation, Durability ensure reliable transactions.
--
-- Status:
-- Starter lab file. Queries are educational examples and are UNTESTED in this repository.

USE dbms_lab;

DROP TABLE IF EXISTS bank_account;
CREATE TABLE bank_account (
    account_no INT PRIMARY KEY,
    holder_name VARCHAR(80),
    balance DECIMAL(12,2) NOT NULL
);

INSERT INTO bank_account VALUES
(1001, 'Anjali', 10000.00),
(1002, 'Rohit', 8000.00);

START TRANSACTION;

-- Transfer 1500 from account 1001 to 1002
UPDATE bank_account SET balance = balance - 1500 WHERE account_no = 1001;
UPDATE bank_account SET balance = balance + 1500 WHERE account_no = 1002;

-- If any issue occurs in a real lab run, use ROLLBACK; otherwise COMMIT.
COMMIT;

SELECT * FROM bank_account ORDER BY account_no;
