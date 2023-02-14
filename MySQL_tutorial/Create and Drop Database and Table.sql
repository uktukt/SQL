# commenting, single line
/*
multi line comments
*/
show databases;
# create database 'name'
# drop database dov
use customers;
# create table in database
create table customer_info(id integer,first_name varchar(10),
last_name varchar(10));
show tables;
select * from customer_info;
insert into customer_info(id,first_name,last_name) values
 (1,'Dov', 'Test');
 insert into customer_info(id,first_name,last_name) values
 (2,'Dov', 'Dovile');
  select * from customer_info;
  
  drop table customer_info;
  show tables;
  drop database customers;
  show databases