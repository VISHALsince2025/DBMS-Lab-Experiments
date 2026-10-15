-- Experiment 03: SQL Operators and Aggregate Functions
-- Aim:
-- Practice WHERE operators and aggregate calculations.
--
-- Concept:
-- Operators filter rows; aggregate functions summarize groups of rows.
--
-- Status:
-- Starter lab file. Queries are educational examples and are UNTESTED in this repository.

USE dbms_lab;

DROP TABLE IF EXISTS marks;
CREATE TABLE marks (
    student_id INT,
    subject VARCHAR(40),
    score INT
);

INSERT INTO marks (student_id, subject, score) VALUES
(101, 'DBMS', 88),
(101, 'AI', 91),
(102, 'DBMS', 76),
(102, 'AI', 84),
(103, 'DBMS', 67);

-- Operators: BETWEEN, IN, AND
SELECT *
FROM marks
WHERE score BETWEEN 70 AND 95
  AND subject IN ('DBMS', 'AI');

-- Aggregate functions
SELECT
    COUNT(*) AS total_rows,
    AVG(score) AS avg_score,
    MAX(score) AS max_score,
    MIN(score) AS min_score,
    SUM(score) AS total_score
FROM marks;
