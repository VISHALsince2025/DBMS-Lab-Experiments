-- Dataset: Students and Courses (small practical dataset)
-- Status: UNTESTED starter dataset

CREATE DATABASE IF NOT EXISTS dbms_lab;
USE dbms_lab;

DROP TABLE IF EXISTS ds_enrollment;
DROP TABLE IF EXISTS ds_courses;
DROP TABLE IF EXISTS ds_students;

CREATE TABLE ds_students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(80) NOT NULL,
    semester INT NOT NULL
);

CREATE TABLE ds_courses (
    course_id INT PRIMARY KEY,
    course_title VARCHAR(100) NOT NULL,
    credits INT NOT NULL
);

CREATE TABLE ds_enrollment (
    student_id INT,
    course_id INT,
    marks INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES ds_students(student_id),
    FOREIGN KEY (course_id) REFERENCES ds_courses(course_id)
);

INSERT INTO ds_students VALUES
(201, 'Aditi', 3),
(202, 'Manav', 3),
(203, 'Priya', 5);

INSERT INTO ds_courses VALUES
(301, 'Database Systems', 4),
(302, 'Machine Learning Basics', 3),
(303, 'Data Structures', 4);

INSERT INTO ds_enrollment VALUES
(201, 301, 86),
(201, 302, 90),
(202, 301, 74),
(203, 303, 88);
