-- MYSQL_TASK_1 PROJECT
-- Description: Employee Management System with Constraints, Joins, Views and Indexes


-- 1. Create Database

CREATE DATABASE MYSQL_TASK_1;
USE MYSQL_TASK_1;


-- 2. Create Departments Table

CREATE TABLE departments (
    dept_id VARCHAR(5) PRIMARY KEY,
    dept_name VARCHAR(30)
);

INSERT INTO departments VALUES
('D101', 'HR'),
('D102', 'Sales'),
('D103', 'IT'),
('D104', 'Finance'),
('D105', 'Marketing'),
('D106', 'Operations');


-- 3. Create Employees Table

CREATE TABLE employees (
    emp_id VARCHAR(5) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email_id VARCHAR(50),
    age INT,
    salary DECIMAL(10,2) CHECK (salary > 10000),
    dept_id VARCHAR(5),
    city VARCHAR(20),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


-- 4. Insert Employee Records

INSERT INTO employees VALUES
('E001', 'Arun', 'arun@gmail.com', 25, 45000.00, 'D101', 'Chennai'),
('E002', 'Rahul', 'rahul@gmail.com', 28, 55000.00, 'D102', 'Coimbatore'),
('E003', 'Priya', 'priya@gmail.com', 30, 60000.00, 'D103', 'Bangalore'),
('E004', 'Sneha', 'sneha@gmail.com', 26, 48000.00, 'D101', 'Madurai'),
('E005', 'Karthik', 'karthik@gmail.com', 32, 70000.00, 'D104', 'Hyderabad'),
('E006', 'Vijay', 'vijay@gmail.com', 29, 52000.00, 'D102', 'Chennai'),
('E007', 'Anitha', 'anitha@gmail.com', 27, 47000.00, 'D105', 'Salem'),
('E008', 'Ramesh', 'ramesh@gmail.com', 35, 80000.00, 'D103', 'Bangalore'),
('E009', 'Divya', 'divya@gmail.com', 31, 62000.00, 'D104', 'Coimbatore'),
('E010', 'Suresh', 'suresh@gmail.com', 24, 40000.00, 'D106', 'Chennai'),
('E011', 'Meena', 'meena@gmail.com', 29, 53000.00, 'D101', 'Trichy'),
('E012', 'Ajay', 'ajay@gmail.com', 33, 75000.00, 'D103', 'Hyderabad'),
('E013', 'Lakshmi', 'lakshmi@gmail.com', 28, 51000.00, 'D105', 'Madurai'),
('E014', 'Prakash', 'prakash@gmail.com', 36, 85000.00, 'D104', 'Bangalore'),
('E015', 'Naveen', 'naveen@gmail.com', 27, 49000.00, 'D102', 'Chennai'),
('E016', 'Swathi', 'swathi@gmail.com', 30, 61000.00, 'D106', 'Salem'),
('E017', 'Manoj', 'manoj@gmail.com', 34, 72000.00, 'D103', 'Coimbatore'),
('E018', 'Keerthi', 'keerthi@gmail.com', 26, 46000.00, 'D101', 'Hyderabad'),
('E019', 'Gokul', 'gokul@gmail.com', 31, 64000.00, 'D105', 'Trichy'),
('E020', 'Harini', 'harini@gmail.com', 29, 58000.00, 'D106', 'Bangalore');


-- 5. Salary Update (15% increment)

UPDATE employees
SET salary = salary + (salary * 15/100);


-- 6. Delete Employee Example

DELETE FROM employees
WHERE emp_id = 'E013';


-- 7. Create Orders Table

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    emp_id VARCHAR(5),
    order_amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);


-- 8. Insert Order Records

INSERT INTO orders VALUES
(1001, 'E001', 15000.00, '2026-01-05'),
(1002, 'E002', 22000.00, '2026-01-07'),
(1003, 'E003', 18000.00, '2026-01-10'),
(1004, 'E004', 12000.00, '2026-01-12'),
(1005, 'E005', 30000.00, '2026-01-15'),
(1006, 'E006', 25000.00, '2026-01-18'),
(1007, 'E007', 14000.00, '2026-01-20'),
(1008, 'E008', 35000.00, '2026-01-22'),
(1009, 'E009', 27000.00, '2026-01-25'),
(1010, 'E010', 10000.00, '2026-01-28');


-- 9. Basic Queries

SELECT * FROM employees;
SELECT name, salary FROM employees WHERE salary > 50000;
SELECT name FROM employees WHERE name LIKE 'S%';
SELECT * FROM employees ORDER BY city ASC, salary DESC;


-- 10. Aggregate Queries

SELECT city, COUNT(name) AS total_employees
FROM employees
GROUP BY city;

SELECT d.dept_name,
       SUM(e.salary) AS total_salary
FROM employees e
INNER JOIN departments d
ON d.dept_id = e.dept_id
GROUP BY d.dept_name;


-- 11. Join Queries

SELECT E.name, D.dept_name
FROM employees E
INNER JOIN departments D
ON E.dept_id = D.dept_id;

SELECT E.name, O.order_amount
FROM employees E
LEFT JOIN orders O
ON E.emp_id = O.emp_id;


-- 12. View Creation

CREATE VIEW emp_and_their_dept AS
SELECT e.name AS EMPLOYEE_NAME,
       d.dept_name AS DEPARTMENT_NAME
FROM employees e
INNER JOIN departments d
ON e.dept_id = d.dept_id;

DROP VIEW emp_and_their_dept;


-- 13. Index Creation

CREATE INDEX idx_employee_name ON employees (name);
CREATE INDEX idx_city_salary ON employees (city, salary);
