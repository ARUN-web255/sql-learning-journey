-- ============================================================
-- PROJECT: COMPANY_ASSESSMENT
-- Description: Employee & Project Management System
-- Covers: DDL, DML, Joins, Aggregations, Subqueries, CASE, TCL
-- ============================================================


-- 1. Create Database

CREATE DATABASE company_assessment;
USE company_assessment;


-- 2. Create Departments Table

CREATE TABLE departments (
    dept_id VARCHAR(5) PRIMARY KEY,
    dept_name VARCHAR(30) NOT NULL UNIQUE
);

INSERT INTO departments VALUES
('D101', 'IT'),
('D102', 'HR'),
('D103', 'Finance'),
('D104', 'Marketing'),
('D105', 'Operations');


-- 3. Create Employees Table

CREATE TABLE employees (
    emp_id VARCHAR(5) PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    age INT CHECK (age > 18),
    salary DECIMAL(10,2) DEFAULT 25000,
    dept_id VARCHAR(5),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO employees VALUES
('E001', 'Arun', 25, 45000, 'D101'),
('E002', 'Rahul', 29, 55000, 'D101'),
('E003', 'Priya', 32, 60000, 'D103'),
('E004', 'Karthik', 27, 35000, 'D104'),
('E005', 'Sneha', 31, 48000, 'D102'),
('E006', 'Vijay', 40, 75000, 'D101'),
('E007', 'Meena', 38, 52000, 'D103'),
('E008', 'Suresh', 45, 30000, 'D105'),
('E009', 'Divya', 26, 42000, 'D104'),
('E010', 'Ajay', 34, 65000, 'D105');


-- 4. Create Projects Table

CREATE TABLE projects (
    project_id VARCHAR(5) PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    emp_id VARCHAR(5),
    budget DECIMAL(10,2) CHECK (budget > 0),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO projects VALUES
('P001', 'AI Chatbot System', 'E001', 800000),
('P002', 'HR Automation Tool', 'E005', 450000),
('P003', 'Financial Dashboard', 'E003', 600000),
('P004', 'Marketing Campaign 2026', 'E004', 300000),
('P005', 'Operations Optimization', 'E010', 900000),
('P006', 'Cyber Security Upgrade', 'E006', 1200000);


-- 5. Basic Select Queries

SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM projects;


-- 6. Update and Delete Operations

-- 10% Salary Increment for IT Department
UPDATE employees
SET salary = salary + (salary * 0.10)
WHERE dept_id = 'D101';

-- Delete Employees Older Than 50
DELETE FROM employees
WHERE age > 50;


-- 7. Join Queries

-- Employee with Department Name
SELECT 
    e.emp_name AS employee_name,
    d.dept_name AS department_name
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;

-- High Budget Projects (Above 500000)
SELECT 
    p.project_name AS project_name,
    e.emp_name AS employee_name,
    p.budget AS project_budget
FROM projects p
INNER JOIN employees e
ON p.emp_id = e.emp_id
WHERE p.budget > 500000;


-- 8. Aggregate and Subqueries

-- Highest Salary
SELECT emp_name, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- Second Highest Salary
SELECT MAX(salary) AS second_highest_salary
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

-- Department Wise Employee Count
SELECT 
    d.dept_name AS department_name,
    COUNT(e.emp_id) AS no_of_employees
FROM departments d
INNER JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Departments with More Than 2 Employees
SELECT 
    d.dept_name AS department_name,
    COUNT(e.emp_id) AS no_of_employees
FROM departments d
INNER JOIN employees e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING COUNT(e.emp_id) > 2;


-- 9. Filtering Queries

SELECT * FROM employees
WHERE salary BETWEEN 30000 AND 60000;

SELECT * FROM employees
WHERE salary > 30000 AND salary < 60000;


-- 10. CASE Statement

SELECT 
    emp_name AS employee_name,
    salary AS salary_amount,
    CASE
        WHEN salary < 30000 THEN 'Low Salary'
        WHEN salary BETWEEN 30000 AND 60000 THEN 'Average Salary'
        ELSE 'High Salary'
    END AS salary_level
FROM employees;


-- 11. ALTER Table Operations

-- Rename salary to balance for transaction practice
ALTER TABLE employees
RENAME COLUMN salary TO balance;

-- Add CHECK Constraint
ALTER TABLE employees
MODIFY COLUMN balance DECIMAL(10,2) CHECK (balance > 0);

SELECT * FROM employees;


-- 12. Transaction Control (TCL)

-- Transaction 1: Salary Transfer
START TRANSACTION;

UPDATE employees
SET balance = balance - 50000
WHERE emp_name = 'Arun';

UPDATE employees
SET balance = balance + 50000
WHERE emp_name = 'Rahul';

COMMIT;


-- Transaction 2: Using Savepoint
START TRANSACTION;

UPDATE employees
SET balance = balance - 10000
WHERE emp_name = 'Arun';

SAVEPOINT processing;

UPDATE employees
SET balance = balance + 10000
WHERE emp_name = 'Rahul';

ROLLBACK TO processing;

COMMIT;


-- Transaction 3: Reverse Transfer
START TRANSACTION;

UPDATE employees
SET balance = balance - 10000
WHERE emp_name = 'Rahul';

SAVEPOINT processing;

UPDATE employees
SET balance = balance + 10000
WHERE emp_name = 'Arun';

COMMIT;
