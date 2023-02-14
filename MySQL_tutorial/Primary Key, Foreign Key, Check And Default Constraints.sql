use customer;

create table person2(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
primary key(id)
);
desc person2;

drop table person2;
create table person2(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
constraint pk_person primary key(id,last_name)
);
alter table student add primary key(id);
desc student;


create table person3(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int
);
alter table person3 add constraint pk_person primary key(id,age);
desc person3;

alter table person3 drop primary key;

# Foreign key
drop table person;
create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
salary int,
primary key(id)
);
desc person;

create table department(
id int not null,
department_name varchar(25) not null,
depertment_id int not null,
primary key(depertment_id),
constraint fk_persondepartment foreign key(id) references person(id)
);
desc department;

drop table department;
create table department(
id int not null,
department_name varchar(25) not null,
depertment_id int not null,
primary key(depertment_id)
);
desc department;

alter table department add foreign key(id) references person(id);
desc department;

drop table department;
drop table person;

# check constraints
create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
salary int,
primary key(id),
check(salary<5000)
);
desc person;

insert into person values(1,'Dov','M',32,6000);
insert into person values(1,'Dov','M',32,4000);
select * from person;

# Default constraint
drop table person;
create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
city_name varchar(25) default 'Vilnius'
);
desc person;

alter table person alter city_name drop default;
desc person;




