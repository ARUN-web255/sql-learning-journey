-- SARAVANA_STORE DATABASE PROJECT
-- Description: Table Creation, Normalization and Query Practice


-- 1. Create database and select it.

CREATE DATABASE Saravana_store;
USE Saravana_store;


-- 2. Create initial Sales_Info table (Denormalized Structure).

CREATE TABLE Sales_Info (
    Product_ID SMALLINT,
    Product_Name VARCHAR(50),
    Product_Price DECIMAL(10,2),
    Customer_ID INT,
    Customer_Name VARCHAR(50),
    Customer_EMAILID VARCHAR(100),
    Customer_Mobile_no VARCHAR(15),
    Sales_Rep_id SMALLINT,
    Sales_Rep_Name VARCHAR(15),
    Sales_Rep_Mobile_no VARCHAR(15),
    Order_ID VARCHAR(5),
    Order_Date DATE
);


-- 3. Modify column datatypes.

ALTER TABLE Sales_Info MODIFY COLUMN Product_ID INT;
ALTER TABLE Sales_Info MODIFY COLUMN Sales_Rep_id INT;


-- 4. Insert sales records.

INSERT INTO Sales_Info VALUES 
(101,'Shirt',400.00,1002,'ram','ram@gmail.com','+91 9288880000',2,'Jagan','+91 9110300488','Q1','2026-01-13'),
(100,'T-Shirt',300.00,1002,'ram','ram@gmail.com','+91 9288880000',2,'Jagan','+91 9110300488','Q2','2026-01-13'),
(108,'Shirt',400.00,1002,'ram','ram@gmail.com','+91 9288880000',2,'Jagan','+91 9110300488','Q3','2026-01-20'),
(100,'T-Shirt',300.00,1002,'ram','ram@gmail.com','+91 9288880000',2,'Jagan','+91 9110300488','Q4','2026-01-21'),
(110,'Jeans',800.00,1003,'Suresh','suresh@gmail.com','+91 9876543210',3,'Mani','+91 9000001234','Q5','2026-01-22'),
(111,'Cap',150.00,1004,'Arun','arun@gmail.com','+91 9123456789',1,'Ravi','+91 9012345678','Q6','2026-01-23'),
(112,'Shoes',1200.00,1005,'Karthik','karthik@gmail.com','+91 9988776655',4,'Vijay','+91 9090909090','Q7','2026-01-24'),
(113,'Jacket',1500.00,1006,'Dinesh','dinesh@gmail.com','+91 9345678123',2,'Jagan','+91 9110300488','Q8','2026-01-25'),
(114,'Belt',250.00,1007,'Prakash','prakash@gmail.com','+91 9765432109',3,'Mani','+91 9000001234','Q9','2026-01-26'),
(115,'Watch',2200.00,1008,'Santhosh','santhosh@gmail.com','+91 9871234560',1,'Ravi','+91 9012345678','Q10','2026-01-27'),
(108,'Shirt',400.00,1002,'ram','ram@gmail.com','+91 9288880000',2,'Jagan','+91 9110300488','Q11','2026-01-28'),
(111,'Cap',150.00,1004,'Arun','arun@gmail.com','+91 9123456789',1,'Ravi','+91 9012345678','Q12','2026-01-23'),
(110,'Jeans',800.00,1009,'Kumar','kumar@gmail.com','+91 9555667788',3,'Mani','+91 9000001234','Q13','2026-01-29'),
(116,'Socks',100.00,1010,'Vikram','vikram@gmail.com','+91 9445566778',2,'Jagan','+91 9110300488','Q14','2026-01-30'),
(117,'Tie',350.00,1011,'Ajith','ajith@gmail.com','+91 9334455667',2,'Jagan','+91 9110300488','Q15','2026-01-31'),
(118,'Blazer',2500.00,1012,'Hari','hari@gmail.com','+91 9223344556',4,'Vijay','+91 9090909090','Q16','2026-02-01'),
(119,'Sweater',900.00,1013,'Ramesh','ramesh@gmail.com','+91 9112233445',3,'Mani','+91 9000001234','Q17','2026-02-02'),
(115,'Watch',2200.00,1014,'Lokesh','lokesh@gmail.com','+91 9001122334',1,'Ravi','+91 9012345678','Q18','2026-02-03'),
(101,'Shirt',400.00,1002,'ram','ram@gmail.com','+91 9288880000',2,'Jagan','+91 9110300488','Q19','2026-02-04'),
(120,'Wallet',600.00,1015,'Naveen','naveen@gmail.com','+91 9887766554',4,'Vijay','+91 9090909090','Q20','2026-02-05'),
(110,'Jeans',800.00,1003,'Suresh','suresh@gmail.com','+91 9876543210',3,'Mani','+91 9000001234','Q21','2026-02-06');


