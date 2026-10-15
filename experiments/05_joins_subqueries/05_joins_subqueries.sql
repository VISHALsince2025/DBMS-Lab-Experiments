-- Experiment 05: Joins and Subqueries
-- Aim:
-- Retrieve related data from multiple tables and use subqueries.
--
-- Concept:
-- Joins combine rows by keys; subqueries build results from nested SELECTs.
--
-- Status:
-- Starter lab file. Queries are educational examples and are UNTESTED in this repository.

USE dbms_lab;

DROP TABLE IF EXISTS course;
DROP TABLE IF EXISTS student_course;
DROP TABLE IF EXISTS student_profile;

CREATE TABLE student_profile (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(80) NOT NULL
);

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(80) NOT NULL
);

CREATE TABLE student_course (
    student_id INT,
    course_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES student_profile(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

INSERT INTO student_profile VALUES
(1, 'Aarav'),
(2, 'Diya'),
(3, 'Kabir');

INSERT INTO course VALUES
(11, 'DBMS'),
(12, 'ML');

INSERT INTO student_course VALUES
(1, 11, 85),
(1, 12, 92),
(2, 11, 75),
(3, 11, 90);

-- INNER JOIN
SELECT sp.student_name, c.course_name, sc.marks
FROM student_course sc
JOIN student_profile sp ON sp.student_id = sc.student_id
JOIN course c ON c.course_id = sc.course_id;

-- Subquery: students scoring above DBMS average
SELECT sp.student_name, sc.marks
FROM student_course sc
JOIN student_profile sp ON sp.student_id = sc.student_id
WHERE sc.course_id = 11
  AND sc.marks > (
      SELECT AVG(marks)
      FROM student_course
      WHERE course_id = 11
  );
