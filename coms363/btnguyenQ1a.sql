drop database if exists btnguyen;
create database btnguyen;
use btnguyen;

drop table if exists Dependents;
create table Dependents (
	dname varchar(255),
	relationships varchar(255),
    date_of_birth date,
    primary key (dname)
);

drop table if exists Employees;
create table Employees (
	essn int,
    ename varchar(255),
    eaddress varchar(255),
    esalary varchar(255),
    ephone_num varchar(10),
    union_mem_num int,
    dname varchar(255),
    primary key (essn),
    foreign key (dname) references Dependents (dname)
);

drop table if exists Model;
create table Model (
	model_no int,
    capacity int,
    weigth int,
    primary key (model_no)
);

drop table if exists Technician;
create table Technician (
	security_clearance varchar(255),
    us_passport_no int
);

drop table if exists Manager;
create table Manager (
	department varchar(255)
);

drop table if exists Traffic_Control;
create table Traffic_Control (
	exam_date date
);

drop table if exists Plane;
create table Plane (
	reg_no int,
    pname varchar(255),
    primary key (reg_no)
);

drop table if exists Test;
create table Test (
	score int,
    tname varchar(255),
    FAA_no int,
    primary key(FAA_no)
);

-- alter table `Employees` 
-- add constraint `Depends` foreign key (`dname`) 
-- references `Dependents` (`dname`) ON DELETE CASCADE ON UPDATE CASCADE;						