-- 5. Basic verification queries.

SELECT * FROM Sales_Info;
SELECT * FROM Sales_Info WHERE Product_Price > 300;
SELECT * FROM Sales_Info WHERE Product_Price % 2 = 0;


-- 6. Update example.

UPDATE Sales_Info
SET Customer_EMAILID = 'suresh007@gmail.com'
WHERE Customer_ID = 1003;


-- 7. Create Customer_info table.

CREATE TABLE Customer_info (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(50),
    Customer_EMAILID VARCHAR(100),
    Customer_Mobile_no VARCHAR(15)
);


-- 8. Insert distinct customers.

INSERT INTO Customer_info
SELECT DISTINCT Customer_ID, Customer_Name, Customer_EMAILID, Customer_Mobile_no
FROM Sales_Info;


-- 9. Create Product_info table.

CREATE TABLE Product_info (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Product_Price DECIMAL(10,2)
);


-- 10. Insert distinct products.

INSERT INTO Product_info
SELECT DISTINCT Product_ID, Product_Name, Product_Price
FROM Sales_Info;


-- 11. Create Sales_Rep table.

CREATE TABLE Sales_Rep(
    Sales_Rep_id INT PRIMARY KEY,
    Sales_Rep_Name VARCHAR(50),
    Sales_Rep_Mobile_no VARCHAR(15)
);


-- 12. Insert distinct sales representatives.

INSERT INTO Sales_Rep
SELECT DISTINCT Sales_Rep_id, Sales_Rep_Name, Sales_Rep_Mobile_no
FROM Sales_Info;


-- 13. Create Orders_Info table.

CREATE TABLE Orders_Info (
    Order_ID VARCHAR(5) PRIMARY KEY,
    Order_Date DATE
);


-- 14. Insert distinct orders.

INSERT INTO Orders_Info
SELECT DISTINCT Order_ID, Order_Date
FROM Sales_Info;


-- 15. Drop redundant columns (Normalization Step).

ALTER TABLE Sales_Info
DROP COLUMN Product_Name,
DROP COLUMN Product_Price,
DROP COLUMN Customer_Name,
DROP COLUMN Customer_EMAILID,
DROP COLUMN Customer_Mobile_no,
DROP COLUMN Sales_Rep_Name,
DROP COLUMN Sales_Rep_Mobile_no,
DROP COLUMN Order_Date;


-- 16. Add foreign key constraints.

ALTER TABLE Sales_Info
ADD CONSTRAINT fk_product FOREIGN KEY (Product_ID) REFERENCES Product_Info(Product_ID);

ALTER TABLE Sales_Info
ADD CONSTRAINT fk_customer FOREIGN KEY (Customer_ID) REFERENCES Customer_Info(Customer_ID);

ALTER TABLE Sales_Info
ADD CONSTRAINT fk_sales FOREIGN KEY (Sales_Rep_id) REFERENCES Sales_Rep(Sales_Rep_id);

ALTER TABLE Sales_Info
ADD CONSTRAINT fk_order FOREIGN KEY (Order_ID) REFERENCES Orders_Info(Order_ID);


-- 17. Join example.

SELECT S.Customer_ID,
       C.Customer_Name,
       C.Customer_EMAILID
FROM Sales_Info S
LEFT JOIN Customer_info C
ON S.Customer_ID = C.Customer_ID;


-- 18. Analytical queries.

SELECT Product_ID AS P_ID,
       Product_Name AS P_NAME,
       Product_Price AS P_PRICE
FROM Product_info
ORDER BY Product_Price DESC;

SELECT Product_Name,
       SUM(Product_Price) AS Total_Price
FROM Product_info
WHERE Product_Name LIKE '%S'
   OR Product_Name LIKE '%T'
GROUP BY Product_Name
ORDER BY SUM(Product_Price) DESC;

SELECT Order_ID AS O_ID,
       Order_Date AS O_DATE
FROM Orders_Info
ORDER BY Order_Date ASC;
