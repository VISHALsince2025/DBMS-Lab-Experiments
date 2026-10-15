# Experiment 05 — SQL Views and Recursive CTE

**Database:** EmployeeDB  
**DBMS:** MySQL 8.0+  
**Prerequisite:** Experiment 03 — Employee–Department–Project Schema

## 1. Aim

To create and query SQL views for department-wise salary analysis and employee reporting relationships, examine view updatability, and implement recursive Common Table Expressions (CTEs) to retrieve individual reporting chains and the complete employee hierarchy.

## 2. Problem Statement

Organizations need to analyze departmental salary statistics and understand reporting relationships between employees and managers. Storing the underlying data across relational tables provides flexibility, but repeatedly writing complex queries can make analysis harder to maintain.

This experiment uses SQL views to provide reusable representations of employee data and recursive CTEs to traverse hierarchical manager relationships.

## 3. Database Components

The experiment uses the following tables from the existing EmployeeDB database:

| Table | Role |
|---|---|
| Department | Stores department identifiers and names |
| Employee | Stores employee details, salaries, departments, and manager references |

The `Employee.ManagerID` column references `Employee.EmpID`, creating a self-referencing relationship that represents the reporting hierarchy.

## 4. Implementation Overview

The implementation is organized into five stages:

1. Create a department salary summary view.
2. Query the view to analyze departmental salary statistics.
3. Create an employee hierarchy view using a self-join.
4. Test whether a simple employee salary view supports updates.
5. Use recursive CTEs to traverse an employee's manager chain and retrieve the complete hierarchy.

The complete executable program is maintained in:

`sql/experiment-05-views-recursive-cte.sql`

## 5. View-Based Salary Analysis

### 5.1 Department_Salary_Summary

The `Department_Salary_Summary` view combines Department and Employee using a LEFT JOIN and calculates:

- Total employees in each department
- Total salary expenditure
- Average salary
- Maximum salary
- Minimum salary

Using LEFT JOIN ensures that departments without employees remain represented in the view. Aggregate functions return NULL for salary statistics when a department has no employees, while `COUNT(e.EmpID)` returns zero.

### 5.2 Filtering Department Salary Statistics

A query against the view identifies departments whose average salary exceeds ₹70,000.

This demonstrates how a view can serve as a reusable query interface without repeating the underlying join and aggregation logic.

## 6. Employee Hierarchy View

The `Employee_Hierarchy` view joins Employee to itself using the employee's `ManagerID` and the manager's `EmpID`.

It exposes the employee name, manager name, department, salary, and identifiers in a single result.

The LEFT JOIN preserves employees who do not have a manager, such as top-level employees whose `ManagerID` is NULL.

## 7. View Updatability

The `Employee_Salary_View` view selects `EmpID`, `EmpName`, `Salary`, and `DeptID` from the Employee table without aggregation or joins.

An UPDATE statement increases the salary of employee 6 by ₹5,000 through this view. A subsequent query against Employee checks whether the base-table value has changed.

This demonstrates that a suitable simple view can be updatable in MySQL. It does not imply that all views are updatable; aggregation, grouping, and joins can impose restrictions.

**Validation requirement:** Record the actual salary before and after the update. Restore the original value if the experiment is intended to be repeatable.

## 8. Recursive CTE — Individual Reporting Chain

The `ReportingChain` CTE starts with employee 6 and repeatedly retrieves the employee referenced by the current row's `ManagerID`.

Each recursive iteration moves one level upward in the reporting hierarchy until no matching manager remains.

The query also constructs a `ReportingPath` and records the hierarchy level for each employee-manager step.

The resulting chain depends on the actual Employee records and their ManagerID values.

## 9. Recursive CTE — Complete Employee Hierarchy

The `EmployeeTree` CTE begins with employees whose `ManagerID` is NULL and recursively retrieves their direct and indirect reports.

The output includes:

- Employee and manager identifiers
- Department identifier
- Hierarchy level
- Reporting path

This approach traverses the hierarchy from top-level managers downward. Employees disconnected from every top-level employee will not appear in this result and should be investigated if all employees are expected to belong to the hierarchy.

## 10. Validation Checklist

- [ ] Department_Salary_Summary returns one row per department.
- [ ] Departments without employees are retained in the salary summary.
- [ ] Employee_Hierarchy displays the correct employee-manager relationships.
- [ ] Updating Employee_Salary_View changes the corresponding base-table record.
- [ ] ReportingChain follows the correct manager references.
- [ ] EmployeeTree retrieves the expected hierarchy from top-level employees.
- [ ] Actual results are checked against the inserted EmployeeDB dataset.

## 11. Expected Outcome

The experiment should demonstrate reusable SQL views, department-level salary analysis, the updatability of a suitable simple view, and recursive traversal of employee reporting relationships.

Exact employee counts, salary statistics, and hierarchy paths depend on the database contents and must be verified by executing the SQL program.

## 12. Conclusion

This experiment demonstrates how SQL views simplify repeated data analysis and how recursive CTEs represent hierarchical relationships stored in a relational table. Together, these techniques provide reusable query interfaces and a practical method for exploring organizational reporting structures.
