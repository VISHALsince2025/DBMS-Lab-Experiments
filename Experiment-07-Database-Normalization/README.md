# Experiment No. 07 — Database Normalization

## 1. Aim

To identify functional dependencies in a denormalized Sales table and normalize it step-by-step from UNF to 3NF and BCNF. To verify lossless join and dependency preservation using SQL queries.

## 2. Theory

Normalization is the process of organizing data in a database to reduce redundancy and avoid insertion, deletion, and update anomalies. UNF, 1NF, 2NF, 3NF, and BCNF are different stages of normalization. Functional dependencies help identify relationships between attributes.

## 3. Software Requirements

- **Database:** MySQL
- **Database Name:** `SalesDB`
- **Tools:** MySQL Workbench / MySQL Command Line Client

## 4. Functional Dependencies

The following functional dependencies are identified in the Sales table:

- `OrderID → CustomerID`
- `CustomerID → CustomerName`
- `ProductID → ProductName, Price`
- `(OrderID, ProductID) → Quantity`

**Candidate Key:** `(OrderID, ProductID)`

## 5. Algorithm

1. Create the `SalesDB` database.
2. Create the denormalized `Sales` table.
3. Insert sample sales records.
4. Identify functional dependencies and the candidate key.
5. Verify First Normal Form (1NF).
6. Decompose the table to remove partial dependencies and achieve 2NF.
7. Remove transitive dependencies to achieve 3NF.
8. Check whether the decomposed tables satisfy BCNF.
9. Verify lossless join by reconstructing the original sales information.
10. Verify dependency preservation using SQL queries.

## 6. Normalization Process

| Normal Form | Description |
|---|---|
| UNF | Initial denormalized Sales table |
| 1NF | Each attribute contains atomic values; repeating groups are removed |
| 2NF | Remove partial functional dependencies |
| 3NF | Remove transitive functional dependencies |
| BCNF | Every determinant of a non-trivial functional dependency must be a superkey |

## 7. Relational Schema After Normalization

### Customers

| Attribute | Key |
|---|---|
| CustomerID | Primary Key |
| CustomerName | — |

### Orders

| Attribute | Key |
|---|---|
| OrderID | Primary Key |
| CustomerID | Foreign Key |

### Products

| Attribute | Key |
|---|---|
| ProductID | Primary Key |
| ProductName | — |
| Price | — |

### OrderDetails

| Attribute | Key |
|---|---|
| OrderID | Composite Primary Key, Foreign Key |
| ProductID | Composite Primary Key, Foreign Key |
| Quantity | — |

## 8. SQL Program

The SQL program performs the following operations:

- Creates the original Sales table and inserts sample data.
- Creates the normalized Customers, Orders, Products, and OrderDetails tables.
- Inserts the corresponding records into the normalized tables.
- Displays the normalized data.
- Reconstructs sales records using joins.
- Checks functional dependencies using aggregate queries.

See the complete SQL source file: [`sql/experiment-07-normalization.sql`](sql/experiment-07-normalization.sql).

## 9. Lossless Join Verification

The normalized tables are joined to reconstruct the original sales information.

```sql
SELECT
    O.OrderID,
    C.CustomerID,
    C.CustomerName,
    P.ProductID,
    P.ProductName,
    OD.Quantity,
    P.Price
FROM Orders O
JOIN Customers C
    ON O.CustomerID = C.CustomerID
JOIN OrderDetails OD
    ON O.OrderID = OD.OrderID
JOIN Products P
    ON OD.ProductID = P.ProductID;
```

**Expected result:** Five sales-line records matching the original sample data, without spurious rows.

## 10. Dependency Preservation Verification

### Verify CustomerID → CustomerName

```sql
SELECT
    CustomerID,
    COUNT(DISTINCT CustomerName) AS NameCount
FROM Customers
GROUP BY CustomerID;
```

### Verify ProductID → ProductName, Price

```sql
SELECT
    ProductID,
    COUNT(DISTINCT ProductName) AS ProductNameCount,
    COUNT(DISTINCT Price) AS PriceCount
FROM Products
GROUP BY ProductID;
```

**Expected result:** Each valid CustomerID should determine one CustomerName, and each ProductID should determine one ProductName and Price. The counts should be `1` for each determinant in the supplied sample data.

## 11. Expected Output

- The original Sales table displays five sample records.
- The normalized tables contain customer, order, product, and order-detail records.
- The join query reconstructs the five original sales lines.
- Dependency checks show one distinct customer name per CustomerID and one distinct product name and price per ProductID.
- The decomposed schema satisfies the stated normal forms under the identified functional dependencies.

## 12. Result

The Sales table was analyzed using functional dependencies and decomposed into Customers, Orders, Products, and OrderDetails. The experiment demonstrates normalization from 1NF through BCNF, lossless reconstruction through joins, and verification of functional dependencies using SQL.

**Note:** Actual BCNF and lossless-join claims depend on the stated dependencies and the keys of the decomposed relations.
