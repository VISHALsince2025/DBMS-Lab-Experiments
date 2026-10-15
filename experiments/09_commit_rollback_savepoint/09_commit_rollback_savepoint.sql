-- Experiment 09: COMMIT, ROLLBACK and SAVEPOINT
-- Aim:
-- Understand partial undo and finalization of transaction changes.
--
-- Concept:
-- SAVEPOINT creates rollback checkpoints inside a transaction.
--
-- Status:
-- Starter lab file. Queries are educational examples and are UNTESTED in this repository.

USE dbms_lab;

DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(80),
    quantity INT NOT NULL
);

INSERT INTO inventory VALUES
(1, 'Mouse', 20),
(2, 'Keyboard', 15),
(3, 'Headset', 10);

START TRANSACTION;

UPDATE inventory SET quantity = quantity - 2 WHERE item_id = 1;
SAVEPOINT after_mouse;

UPDATE inventory SET quantity = quantity - 3 WHERE item_id = 2;
SAVEPOINT after_keyboard;

-- Undo only the second update
ROLLBACK TO after_mouse;

-- Persist remaining changes
COMMIT;

SELECT * FROM inventory ORDER BY item_id;
