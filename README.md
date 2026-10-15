# DBMS Lab Experiments

Professional, beginner-friendly starter repository for **DBMS practicals** for B.Tech CSE (AI & ML) students.

> This repository provides educational starter SQL files and sample datasets.
> It is **not** a record of completed university practicals.

## Repository Purpose

This repository helps you practice core DBMS concepts with clean, topic-wise SQL scripts using a **MySQL-first** approach:

- schema creation and data manipulation
- constraints and relational integrity
- analytical querying (aggregates, grouping, sorting)
- joins and subqueries
- views, indexes, transactions, and stored programs
- normalization-oriented schema design

## Prerequisites

- MySQL 8.0+ recommended (CHECK constraints are properly supported in MySQL 8.0.16+)
- Terminal/Command Prompt access
- Optional GUI: MySQL Workbench / DBeaver / phpMyAdmin

## Repository Structure

```text
DBMS-Lab-Experiments/
├── datasets/
│   ├── retail_orders_seed.sql
│   └── students_courses_seed.sql
├── experiments/
│   ├── 01_ddl_dml/
│   ├── 02_integrity_constraints/
│   ├── 03_operators_aggregates/
│   ├── 04_groupby_having_orderby/
│   ├── 05_joins_subqueries/
│   ├── 06_views_indexes/
│   ├── 07_normalization_design/
│   ├── 08_transactions_acid/
│   ├── 09_commit_rollback_savepoint/
│   └── 10_stored_programs_triggers/
└── README.md
```

## How to Set Up Locally

1. Clone the repository.
2. Start MySQL server.
3. Open terminal in project root.
4. Execute any SQL file:

```bash
mysql -u <your_username> -p < /absolute/path/to/your_file.sql
```

Example:

```bash
mysql -u root -p < /home/runner/work/DBMS-Lab-Experiments/DBMS-Lab-Experiments/experiments/01_ddl_dml/01_create_insert_update_delete.sql
```

## Experiment Index

Each experiment contains: **title, aim, concept, SQL queries, sample data, and comments**.

1. `experiments/01_ddl_dml/01_create_insert_update_delete.sql`
   - DDL and DML commands
2. `experiments/02_integrity_constraints/02_primary_foreign_unique_check.sql`
   - Integrity constraints (PK, FK, UNIQUE, CHECK)
3. `experiments/03_operators_aggregates/03_operators_aggregate_functions.sql`
   - SQL operators and aggregate functions
4. `experiments/04_groupby_having_orderby/04_groupby_having_orderby.sql`
   - GROUP BY, HAVING, ORDER BY
5. `experiments/05_joins_subqueries/05_joins_subqueries.sql`
   - Joins and subqueries
6. `experiments/06_views_indexes/06_views_indexes.sql`
   - Views and indexes
7. `experiments/07_normalization_design/07_normalization_and_design.sql`
   - Normalization and database design
8. `experiments/08_transactions_acid/08_transactions_acid_demo.sql`
   - Transactions and ACID properties
9. `experiments/09_commit_rollback_savepoint/09_commit_rollback_savepoint.sql`
   - COMMIT, ROLLBACK, SAVEPOINT
10. `experiments/10_stored_programs_triggers/10_stored_programs_functions_triggers.sql`
    - Stored procedures, functions, triggers (where supported)

## Expected Output Notes

- Some scripts include **illustrative output blocks** for learning.
- Such output is explicitly marked as **UNTESTED**.
- Please run scripts locally to verify actual results in your environment/version.

## Database-Specific Notes

- Default syntax is **MySQL-compatible**.
- Stored routines/trigger script uses MySQL `DELIMITER` blocks.
- If using PostgreSQL/SQLite, adapt routine/trigger syntax and date/string functions as required.

## Sample Datasets

Small and beginner-friendly seed data is provided in:

- `datasets/students_courses_seed.sql`
- `datasets/retail_orders_seed.sql`

These are suitable for join, aggregate, and filter practice in college practical sessions.

## Safety and Good Practices

- Do not store credentials in SQL files.
- Keep local usernames/passwords outside version control.
- Review scripts before execution in shared databases.
