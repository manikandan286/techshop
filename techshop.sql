CREATE DATABASE techshop_hexaware;
USE techshop_hexaware;
SHOW DATABASES;

-- Table to store customer details
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each customer
    FirstName VARCHAR(50) NOT NULL,  -- First name (Required)
    LastName VARCHAR(50) NOT NULL,  -- Last name (Required)
    Email VARCHAR(100) UNIQUE NOT NULL,  -- Email (Must be unique and required)
    Phone VARCHAR(15),  -- Optional phone number
    Address TEXT  -- Address details
);

-- Table to store product details
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each product
    ProductName VARCHAR(100) NOT NULL,  -- Product name (Required)
    Description TEXT,  -- Description of the product
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0)  -- Price must be greater than zero
);

-- Table to store order details
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique order ID
    CustomerID INT,  -- Reference to the customer who placed the order
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,  -- Timestamp of order creation
    TotalAmount DECIMAL(10,2) NOT NULL CHECK (TotalAmount >= 0),  -- Order total (Non-negative)
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE  -- Links to Customers table
);

-- Table to store detailed order breakdown
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each order detail
    OrderID INT,  -- Reference to the order
    ProductID INT,  -- Reference to the product
    Quantity INT NOT NULL CHECK (Quantity > 0),  -- Product quantity must be positive
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,  -- Links to Orders table
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE  -- Links to Products table
);

-- Table to manage inventory stock
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique inventory ID
    ProductID INT UNIQUE,  -- Links to a product (one-to-one mapping)
    QuantityInStock INT NOT NULL CHECK (QuantityInStock >= 0),  -- Stock cannot be negative
    LastStockUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  -- Tracks the last update
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE  -- Links to Products table
);


-- Insert into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('LOGANATH', 'R', 'loganath.r@hexaware.com', '9876543210', 'Chennai, India'),
('LOKESH KANNAN', 'J', 'lokeshkannan.j@hexaware.com', '9876543211', 'Bangalore, India'),
('LUKESH RAJARAMAN', 'D', 'lukeshrajaraman.d@hexaware.com', '9876543212', 'Hyderabad, India'),
('MAHAJAN', 'S', 'mahajan.s@hexaware.com', '9876543213', 'Mumbai, India'),
('MANIGANDAA', 'C S', 'manigandaa.cs@hexaware.com', '9876543214', 'Pune, India'),
('MANIKANDAN', 'V', 'manikandan.v@hexaware.com', '9876543215', 'Tirupathur, India'),
('MATHAN RAJ KUMAR', 'M', 'mathanrajkumar.m@hexaware.com', '9876543216', 'Kolkata, India'),
('MATHANKUMAR', 'K', 'mathankumar.k@hexaware.com', '9876543217', 'Coimbatore, India'),
('MOHAMED ARSHAD', 'M', 'mohamedarshad.m@hexaware.com', '9876543218', 'Delhi, India'),
('DINESH', 'S', 'dinesh.s@hexaware.com', '9876543219', 'Madurai, India');

select * from Customers;


-- Insert into Products
INSERT INTO Products (ProductName, Description, Price) VALUES
('Laptop', 'High-performance laptop', 75000.00),
('Smartphone', 'Latest 5G smartphone', 50000.00),
('Headphones', 'Noise-canceling headphones', 8000.00),
('Smartwatch', 'Fitness and health tracking smartwatch', 15000.00),
('Tablet', 'Portable tablet with stylus', 30000.00),
('Keyboard', 'Mechanical gaming keyboard', 5000.00),
('Mouse', 'Wireless ergonomic mouse', 3000.00),
('Monitor', '4K ultra HD monitor', 35000.00),
('External SSD', '1TB portable SSD', 12000.00),
('Smart Speaker', 'AI-powered smart speaker', 7000.00);

select * from Products;



-- Insert into Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-03-01 10:30:00', 75000.00),
(2, '2024-03-02 12:45:00', 50000.00),
(3, '2024-03-03 14:00:00', 8000.00),
(4, '2024-03-04 16:30:00', 15000.00),
(5, '2024-03-05 18:15:00', 30000.00),
(6, '2024-03-06 19:45:00', 5000.00),
(7, '2024-03-07 09:20:00', 3000.00),
(8, '2024-03-08 11:10:00', 35000.00),
(9, '2024-03-09 13:50:00', 12000.00),
(10, '2024-03-10 15:30:00', 7000.00);

