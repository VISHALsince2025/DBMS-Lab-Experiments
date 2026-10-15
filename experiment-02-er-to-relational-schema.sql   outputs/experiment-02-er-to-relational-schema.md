# Experiment 02 — ER-to-Relational Schema Mapping and Integrity Constraints

**Domain:** Relational Database Design  
**DBMS:** MySQL  
**Database:** `EcommerceDB`  
**Experiment Type:** Schema Implementation and Constraint Validation

## 1. Problem Statement

An Entity–Relationship model describes the conceptual structure of a database. Before it can be used in an application, the model must be mapped into relational tables with appropriate keys, relationships, and integrity constraints.

This experiment translates the Indian e-commerce platform designed in Experiment 01 into a relational schema and implements it in MySQL. The implementation covers entity tables, multivalued attributes, product specialization, composite keys, foreign-key relationships, and referential actions.

## 2. Aim

To convert the ER diagram of an Indian e-commerce platform into a relational database schema and implement it in MySQL using primary keys, foreign keys, `NOT NULL`, `UNIQUE`, `ON DELETE CASCADE`, `ON DELETE SET NULL`, and other appropriate integrity constraints. To insert sample records and demonstrate referential integrity violations.

## 3. Design Approach

The ER model is mapped into relational tables according to the following principles:

- Strong entities are represented as individual tables.
- Entity identifiers are implemented using primary keys.
- Multivalued attributes are separated into their own relations.
- One-to-many relationships are represented using foreign keys on the many side.
- Many-to-many relationships are represented using an associative table.
- Product specialization is represented using a parent table and subtype tables.
- Foreign-key actions define how related records behave when referenced records are deleted.

## 4. Relational Schema

The resulting database consists of the following relations.

| Relation | Primary Key | Purpose |
|---|---|---|
| CUSTOMER | CustomerID | Customer details |
| CUSTOMER_PHONE | CustomerID, PhoneNumber | Customer phone numbers |
| ADDRESS | AddressID | Address information |
| CUSTOMER_ADDRESS | CustomerID, AddressID | Customer-address association |
| CATEGORY | CategoryID | Product categories |
| SELLER | SellerID | Seller details |
| PRODUCT | ProductID | Common product information |
| PHYSICAL_PRODUCT | ProductID | Physical-product attributes |
| DIGITAL_PRODUCT | ProductID | Digital-product attributes |
| ORDERS | OrderID | Order information |
| ORDER_ITEM | OrderID, ProductID | Products included in an order |
| PAYMENT | PaymentID | Payment records |
| DELIVERY | DeliveryID | Delivery and tracking information |

**Key observation:** `CUSTOMER_PHONE` and `CUSTOMER_ADDRESS` demonstrate how multivalued attributes and many-to-many associations can be represented in a relational database. `ORDER_ITEM` uses a composite primary key to identify an order-product combination.

## 5. Implementation

The MySQL implementation is maintained in a separate executable script:

`sql/experiment-02-er-to-relational-schema.sql`

The script contains the following stages:

1. Create and select the `EcommerceDB` database.
2. Create the relational tables in dependency order.
3. Define primary keys and composite primary keys.
4. Establish foreign-key relationships.
5. Apply `NOT NULL`, `UNIQUE`, `DEFAULT`, and referential-action constraints.
6. Insert sample records representing a customer purchasing a laptop.
7. Execute validation queries to inspect the inserted data and test constraint enforcement.

## 6. Integrity Constraints

| Constraint | Purpose | Example in this schema |
|---|---|---|
| `PRIMARY KEY` | Uniquely identifies each row | `CustomerID` |
| `FOREIGN KEY` | Prevents references to nonexistent parent records | `Product.CategoryID` |
| `NOT NULL` | Requires a value for a column | `Customer.Name` |
| `UNIQUE` | Prevents duplicate non-NULL values in a unique column | `Customer.Email` |
| `DEFAULT` | Supplies a value when one is omitted | `Address.Country` |
| `ON DELETE CASCADE` | Deletes dependent rows when a referenced parent is deleted | `Customer_Phone` referencing `Customer` |
| `ON DELETE SET NULL` | Clears an optional foreign-key value when its referenced row is deleted | `Seller.AddressID` |
| `ON DELETE RESTRICT` | Prevents deletion of a referenced row while dependent records exist | `Product.CategoryID` |

## 7. Sample Transaction Scenario

The sample data models the following workflow:

1. A customer named Rahul Sharma is registered.
2. An address in Lucknow is added and associated with the customer.
3. An Electronics category and a seller are created.
4. A laptop is registered as a physical product.
5. An order is placed for the laptop.
6. An order item records the purchased product and its unit price.
7. A payment record and a delivery record are created.

This scenario demonstrates how multiple relations work together to represent a single e-commerce transaction.

## 8. Referential Integrity Validation

The implementation should be tested with both valid and invalid operations.

### Test A — Invalid foreign key

Attempt to insert a product with a `CategoryID` that does not exist in `CATEGORY`. MySQL should reject the insertion.

### Test B — Unique constraint violation

Attempt to register a second customer using an existing email address. MySQL should reject the duplicate value.

### Test C — Cascade deletion

Create a disposable customer with a related phone-number record, then delete the customer. Verify that the dependent phone-number record is automatically removed.

### Test D — Set NULL

Create a disposable seller referencing an existing address, then delete that address. Verify that the seller's `AddressID` becomes `NULL`.

### Test E — Restricted deletion

Attempt to delete a category that is referenced by a product. MySQL should reject the deletion while the dependent product exists.

**Testing note:** Run destructive tests using disposable records or a separate test database. Record the actual MySQL messages and query results rather than treating expected outcomes as already verified.

## 9. Expected Outcome

The expected outcome is a relational database containing the specified tables, primary and foreign keys, and integrity constraints. Valid sample records should be accepted, while operations that violate the defined constraints should be rejected or handled according to their configured referential actions.

## 10. Conclusion

This experiment demonstrates the conversion of an ER model into a relational schema and its implementation using MySQL. It illustrates the role of primary keys, foreign keys, uniqueness rules, and referential actions in maintaining consistency between related tables.

The resulting schema provides a foundation for further DBMS experiments involving joins, normalization, transactions, and SQL query development.
