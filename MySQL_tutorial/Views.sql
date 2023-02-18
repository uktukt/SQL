use customer;
drop table student;
create table student(
studentid int auto_increment,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
primary key(studentid)
);
select * from student;
insert into student values(1,'Kr','Na',31),
(2,'Ra','Sa',31),
(3,'Sa','Jo',31);
drop table department;
create table department(
studentid int auto_increment,
department_name varchar(25) not null,
foreign key(studentid) references student(studentid)
);
desc department;

insert into department values(1,'CS'),
(2,'Electronics'),
(3,'Mechanical');

select * from department;
select * from student;

create view student_info as
select first_name, last_name, age from student inner join
 department using (studentid);
 
 select * from student_info;
 
 drop view student_info;
 
create view student_info as
select first_name, last_name, department_name from student inner join
 department using (studentid);
select * from student_info;