select * from Orders;

-- Insert into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 1),
(5, 5, 1),
(6, 6, 2),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1);

select * from OrderDetails;

-- Insert into Inventory
INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate) VALUES
(1, 50, NOW()),
(2, 30, NOW()),
(3, 40, NOW()),
(4, 25, NOW()),
(5, 20, NOW()),
(6, 35, NOW()),
(7, 60, NOW()),
(8, 15, NOW()),
(9, 45, NOW()),
(10, 10, NOW());

select * from Inventory;

-- 1.	Write an SQL query to retrieve the names and emails of all customers.
SELECT FirstName, LastName, Email 
FROM Customers;
-- 2.	Write an SQL query to list all orders with their order dates and corresponding customer names.
SELECT 
    Orders.OrderID, 
    Orders.OrderDate, 
    Customers.FirstName, 
    Customers.LastName 
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
select * from Orders;

-- 3. Write an SQL query to insert a new customer record into the "Customers" table. Include customer information such as name, email, and address.
DELETE FROM Customers WHERE Email = 'loganath.r@hexaware.com';
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)  
VALUES ('Loganath', 'R', 'loganath.r@hexaware.com', '9876543210', 'No.10, Gandhi Street, Chennai, India');
select * from Customers;

 -- 4.Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
UPDATE Products
SET Price = Price * 1.10
WHERE ProductName LIKE '%Electronic%' OR Description LIKE '%electronic%';
select * from Products;

-- 5.	Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
SET @INPUT=100;
DELETE FROM OrderDetails 
WHERE OrderID = @INPUT;
select * from OrderDetails;

DELETE FROM Orders 
WHERE OrderID = @INPUT; 
select * from Orders;
-- 6.	Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information.

SET @CustomerID = 1;  
SET @OrderDate = NOW();
SET @TotalAmount = 500.00;

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)  
VALUES (@CustomerID, @OrderDate, @TotalAmount);
select * from Orders;

-- 7. Write an SQL query to update the contact information (e.g., email and address) of a specific customer in the "Customers" table. Allow users to input the customer ID and new contact information.
SET @CustomerID = 1;  -- Replace with the actual Customer ID
SET @NewEmail = 'new.email@hexaware.com';  -- Replace with the new email
SET @NewAddress = '123 New Street, Chennai, India';  -- Replace with the new address

UPDATE Customers
SET Email = @NewEmail, Address = @NewAddress
WHERE CustomerID = @CustomerID;
select * from Customers;

-- 8.Write an SQL query to recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
UPDATE Orders o
SET TotalAmount = (
    SELECT SUM(od.Quantity * p.Price)
    FROM OrderDetails od
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE od.OrderID = o.OrderID
);
select * from orders;
-- 9.	Write an SQL query to delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter


DELETE od FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.CustomerID = 123; 
SELECT * FROM Orderdetails;
 

DELETE FROM Orders WHERE CustomerID = 123; 
SELECT * FROM orders;


-- 10.	Write an SQL query to insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.

INSERT INTO Products (ProductName, Description, Price)  
VALUES ('Smartphone X10', 'Electronic gadget - 128GB, 5G, AI Camera', 499.99);
SELECT * FROM Products;
-- 11.	Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
ALTER TABLE Orders ADD COLUMN Status VARCHAR(20) DEFAULT 'Pending';
select * from Orders;

-- 12.	Write an SQL query to calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
ALTER TABLE Customers ADD COLUMN OrderCount INT DEFAULT 0;
select * from Customers;

UPDATE Customers c
SET OrderCount = (
    SELECT COUNT(*)
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
);
select * from Customers;

-- Task 3. Aggregate functions, Having, Order By, GroupBy and Joins:
-- 1.	Write an SQL query to retrieve a list of all orders along with customer information (e.g., customer name) for each order.
SELECT o.OrderID, c.FirstName, c.LastName, c.Email, o.OrderDate, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 2.	Write an SQL query to find the total revenue generated by each electronic gadget product. Include the product name and the total revenue
SELECT p.ProductName, SUM(od.Quantity * p.Price) AS TotalRevenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Description LIKE '%electronic%' OR p.ProductName LIKE '%Electronic%'
GROUP BY p.ProductID;
-- 3.	Write an SQL query to list all customers who have made at least one purchase. Include their names and contact information.

