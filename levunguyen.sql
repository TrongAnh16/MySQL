drop database if exists student_management;
-- tao database
create database db_student;
-- su dung db
use db_student;

-- tao bang: Cú pháp: tên cột kiểu du lieu cot khoa chinh
create table student (
	student_id int primary key,
    student_name varchar(50) not null
);
insert into student (student_id, student_name)
values (1, 'Jonh');