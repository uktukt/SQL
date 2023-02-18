create database company;
use company;

create table Employee(empid int Not null primary key auto_increment,
first_name varchar(25),
last_name varchar(25),
salary int,
joining_date datetime,
department_name varchar(25)
);

desc Employee;

create table bonus(
emp_ref_id int,
bonus_amt int,
bonus_date datetime,
foreign key(emp_ref_id) references Employee(empid) on Delete cascade
);

create table designation(
emp_ref_id int,
designation varchar(25),
designation_date datetime,
foreign key(emp_ref_id) references Employee(empid) on Delete cascade
);

insert into Employee values
(0001,'Kr','Na',500,'14-12-11 09.00.00','Development');
(0002,'Su','Ku',600,'14-12-13 09.00.00','Development'),
(0003,'Sa','Mu',700,'14-12-14 09.00.00','HR'),
(0004,'Da','Be',700,'15-12-16 09.00.00','HR'),
(0005,'St','Bh',300,'17-10-21 09.00.00','IT'),
(0006,'Sh','He',500,'17-10-16 09.00.00','IT');

select * from Employee;

insert into bonus values
(0001,500,'16-03-14'),
(0002,500,'16-03-15'),
(0003,600,'16-03-16'),
(0004,700,'16-03-17'),
(0005,400,'18-03-20'),
(0001,600,'19-03-21'),
(0004,620,'19-03-21'),
(0002,650,'20-03-21');

select * from bonus;

create table emp_designation(
emp_ref_id int,
designation varchar(25),
designation_date datetime,
foreign key(emp_ref_id) references Employee(empid) on Delete cascade
);

insert into emp_designation values
(0001,'Manager','16-03-14'),
(0002,'Excutive','16-03-15'),
(0003,'Manager','16-03-16'),
(0005,'CFO','16-03-17'),
(0005,'Lead','18-03-20'),
(0002,'Manager','19-03-21'),
(0004,'Lead','19-03-21'),
(0002,'CEO','20-03-21');

select * from emp_designation;