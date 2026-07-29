 -- ============================================================================
-- SQL SUBQUERIES SOLUTION & CASE STUDY
-- Student Name: Tarun Das
-- Course: Data Analytics with Generative AI
-- Subject: 15 Daily Practice Problems (DPP) on Subqueries
-- Database Engine: MySQL
-- ============================================================================

-- ----------------------------------------------------------------------------
-- STEP 1: DATABASE & SCHEMA SETUP
-- ----------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS Subquery_Assign;
USE Subquery_Assign;

-- Drop tables if they already exist to ensure a clean setup
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

-- Create Department Table
CREATE TABLE Department (
    department_id VARCHAR(10) PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);

-- Create Employee Table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    department_id VARCHAR(10),
    salary DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- Create Sales Table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    emp_id INT,
    sale_amount DECIMAL(10, 2) NOT NULL,
    sale_date DATE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);


-- ----------------------------------------------------------------------------
-- STEP 2: INSERT DATASETS
-- ----------------------------------------------------------------------------

-- Populate Department Table
INSERT INTO Department (department_id, department_name, location) VALUES
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bengaluru'),
('D05', 'IT', 'Hyderabad');

-- Populate Employee Table
INSERT INTO Employee (emp_id, name, department_id, salary) VALUES
(101, 'Abhishek', 'D01', 62000.00),
(102, 'Shubham', 'D01', 58000.00),
(103, 'Priya', 'D02', 67000.00),
(104, 'Sahil', 'D02', 54000.00),
(105, 'Neha', 'D03', 72000.00),
(106, 'Aman', 'D03', 88000.00),
(107, 'Ravi', 'D04', 50000.00),
(108, 'Sneha', 'D04', 75000.00),
(109, 'Karan', 'D05', 78000.00),
(110, 'Tanuja', 'D05', 65000.00);

-- Populate Sales Table
INSERT INTO Sales (sale_id, emp_id, sale_amount, sale_date) VALUES
(201, 101, 4500.00, '2025-01-05'),
(202, 102, 7800.00, '2025-01-10'),
(203, 103, 3700.00, '2025-01-14'),
(204, 104, 12000.00, '2025-01-20'),
(205, 105, 9000.00, '2025-02-02'),
(206, 106, 10500.00, '2025-02-05'),
(207, 107, 2500.00, '2025-02-08'),
(208, 108, 11000.00, '2025-02-15'),
(209, 109, 3000.00, '2025-02-22'),
(210, 110, 7200.00, '2025-03-01');


-- ============================================================================
-- SECTION 1: BASIC LEVEL SUBQUERIES
-- ============================================================================

-- Q1: Retrieve the names of employees who earn more than the average salary of all employees.
-- Business Use Case: HR audit to identify high-earning workforce exceeding the company baseline.
SELECT name, salary 
FROM Employee 
WHERE salary > (
    SELECT AVG(salary) 
    FROM Employee
);

-- Q2: Find the employees who belong to the department with the highest average salary.
-- Business Use Case: Executive compensation audit to locate top-tier salary departments.
SELECT name, department_id, salary 
FROM Employee 
WHERE department_id = (
    SELECT department_id 
    FROM Employee 
    GROUP BY department_id 
    ORDER BY AVG(salary) DESC 
    LIMIT 1
);

-- Q3: List all employees who have made at least one sale.
-- Business Use Case: Revenue contribution tracking for active sales reps.
SELECT emp_id, name 
FROM Employee 
WHERE emp_id IN (
    SELECT DISTINCT emp_id 
    FROM Sales
);

-- Q4: Find the employee with the highest sale amount.
-- Business Use Case: Top sales performer recognition for peak deal closure.
SELECT emp_id, name 
FROM Employee 
WHERE emp_id IN (
    SELECT emp_id 
    FROM Sales 
    WHERE sale_amount = (
        SELECT MAX(sale_amount) 
        FROM Sales
    )
);