SELECT DISTINCT c.FirstName, c.LastName, c.Email, c.Phone, c.Address
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 4.	Write an SQL query to find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
SELECT p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Description LIKE '%electronic%' OR p.ProductName LIKE '%Electronic%'
GROUP BY p.ProductID
ORDER BY TotalQuantityOrdered DESC
LIMIT 1;

-- 5.	Write an SQL query to retrieve a list of electronic gadgets along with their corresponding categories.
SELECT ProductName, Description  
FROM Products  
WHERE Description LIKE '%electronic%';

-- 6.	Write an SQL query to calculate the average order value for each customer. Include the customer's name and their average order value.
SELECT c.FirstName, c.LastName, AVG(o.TotalAmount) AS AvgOrderValue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID;

-- 7.	Write an SQL query to find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
SELECT o.OrderID, c.FirstName, c.LastName, c.Email, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY o.TotalAmount DESC
LIMIT 1;


-- 8.	Write an SQL query to list electronic gadgets and the number of times each product has been ordered.
SELECT p.ProductName, COUNT(od.OrderDetailID) AS TimesOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Description LIKE '%electronic%' OR p.ProductName LIKE '%Electronic%'
GROUP BY p.ProductID
ORDER BY TimesOrdered DESC;

-- 9.	Write an SQL query to find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.
SELECT DISTINCT c.FirstName, c.LastName, c.Email, c.Phone  
FROM Customers c  
JOIN Orders o ON c.CustomerID = o.CustomerID  
JOIN OrderDetails od ON o.OrderID = od.OrderID  
JOIN Products p ON od.ProductID = p.ProductID  
WHERE p.ProductName = 'Your Product Name';

-- 10.	Write an SQL query to calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters.
SELECT SUM(o.TotalAmount) AS TotalRevenue  
FROM Orders o  
WHERE o.OrderDate BETWEEN '2024-01-01' AND '2024-12-31';

-- Task 4. Subquery and its type:
-- 1.	Write an SQL query to find out which customers have not placed any orders.

-- 2.	Write an SQL query to find the total number of products available for sale.
SELECT FirstName, LastName, Email 
FROM Customers 
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

-- 3.	Write an SQL query to calculate the total revenue generated by TechShop.
SELECT SUM(od.Quantity * p.Price) AS TotalRevenue 
FROM OrderDetails od 
JOIN Products p ON od.ProductID = p.ProductID;

-- 4.	Write an SQL query to calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.
DESC Products;
ALTER TABLE Products ADD COLUMN Category VARCHAR(255);
select *  from products;

-- 5.	Write an SQL query to calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
SELECT SUM(od.Quantity * p.Price) AS TotalRevenue  
FROM Orders o  
JOIN OrderDetails od ON o.OrderID = od.OrderID  
JOIN Products p ON od.ProductID = p.ProductID  
WHERE o.CustomerID = 123; 

-- 6.	Write an SQL query to find the customers who have placed the most orders. List their names and the number of orders they've placed.
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
GROUP BY c.CustomerID 
ORDER BY OrderCount DESC 
LIMIT 1;

-- 7.	Write an SQL query to find the most popular product category, which is the one with the highest total quantity ordered across all orders.
SELECT p.Category, SUM(od.Quantity) AS TotalOrdered 
FROM OrderDetails od 
JOIN Products p ON od.ProductID = p.ProductID 
GROUP BY p.Category 
ORDER BY TotalOrdered DESC 
LIMIT 1;

-- 8.	Write an SQL query to find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.
SELECT c.FirstName, c.LastName, SUM(od.Quantity * p.Price) AS TotalSpent 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN OrderDetails od ON o.OrderID = od.OrderID 
JOIN Products p ON od.ProductID = p.ProductID 
WHERE p.Category LIKE '%Electronic%' 
GROUP BY c.CustomerID 
ORDER BY TotalSpent DESC 
LIMIT 1;

-- 9.	Write an SQL query to calculate the average order value (total revenue divided by the number of orders) for all customers.
SELECT (SUM(od.Quantity * p.Price) / COUNT(DISTINCT o.OrderID)) AS AverageOrderValue 
FROM Orders o 
JOIN OrderDetails od ON o.OrderID = od.OrderID 
JOIN Products p ON od.ProductID = p.ProductID;

-- 10. Write an SQL query to find the total number of orders placed by each customer and list their names along with the order count.
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS OrderCount 
FROM Customers c 
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID 
GROUP BY c.CustomerID;


























