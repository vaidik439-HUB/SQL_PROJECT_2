# SQL Project 2 – Data Transformer

## Project Overview

This project is a beginner-friendly **MySQL database project** designed to demonstrate important SQL concepts using three related tables:

- Customers
- Orders
- Employees

The project covers database creation, table creation, data insertion, joins, subqueries, date functions, string functions, window functions, and conditional expressions.

---

## Objectives

The main objectives of this project are to:

- Create and manage a MySQL database.
- Create tables with appropriate data types and constraints.
- Insert records into database tables.
- Retrieve data using SQL queries.
- Understand different types of SQL JOINs.
- Use subqueries for data analysis.
- Work with date and time functions.
- Perform string manipulation.
- Use window functions.
- Calculate running totals and rankings.
- Apply conditional logic using `CASE`.

---

## Technologies Used

- **Database:** MySQL
- **Language:** SQL
- **Concepts:** DDL, DML, Joins, Subqueries, Functions, Window Functions, CASE Statements

---

## Database Name

```sql
PROJECT1
````

---

## Database Structure

The project contains three tables:

```text
PROJECT1
│
├── customers
├── orders
└── employees
```

### 1. Customers Table

Stores customer registration and personal information.

| Column           | Data Type    | Constraints           |
| ---------------- | ------------ | --------------------- |
| customersID      | INT          | PRIMARY KEY, NOT NULL |
| FirstName        | VARCHAR(100) | NOT NULL              |
| LastName         | VARCHAR(100) | NOT NULL              |
| Email            | VARCHAR(100) | NOT NULL, UNIQUE      |
| RegistrationDate | DATE         | NOT NULL              |

### 2. Orders Table

Stores customer order information.

| Column      | Data Type     | Constraints           |
| ----------- | ------------- | --------------------- |
| OrderID     | INT           | PRIMARY KEY, NOT NULL |
| CustomerID  | INT           | NOT NULL              |
| OrderDate   | DATE          | NOT NULL              |
| TotalAmount | DECIMAL(10,2) | NOT NULL              |

### 3. Employees Table

Stores employee information.

| Column     | Data Type     | Constraints           |
| ---------- | ------------- | --------------------- |
| EmployeeID | INT           | PRIMARY KEY, NOT NULL |
| FirstName  | VARCHAR(100)  | NOT NULL              |
| LastName   | VARCHAR(100)  | NOT NULL              |
| Department | VARCHAR(100)  | NOT NULL              |
| HireDate   | DATE          | NOT NULL              |
| Salary     | DECIMAL(10,2) | NOT NULL              |

---

## Sample Data

### Customers

| customersID | FirstName | LastName | Email                                               | RegistrationDate |
| ----------: | --------- | -------- | --------------------------------------------------- | ---------------- |
|           1 | Vaidik    | Makwana  | [vaidik.mak@gamil.com](mailto:vaidik.mak@gamil.com) | 2022-03-15       |
|           2 | Ved       | Makwana  | [ved.mak123@gamil.com](mailto:ved.mak123@gamil.com) | 2021-11-02       |

### Orders

| OrderID | CustomerID | OrderDate  | TotalAmount |
| ------: | ---------: | ---------- | ----------: |
|     101 |          1 | 2023-07-01 |      150.50 |
|     102 |          2 | 2023-07-03 |      200.75 |

### Employees

| EmployeeID | FirstName | LastName | Department | HireDate   |   Salary |
| ---------: | --------- | -------- | ---------- | ---------- | -------: |
|          1 | Vineet    | Parmar   | Sales      | 2020-01-15 | 50000.00 |
|          2 | Pooja     | Patel    | HR         | 2021-03-20 | 55000.00 |

---

# SQL Concepts Covered

## 1. Database Creation

The project begins by creating and selecting the database.

```sql
CREATE DATABASE PROJECT1;
USE PROJECT1;
```

---

## 2. Table Creation

Three tables are created using the `CREATE TABLE` statement.

```sql
CREATE TABLE customers(
    customersID INT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    RegistrationDate DATE NOT NULL
);
```

---

## 3. Data Insertion

Sample records are inserted into the tables using the `INSERT INTO` statement.

```sql
INSERT INTO customers VALUES
(1,"Vaidik","Makwana","vaidik.mak@gamil.com","2022-03-15"),
(2,"Ved","Makwana","ved.mak123@gamil.com","2021-11-02");
```

---

# Queries Implemented

## 1. INNER JOIN

Retrieves orders along with the corresponding customer information.

```sql
SELECT o.orderID,o.orderDate,o.TotalAmount,
       c.customersID,c.FirstName,c.LastName