-- Q5: Retrieve the names of employees whose salaries are higher than Shubham's salary.
-- Business Use Case: Peer-to-peer salary benchmarking against a baseline team member.
SELECT name, salary 
FROM Employee 
WHERE salary > (
    SELECT salary 
    FROM Employee 
    WHERE name = 'Shubham'
);


-- ============================================================================
-- SECTION 2: INTERMEDIATE LEVEL SUBQUERIES
-- ============================================================================

-- Q6: Find employees who work in the same department as Abhishek.
-- Business Use Case: Organizational intradepartmental team mapping.
SELECT name, department_id 
FROM Employee 
WHERE department_id = (
    SELECT department_id 
    FROM Employee 
    WHERE name = 'Abhishek'
) 
AND name <> 'Abhishek';

-- Q7: List departments that have at least one employee earning more than 50,000.
-- Business Use Case: High-pay-grade department auditing.
SELECT department_id, department_name 
FROM Department 
WHERE department_id IN (
    SELECT DISTINCT department_id 
    FROM Employee 
    WHERE salary > 50000
);

-- Q8: Find the department name of the employee who made the highest sale.
-- Business Use Case: Identifying top-performing revenue-generating business unit.
SELECT department_name 
FROM Department 
WHERE department_id IN (
    SELECT department_id 
    FROM Employee 
    WHERE emp_id IN (
        SELECT emp_id 
        FROM Sales 
        WHERE sale_amount = (
            SELECT MAX(sale_amount) 
            FROM Sales
        )
    )
);

-- Q9: Retrieve employees who have made sales greater than the average sale amount.
-- Business Use Case: Identifying outperforming sales agents above company deal average.
SELECT emp_id, name 
FROM Employee 
WHERE emp_id IN (
    SELECT DISTINCT emp_id 
    FROM Sales 
    WHERE sale_amount > (
        SELECT AVG(sale_amount) 
        FROM Sales
    )
);

-- Q10: Find the total sales made by employees who earn more than the average salary.
-- Business Use Case: Measuring ROI and sales productivity of high-salary employees.
SELECT SUM(sale_amount) AS total_sales_high_earners
FROM Sales 
WHERE emp_id IN (
    SELECT emp_id 
    FROM Employee 
    WHERE salary > (
        SELECT AVG(salary) 
        FROM Employee
    )
);


-- ============================================================================
-- SECTION 3: ADVANCED LEVEL SUBQUERIES
-- ============================================================================

-- Q11: Find employees who have not made any sales.
-- Business Use Case: Non-performing asset detection using NULL-safe NOT EXISTS logic.
SELECT emp_id, name 
FROM Employee e
WHERE NOT EXISTS (
    SELECT 1 
    FROM Sales s 
    WHERE s.emp_id = e.emp_id
);

-- Q12: List departments where the average salary is above 55,000.
-- Business Use Case: Financial budgeting audit for high-overhead departments.
SELECT department_id, department_name 
FROM Department 
WHERE department_id IN (
    SELECT department_id 
    FROM Employee 
    GROUP BY department_id 
    HAVING AVG(salary) > 55000
);

-- Q13: Retrieve department names where the total sales exceed 10,000.
-- Business Use Case: Identifying high-revenue departmental business units.
SELECT department_name 
FROM Department 
WHERE department_id IN (
    SELECT e.department_id 
    FROM Employee e
    JOIN Sales s ON e.emp_id = s.emp_id
    GROUP BY e.department_id 
    HAVING SUM(s.sale_amount) > 10000
);

-- Q14: Find the employee who has made the second-highest sale.
-- Business Use Case: Talent incentive modeling for runner-up deal identification.
SELECT emp_id, name 
FROM Employee 
WHERE emp_id IN (
    SELECT emp_id 
    FROM Sales 
    WHERE sale_amount = (
        SELECT DISTINCT sale_amount 
        FROM Sales 
        ORDER BY sale_amount DESC 
        LIMIT 1 OFFSET 1
    )
);

-- Q15: Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
-- Business Use Case: Cost vs revenue yield analysis comparing base pay against peak deal value.
SELECT name, salary 
FROM Employee 
WHERE salary > (
    SELECT MAX(sale_amount) 
    FROM Sales
);