# Experiment No. 08 — Banking Transactions and Concurrency Control

## 1. Aim

To implement banking-style transactions using `BEGIN`, `COMMIT`, `ROLLBACK`, and `SAVEPOINT`. To simulate partial failures and demonstrate isolation levels and concurrency anomalies using two sessions.

## 2. Theory

Transactions are a group of SQL operations executed as a single logical unit. `COMMIT` saves changes permanently, `ROLLBACK` cancels uncommitted changes, and `SAVEPOINT` allows partial rollback. Isolation levels control how concurrent transactions interact.

## 3. Software Requirements

- **Database:** MySQL
- **Database Name:** `BankingDB`
- **Storage Engine:** InnoDB
- **Tools:** MySQL Workbench or MySQL Command-Line Client

## 4. Algorithm

1. Create the `BankingDB` database and the `Accounts` table.
2. Insert sample account records.
3. Perform a fund transfer using a transaction and commit the changes.
4. Demonstrate transaction cancellation using `ROLLBACK`.
5. Use `SAVEPOINT` to undo selected operations within a transaction.
6. Simulate partial failure and observe the resulting account balances.
7. Set and test different transaction isolation levels.
8. Use two database sessions to observe concurrent transaction behavior.
9. Verify the account balances after each operation.

## 5. SQL Queries / Program

### Step 1: Create Database and Table

```sql
CREATE DATABASE BankingDB;
USE BankingDB;

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountHolder VARCHAR(50),
    Balance DECIMAL(10,2) NOT NULL
) ENGINE = InnoDB;

INSERT INTO Accounts VALUES
(101, 'Amit', 10000.00),
(102, 'Ravi', 15000.00),
(103, 'Neha', 20000.00);

SELECT * FROM Accounts;
```

**Expected output:** Three accounts are displayed with their initial balances.

### Step 2: Demonstrate BEGIN and COMMIT

```sql
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 2000
WHERE AccountID = 101;

UPDATE Accounts
SET Balance = Balance + 2000
WHERE AccountID = 102;

COMMIT;

SELECT * FROM Accounts;
```

**Expected output:**

- Account 101 balance decreases by 2000.
- Account 102 balance increases by 2000.
- Account 103 remains unchanged.

### Step 3: Demonstrate ROLLBACK

```sql
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 5000
WHERE AccountID = 101;

ROLLBACK;

SELECT * FROM Accounts;
```

**Expected output:** The uncommitted deduction is cancelled, and account 101 retains its balance from before this transaction.

### Step 4: Demonstrate SAVEPOINT

```sql
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 1000
WHERE AccountID = 101;

SAVEPOINT sp1;

UPDATE Accounts
SET Balance = Balance - 2000
WHERE AccountID = 102;

ROLLBACK TO sp1;

COMMIT;

SELECT * FROM Accounts;
```

**Expected output:** The 1000 deduction from account 101 is committed. The 2000 deduction from account 102 is rolled back.

### Step 5: Simulate Partial Failure

```sql
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 1000
WHERE AccountID = 101;

SAVEPOINT transfer_point;

UPDATE Accounts
SET Balance = Balance + 1000
WHERE AccountID = 102;

ROLLBACK TO transfer_point;

COMMIT;

SELECT * FROM Accounts;
```

**Expected output:** The credit to account 102 is undone, while the earlier deduction from account 101 is committed.

**Observation:** This demonstrates partial rollback, not a complete atomic bank transfer. A real fund transfer should roll back both the debit and credit if either operation fails.

### Step 6: Demonstrate Isolation Levels

#### A. READ UNCOMMITTED

```sql
SET SESSION TRANSACTION ISOLATION LEVEL
READ UNCOMMITTED;

START TRANSACTION;
SELECT * FROM Accounts;
COMMIT;
```

#### B. READ COMMITTED

```sql
SET SESSION TRANSACTION ISOLATION LEVEL
READ COMMITTED;

START TRANSACTION;
SELECT * FROM Accounts;
COMMIT;
```

#### C. REPEATABLE READ

```sql
SET SESSION TRANSACTION ISOLATION LEVEL
REPEATABLE READ;

START TRANSACTION;
SELECT * FROM Accounts;
COMMIT;
```

**Expected output:** The account records are displayed under each isolation level. To observe differences in visibility, concurrent transactions must modify the data while the test transactions are running.

### Step 7: Demonstrate Concurrency Using Two Sessions

Open two MySQL sessions connected to the same `BankingDB` database.

**Session 1:**

```sql
START TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 1000
WHERE AccountID = 101;

SELECT * FROM Accounts
WHERE AccountID = 101;

-- Commit after observing Session 2
COMMIT;
```

**Session 2:** Execute this query after Session 1 has updated the row but before Session 1 commits.

```sql
START TRANSACTION;

SELECT * FROM Accounts
WHERE AccountID = 101;

COMMIT;
```

**Expected observation:**

- Under `READ UNCOMMITTED`, Session 2 may read Session 1's uncommitted change.
- Under `READ COMMITTED`, Session 2 reads committed data rather than dirty data.
- Under InnoDB `REPEATABLE READ`, consistent reads generally use the transaction's snapshot; repeated reads can return the same committed row version.

The actual behavior depends on the isolation level configured for Session 2 and the timing of both transactions.

## 6. Expected Output Summary

| Operation | Expected result |
|---|---|
| Initial data | Three account records displayed |
| BEGIN and COMMIT | Transfer of 2000 is committed |
| ROLLBACK | Uncommitted deduction is cancelled |
| SAVEPOINT | Changes after the savepoint are undone |
| Partial failure | Only changes before the savepoint are retained |
| Isolation levels | Account data is read under different isolation settings |
| Two-session concurrency | Data visibility depends on isolation and transaction timing |

Account balances after each step depend on the previous committed operations. Reset the sample data before rerunning the full experiment if you want the same results each time.

## 7. Precautions

- Use the InnoDB storage engine to support transactions and savepoints.
- Execute the program in a test database.
- Run the two-session experiment with careful timing.
- Do not assume `ROLLBACK TO SAVEPOINT` cancels operations performed before the savepoint.
- Reset the sample data before rerunning the complete program.

## 8. Result

Thus, banking-style transactions were implemented using `BEGIN`/`START TRANSACTION`, `COMMIT`, `ROLLBACK`, and `SAVEPOINT`. Partial failures, transaction isolation levels, and concurrency behavior were demonstrated using SQL queries.
