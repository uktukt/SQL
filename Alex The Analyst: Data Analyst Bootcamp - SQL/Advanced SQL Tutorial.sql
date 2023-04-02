USE alex;
#CTE

WITH CTE_Employee as
(SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (Partition By Gender) AS TotalGender,
AVG(Salary) OVER (Partition By Gender) AS AvgSalary
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID
WHERE Salary > '45000'
)
SELECT * FROM CTE_Employee;

WITH CTE_Employee as
(SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (Partition By Gender) AS TotalGender,
AVG(Salary) OVER (Partition By Gender) AS AvgSalary
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID
WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary FROM CTE_Employee;

# Temp Tables

CREATE TEMPORARY TABLE temp_Employee ( 
EmployeeID int,
JobTitle varchar(50),
Salary int
);

SELECT * FROM temp_Employee;

INSERT INTO temp_Employee VALUES(
'1001', 'HR', '45000'
);

INSERT INTO temp_Employee
SELECT * 
FROM EmployeeSalary;

CREATE TEMPORARY TABLE temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJOB int,
AvgAge int,
AvgSalary int
);

INSERT INTO temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary) FROM EmployeeDemographics dem
JOIN employeesalary sal
	ON dem.EmployeeID = sal.EmployeeID
GROUP BY JobTitle;

SELECT * FROM temp_Employee2;

DROP TABLE IF EXISTS temp_Employee2;
CREATE TABLE temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJOB int,
AvgAge int,
AvgSalary int
);

# String Functions

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50),
FirstName varchar(50),
LastName varchar(50));

INSERT INTO EmployeeErrors VALUES
('1001 ', 'Jimbo', 'Halbert'),
(' 1002', 'Pamela', 'Beasely'),
('1005', 'TOby', 'Flenderson - Fired');

SELECT * FROM EmployeeErrors;

SELECT EmployeeID, TRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors;

SELECT EmployeeID, LTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors;

SELECT EmployeeID, RTRIM(EmployeeID) as IDTRIM
FROM EmployeeErrors;

SELECT LastName, REPLACE(LastName, '- Fired','') as LastNameFixed
FROM EmployeeErrors;

SELECT SUBSTRING(FirstName,1,3)
FROM EmployeeErrors;

SELECT SUBSTRING(FirstName,3,3)
FROM EmployeeErrors;

SELECT SUBSTRING(FirstName,3,3)
FROM EmployeeErrors;

SELECT err.FirstName, dem.FirstName
FROM employeeErrors err
JOIN employeedemographics dem
	ON err.FirstName = dem.FirstName;
    
SELECT err.FirstName, SUBSTRING(err.FirstName,1,3), dem.FirstName, SUBSTRING(dem.FirstName,1,3)
FROM employeeErrors err
JOIN employeedemographics dem
	ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3);
    
SELECT FirstName, LOWER(FirstName) FROM EmployeeErrors;

SELECT FirstName, UPPER(FirstName) FROM EmployeeErrors;

CREATE procedure TEST2 ()
BEGIN
	SELECT * FROM EmployeeDemographics
END
DELIMITER ;

SELECT * FROM employeedemographics;

# EXEC test
CALL alex.test();

CALL Temp_Employee ('HR');

# Subqueries

SELECT * FROM EmployeeSalary;

SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary;

SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
FROM EmployeeSalary;

SELECT a.EmployeeID, AllAvgSalary
FROM (SELECT EmployeeID, Salary, AVG(Salary) OVER () AS AllAvgSalary
	FROM EmployeeSalary) a;
    
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID IN (
	SELECT EmployeeID
    FROM EmployeeDemographics
    WHERE Age > 34);
    
