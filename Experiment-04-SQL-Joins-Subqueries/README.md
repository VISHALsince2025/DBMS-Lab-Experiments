# Experiment No. 04 — SQL Joins and Subqueries

## 1. Aim

To write and execute SQL queries on the Employee–Department–Project database using `INNER JOIN`, `LEFT JOIN`, `SELF JOIN`, multi-table joins, correlated subqueries, `EXISTS`, simulated `INTERSECT` and `EXCEPT`, and to examine query execution plans using `EXPLAIN`.

## 2. Problem Statement

To retrieve and analyze related information from the Employee, Department, Project, and Employee_Project tables using SQL joins and subqueries.

## 3. Objectives

- Retrieve employees along with their department details.
- Display all departments, including those without employees.
- Identify employees and their managers.
- Combine employee, department, and project information.
- Find employees earning above their department's average salary.
- Use `EXISTS` and `NOT EXISTS` to test record availability.
- Simulate set operations using joins and subqueries.
- Analyze query execution plans using `EXPLAIN`.

## 4. Software Requirements

- **Database:** MySQL
- **Database Name:** `EmployeeDB`
- **Tables:** `Employee`, `Department`, `Project`, `Employee_Project`
- **Tool:** MySQL Workbench, phpMyAdmin, or MySQL Command Line Client

## 5. Database Relationships

| Table | Purpose |
|---|---|
| `Employee` | Stores employee details, salary, department, and manager |
| `Department` | Stores department information |
| `Project` | Stores project details |
| `Employee_Project` | Connects employees to projects and records hours worked |

## 6. Algorithm

1. Open the database created in Experiment No. 03.
2. Retrieve matching employee and department records using `INNER JOIN`.
3. Use `LEFT JOIN` to display every department, including departments without employees.
4. Apply `SELF JOIN` to display employees and their managers.
5. Combine employee, department, and project details using joins.
6. Use a correlated subquery to compare salaries with department averages.
7. Use `EXISTS` to find departments containing employees.
8. Simulate `INTERSECT` and `EXCEPT` using joins and subqueries.
9. Find employees assigned to projects whose names contain “AI”.
10. Use `EXPLAIN` to inspect the execution plan.
11. Execute the queries and verify the results.

## 7. SQL Queries

### Query 1: INNER JOIN

Display employees along with their department names.

```sql
SELECT
    e.EmpID,
    e.EmpName,
    e.Salary,
    d.DeptName
FROM Employee e
INNER JOIN Department d
    ON e.DeptID = d.DeptID;
```

### Query 2: LEFT JOIN

Display all departments, including departments without employees.

```sql
SELECT
    d.DeptID,
    d.DeptName,
    e.EmpName
FROM Department d
LEFT JOIN Employee e
    ON d.DeptID = e.DeptID;
```

### Query 3: SELF JOIN

Display each employee and their manager.

```sql
SELECT
    e.EmpName AS Employee,
    m.EmpName AS Manager
FROM Employee e
LEFT JOIN Employee m
    ON e.ManagerID = m.EmpID;
```

### Query 4: Multi-Table JOIN

Display employee, department, and project information.

```sql
SELECT
    e.EmpName,
    d.DeptName,
    p.ProjectName,
    ep.HoursWorked
FROM Employee e
INNER JOIN Department d
    ON e.DeptID = d.DeptID
INNER JOIN Employee_Project ep
    ON e.EmpID = ep.EmpID
INNER JOIN Project p
    ON ep.ProjectID = p.ProjectID;
```

### Query 5: Correlated Subquery

Find employees whose salaries are greater than the average salary of their own departments.

```sql
SELECT
    e.EmpID,
    e.EmpName,
    e.Salary,
    e.DeptID
FROM Employee e
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employee e2
    WHERE e2.DeptID = e.DeptID
);
```

### Query 6: EXISTS

Find departments that have at least one employee.

```sql
SELECT
    d.DeptID,
    d.DeptName
FROM Department d
WHERE EXISTS (
    SELECT 1
    FROM Employee e
    WHERE e.DeptID = d.DeptID
);
```

### Query 7: Simulated INTERSECT

Find employees who are assigned to at least one project. This query represents the intersection of employees and employees assigned to projects.

```sql
SELECT
    e.EmpID,
    e.EmpName
FROM Employee e
WHERE EXISTS (
    SELECT 1
    FROM Employee_Project ep
    WHERE ep.EmpID = e.EmpID
);
```

**Alternative using INNER JOIN:**

```sql
SELECT DISTINCT
    e.EmpID,
    e.EmpName
FROM Employee e
INNER JOIN Employee_Project ep
    ON e.EmpID = ep.EmpID;
```

### Query 8: Simulated EXCEPT

Find employees who are not assigned to any project.

```sql
SELECT
    e.EmpID,
    e.EmpName
FROM Employee e
WHERE NOT EXISTS (
    SELECT 1
    FROM Employee_Project ep
    WHERE ep.EmpID = e.EmpID
);
```

### Query 9: Employees Working on AI Projects

Find employees assigned to projects whose names contain “AI”.

```sql
SELECT DISTINCT
    e.EmpName,
    p.ProjectName
FROM Employee e
JOIN Employee_Project ep
    ON e.EmpID = ep.EmpID
JOIN Project p
    ON ep.ProjectID = p.ProjectID
WHERE p.ProjectName LIKE '%AI%';
```

### Query 10: EXPLAIN — Query Execution Plan

Examine the execution plan for a query that retrieves employees earning more than 70,000 along with their department names.

```sql
EXPLAIN
SELECT
    e.EmpName,
    d.DeptName
FROM Employee e
INNER JOIN Department d
    ON e.DeptID = d.DeptID
WHERE e.Salary > 70000;
```

**Optional: EXPLAIN ANALYZE (MySQL 8.0.18 or later)**

```sql
EXPLAIN ANALYZE
SELECT
    e.EmpName,
    d.DeptName
FROM Employee e
INNER JOIN Department d
    ON e.DeptID = d.DeptID
WHERE e.Salary > 70000;
```

`EXPLAIN` displays the optimizer's execution plan. `EXPLAIN ANALYZE` executes the query and reports actual execution details, so use it carefully on queries that modify data.

## 8. Expected Output

| Query | Expected Result |
|---|---|
| INNER JOIN | Employees with matching department names |
| LEFT JOIN | All departments, including those without employees |
| SELF JOIN | Employees and their managers |
| Multi-Table JOIN | Employee, department, and project details |
| Correlated Subquery | Employees earning above their department average |
| EXISTS | Departments having at least one employee |
| Simulated INTERSECT | Employees assigned to projects |
| Simulated EXCEPT | Employees not assigned to any project |
| AI Projects | Employees working on projects with “AI” in the name |
| EXPLAIN | Query execution plan and optimizer details |

*Note: Actual rows depend on the data inserted in Experiment No. 03. If every employee is assigned to a project, the simulated EXCEPT query will return no rows.*

## 9. Result

SQL joins and subqueries were used to retrieve and analyze related information from the Employee–Department–Project database. The experiment demonstrated matching records, unmatched departments, employee-manager relationships, correlated subqueries, existence checks, simulated set operations, and query execution plan analysis.
