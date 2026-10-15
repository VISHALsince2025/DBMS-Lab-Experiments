# Experiment 01 — Entity–Relationship Modeling of an Indian E-Commerce Platform

**Domain:** E-Commerce and Database Design  
**Subject:** Database Management Systems (DBMS)  
**Modeling Technique:** Entity–Relationship (ER) Modeling

---

## 01. Problem Definition

An Indian e-commerce platform must manage customer information, product listings, sellers, product categories, customer orders, payments, deliveries, and delivery addresses. These components are interconnected, and the database must represent their relationships without introducing ambiguity or unnecessary duplication.

The objective of this experiment is to develop a conceptual data model that captures the platform's core entities, their attributes, identification rules, relationship cardinalities, and participation constraints.

## 02. Design Objectives

The proposed ER model is designed to:

- Represent the core entities involved in an e-commerce transaction.
- Define entity identifiers and distinguish regular entities from weak entities.
- Model one-to-one, one-to-many, and many-to-one relationships.
- Represent composite and multivalued attributes using standard ER notation.
- Apply specialization to distinguish physical products from digital products.
- Establish a conceptual foundation for subsequent relational schema design.

## 03. ER Model

**Figure 1.** Entity–Relationship model of an Indian e-commerce platform.

<img width="727" height="454" alt="image" src="https://github.com/user-attachments/assets/4e714f5a-036e-43cd-b107-76101cbe1419" />



The diagram captures the relationships among Customer, Address, Product, Category, Seller, Order, OrderItem, Payment, and Delivery. It also represents OrderItem as a weak entity and Product as a generalized entity with PhysicalProduct and DigitalProduct subtypes.

## 04. Entity and Attribute Design

| Entity | Role in the System | Key Attributes |
|---|---|---|
| Customer | Stores customer identity and contact information | CustomerID, Name, Email, DateOfBirth, PhoneNumbers |
| Address | Stores address information | AddressID, Street, City, State, Country, Pincode, AddressType |
| Product | Maintains common product information | ProductID, ProductName, Description, Price, StockQuantity, SKU |
| Category | Classifies products | CategoryID, CategoryName |
| Seller | Maintains seller and business information | SellerID, SellerName, Email, Phone, GSTIN |
| Order | Records customer orders | OrderID, OrderDate, OrderStatus, TotalAmount |
| OrderItem | Records individual products within an order | OrderID, ProductID, Quantity, UnitPrice, Discount |
| Payment | Stores payment transaction details | PaymentID, PaymentDate, Amount, PaymentMethod, PaymentStatus, TransactionID |
| Delivery | Tracks order delivery information | DeliveryID, DeliveryDate, DeliveryStatus, TrackingNumber, CourierPartner |
| PhysicalProduct | Stores physical-product-specific properties | Weight, Dimensions, ManufacturingDate |
| DigitalProduct | Stores digital-product-specific properties | FileSize, FileType, DownloadLink |

## 05. Relationship Analysis

The relationships in the proposed model represent the following business operations:

| Relationship | Cardinality | Interpretation |
|---|---|---|
| Customer — Address | 1:N | A customer can have multiple addresses. |
| Customer — Order | 1:N | A customer can place multiple orders. |
| Product — Category | N:1 | Multiple products can belong to one category. |
| Product — Seller | N:1 | Multiple products can be listed by one seller. |
| Order — OrderItem | 1:N | An order contains one or more order items. |
| Order — Payment | 1:1 | Each order is associated with one payment record in the current model. |
| Order — Delivery | 1:1 | Each order is associated with one delivery record in the current model. |
| OrderItem — Product | N:1 | Each order item refers to one product. |
| Delivery — Address | N:1 | Multiple deliveries may use the same address. |

The cardinalities above describe the assumptions represented by the diagram. A production system may require different payment and delivery cardinalities to support payment retries, split shipments, and partial fulfilment.

## 06. ER Modeling Decisions

**Weak entity and identification**

OrderItem is modeled as a weak entity dependent on Order. Its identifying key is the combination of OrderID and ProductID. This assumes that a product can occur only once within a given order; if duplicate lines are allowed, an additional OrderItemID or line number would be required.

**Multivalued attribute**

PhoneNumbers allows a customer to have more than one phone number. In a relational implementation, these values would normally be stored in a separate related table rather than a single multivalued column.

**Composite attribute**

Address is represented through individual components such as Street, City, State, Country, and Pincode. This supports more precise storage and retrieval than treating the entire address as an indivisible value.

**Product specialization**

Product is divided into PhysicalProduct and DigitalProduct. Common attributes remain at the parent level, while subtype-specific attributes capture shipping-related physical properties or digital file and download information.

**Participation constraints**

The ER notation uses participation constraints to express whether entity participation in a relationship is mandatory or optional. These constraints should be checked against the business rules before the model is converted into tables.

## 07. Design Validation

The model should be reviewed against the following conditions:

- Every strong entity has a defined primary key.
- OrderItem has an appropriate identifying key and an identifying relationship with Order.
- Each relationship has a clearly defined cardinality.
- Product subtype attributes are separated from common product attributes.
- Multivalued attributes are identifiable for relational conversion.
- Participation constraints are consistent with the intended business rules.
- Payment and delivery assumptions are explicitly documented.

## 08. Outcome

The conceptual ER model establishes the principal data objects and their relationships for an Indian e-commerce platform. It provides a basis for the next stage of database development: converting the ER model into a relational schema, defining primary and foreign keys, and implementing the schema using SQL.

## 09. Scope for Further Work

The next stage can include relational schema mapping, normalization, SQL table creation, referential integrity constraints, and sample transaction queries. Additional production requirements—such as multiple payment attempts, split deliveries, product inventory by seller, and order cancellation—can be incorporated as the model evolves.
