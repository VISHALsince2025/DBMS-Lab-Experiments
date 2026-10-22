# Experiment No. 10 — SQL Query Optimization and Performance Analysis

## 1. Aim

To generate a dataset with at least 10,000 rows, write five slow queries, analyze them using `EXPLAIN`, optimize them using indexing and query rewriting, and compare execution time before and after optimization.

## 2. Theory

Query optimization improves database performance by reducing execution time and unnecessary data access. Indexing, efficient filtering, and query rewriting help MySQL execute queries faster. The `EXPLAIN` statement is used to analyze the execution plan of a query.

Indexes can improve data retrieval, but they require additional storage and may increase the cost of insert, update, and delete operations. Performance improvements should be verified using actual execution plans and measured execution times.

## 3. Software Requirements

- **Database:** MySQL
- **Database Name:** `OptimizationDB`
- **Tools:** MySQL Workbench or MySQL Command-Line Client
- **Dataset:** At least 10,000 sales records

## 4. Algorithm

1. Create the `OptimizationDB` database and `Sales` table.
2. Generate and insert 10,000 sample records.
3. Verify the total number of records.
4. Write five SQL queries and analyze them using `EXPLAIN`.
5. Create suitable single-column and composite indexes.
6. Rewrite queries to retrieve only the required columns.
7. Analyze the optimized queries using `EXPLAIN`.
8. Measure query execution times before and after optimization.
9. Compare execution plans and observed performance.
10. Display a sample of the generated dataset.

## 5. SQL Queries / Program

### Step 1: Create Database and Table

```sql
CREATE DATABASE OptimizationDB;
USE OptimizationDB;

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Region VARCHAR(30),
    Quantity INT,
    Amount DECIMAL(10,2),
    SaleDate DATE
);
```

### Step 2: Generate 10,000 Records

```sql
DELIMITER //

CREATE PROCEDURE GenerateSales()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 10000 DO
        INSERT INTO Sales VALUES (
            i,
            1 + (i MOD 500),
            1 + (i MOD 100),
            CASE
                WHEN i MOD 4 = 0 THEN 'North'
                WHEN i MOD 4 = 1 THEN 'South'
                WHEN i MOD 4 = 2 THEN 'East'
                ELSE 'West'
            END,
            1 + (i MOD 10),
            100 + (i MOD 5000),
            DATE_ADD(
                '2025-01-01',
                INTERVAL (i MOD 365) DAY
            )
        );

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL GenerateSales();

SELECT COUNT(*) AS TotalRecords
FROM Sales;
```

**Expected output:** `TotalRecords = 10000` when the table is initially empty and the procedure completes successfully.

### Step 3: Analyze Five Queries Before Optimization

#### Query 1: Filter by CustomerID

```sql
EXPLAIN
SELECT *
FROM Sales
WHERE CustomerID = 150;
```

#### Query 2: Filter by Region and SaleDate

```sql
EXPLAIN
SELECT *
FROM Sales
WHERE Region = 'North'
  AND SaleDate = '2025-03-15';
```

#### Query 3: Calculate Total Sales by Region

```sql
EXPLAIN
SELECT Region, SUM(Amount)
FROM Sales
GROUP BY Region;
```

#### Query 4: Find Products with High Sales Amounts

```sql
EXPLAIN
SELECT *
FROM Sales
WHERE Amount > 4000
ORDER BY Amount DESC;
```

#### Query 5: Find Customers Whose Total Sales Exceed a Threshold

```sql
EXPLAIN
SELECT CustomerID, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(Amount) > 10000;
```

**Observation:** Record the `type`, `possible_keys`, `key`, and `rows` values from each execution plan.

### Step 4: Create Indexes

```sql
CREATE INDEX idx_customer
ON Sales(CustomerID);

CREATE INDEX idx_region_date
ON Sales(Region, SaleDate);

CREATE INDEX idx_amount
ON Sales(Amount);

CREATE INDEX idx_customer_amount
ON Sales(CustomerID, Amount);
```

