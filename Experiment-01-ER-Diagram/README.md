# Experiment 01 — ER Diagram for an Indian E-Commerce Platform

## 1. Aim

To design an Entity–Relationship (ER) diagram for an Indian e-commerce platform by identifying entities, attributes, primary keys, relationships, cardinalities, participation constraints, weak entities, multivalued attributes, and specialization.

## 2. Problem Statement

An e-commerce platform manages customers, products, sellers, orders, payments, deliveries, and addresses. An appropriate conceptual database design is required to represent these objects and their relationships clearly before converting the design into relational tables.

This experiment models the platform using standard ER notation and identifies the structural constraints required for an organized database design.

## 3. Entities Identified

The ER model contains the following entities:

- **Customer:** Stores customer details.
- **Address:** Represents customer or delivery addresses.
- **Product:** Stores common product information.
- **Category:** Classifies products into categories.
- **Seller:** Stores seller information.
- **Order:** Represents customer orders.
- **OrderItem:** Represents individual products included in an order.
- **Payment:** Records payment details.
- **Delivery:** Stores delivery and tracking information.
- **PhysicalProduct:** Represents products requiring physical delivery.
- **DigitalProduct:** Represents electronically delivered products.

## 4. Important ER Concepts

### Primary and Composite Keys

Primary keys uniquely identify entity records. The OrderItem weak entity is identified using the composite key `(OrderID, ProductID)`.

### Multivalued Attribute

`PhoneNumbers` represents a multivalued customer attribute because a customer may have multiple phone numbers.

### Weak Entity

OrderItem depends on its associated Order and Product for identification. Its composite key combines the identifying keys of these entities.

### Specialization

Product is specialized into PhysicalProduct and DigitalProduct. PhysicalProduct contains attributes such as weight and dimensions, whereas DigitalProduct contains file-related attributes.

### Relationships and Cardinalities

The diagram represents relationships between customers, addresses, orders, products, sellers, categories, payments, and deliveries. Cardinalities indicate how many instances of one entity can be associated with another.

Participation constraints specify whether participation in a relationship is mandatory or optional.

## 5. ER Diagram

![ER Diagram for an Indian E-Commerce Platform](images/er-diagram-ecommerce.png)

The diagram illustrates the entities, attributes, relationships, primary keys, weak entity notation, specialization, cardinalities, and participation constraints.

## 6. Design Considerations

- Entity identifiers should uniquely identify records.
- Multivalued attributes should be mapped to separate relations during relational conversion.
- Weak entities require an identifying relationship and an appropriate composite key.
- Specialization attributes should be separated from common Product attributes.
- Foreign-key relationships should preserve referential integrity in the relational schema.

## 7. Expected Outcome

A conceptual ER model representing the main data requirements of an Indian e-commerce platform, ready to be mapped into a relational database schema.

## 8. Conclusion

This experiment demonstrates how ER modeling translates real-world e-commerce requirements into a structured conceptual database design. It provides the foundation for relational schema mapping and SQL implementation in subsequent experiments.
