# Not Null, Unique, Primary Key, Foreign Key, Check, Default, Index

use customer;

create table student(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int
);
desc student;

alter table student modify age int not null;
desc student;

# unique
create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int not null,
unique(id) 
);

insert into person value (1, 'Krish','Naik','31');
select * from person;
insert into person value (2, 'Krish1','Naik','31');
select * from person;
insert into person value (1, 'Krish2','Naik','31'); #Error Code: 1062. Duplicate entry '1' for key 'person.id'

alter table person add unique(first_name);
desc person;

alter table person add  constraint uc_person unique (age,first_name);
desc person;

alter table person drop index uc_person;
desc person;

# Primary Key
create table person1(
id int not null,
first_name varchar(25) not null,
last_name varchar(25),
age int,
constraint pk_person primary key(id,last_name)
);
desc person1;

alter table person1 drop primary key;
desc person1;



