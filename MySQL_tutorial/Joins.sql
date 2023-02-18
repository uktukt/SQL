use customer;
select * from student;
select * from department;
insert into student values(4,'Ra','sin',25);
insert into student values(5,'Ram','sing',27);

# inner join
select * from student inner join department on student.studentid=department.studentid;
select student.first_name, student.last_name, student.age, department.department_name from student
inner join department on student.studentid=department.studentid;
 
# left join
select student.first_name, student.last_name, student.age, department.department_name from student
left join department on student.studentid=department.studentid;

# right join
select student.first_name, student.last_name, student.age, department.department_name from student
right join department on student.studentid=department.studentid;

# full outer join
select student.first_name, student.last_name, student.age, department.department_name from student
left join department on student.studentid=department.studentid

union 

select student.first_name, student.last_name, student.age, department.department_name from student
right join department on student.studentid=department.studentid;

# cross join
select student.first_name, student.last_name, student.age, department.department_name from student
cross join department;

# natural join
select student.first_name, student.last_name, student.age, department.department_name from student
natural join department;

