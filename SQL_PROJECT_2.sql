CREATE DATABASE PROJECT1;
USE PROJECT1;
# CREATING THE TABLES

#1. CUSTOMERS TABLE
CREATE TABLE customers(
customersID INT PRIMARY KEY NOT NULL,
FirstName VARCHAR(100) NOT NULL,
LastName VARCHAR(100) NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
RegistrationDate DATE NOT NULL 
);

#2. ORDERS TABLE
CREATE TABLE orders(
OrderID INT PRIMARY KEY NOT NULL,
CustomerID INT NOT NULL,
OrderDate DATE NOT NULL,
TotalAmount DECIMAL(10,2) NOT NULL
);

#3. EMPLOYEES TABLE
CREATE TABLE Employees(
EmployeeID INT PRIMARY KEY NOT NULL,
FirstName VARCHAR(100) NOT NULL,
LastName VARCHAR(100) NOT NULL,
Department VARCHAR (100) NOT NULL,
HireDate DATE NOT NULL,
Salary DECIMAL(10,2) NOT NULL
);

# INSERTING DATA INTO THE TABLE
INSERT INTO customers VALUES
(1,"Vaidik","Makwana","vaidik.mak@gamil.com","2022-03-15"),
(2,"Ved","Makwana","ved.mak123@gamil.com","2021-11-02");

INSERT INTO Orders VALUES
(101,1,"2023-07-01",150.50),
(102,2,"2023-07-03",200.75);  

INSERT INTO Employees VALUES
(1,"Vineet","Parmar","Sales","2020-01-15",50000.00),
(2,"Pooja","Patel","HR","2021-03-20",55000.00);

#QUERIES (ALL)
# 1.INNER JOIN
SELECT o.orderID,o.orderDate,o.TotalAmount,c.customersID,c.FirstName,c.LastName FROM orders AS o
INNER JOIN customers AS c
ON o.customerID=c.cuStomersID;

#2. LEFT JOIN
SELECT c.customersID,c.FirstName,c.LastName,o.orderID,o.orderDate,o.TotalAmount FROM customers AS c
LEFT JOIN orders AS o
ON c.customersID=o.orderID;

#3. RIGHT JOIN 
SELECT o.orderID,o.orderDate,o.TotalAmount,c.customersID,c.FirstName,c.LastName FROM orders AS O
RIGHT JOIN   customers AS c
ON c.customersID=o.orderID;

# 4.FULL OUTER JOIN
SELECT c.customersID,c.FirstName,c.LastName,o.orderID,o.orderDate,o.TotalAmount FROM customers AS c
LEFT JOIN orders AS o
ON c.customersID=o.orderID
UNION
SELECT o.orderID,o.orderDate,o.TotalAmount,c.customersID,c.FirstName,c.LastName FROM orders AS O
RIGHT JOIN   customers AS c
ON c.customersID=o.orderID;


# 5.SUBQUERY: CUSTOMERS WITH ORDERS ABOVE AVARAGE AMOUNT
SELECT DISTINCT c.customersID,c.FirstName,c.LastName FROM customers AS c
JOIN orders AS o 
ON c.customersID=o.customerID
WHERE o.TotalAmount > (SELECT AVG(TotalAmount) FROM orders);

# 6.SUBQUERY: EMPLOYEES WITH SALARIES ABOVE AVARAGE SALARY
SELECT EmployeeID,FirstName,LastName,Department,Salary FROM Employees 
WHERE Salary >(SELECT AVG(Salary) FROM Employees);

# 7.SUBQUERY: EXTRACT YEAR AND MONTH FROM ORDRESDATE
SELECT OrderID,OrderDate,
EXTRACT(YEAR FROM OrderDate) AS OrderYear,
EXTRACT(MONTH FROM OrderDate) AS OrderMonth
FROM Orders;

# 8. DAYS DIFFERENCE BBETWEEN ORDER DATE AND CURRENT DATE
SELECT OrderID,OrderDate,DATEDIFF(CURRENT_DATE(),OrderDate) as DaysDifference
FROM Orders;

# 9. FORMATE ORDERDATE('DD-MM-YYYY')
SELECT 	OrderID,DATE_FORMAT(OrderDate, "%d-%b-%Y") AS FormattedDate 
FROM orders;

# 10. CONCATE FIRSTNAME AND LASTNAME 
SELECT customersID,CONCAT(FirstName,' ',LastName) AS FullName
FROM customers;

#11. REPALCE STRING PATTERN
SELECT customersID,REPLACE(FirstName,"Ved","Vedant") AS Updated_FirstNme
FROM customers;

#12. CONVERT FIRSTNAME TO UPPER AND LAST NAME TO LOWER
SELECT customersID,
       UPPER(FirstName) AS Upper_FirstName,
       LOWER(LastName) AS LOWER_LastName
 FROM customers;  
 
#13. TRIM EXTRA SPACE FROM EMAIL
SELECT customersID, TRIM(Email) AS CleanEmail
FROM customers; 

#14. RUNNING TOTAL OF TOTALAMOUNT
SELECT OrderID,OrderDate,TotalAmount,
      SUM(TotalAmount) OVER (ORDER BY OrderDate,OrderID) AS RunningTotal
FROM Orders;      
      
#15. RANK ORDERS BY TOTALAMOUNT 
SELECT orderID,TotalAmount,
      RANK() OVER (ORDER BY TotalAmount DESC) AS  OrderRank
FROM Orders;
      
#16. ASSIGN DISCOUNT BASED ON TOTALAMOUNT   
SELECT orderID,TotalAmount,
      CASE
      WHEN TotalAmount>1000 THEN '10% OFF'
      WHEN TotalAmount>500 THEN '5% OFF'
      ELSE 'NO DISCOUNT' END AS Discount
FROM Orders;

#17. CATEGORIZE EMPLOYEE SALARIES
SELECT EmployeeID,FirstName,LastName,Salary,
CASE 
    WHEN SALARY>=80000 THEN'High' 
    WHEN SALARY>=50000 THEN'Medium'
END AS SalaryCategory
FROM EMPLOYEES;
    