FROM orders AS o
INNER JOIN customers AS c
ON o.customerID = c.customersID;
```

### Concept

`INNER JOIN` returns records that have matching values in both tables.

---

## 2. LEFT JOIN

Retrieves all customers and their corresponding orders.

```sql
SELECT c.customersID,c.FirstName,c.LastName,
       o.orderID,o.orderDate,o.TotalAmount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customersID = o.customerID;
```

### Concept

`LEFT JOIN` returns all records from the left table and matching records from the right table.

---

## 3. RIGHT JOIN

Retrieves orders along with matching customer information.

```sql
SELECT o.orderID,o.orderDate,o.TotalAmount,
       c.customersID,c.FirstName,c.LastName
FROM orders AS o
RIGHT JOIN customers AS c
ON c.customersID = o.customerID;
```

### Concept

`RIGHT JOIN` returns all records from the right table and matching records from the left table.

---

## 4. FULL OUTER JOIN

MySQL does not directly support `FULL OUTER JOIN`, so it can be simulated using `LEFT JOIN`, `RIGHT JOIN`, and `UNION`.

```sql
SELECT c.customersID,c.FirstName,c.LastName,
       o.orderID,o.orderDate,o.TotalAmount
FROM customers AS c
LEFT JOIN orders AS o
ON c.customersID = o.customerID

UNION

SELECT c.customersID,c.FirstName,c.LastName,
       o.orderID,o.orderDate,o.TotalAmount
FROM orders AS o
RIGHT JOIN customers AS c
ON c.customersID = o.customerID;
```

### Concept

This approach combines records from both sides of the relationship.

---

## 5. Subquery – Customers With Orders Above Average

Finds customers whose order amount is greater than the average order amount.

```sql
SELECT DISTINCT c.customersID,c.FirstName,c.LastName
FROM customers AS c
JOIN orders AS o
ON c.customersID = o.customerID
WHERE o.TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM orders
);
```

### Concept

A subquery is used to calculate the average order amount before filtering the customers.

---

## 6. Subquery – Employees With Above-Average Salary

Finds employees whose salary is greater than the average employee salary.

```sql
SELECT EmployeeID,FirstName,LastName,Department,Salary
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);
```

---

## 7. Extract Year and Month From Order Date

Extracts the year and month from the order date.

```sql
SELECT OrderID,
       OrderDate,
       EXTRACT(YEAR FROM OrderDate) AS OrderYear,
       EXTRACT(MONTH FROM OrderDate) AS OrderMonth
FROM Orders;
```

### Example

```text
OrderDate: 2023-07-01
OrderYear: 2023
OrderMonth: 7
```

---

## 8. Days Difference Between Order Date and Current Date

Calculates the number of days between the order date and the current date.

```sql
SELECT OrderID,
       OrderDate,
       DATEDIFF(CURRENT_DATE(),OrderDate) AS DaysDifference
FROM Orders;
```

---

## 9. Format Order Date

Formats the order date into a readable format.

```sql
SELECT OrderID,
       DATE_FORMAT(OrderDate,"%d-%b-%Y") AS FormattedDate
FROM Orders;
```

### Example

```text
2023-07-01 → 01-Jul-2023
```

---

## 10. Concatenate First Name and Last Name

Combines first name and last name into a single full name.

```sql
SELECT customersID,
       CONCAT(FirstName,' ',LastName) AS FullName
FROM customers;
```

### Example

```text
Vaidik + Makwana → Vaidik Makwana
```

---

## 11. Replace String Pattern

Replaces the name `Ved` with `Vedant`.

```sql
SELECT customersID,
       REPLACE(FirstName,"Ved","Vedant") AS Updated_FirstName
FROM customers;
```

---

## 12. Convert First Name to Uppercase and Last Name to Lowercase

```sql
SELECT customersID,
       UPPER(FirstName) AS Upper_FirstName,
       LOWER(LastName) AS LOWER_LastName
FROM customers;
```

### Functions Used

* `UPPER()` – converts text to uppercase.
* `LOWER()` – converts text to lowercase.

---

## 13. Trim Extra Spaces From Email

Removes leading and trailing spaces from email values.

```sql
SELECT customersID,
       TRIM(Email) AS CleanEmail
FROM customers;
```

---

## 14. Running Total of Order Amount

Calculates a cumulative total of order amounts.

```sql
SELECT OrderID,
       OrderDate,
       TotalAmount,
       SUM(TotalAmount) OVER (
           ORDER BY OrderDate,OrderID
       ) AS RunningTotal
