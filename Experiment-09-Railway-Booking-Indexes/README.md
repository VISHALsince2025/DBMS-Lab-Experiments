# Experiment No. 09 — Railway Booking Indexing and Query Performance

## 1. Aim

To create a Railway Booking table with at least 5,000 records and benchmark query performance before and after creating single-column and composite indexes. To compare execution plans using `EXPLAIN`.

## 2. Theory

An index is a database object that improves data retrieval speed. A single-column index works on one column, whereas a composite index works on multiple columns. The `EXPLAIN` statement displays the execution plan used by MySQL to execute a query.

Indexes can improve query performance, but they also require storage and can increase the cost of insert, update, and delete operations.

## 3. Software Requirements

- **Database:** MySQL
- **Database Name:** `RailwayDB`
- **Tools:** MySQL Workbench or MySQL Command-Line Client
- **Dataset:** At least 5,000 railway booking records

## 4. Algorithm

1. Create the `RailwayDB` database.
2. Create the `RailwayBooking` table.
3. Generate and insert 5,000 sample booking records.
4. Verify the total number of records.
5. Run queries and inspect execution plans before indexing.
6. Create a single-column index on `TrainNo`.
7. Create a composite index on `Source` and `Destination`.
8. Run the same queries again using `EXPLAIN`.
9. Compare the selected indexes and estimated rows examined.
10. Measure execution times before and after indexing.
11. Display a sample of booking records.

## 5. SQL Queries / Program

### Step 1: Create Database and Table

```sql
CREATE DATABASE RailwayDB;
USE RailwayDB;

CREATE TABLE RailwayBooking (
    BookingID INT PRIMARY KEY,
    PassengerName VARCHAR(50),
    TrainNo INT,
    Source VARCHAR(50),
    Destination VARCHAR(50),
    JourneyDate DATE,
    SeatNo INT,
    Fare DECIMAL(10,2)
);
```

### Step 2: Insert 5,000 Records

```sql
DELIMITER //

CREATE PROCEDURE GenerateBookings()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 5000 DO
        INSERT INTO RailwayBooking
        VALUES (
            i,
            CONCAT('Passenger', i),
            10000 + (i MOD 20),
            CASE
                WHEN i MOD 3 = 0 THEN 'Delhi'
                WHEN i MOD 3 = 1 THEN 'Lucknow'
                ELSE 'Mumbai'
            END,
            CASE
                WHEN i MOD 3 = 0 THEN 'Mumbai'
                WHEN i MOD 3 = 1 THEN 'Delhi'
                ELSE 'Lucknow'
            END,
            DATE_ADD('2026-01-01',
                INTERVAL (i MOD 365) DAY),
            1 + (i MOD 72),
            500 + (i MOD 1000)
        );

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL GenerateBookings();

SELECT COUNT(*) AS TotalRecords
FROM RailwayBooking;
```

**Expected output:** `TotalRecords = 5000` when the table was initially empty and the procedure completed successfully.

### Step 3: Check Performance Before Indexing

```sql
EXPLAIN
SELECT *
FROM RailwayBooking
WHERE TrainNo = 10005;

EXPLAIN
SELECT *
FROM RailwayBooking
WHERE Source = 'Delhi'
  AND Destination = 'Mumbai';
```

**Observation:** Record the values in the `type`, `possible_keys`, `key`, and `rows` columns.

### Step 4: Create a Single-Column Index

```sql
CREATE INDEX idx_train
ON RailwayBooking(TrainNo);

EXPLAIN
SELECT *
FROM RailwayBooking
WHERE TrainNo = 10005;
```

**Expected observation:** MySQL may select `idx_train` for the train-number query. The actual execution plan depends on the optimizer and data distribution.

### Step 5: Create a Composite Index

```sql
CREATE INDEX idx_route
ON RailwayBooking(Source, Destination);

EXPLAIN
SELECT *
FROM RailwayBooking
WHERE Source = 'Delhi'
  AND Destination = 'Mumbai';
```

**Expected observation:** MySQL may select `idx_route` for the route query.

### Step 6: Compare Execution Plans

Run the following queries after creating the indexes:

```sql
EXPLAIN
SELECT *
FROM RailwayBooking
WHERE TrainNo = 10005;

EXPLAIN
SELECT *
FROM RailwayBooking
WHERE Source = 'Delhi'
  AND Destination = 'Mumbai';
```

Observe these columns:

- `type`: The access method selected by MySQL.
- `possible_keys`: Indexes that the optimizer considers usable.
- `key`: The index actually selected, if any.
- `rows`: The estimated number of rows MySQL expects to examine.

### Step 7: Measure Query Execution Time

On MySQL versions that support profiling, run:

```sql
SET PROFILING = 1;

SELECT *
FROM RailwayBooking
WHERE TrainNo = 10005;

SELECT *
FROM RailwayBooking
WHERE Source = 'Delhi'
  AND Destination = 'Mumbai';

SHOW PROFILES;
```

Repeat the measurements before and after indexing, using the same data and queries.

**Note:** `SET PROFILING` and `SHOW PROFILES` may not be available in newer MySQL versions. In that case, use your SQL client’s query execution-time display or another suitable timing method. Run each test multiple times for a more reliable comparison.

### Step 8: Display Booking Records

```sql
SELECT *
FROM RailwayBooking
LIMIT 10;
```

**Expected output:** Ten booking records are displayed.

## 6. Expected Output Summary

| Operation | Expected result |
|---|---|
| Record generation | 5,000 sample booking records |
| Query before indexing | Baseline execution plan |
| Single-column index | `idx_train` becomes available for train-number filtering |
| Composite index | `idx_route` becomes available for route filtering |
| EXPLAIN comparison | Execution plans can be compared before and after indexing |
| Timing comparison | Query execution times can be recorded |
| Sample display | First 10 booking records are displayed |

Actual execution plans and timing results must be recorded from the MySQL environment where the program is executed.

## 7. Precautions

- Start with an empty table when checking for exactly 5,000 generated records.
- Do not call `GenerateBookings()` repeatedly without clearing or otherwise managing existing data.
- Compare the same queries before and after creating indexes.
- Do not assume an index will always improve execution time; optimizer decisions and dataset size matter.
- Record actual `EXPLAIN` output and measured times instead of inventing benchmark results.

## 8. Result

Thus, a Railway Booking table was populated with 5,000 sample records, and single-column and composite indexes were implemented. Query execution plans and performance were compared using `EXPLAIN` and execution-time measurements.