These indexes support customer filtering, route-independent region/date filtering, amount filtering, and customer-related lookups or aggregations. The optimizer determines whether each index is useful for a particular query.

### Step 5: Rewrite and Analyze the Queries

#### Optimized Query 1

```sql
EXPLAIN
SELECT SaleID, CustomerID, Amount
FROM Sales
WHERE CustomerID = 150;
```

#### Optimized Query 2

```sql
EXPLAIN
SELECT SaleID, Region, SaleDate, Amount
FROM Sales
WHERE Region = 'North'
  AND SaleDate = '2025-03-15';
```

#### Optimized Query 3

```sql
EXPLAIN
SELECT Region, SUM(Amount)
FROM Sales
GROUP BY Region;
```

#### Optimized Query 4

```sql
EXPLAIN
SELECT SaleID, ProductID, Amount
FROM Sales
WHERE Amount > 4000
ORDER BY Amount DESC;
```

#### Optimized Query 5

```sql
EXPLAIN
SELECT CustomerID, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(Amount) > 10000;
```

**Observation:** Queries 1, 2, and 4 now retrieve fewer columns, which can reduce data transfer and sometimes improve performance. Queries 3 and 5 retain their original aggregation logic. Actual improvements depend on the execution plan and database environment.

### Step 6: Measure Execution Time

Run the queries before and after optimization and record the execution times displayed by MySQL Workbench or another SQL client.

```sql
SELECT SaleID, CustomerID, Amount
FROM Sales
WHERE CustomerID = 150;

SELECT SaleID, Region, SaleDate, Amount
FROM Sales
WHERE Region = 'North'
  AND SaleDate = '2025-03-15';

SELECT Region, SUM(Amount)
FROM Sales
GROUP BY Region;

SELECT SaleID, ProductID, Amount
FROM Sales
WHERE Amount > 4000
ORDER BY Amount DESC;

SELECT CustomerID, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(Amount) > 10000;
```

Repeat the measurements after creating indexes and compare the results.

**Note:** `SET PROFILING` and `SHOW PROFILES` are unavailable in some newer MySQL versions. Use the query execution-time display in your SQL client if profiling is unsupported. Run multiple trials under similar conditions for a fair comparison.

### Step 7: Verify the Dataset

```sql
SELECT COUNT(*) AS TotalRows
FROM Sales;

SELECT *
FROM Sales
LIMIT 10;
```

**Expected output:** The table contains 10,000 records, and the final query displays ten sample rows.

## 6. Execution Plan Comparison

| EXPLAIN column | Purpose |
|---|---|
| `type` | Indicates the access method used by MySQL |
| `possible_keys` | Lists indexes that may be usable |
| `key` | Shows the index selected by the optimizer |
| `rows` | Estimates the number of rows examined |

## 7. Performance Comparison

Record your actual measurements in the following table after executing the experiment.

| Query | Before optimization | After optimization |
|---|---|---|
| Query 1 — CustomerID | Record measured time | Record measured time |
| Query 2 — Region and date | Record measured time | Record measured time |
| Query 3 — Region aggregation | Record measured time | Record measured time |
| Query 4 — High amount | Record measured time | Record measured time |
| Query 5 — Customer totals | Record measured time | Record measured time |

Do not enter assumed performance improvements. Use the values measured in your own MySQL environment.

## 8. Precautions

- Begin with an empty table when generating exactly 10,000 records.
- Avoid calling `GenerateSales()` repeatedly without resetting or managing existing data.
- Compare the same query logic before and after optimization.
- Use `EXPLAIN` to verify whether the optimizer selects the intended indexes.
- Remember that adding indexes does not guarantee faster execution for every query.
- Run repeated timing trials and compare results under similar conditions.

## 9. Result

Thus, a dataset containing 10,000 sales records was generated, and five SQL queries were analyzed and optimized using indexing and query rewriting. Execution plans and execution times were compared to evaluate the effect of optimization.
