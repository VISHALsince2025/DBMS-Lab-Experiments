-- Experiment 02: Integrity Constraints
-- Aim:
-- Apply PRIMARY KEY, FOREIGN KEY, UNIQUE, and CHECK constraints.
--
-- Concept:
-- Constraints enforce valid and consistent data in relational tables.
--
-- Status:
-- Starter lab file. Queries are educational examples and are UNTESTED in this repository.

USE dbms_lab;

DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS student;

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(80) NOT NULL,
    email VARCHAR(120) UNIQUE,
    age INT CHECK (age >= 17)
);

CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_name VARCHAR(80) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

INSERT INTO student (student_id, full_name, email, age) VALUES
(101, 'Anita Sharma', 'anita@example.edu', 19),
(102, 'Rahul Verma', 'rahul@example.edu', 20);

INSERT INTO enrollment (enrollment_id, student_id, course_name) VALUES
(1, 101, 'DBMS'),
(2, 102, 'Operating Systems');

SELECT s.student_id, s.full_name, e.course_name
FROM student s
JOIN enrollment e ON s.student_id = e.student_id;

-- Note:
-- CHECK is supported in MySQL 8.0.16+.
-- For older versions, enforce equivalent logic via application validation or triggers.
