CREATE DATABASE Saravana_store;
USE Saravana_store;

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

ALTER TABLE Sales_Info MODIFY COLUMN Product_ID INT;
ALTER TABLE Sales_Info MODIFY COLUMN Sales_Rep_id INT;
ALTER TABLE Sales_Info
DROP COLUMN Product_Name,
DROP COLUMN Product_Price,
DROP COLUMN Customer_Name,
DROP COLUMN Customer_EMAILID,
DROP COLUMN Customer_Mobile_no,
DROP COLUMN Sales_Rep_Name,
DROP COLUMN Sales_Rep_Mobile_no,
DROP COLUMN Order_Date;

ALTER TABLE Sales_Info ADD CONSTRAINT fk_product FOREIGN KEY (Product_ID) REFERENCES Product_Info(Product_ID);
ALTER TABLE Sales_Info ADD CONSTRAINT fk_customer FOREIGN KEY (Customer_ID) REFERENCES Customer_Info(Customer_ID);
ALTER TABLE Sales_Info ADD CONSTRAINT fk_sales FOREIGN KEY (Sales_Rep_id) REFERENCES Sales_Rep(Sales_Rep_id);


ALTER TABLE Sales_Info ADD CONSTRAINT fk_Order FOREIGN KEY (Order_ID) REFERENCES Orders_Info(Order_ID);

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
SELECT * FROM Sales_Info  ;
SELECT * FROM Sales_Info where Product_Price > 300;
UPDATE Sales_info set Customer_EMAILID = 'suresh007@gmail.com' where Customer_ID = 1003 ;
insert into Sales_Info values (
CREATE TABLE Customer_info (
Customer_ID INT UNIQUE,
Customer_Name VARCHAR(50),
Customer_EMAILID VARCHAR(100),
Customer_Mobile_no VARCHAR(15)
);
SELECT  Customer_Name , sum(Product_Price) as total_amount FROM Sales_Info 
GROUP BY Customer_Name;
SELECT Customer_Name , COUNT(Customer_Name) , sum(Product_Price) as total_amount FROM Sales_Info 
GROUP BY Customer_Name ORDER BY total_amount DESC LIMIT 5;
SELECT * FROM Sales_info where Product_Price %2 = 0;
SELECT * FROM Customer_info;

INSERT INTO Customer_info  
SELECT DISTINCT Customer_ID, Customer_Name, Customer_EMAILID, Customer_Mobile_no 
FROM Sales_Info;


SELECT S.Customer_ID, C.Customer_Name, Customer_EMAILID FROM Sales_Info S LEFT JOIN Customer_info C on S.Customer_ID = C.Customer_ID;

CREATE TABLE Product_info (
Product_ID SMALLINT,
Product_Name VARCHAR(50),
Product_Price DECIMAL(10,2)
);

INSERT INTO Product_info
SELECT DISTINCT Product_ID, Product_Name, Product_Price 
FROM Sales_Info;

ALTER TABLE Product_info MODIFY COLUMN Product_ID INT PRIMARY KEY ;

SELECT * FROM Product_info;
SELECT * FROM Product_info order by Product_ID ;
SELECT * FROM Product_info ORDER BY Product_Price DESC LIMIT 3;
UPDATE Product_info SET  Product_Name = ' Baggy shirt' where Product_ID = 108;
SELECT Product_ID as P_ID, Product_name as P_NAME, Product_Price as P_PRICE FROM Product_info ORDER BY Product_Price DESC;
SELECT  Product_Name , SUM(Product_Price) AS Total_Price FROM Product_info WHERE Product_Name LIKE '%S' OR Product_Name LIKE '%T' GROUP BY Product_Name ORDER BY SUM(Product_Price) DESC; 

CREATE TABLE Sales_Rep(
Sales_Rep_id INT,
Sales_Rep_Name VARCHAR(50),
Sales_Rep_Mobile_no VARCHAR(15)
);
ALTER TABLE Sales_Rep MODIFY COLUMN Sales_Rep_id INT PRIMARY KEY;
SELECT * FROM Sales_Rep;

INSERT INTO Sales_Rep 
SELECT DISTINCT Sales_Rep_id, Sales_Rep_Name, Sales_Rep_Mobile_no 
FROM Sales_Info;

SELECT Sales_Rep_id as REP_ID, Sales_Rep_Name as REP_NAME , Sales_Rep_Mobile_no as REP_NUMBER FROM Sales_Rep ORDER BY Sales_Rep_Name ASC;

CREATE TABLE Orders_Info (
Order_ID VARCHAR(5) UNIQUE,
Order_Date DATE
);
ALTER TABLE Orders_Info MODIFY COLUMN Order_ID VARCHAR(5) PRIMARY KEY;
SELECT * FROM Orders_Info;

INSERT INTO Orders_Info
SELECT DISTINCT Order_ID, Order_Date 
FROM Sales_Info;

SELECT Order_ID as O_ID, Order_Date as O_DATE FROM Orders_Info ORDER BY Order_Date ASC;
SELECT C.Customer_Name , sum(P.Product_Price) as TOTAL_AMOUNT_SPENDED FROM Sales_info S 
LEFT join Customer_info C on S.Customer_ID = C.Customer_ID 
LEFT join Product_info P on S.Product_ID = P.Product_ID 
group by C.Customer_Name
HAVING 500 > sum(P.Product_Price);

SELECT repeat(10,10);



C


