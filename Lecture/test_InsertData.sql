
-- Customer table
INSERT INTO store."Customer" ("CustomerID", "FirstName", "LastName", "Address", "City", "State", "Zip", "Phone") VALUES ('BLU003', 'AAAA', 'Katie', '342 Pine', 'Hammond', 'IN', '46200', '555-9242');

INSERT INTO store."Customer" ("CustomerID", "FirstName", "LastName", "Address", "City", "State", "Zip", "Phone") VALUES ('BLU001', 'Blum', 'Jessica', '229 State', 'Whiting', 'IN', '46300', '555-0921');

INSERT INTO store."Customer" ("CustomerID", "FirstName", "LastName", "Address", "City", "State", "Zip", "Phone") VALUES ('BLU005', 'Bbbbbbbb', 'Rich', '123 Main St.', 'Chicago', 'IL', '60633', '555-1234');

INSERT INTO store."Customer" ("CustomerID", "FirstName", "LastName", "Address", "City", "State", "Zip", "Phone") VALUES ('WIL001', 'Williams', 'Frank', '456 Oak St.', 'Hammond', 'IN', '46102', NULL);

-- Order table--
INSERT INTO store."Order" 
("ProductID", "OrderID", "CustomerID", "PurchaseDate", "Quantity", "TotalCost")
VALUES ('LAP001', 'ORD001',  'BLU001', '2012-08-21', 1, '$1.30');

INSERT INTO store."Order" 
("ProductID", "OrderID", "CustomerID", "PurchaseDate", "Quantity", "TotalCost")
VALUES ('LAP002', 'ODR002', 'BLU003', '2012-02-03', 2, '$2.00');

INSERT INTO store."Order" 
("ProductID", "OrderID", "CustomerID", "PurchaseDate", "Quantity", "TotalCost")
VALUES ('LAP001', 'ORD003', 'WIL001', '2012-06-06', 1, '$1.30');

-- Product table
INSERT INTO store."Product"("ProductID", "ProductName", "Model", "Manufacturer", "UnitPrice", "Inventory") VALUES ('LAP001', 'Vaio CR31Z', 'CR', 'Sony Vaio', '$1.30', 5);

INSERT INTO store."Product"("ProductID", "ProductName", "Model", "Manufacturer", "UnitPrice", "Inventory") VALUES ('LAP002', 'HP AZE', 'HP', NULL, '$1.00', 18);

INSERT INTO store."Product"("ProductID", "ProductName", "Model", "Manufacturer", "UnitPrice", "Inventory") VALUES ('LAP003', 'HP 34', 'HP', 'HP', '$1,000.00', 200);