FROM Orders;
```

### Concept

The `SUM() OVER()` window function calculates the running total without grouping the rows.

---

## 15. Rank Orders by Total Amount

Ranks orders from the highest amount to the lowest amount.

```sql
SELECT OrderID,
       TotalAmount,
       RANK() OVER (
           ORDER BY TotalAmount DESC
       ) AS OrderRank
FROM Orders;
```

### Concept

The `RANK()` window function assigns a ranking based on the order amount.

---

## 16. Assign Discount Based on Total Amount

Uses a `CASE` expression to assign discounts.

```sql
SELECT OrderID,
       TotalAmount,
       CASE
           WHEN TotalAmount > 1000 THEN '10% OFF'
           WHEN TotalAmount > 500 THEN '5% OFF'
           ELSE 'NO DISCOUNT'
       END AS Discount
FROM Orders;
```

### Discount Rules

| Order Amount   | Discount    |
| -------------- | ----------- |
| More than 1000 | 10% OFF     |
| More than 500  | 5% OFF      |
| 500 or less    | NO DISCOUNT |

---

## 17. Categorize Employee Salaries

Classifies employee salaries into categories.

```sql
SELECT EmployeeID,
       FirstName,
       LastName,
       Salary,
       CASE
           WHEN Salary >= 80000 THEN 'High'
           WHEN Salary >= 50000 THEN 'Medium'
       END AS SalaryCategory
FROM Employees;
```

### Salary Categories

|           Salary | Category |
| ---------------: | -------- |
|   80000 or above | High     |
| 50000 – 79999.99 | Medium   |

---

# SQL Functions Used

| Function / Feature | Purpose                             |
| ------------------ | ----------------------------------- |
| `AVG()`            | Calculates average value            |
| `SUM()`            | Calculates total value              |
| `EXTRACT()`        | Extracts date components            |
| `DATEDIFF()`       | Calculates difference between dates |
| `CURRENT_DATE()`   | Gets the current date               |
| `DATE_FORMAT()`    | Formats dates                       |
| `CONCAT()`         | Combines strings                    |
| `REPLACE()`        | Replaces text                       |
| `UPPER()`          | Converts text to uppercase          |
| `LOWER()`          | Converts text to lowercase          |
| `TRIM()`           | Removes extra spaces                |
| `RANK()`           | Assigns ranking                     |
| `CASE`             | Performs conditional logic          |
| `UNION`            | Combines query results              |

---

# SQL Concepts Demonstrated

```text
Database Creation
       ↓
Table Creation
       ↓
Data Insertion
       ↓
INNER JOIN
       ↓
LEFT JOIN
       ↓
RIGHT JOIN
       ↓
FULL OUTER JOIN Simulation
       ↓
Subqueries
       ↓
Date Functions
       ↓
String Functions
       ↓
Window Functions
       ↓
CASE Expressions
```

---

# Project Structure

```text
SQL-PROJECT1/
│
├── project1.sql
└── README.md
```

---

# How to Run the Project

## Step 1: Install MySQL

Install MySQL Server and MySQL Workbench if they are not already installed.

## Step 2: Open MySQL Workbench

Open MySQL Workbench and connect to your MySQL server.

## Step 3: Open the SQL File

Open:

```text
project1.sql
```

## Step 4: Execute the Script

Run the complete SQL script.

The script will:

1. Create the `PROJECT1` database.
2. Select the database.
3. Create the `customers` table.
4. Create the `orders` table.
5. Create the `employees` table.
6. Insert sample data.
7. Execute SQL queries.

---

# Expected Learning Outcomes

After completing this project, you should understand:

* How to create a MySQL database.
* How to create tables.
* How primary keys and unique constraints work.
* How to insert data.
* How table relationships can be queried.
* Difference between `INNER JOIN`, `LEFT JOIN`, and `RIGHT JOIN`.
* How to simulate a `FULL OUTER JOIN` in MySQL.
* How subqueries work.
* How to use SQL date functions.
* How to manipulate strings.
* How window functions work.
* How to calculate running totals.
* How to rank records.
* How to use `CASE` for conditional classification.

---

# Conclusion

**SQL Project 1 – Customer, Orders & Employee Database** provides practical experience with fundamental and intermediate MySQL concepts. It combines database design, data manipulation, joins, subqueries, date processing, string operations, window functions, and conditional logic into one project.

This project is suitable for students who are learning **SQL and MySQL fundamentals** and want hands-on practice with real-world database queries.
