-- Lab 3

-- Creating a new database
  CREATE DATABASE NewAdvancedSQL;

  USE NewAdvancedSQL;

-- Creating the tables

CREATE TABLE department
(
DepartmentID INT NOT NULL
CONSTRAINT PK_department
Primary Key,
DepartmentName VARCHAR (20) NOT NULL
);

CREATE TABLE employee
(
EmployeeID INT NOT NULL
CONSTRAINT PK_employee
Primary Key,
LastName VARCHAR(20) NOT NULL,
 HireDate Date NOT NULL,
 DepartmentID INT 
 CONSTRAINT FK_employee_department
 references department(DepartmentID)
);

Use NewAdvancedSQL;

 INSERT INTO department VALUES(30,'Sales');
 INSERT INTO department VALUES(31,'Marketing');
 INSERT INTO department VALUES(34,'AI/ML');
 INSERT INTO department VALUES(36,'Data Analytics');

 INSERT INTO employee VALUES(1,'Dahmer','2005-10-17', 30);
 INSERT INTO employee VALUES(2,'Robertson','2012-6-14', 34);
 INSERT INTO employee VALUES(3,'Bond','2016-8-12', NULL);
 INSERT INTO employee VALUES(4,'Jones','2004-3-29', 31);
 INSERT INTO employee VALUES(5,'Ngyuen','2020-11-14', 36);
 INSERT INTO employee VALUES(6,'Fulmer','2010-9-20', 30);

 -- Data Filtering using WHERE and SELECT clause
 -- Matching the Departments
 SELECT LastName, Hiredate
 FROM employee
 WHERE DepartmentID = 30

 -- Logical Operators
  SELECT LastName, Hiredate
 FROM employee
 WHERE DepartmentID = 30
 AND LastName = 'Dahmer'

  SELECT LastName, Hiredate
 FROM employee
 WHERE DepartmentID = 30
 AND NOT (LastName = 'Dahmer')

  SELECT LastName, Hiredate
 FROM employee
 Where HireDate < '1-1-2011'

 -- Special operators
  SELECT LastName, Hiredate
 FROM employee
 WHERE HireDate BETWEEN '1-1-2004' AND '1-1-2005'

 -- Select all employees whos lastname begins with a F
  SELECT LastName, Hiredate
 FROM employee
 WHERE Lastname LIKE 'F%'

  -- Select all employees whos lastname begins with a B
  SELECT LastName, Hiredate
 FROM employee
 WHERE Lastname LIKE 'B%'


 -- Using an IN operator
 -- It selects rows that match any listed values 
 -- Can be used instead of OR to simplify the code
  SELECT LastName, Hiredate
 FROM employee
 WHERE DepartmentID IN (31, 34, 36)

   SELECT LastName, Hiredate
 FROM employee
 WHERE DepartmentID Is NULL

 -- Joining different tables
 -- INNER JOIN
 SELECT department.DepartmentID, department.DepartmentName, employee.LastName
 FROM department
 INNER JOIN employee
 ON department.DepartmentID= employee.DepartmentID;

  -- LEFT JOIN
 SELECT department.DepartmentID, department.DepartmentName, employee.LastName
 FROM employee
 LEFT JOIN department
 ON employee.DepartmentID= department.DepartmentID;

 -- RIGHT JOIN
 SELECT *
 FROM employee
 RIGHT JOIN department
 ON department.DepartmentID= employee.DepartmentID;

 -- Aggregate Functions
 SELECT COUNT (EmployeeID) AS [Employee Count]
 FROM employee
 WHERE DepartmentID = 30

  SELECT COUNT (EmployeeID) AS [Employee Count]
 FROM employee
 WHERE DepartmentID is null

 -- Group By clause
SELECT DepartmentID, COUNT(EmployeeID) AS [Employee Count By Department]
FROM employee
GROUP BY DepartmentID

-- Common error using Group By
-- SELECT EmployeeID
-- from employee
-- group by DepartmentID

-- HAVING Clause
SELECT DepartmentID, COUNT(EmployeeID) AS [Employee Count]
FROM employee
GROUP BY DepartmentID
HAVING COUNT(employeeID ) > 0

-- WHERE SubQuery
SELECT employee.LastName
FROM employee
WHERE employee.DepartmentID = (SELECT department.DepartmentID
FROM department
WHERE department.DepartmentName = 'Sales');

-- IN SubQuery
SELECT EmployeeID, LastName
FROM employee
WHERE employee.DepartmentID IN(SELECT department.DepartmentID
from department
WHERE department.DepartmentName <> 'Sales');

-- Date Functions
-- Extracting year from the HireDate
SELECT LastName, HireDate, YEAR(HireDate) AS HireYear
FROM employee;

-- Extracting month from the HireDate
SELECT LastName, HireDate, MONTH(HireDate) AS HireMonth
FROM employee;

-- Extracting date from the HireDate
SELECT LastName, HireDate, DAY(HireDate)AS HireDay
FROM employee;

-- Extracting the week day from the HireDate
SELECT LastName, HireDate, DATENAME(WEEKDAY, HireDate)AS HireDay
FROM employee;

-- Using the DATEDIFF
--Calculates difference between 2 dates
--Calculating the number of days since the employee was hired
SELECT LastName, HireDate, DATEDIFF(DAY,HireDate,GETDATE()) AS DaysSinceHire
FROM employee;

--Calculating the number of years since the employee was hired
SELECT LastName, HireDate, DATEDIFF(YEAR,HireDate,GETDATE()) AS YearsSinceHire
FROM employee;

-- Selecting employees hired in the last 10 years
SELECT LastName, HireDate
FROM employee
WHERE HireDate >= DATEADD(YEAR, -10, GETDATE());

--Adding 6 months to the HireDate
SELECT LastName, DATEADD(MM , 6, HireDate) AS [Future Date]
FROM employee

--Numeric Functions
-- Rounds to 2 decimal places (119.456)
SELECT ROUND(119.456, 2) AS RoundValue;

-- Rounds number 1 place to left of demimal point (3330.000)
SELECT ROUND(3330.456, -1) AS RoundValue;

-- Rounds number 2 places to left of decimal point (800.000)
SELECT ROUND(846.456, -2) AS RoundValue;

