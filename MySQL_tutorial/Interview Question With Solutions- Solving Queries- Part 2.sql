use company;
select * from employee;
select * from bonus;
select * from emp_designation;

# write an sql query to retreive all details where 
# first name from employee table which starts with 'd'

select * from employee where first_name like 'd%';

# 2. write an sql query to print all details of the employees whose salary
# is betweeen 300 to 500
# fetch Employee name

select * from employee where salary between 300 and 500;

select first_name from employee where salary between 300 and 500;

select concat(first_name,' ',last_name) as Employee_name,salary from 
employee where empid in (select empid from employee where salary between 300 and 500);

# 3. sql query to retrieve details of the employees who have joined on a date dec 2014

select * from employee where year(joining_date)=2014;

select * from employee where year(joining_date)=2014 and month(joining_date)=12;

# 4. SQL query to fetch number of employees in every department

select count(*) from employee group by department_name;

select * from employee where department_name='IT';

select concat(first_name,' ',last_name) as Employee_name from 
employee where empid in (select empid from emp_designation where department_name='IT');

# 5. sql query to print details of the employee who are also Managers

select employee.first_name, emp_designation.designation from employee
inner join emp_designation on employee.empid=emp_designation.emp_ref_id
and emp_designation.designation='Manager';

# 6. sql query to clone a new table from another table

create table clone_employee like employee;
select * from clone_employee;
desc clone_employee;

# 7. sql query to show top n salary

select * from employee order by salary desc limit 5;

# sql query to determine the 5th highest salary

select Salary from employee order by salary desc limit 3,1;

# sql query to determine the 6th highest salary without using limit

select salary from employee e1 where 6-1 =
(select count(salary)
from employee e2 where e2.salary > e1.salary);