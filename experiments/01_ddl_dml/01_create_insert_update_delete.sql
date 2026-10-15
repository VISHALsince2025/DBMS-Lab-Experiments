-- Experiment 01: DDL and DML Commands
-- Aim:
-- Learn basic table creation and row manipulation using MySQL-compatible SQL.
--
-- Concept:
-- DDL (Data Definition Language) defines schema objects.
-- DML (Data Manipulation Language) inserts, updates, and deletes data.
--
-- Status:
-- Starter lab file. Queries below are educational examples and are UNTESTED in this repository.

CREATE DATABASE IF NOT EXISTS dbms_lab;
USE dbms_lab;

-- DDL: create table
DROP TABLE IF EXISTS department;
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- DML: insert sample rows
INSERT INTO department (dept_id, dept_name) VALUES
(1, 'CSE'),
(2, 'ECE'),
(3, 'ME');

-- DML: update row
UPDATE department
SET dept_name = 'Computer Science and Engineering'
WHERE dept_id = 1;

-- DML: delete row
DELETE FROM department
WHERE dept_id = 3;

-- Verify result
SELECT * FROM department ORDER BY dept_id;

-- Illustrative output example (UNTESTED, for reference only):
-- +---------+----------------------------------+
-- | dept_id | dept_name                        |
-- +---------+----------------------------------+
-- |       1 | Computer Science and Engineering |
-- |       2 | ECE                              |
-- +---------+----------------------------------+
