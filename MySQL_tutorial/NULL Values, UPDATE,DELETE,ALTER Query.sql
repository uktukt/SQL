create database customer;
show databases;
use customer;
# create customer_info table
create table customer_info(
id integer auto_increment,
first_name varchar(25),
last_name varchar(25),
salary integer,
primary key(id)
);
select * from customer_info;
# insert records
insert into customer_info(first_name,last_name,salary) values
('John','Daniel','5000'),
('Krish','Naik','6000'),
('Darius','Beng','7000'),
('Chan','Kumar','4000'),
('Ankit','Sharma',NULL);
select * from customer_info;

select * from customer_info where salary is null;
select * from customer_info where salary is not null;

# sql update statment
update customer_info set salary=5000 where id=5;
select * from customer_info;

# sql delete statement
delete from customer_info where id=5;
select * from customer_info;

# sql alter table
# add column in existing table
alter table customer_info add email varchar(25);
select * from customer_info;
alter table customer_info add dob date;
select * from customer_info;

# alter table modify column
alter table customer_info modify dob year;
desc customer_info;

# alter table to drop column
alter table customer_info drop column email;
select * from customer_info;


