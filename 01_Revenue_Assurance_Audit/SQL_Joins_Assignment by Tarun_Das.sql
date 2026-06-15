-- =========================================================
-- PW SKILLS - SQL JOINS ASSIGNMENT
-- Student Name: Tarun das
-- =========================================================

-- STEP 1: Database Create aur Use karna
CREATE DATABASE IF NOT EXISTS pwskills_assignment;
USE pwskills_assignment;

-- STEP 2: Tables Create karna (Schema Setup)
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    Amount INT
);

CREATE TABLE Payments (
    PaymentID VARCHAR(10) PRIMARY KEY,
    CustomerID INT,
    PaymentDate DATE,
    Amount INT
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    ManagerID INT
);

-- STEP 3: Tables me Dummy Data Insert karna
INSERT INTO Customers VALUES 
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Nancy Miller', 'Houston'),
(5, 'Robert White', 'Miami');

INSERT INTO Orders VALUES 
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 6, '2024-10-12', 400);

INSERT INTO Payments VALUES 
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);

INSERT INTO Employees VALUES 
(1, 'Alex Green', NULL),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'David Kim', 2),
(5, 'Eva Smith', 2);


-- =========================================================
-- ASSIGNMENT QUESTIONS & SOLUTIONS
-- =========================================================

-- Question 1. Retrieve all customers who have placed at least one order.
SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID;


-- Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.
SELECT c.CustomerID, c.CustomerName, c.City, o.OrderID, o.OrderDate, o.Amount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID;


-- Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.
SELECT o.OrderID, o.OrderDate, o.Amount, o.CustomerID AS Order_CustomerID, c.CustomerName, c.City
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;


-- Question 4. Display all customers and orders, whether matched or not.
-- Note: MySQL me FULL OUTER JOIN directly support nahi hota, isliye humne LEFT aur RIGHT JOIN ko UNION kiya hai.
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.Amount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
UNION
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.Amount
FROM Customers c
RIGHT JOIN Orders o ON c.CustomerID = o.CustomerID;


-- Question 5. Find customers who have not placed any orders.
SELECT c.CustomerID, c.CustomerName, c.City
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- Question 6. Retrieve customers who made payments but did not place any orders.
SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Payments p ON c.CustomerID = p.CustomerID
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;


-- Question 7. Generate a list of all possible combinations between Customers and Orders.
SELECT c.CustomerID, c.CustomerName, o.OrderID, o.Amount
FROM Customers c
CROSS JOIN Orders o;


-- Question 8. Show all customers along with order and payment amounts in one table.
SELECT 
    c.CustomerID, 
    c.CustomerName, 
    o.OrderID, 
    o.Amount AS Order_Amount, 
    p.PaymentID, 
    p.Amount AS Payment_Amount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN Payments p ON c.CustomerID = p.CustomerID;


-- Question 9. Retrieve all customers who have both placed orders and made payments.
SELECT DISTINCT c.CustomerID, c.CustomerName, c.City
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN Payments p ON c.CustomerID = p.CustomerID;