# Experiment 03 — Employee, Department and Project Database

**Domain:** Relational Database Management  
**DBMS:** MySQL  
**Database:** `EmployeeDB`  
**Focus:** SQL Queries, Aggregation and Data Analysis

## 1. Aim

To design and implement an Employee–Department–Project database schema, populate it with five departments, eight projects, and thirty employees, and execute SQL queries demonstrating selection, projection, aggregate functions, grouping, filtering grouped results, conditional expressions, sorting, and department-wise salary analysis.

## 2. Problem Definition

An organization requires a relational database to manage its departments, employees, projects, and employee assignments. The database must maintain relationships between these entities and support queries that extract meaningful information about workforce distribution, salary statistics, and project participation.

This experiment implements the database using MySQL and demonstrates how SQL transforms stored records into useful analytical results.

## 3. Database Design

The database consists of four relations:

| Relation | Purpose | Primary Key |
|---|---|---|
| Department | Stores department names and locations | DeptID |
| Employee | Stores employee details, salary, and reporting relationships | EmpID |
| Project | Stores project names, budgets, and owning departments | ProjectID |
| Employee_Project | Associates employees with projects and records hours worked | EmpID, ProjectID |

### Relationship design

- A department can contain multiple employees.
- A department can manage multiple projects.
- An employee may report to another employee through `ManagerID`.
- Employees and projects have a many-to-many relationship, implemented using `Employee_Project`.
- The composite primary key in `Employee_Project` prevents the same employee-project pair from being inserted more than once.

## 4. Algorithm

1. Create the `EmployeeDB` database.
2. Create the Department table.
3. Create the Employee table with department and self-referencing manager foreign keys.
4. Create the Project table with a department foreign key.
5. Create the Employee_Project junction table with a composite primary key.
6. Insert five department records and eight project records.
7. Insert thirty employee records distributed among the departments.
8. Assign employees to projects and record their working hours.
9. Execute SQL queries for selection, projection, aggregation, grouping, `HAVING`, `CASE`, and sorting.
10. Execute a department-wise salary analysis using a join.
11. Verify the number of departments, projects, employees, and employee-project assignments.

## 5. SQL Implementation

The complete executable program should be maintained separately in:

`sql/experiment-03-employee-department-project.sql`

The program should contain the database definition, table creation statements, sample data for all four relations, and all eight query demonstrations.

The Employee table must be populated before inserting employee-project assignments because the junction table references existing employees and projects.

## 6. Query Demonstrations

### Query 1 — Selection

Retrieve employees whose salary exceeds ₹70,000.

```sql
SELECT *
FROM Employee
WHERE Salary > 70000;
```

**Concept:** `WHERE` filters rows according to a condition.

### Query 2 — Projection

Retrieve only employee names and salaries.

```sql
SELECT EmpName, Salary
FROM Employee;
```

**Concept:** Projection selects the required columns from a relation.

### Query 3 — Aggregate Functions

Calculate the total, average, maximum, and minimum salary.

```sql
SELECT
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AverageSalary,
    MAX(Salary) AS MaximumSalary,
    MIN(Salary) AS MinimumSalary
FROM Employee;
```

**Concept:** Aggregate functions summarize values across multiple rows.

### Query 4 — GROUP BY

Count employees and calculate the average salary in each department.

```sql
SELECT
    DeptID,
    COUNT(*) AS EmployeeCount,
    AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY DeptID;
```

**Concept:** `GROUP BY` partitions rows into groups for aggregate calculations.

### Query 5 — HAVING

Retrieve departments with more than five employees.

```sql
SELECT
    DeptID,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY DeptID
HAVING COUNT(*) > 5;
```

**Concept:** `HAVING` filters groups after grouping and aggregation.

### Query 6 — CASE Expression

Classify employees according to salary.

```sql
SELECT
    EmpName,
    Salary,
    CASE
        WHEN Salary >= 90000 THEN 'High Salary'
        WHEN Salary >= 70000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS SalaryCategory
FROM Employee;
```

**Concept:** `CASE` applies conditional logic to produce a derived result.

### Query 7 — ORDER BY

Sort employees from highest to lowest salary.

```sql
SELECT EmpID, EmpName, Salary
FROM Employee
ORDER BY Salary DESC;
```

**Concept:** `ORDER BY` sorts query results. `DESC` specifies descending order.

### Query 8 — Department-wise Salary Analysis

Calculate the number of employees, total salary, and average salary for each department.

```sql
SELECT
    d.DeptName,
    COUNT(e.EmpID) AS TotalEmployees,
    SUM(e.Salary) AS TotalSalary,
    AVG(e.Salary) AS AverageSalary
FROM Department d
JOIN Employee e
    ON d.DeptID = e.DeptID
GROUP BY d.DeptID, d.DeptName
ORDER BY AverageSalary DESC;
```

**Concept:** This query combines data from related tables using a join, groups employees by department, calculates salary statistics, and ranks departments by average salary.

## 7. Validation Checklist

- [ ] Five department records are present.
- [ ] Eight project records are present.
- [ ] Thirty employee records are present.
- [ ] Employee-project assignments reference valid employees and projects.
- [ ] Foreign-key constraints are enforced.
- [ ] All eight SQL queries execute successfully.
- [ ] Query results are checked against the inserted dataset.

## 8. Expected Outcome

The database should contain five departments, eight projects, and thirty employees. The SQL queries should demonstrate row filtering, column selection, aggregate calculations, grouping, conditional group filtering, salary classification, sorting, and joined departmental analysis.

Exact salary totals, averages, and query result counts must be determined by executing the queries against the completed dataset.

## 9. Conclusion

This experiment demonstrates the practical application of relational database design and fundamental SQL query operations. It also shows how joins and aggregate functions can be used to derive department-level workforce and salary insights from normalized relational data.
