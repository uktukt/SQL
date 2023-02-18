use customer;

select * from student;

-- CREATE DEFINER=`root`@`localhost` PROCEDURE `get_student_info`()
-- BEGIN
-- select * from student where student.age=31;
-- END

-- CREATE DEFINER=`root`@`localhost` PROCEDURE `get_student_info2`(in age int)
-- BEGIN
-- select * from student where student.age=age;
-- END

-- CREATE DEFINER=`root`@`localhost` PROCEDURE `get_student_info3`(out records int)
-- BEGIN
-- select count(*) into records from student where student.age=31;
-- END

-- CREATE DEFINER=`root`@`localhost` PROCEDURE `get_student_info4`(inout records int,in age int)
-- BEGIN
-- select count(*) into records from student where student.age;
-- END

call get_student_info;
call get_student_info2(27);
call get_student_info3(@record);
select @record as Totalrecords;

call get_student_info4(@record,31);
select @record as Totalrecords;