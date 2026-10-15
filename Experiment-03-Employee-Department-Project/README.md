# Experiment 03 — Employee–Department–Project Schema

**Subject:** Database Management Systems (DBMS)  
**DBMS:** MySQL  
**Database Name:** EmployeeDB

## 1. Aim

To design and implement an Employee–Department–Project relational database, populate it with five departments, eight projects, and thirty employees, and execute SQL queries demonstrating selection, projection, aggregate functions, GROUP BY, HAVING, CASE expressions, ORDER BY, and department-wise salary analysis.

## 2. Problem Statement

An organization needs a database to maintain employee records, department information, project details, and employee assignments. The database should preserve relationships between these entities and support queries for analyzing employee salaries, department-wise workforce distribution, and project participation.

This experiment implements the required relational schema and demonstrates fundamental SQL operations using MySQL.

## 3. Objectives

- Create relational tables with primary keys and foreign-key constraints.
- Establish relationships between employees, departments, and projects.
- Insert sample data for five departments and eight projects.
- Populate the database with thirty employees.
- Assign employees to projects and record their working hours.
- Execute SQL queries using filtering, projection, aggregation, grouping, conditional expressions, and sorting.
- Analyze salary statistics at the department level.

## 4. Database Schema

The database consists of four tables.

| Table | Description | Primary Key |
|---|---|---|
| Department | Stores department names and locations | DeptID |
| Employee | Stores employee details, salary, department, and manager | EmpID |
| Project | Stores project names, budgets, and departments | ProjectID |
| Employee_Project | Associates employees with projects and records hours worked | EmpID, ProjectID |

### Relationships

- One department can have multiple employees.
- One department can manage multiple projects.
- An employee may report to another employee through the self-referencing `ManagerID` foreign key.
- Employees and projects have a many-to-many relationship, implemented through `Employee_Project`.
- The composite primary key `(EmpID, ProjectID)` prevents duplicate assignments of the same employee to the same project.

## 5. Algorithm

1. Create the `EmployeeDB` database.
2. Create the Department table.
3. Create the Employee table with department and manager foreign keys.
4. Create the Project table.
5. Create the Employee_Project junction table.
6. Insert five departments and eight projects.
7. Insert thirty employee records distributed across the departments.
8. Assign employees to projects and specify working hours.
9. Execute SQL queries demonstrating selection and projection.
10. Apply aggregate functions and GROUP BY to analyze employee salaries.
11. Use HAVING to filter departments based on employee count.
12. Apply CASE expressions to classify employees by salary.
13. Use ORDER BY to sort employees by salary.
14. Execute a department-wise salary analysis using JOIN.
15. Verify the final number of departments, projects, employees, and project assignments.

## 6. SQL Query Demonstrations

### 6.1 Selection

Retrieves employees whose salary exceeds ₹70,000.

```sql
SELECT *
FROM Employee
WHERE Salary > 70000;
```

**Concept:** Selection filters rows based on a specified condition.

### 6.2 Projection

Displays only employee names and salaries.

```sql
SELECT EmpName, Salary
FROM Employee;
```

**Concept:** Projection selects the required columns from a table.

### 6.3 Aggregate Functions

Calculates total, average, maximum, and minimum salaries.

```sql
SELECT
    SUM(Salary) AS TotalSalary,
    AVG(Salary) AS AverageSalary,
    MAX(Salary) AS MaximumSalary,
    MIN(Salary) AS MinimumSalary
FROM Employee;
```

**Concept:** Aggregate functions summarize numerical values across multiple rows.

### 6.4 GROUP BY

Counts employees and calculates the average salary in each department.

```sql
SELECT
    DeptID,
    COUNT(*) AS EmployeeCount,
    AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY DeptID;
```

**Concept:** GROUP BY divides records into groups for aggregate calculations.

### 6.5 HAVING

Displays departments containing more than five employees.

```sql
SELECT
    DeptID,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY DeptID
HAVING COUNT(*) > 5;
```

**Concept:** HAVING filters grouped results based on aggregate conditions.

### 6.6 CASE Expression

Classifies employees according to their salary.

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

**Concept:** CASE applies conditional logic and produces a derived value for each employee.

### 6.7 ORDER BY

Displays employees from highest to lowest salary.

```sql
SELECT EmpID, EmpName, Salary
FROM Employee
ORDER BY Salary DESC;
```

**Concept:** ORDER BY sorts the result set in the specified order. DESC indicates descending order.

### 6.8 Department-wise Salary Analysis

Calculates employee count, total salary, and average salary for each department.

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

**Concept:** This query combines related tables using JOIN, calculates department-level statistics, and sorts departments by average salary.

## 7. Expected Output

After successful insertion and execution, the database should contain:

| Entity | Expected Count |
|---|---:|
| Departments | 5 |
| Projects | 8 |
| Employees | 30 |

The SQL queries should return employee records matching the specified conditions, salary aggregates, department-wise employee counts, salary classifications, sorted employee lists, and department-level salary statistics.

Exact salary values and query result counts depend on the inserted dataset and must be verified by executing the SQL statements.

## 8. Validation Checklist

- [ ] All four tables are created successfully.
- [ ] Five department records are inserted.
- [ ] Eight project records are inserted.
- [ ] Thirty employee records are inserted.
- [ ] Employee-project assignments reference valid employees and projects.
- [ ] Primary-key and foreign-key constraints are satisfied.
- [ ] All eight query demonstrations execute successfully.
- [ ] Department-wise salary statistics are verified against the dataset.

## 9. Conclusion

This experiment demonstrates the design and implementation of a relational database for employee, department, and project management. It provides practical experience with primary keys, foreign keys, many-to-many relationships, selection, projection, aggregate functions, grouping, conditional expressions, sorting, and multi-table joins.

The experiment also illustrates how SQL transforms stored organizational data into useful information for workforce and salary analysis.
