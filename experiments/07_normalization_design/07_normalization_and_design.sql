-- Experiment 07: Normalization and Database Design
-- Aim:
-- Understand conversion from an unnormalized structure to 1NF/2NF/3NF style schema.
--
-- Concept:
-- Normalization reduces redundancy and update anomalies using proper table decomposition.
--
-- Status:
-- Starter lab file. Queries are educational examples and are UNTESTED in this repository.

USE dbms_lab;

-- Example denormalized data design (for discussion):
-- student_all(student_id, student_name, course1, course2, instructor1, instructor2)
-- Problems: repeating groups, redundancy, and anomalies.

-- 1NF/2NF/3NF-friendly design:
DROP TABLE IF EXISTS n_enrollment;
DROP TABLE IF EXISTS n_course;
DROP TABLE IF EXISTS n_student;

CREATE TABLE n_student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(80) NOT NULL
);

CREATE TABLE n_course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(80) NOT NULL,
    instructor_name VARCHAR(80) NOT NULL
);

CREATE TABLE n_enrollment (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES n_student(student_id),
    FOREIGN KEY (course_id) REFERENCES n_course(course_id)
);

INSERT INTO n_student VALUES (1, 'Saanvi'), (2, 'Arjun');
INSERT INTO n_course VALUES (101, 'DBMS', 'Dr. Rao'), (102, 'ML', 'Dr. Iyer');
INSERT INTO n_enrollment VALUES (1, 101), (1, 102), (2, 101);

SELECT ns.student_name, nc.course_name, nc.instructor_name
FROM n_enrollment ne
JOIN n_student ns ON ns.student_id = ne.student_id
JOIN n_course nc ON nc.course_id = ne.course_id;
