#Basics

SELECT FirstName, LastName FROM Employeedemographics;

SELECT DISTINCT(Gender) FROM Employeedemographics;

SELECT COUNT(LastName) FROM Employeedemographics;
SELECT COUNT(Gender) FROM Employeedemographics;

SELECT COUNT(LastName) AS LastNameCount FROM Employeedemographics;

SELECT MAX(Salary) FROM EmployeeSalary;
SELECT AVG(Salary) FROM EmployeeSalary;

SELECT * FROM Employeedemographics WHERE FirstName = 'Jim';
SELECT * FROM Employeedemographics WHERE FirstName <> 'Jim';

SELECT * FROM Employeedemographics WHERE Age >= 30;

SELECT * FROM Employeedemographics WHERE Age >= 30;

SELECT * FROM Employeedemographics WHERE Age >= 30 AND Gender = 'Male';

SELECT * FROM Employeedemographics WHERE Age >= 30 OR Gender = 'Male';

SELECT * FROM Employeedemographics WHERE LastName LIKE 'S%';

SELECT * FROM Employeedemographics WHERE LastName LIKE '%S%';

SELECT * FROM Employeedemographics WHERE LastName LIKE '%S%o%';

SELECT * FROM Employeedemographics WHERE FirstName is NULL;

SELECT * FROM Employeedemographics WHERE FirstName is not NULL;

SELECT * FROM Employeedemographics WHERE FirstName IN ('Jim', 'Michael');

SELECT Gender FROM Employeedemographics GROUP BY Gender;

SELECT Gender, COUNT(Gender) FROM Employeedemographics GROUP BY Gender;

SELECT Gender, Age, COUNT(Gender) FROM Employeedemographics GROUP BY Gender, Age;

SELECT Gender, COUNT(Gender) FROM Employeedemographics
WHERE Age > 30
GROUP BY Gender;

SELECT Gender, COUNT(Gender)
FROM Employeedemographics
WHERE Age > 30
GROUP BY Gender;

SELECT Gender, COUNT(Gender) AS CountGender
FROM Employeedemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY CountGender DESC;

SELECT * FROM Employeedemographics
ORDER BY Age DESC;

SELECT * FROM Employeedemographics
ORDER BY Age, Gender;

SELECT * FROM Employeedemographics
ORDER BY Age DESC, Gender DESC;

SELECT * FROM Employeedemographics
ORDER BY 4 DESC, 5 DESC;
