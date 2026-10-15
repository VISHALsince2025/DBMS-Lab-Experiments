# Experiment 06 — SQL Transactions and Concurrency Control

**DBMS:** MySQL  
**Database:** EmployeeDB  
**Prerequisite:** Experiment 03 — Employee–Department–Project Schema

## 1. Aim

To study and implement SQL transactions using START TRANSACTION, SAVEPOINT, COMMIT, and ROLLBACK, and to understand how transaction control maintains data consistency and integrity.

## 2. Problem Statement

Database operations may involve multiple related modifications. If an operation fails or only part of a change should be retained, transaction control allows the database to save valid changes or undo unwanted modifications.

This experiment demonstrates how MySQL transactions manage employee salary updates and how savepoints provide partial rollback within a transaction.

## 3. Algorithm

1. Select the EmployeeDB database.
2. Start a transaction.
3. Increase the salary of employee 6 by ₹5,000.
4. Create a savepoint after the first update.
5. Increase the salary of employee 7 by ₹3,000.
6. Roll back to the savepoint, undoing the second update.
7. Commit the remaining change.
8. Start another transaction and increase employee 8's salary by ₹10,000.
9. Roll back the second transaction.
10. Query the affected employees to verify the final database state.

## 4. SQL Implementation

The complete executable program is maintained separately in:

`sql/experiment-06-transactions.sql`

The program contains the transaction statements, savepoint demonstration, commit operation, full rollback demonstration, and verification queries.

## 5. Transaction Demonstrations

### 5.1 START TRANSACTION

Begins an explicit transaction so that subsequent changes can be committed or rolled back.

### 5.2 SAVEPOINT

Creates a named point within the current transaction. It allows selected subsequent changes to be undone without discarding earlier changes in the same transaction.

### 5.3 ROLLBACK TO SAVEPOINT

Undoes changes made after the specified savepoint while preserving earlier changes in the transaction.

### 5.4 COMMIT

Permanently commits the remaining transaction changes. In this experiment, employee 6's salary increase is retained, while employee 7's later increase is undone.

### 5.5 Full ROLLBACK

The second transaction modifies employee 8's salary and then rolls back the transaction. The salary should return to its value before that transaction, assuming the update succeeded and no other transaction changed the record.

## 6. Expected Results

| Operation | Expected effect |
|---|---|
| Update employee 6 | Salary increases by ₹5,000 |
| Create savepoint | Establishes a rollback point |
| Update employee 7 | Salary temporarily increases by ₹3,000 |
| Roll back to savepoint | Reverses employee 7's update |
| Commit | Retains employee 6's salary increase |
| Update employee 8 | Salary temporarily increases by ₹10,000 |
| Full rollback | Reverses employee 8's update |

Actual salary values depend on the database state before execution. The verification queries should be run after each transaction to confirm the results.

## 7. ACID Properties

Transactions are commonly described using four ACID properties:

- **Atomicity:** A transaction's changes are committed as a unit or rolled back.
- **Consistency:** A transaction should preserve database rules and constraints.
- **Isolation:** Concurrent transactions are controlled according to the configured isolation level.
- **Durability:** Committed changes persist according to the database's durability guarantees.

This experiment directly demonstrates transaction control and rollback. It does not, by itself, test all isolation levels or simulate competing concurrent sessions.

## 8. Validation Checklist

- [ ] Employee 6's salary reflects the committed increase.
- [ ] Employee 7's salary does not retain the update made after the savepoint.
- [ ] Employee 8's salary returns to its pre-transaction value after rollback.
- [ ] Verification queries return the expected records.
- [ ] The results are checked against the actual database state.

## 9. Conclusion

This experiment demonstrates how transaction control statements manage database modifications. COMMIT retains the intended changes, ROLLBACK reverses uncommitted changes, and SAVEPOINT enables partial rollback within a transaction. These mechanisms are important for reliable and consistent database operations.
