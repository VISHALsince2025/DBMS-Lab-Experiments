-- Experiment 06: Views and Indexes
-- Aim:
-- Create reusable virtual tables and improve query lookup performance.
--
-- Concept:
-- Views simplify repeated query logic. Indexes optimize search on selected columns.
--
-- Status:
-- Starter lab file. Queries are educational examples and are UNTESTED in this repository.

USE dbms_lab;

DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(80) NOT NULL,
    dept_name VARCHAR(40) NOT NULL,
    salary DECIMAL(10,2) NOT NULL
);

INSERT INTO employee VALUES
(1, 'Isha', 'CSE', 55000),
(2, 'Nitin', 'CSE', 62000),
(3, 'Meera', 'ECE', 51000);

-- View for employees with salary >= 55000
CREATE OR REPLACE VIEW high_salary_employees AS
SELECT emp_id, emp_name, dept_name, salary
FROM employee
WHERE salary >= 55000;

SELECT * FROM high_salary_employees ORDER BY salary DESC;

-- Index on frequently filtered column
CREATE INDEX idx_employee_dept_name ON employee(dept_name);

-- Verify index usage with execution plans (MySQL command line):
-- EXPLAIN SELECT * FROM employee WHERE dept_name = 'CSE';
