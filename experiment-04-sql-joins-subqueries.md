# Experiment 04 — SQL Joins, Subqueries and Query Execution Plans

**DBMS:** MySQL  
**Database:** EmployeeDB  
**Prerequisite:** Experiment 03 — Employee–Department–Project Schema

## 1. Aim

To implement and analyze SQL joins and subqueries on the Employee–Department–Project database, including INNER JOIN, LEFT JOIN, SELF JOIN, multi-table joins, correlated subqueries, EXISTS, simulated INTERSECT and EXCEPT operations, and execution-plan analysis using EXPLAIN.

## 2. Problem Statement

Relational databases distribute related information across multiple tables. Retrieving meaningful information often requires combining these tables or evaluating queries based on the results of other queries.

This experiment explores how SQL joins combine related records, how subqueries express dependent conditions, and how execution plans help examine the way MySQL processes a query.

## 3. Database Prerequisites

The following tables from Experiment 03 are required:

- Employee
- Department
- Project
- Employee_Project

The tables must contain valid sample records and the required primary-key and foreign-key relationships before the queries are executed.

## 4. Query Operations

### 4.1 INNER JOIN — Employee and Department

Retrieves employees with their corresponding department names.

### 4.2 LEFT JOIN — Departments and Employees

Returns all departments, including departments without employees. Employee columns appear as NULL when no matching employee exists.

### 4.3 SELF JOIN — Employee and Manager

Joins the Employee table to itself to display reporting relationships. A LEFT JOIN preserves employees whose ManagerID is NULL or has no matching manager record.

### 4.4 Multi-table JOIN — Employee, Department and Project

Combines employee, department, project-assignment and project records to show which employees work on which projects and how many hours they have recorded.

### 4.5 Correlated Subquery — Department Salary Comparison

Compares each employee's salary with the average salary of the employee's own department. The inner query refers to the current employee row from the outer query.

### 4.6 EXISTS — Departments with Employees

Checks whether at least one employee exists for a department. EXISTS evaluates whether the subquery returns a row.

### 4.7 Simulated INTERSECT — Employees Assigned to Projects

Retrieves employees satisfying both conditions: having a department assignment and being assigned to at least one project. In this schema, the department condition is represented by a non-NULL DeptID; referential integrity ensures that it refers to an existing department.

### 4.8 Simulated EXCEPT — Employees without Project Assignments

Uses NOT EXISTS to identify employees for whom no matching record exists in Employee_Project.

### 4.9 AI-related Projects

Uses joins and a LIKE condition to retrieve employee-project combinations whose project names contain the text 'AI'.

### 4.10 EXPLAIN — Query Execution Plan

Uses EXPLAIN to inspect the query plan, including access methods, possible indexes, selected keys, estimated rows and filtering information where provided by MySQL.

EXPLAIN ANALYZE executes the query and reports actual execution information. It should be used only when supported by the installed MySQL version.

## 5. SQL Implementation

The complete runnable program is maintained separately in:

`sql/experiment-04-sql-joins-subqueries.sql`

The script contains the ten query demonstrations, including both approaches shown for simulated INTERSECT and the EXPLAIN examples.

## 6. Concepts Demonstrated

| Concept | Purpose |
|---|---|
| INNER JOIN | Returns matching rows from related tables |
| LEFT JOIN | Preserves all rows from the left table |
| SELF JOIN | Relates records within the same table |
| Multi-table JOIN | Combines information across several relations |
| Correlated subquery | Evaluates a condition using the current outer row |
| EXISTS | Tests whether a matching row exists |
| NOT EXISTS | Tests whether a matching row does not exist |
| DISTINCT | Removes duplicate rows from the result |
| LIKE | Performs pattern matching on text |
| EXPLAIN | Inspects the query execution plan |

## 7. Validation and Observations

After executing each query, verify that:

- Employee records are associated with the correct departments.
- LEFT JOIN retains departments without matching employees.
- SELF JOIN displays the correct employee-manager pairs.
- Multi-table joins return valid employee-project assignments.
- Salary comparisons use the correct department average.
- EXISTS and NOT EXISTS return the expected employee or department sets.
- DISTINCT prevents duplicate employee-project result combinations where appropriate.
- EXPLAIN provides a plan for the selected query.

Actual row counts and execution details should be recorded after running the queries against the populated database.

## 8. Conclusion

This experiment demonstrates how SQL joins and subqueries retrieve related information from a relational database. It also introduces query-plan inspection, which helps developers understand database access strategies and investigate opportunities for query optimization.
