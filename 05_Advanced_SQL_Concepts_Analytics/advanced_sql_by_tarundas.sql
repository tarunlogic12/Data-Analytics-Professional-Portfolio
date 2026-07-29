-- ============================================================
-- ADVANCED SQL CONCEPTS & DATABASE OBJECTS SCRIPT
-- Author: Tarun Das
-- Repository: Data-Analytics-Professional-Portfolio
-- Module: 05_Advanced_SQL_Concepts_Analytics
-- ============================================================

CREATE DATABASE IF NOT EXISTS Advanced_SQL_DB;
USE Advanced_SQL_DB;

-- ------------------------------------------------------------
-- PART 1: THEORETICAL FOUNDATIONS (Q1 - Q5)
-- ------------------------------------------------------------

/*
Q1. What is a Common Table Expression (CTE), and how does it improve SQL query readability?
Answer:
A CTE is a temporary named result set created using the WITH clause. It exists only while the query is running.
How it helps readability:
- Breaks large, complex queries into simple, step-by-step parts.
- Avoids messy nested subqueries.
- Makes code easier to read, test, and maintain for team members.
*/

/*
Q2. Why are some views updatable while others are read-only? Explain with an example.
Answer:
A View is a saved SQL query. 
- Updatable View: Created from a single simple table without calculations or grouping. The database easily knows which exact row to update in the main table.
- Read-Only View: Created using formulas (AVG, SUM), GROUP BY, or multiple combined tables. The database cannot guess how to change underlying rows when summary data is edited.
Example:
- SELECT ProductID, Price FROM Products --> UPDATABLE (Simple columns)
- SELECT Category, AVG(Price) FROM Products GROUP BY Category --> READ-ONLY (Summary data)
*/

/*
Q3. What advantages do stored procedures offer compared to writing raw SQL queries repeatedly?
Answer:
1. Reusability: Write complex logic once and call it anytime using a simple name.
2. Faster Speed: Pre-compiled on the server, so it runs much faster than raw queries.
3. Security: Users can run the procedure without getting direct access to sensitive underlying tables.
4. Less Network Traffic: Sends one execution command instead of long SQL statements every time.
*/

/*
Q4. What is the purpose of triggers in a database? Mention one use case where a trigger is essential.
Answer:
A Trigger is an automatic action that runs whenever data is inserted, updated, or deleted in a table.
Essential Use Case: 
Automatic Backup / Audit Log. When someone deletes a record (e.g., a customer or product), a trigger automatically saves a copy into a hidden backup table with the exact deletion time.
*/

/*
Q5. Explain the need for data modelling and normalization when designing a database.
Answer:
- Data Modelling: Creates a clean blueprint of tables and how they connect to each other.
- Normalization: Organizing data into related tables to remove duplicate entries, save storage space, and prevent errors during data updates.
*/


-- ------------------------------------------------------------
-- PART 2: DATASET SETUP (FOR Q6 - Q10)
-- ------------------------------------------------------------

DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS ProductArchive;
DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 3500);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 4, '2024-01-05'),
(2, 1, 10, '2024-01-05'),
(3, 2, 7, '2024-01-10'),
(4, 4, 1, '2024-01-11');


-- ------------------------------------------------------------
-- PART 3: PRACTICAL IMPLEMENTATION (Q6 - Q10)
-- ------------------------------------------------------------

-- Q6: Write a CTE to calculate the total revenue for each product 
-- (Revenue = Price * Quantity), and return only products where revenue > 3000.
WITH ProductRevenueCTE AS (
    SELECT 
        p.ProductID,
        p.ProductName,
        SUM(p.Price * s.Quantity) AS TotalRevenue
    FROM Products p
    JOIN Sales s ON p.ProductID = s.ProductID
    GROUP BY p.ProductID, p.ProductName
)
SELECT 
    ProductID,
    ProductName,
    TotalRevenue
FROM ProductRevenueCTE
WHERE TotalRevenue > 3000;


-- Q7: Create a view named vw_CategorySummary that shows: 
-- Category, TotalProducts, AveragePrice.
CREATE OR REPLACE VIEW vw_CategorySummary AS
SELECT 
    Category,
    COUNT(ProductID) AS TotalProducts,
    AVG(Price) AS AveragePrice
FROM Products
GROUP BY Category;

-- Test View Q7
SELECT * FROM vw_CategorySummary;


-- Q8: Create an updatable view containing ProductID, ProductName, and Price.
-- Then update the price of ProductID = 1 using the view.
CREATE OR REPLACE VIEW vw_UpdatableProducts AS
SELECT 
    ProductID,
    ProductName,
    Price
FROM Products;

-- Update price via view
UPDATE vw_UpdatableProducts
SET Price = 1350.00
WHERE ProductID = 1;

-- Test Update Q8
SELECT * FROM Products WHERE ProductID = 1;


-- Q9: Create a stored procedure that accepts a category name and returns all products belonging to that category.
DELIMITER //

CREATE PROCEDURE GetProductsByCategory(IN input_category VARCHAR(50))
BEGIN
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price
    FROM Products
    WHERE Category = input_category;
END //

DELIMITER ;

-- Test Procedure Q9
CALL GetProductsByCategory('Electronics');


-- Q10: Create an AFTER DELETE trigger on the Products table that archives deleted product rows 
-- into a new table ProductArchive. The archive should store ProductID, ProductName, Category, Price, and DeletedAt timestamp.

-- Step 1: Create Archive Table
CREATE TABLE ProductArchive (
    ArchiveID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 2: Create AFTER DELETE Trigger
DELIMITER //

CREATE TRIGGER trg_AfterDeleteProduct
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive (ProductID, ProductName, Category, Price, DeletedAt)
    VALUES (OLD.ProductID, OLD.ProductName, OLD.Category, OLD.Price, NOW());
END //

DELIMITER ;