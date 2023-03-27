USE alex;

SELECT * FROM alex.EmployeeDemographics;

SELECT * FROM alex.EmployeeSalary;

SELECT * FROM EmployeeDemographics
Inner Join employeesalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID;
    
SELECT * FROM EmployeeDemographics
Left Outer Join EmployeeSalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID;
    
SELECT * FROM EmployeeDemographics
Right Outer Join EmployeeSalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID;
    
SELECT employeedemographics.EmployeeID, FirstName, LastName, JobTitle, Salary FROM EmployeeDemographics
Inner Join EmployeeSalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID;
    
SELECT employeesalary.EmployeeID, FirstName, LastName, JobTitle, Salary FROM EmployeeDemographics
Right Outer Join EmployeeSalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID;

SELECT employeesalary.EmployeeID, FirstName, LastName, JobTitle, Salary FROM EmployeeDemographics
Left Outer Join EmployeeSalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID;
    
SELECT employeedemographics.EmployeeID, FirstName, LastName, Salary FROM EmployeeDemographics
Inner Join EmployeeSalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC;

SELECT JobTitle, AVG(salary) FROM EmployeeDemographics
Inner Join EmployeeSalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle;

CREATE TABLE WareHouseDemographics AS SELECT * FROM EmployeeDemographics;

SELECT * FROM EmployeeDemographics
UNION ALL
SELECT * FROM WareHouseDemographics
ORDER BY EmployeeID;

SELECT EmployeeID, Age, FirstName FROM EmployeeDemographics
UNION
SELECT EmployeeID, JobTitle, Salary FROM EmployeeSalary
ORDER BY EmployeeID;

SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
    ELSE 'Young'
END
FROM EmployeeDemographics
WHERE AGE is NOT NULL
ORDER BY Age;

SELECT FirstName, LastName, Age,
CASE
	WHEN Age > 30 THEN 'Old'
    WHEN Age = 38 THEN 'Sten'
    ELSE 'Young'
END
FROM EmployeeDemographics
WHERE AGE is NOT NULL
ORDER BY Age;

SELECT FirstName, LastName, Age,
CASE
    WHEN Age = 38 THEN 'Sten'
    WHEN Age > 30 THEN 'Old'
    ELSE 'Young'
END
FROM EmployeeDemographics
WHERE AGE is NOT NULL
ORDER BY Age;

SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .01)
    WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
    WHEN JobTitle = 'HR' THEN Salary + (Salary * .001)
    ELSE Salary + (Salary * .03)
END AS SalaryAfterRaise
FROM EmployeeDemographics
Join EmployeeSalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID;
    
SELECT JobTitle, COUNT(JobTitle) FROM EmployeeDemographics
Join employeesalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1;
    
SELECT JobTitle, AVG(Salary) FROM EmployeeDemographics
Join employeesalary
	ON employeedemographics.EmployeeID = employeesalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary);

SELECT * FROM EmployeeDemographics WHERE EmployeeID = 1012;

INSERT INTO EmployeeDemographics (FirstName, LastName) VALUES ('Holly', 'Flax');

UPDATE EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax';

UPDATE EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE EmployeeID = 1012;

DELETE FROM EmployeeDemographics
WHERE EmployeeID = 1012;

# SELECT *
DELETE FROM EmployeeDemographics
WHERE EmployeeID = 1012;


SELECT FirstName AS Fname FROM EmployeeDemographics;

SELECT FirstName Fname FROM EmployeeDemographics;

SELECT CONCAT(FirstName,' ',LastName) AS FullName FROM EmployeeDemographics;

SELECT AVG(Age) AS AvgAge FROM EmployeeDemographics;

SELECT Demo.EmployeeID
FROM EmployeeDemographics AS Demo
JOIN EmployeeSalary AS Sal
	ON Demo.EmployeeID = Sal.EmployeeID;
    
SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (Partition By Gender) AS TotalGender
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID;
    
SELECT FirstName, LastName, Gender, Salary, COUNT(Gender)
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary;

SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics Demo
JOIN EmployeeSalary Sal
	ON Demo.EmployeeID = Sal.EmployeeID
GROUP BY Gender;