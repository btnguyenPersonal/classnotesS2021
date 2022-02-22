drop database if exists btnguyen;
create database btnguyen;
use btnguyen;

drop table if exists Employees;
create table Employees (
	essn int not null,
    ename varchar(255),
    eaddress varchar(255),
    esalary varchar(255),
    ephone_num varchar(10),
    union_mem_num int unique,
    primary key (essn)
);

drop table if exists Dependents;
create table Dependents (
	dname varchar(255) not null,
	relationships varchar(255),
    date_of_birth varchar(255),
    dependssn int unique not null,
    primary key (dname, dependssn),
    foreign key (dependssn) references Employees (essn)
);

drop table if exists Model;
create table Model (
	model_no int not null,
    capacity int,
    weight int,
    primary key (model_no)
);

drop table if exists Technician;
create table Technician (
	security_clearance varchar(255),
	us_passport_no int,
	tech_ssn int primary key,
    foreign key (tech_ssn) references Employees (essn)
);

drop table if exists Expert_of;
create table Expert_of (
	model_no int not null,
	t_ssn int not null,
    foreign key (model_no) references Model (model_no),
    primary key (t_ssn, model_no)
);

alter table Expert_of
add foreign key (t_ssn) references Technician (tech_ssn);

drop table if exists Manager;
create table Manager (
	department varchar(255),
    manager_ssn int primary key unique not null,
    foreign key (manager_ssn) references Employees (essn)
);

drop table if exists Traffic_Control;
create table Traffic_Control (
	exam_date varchar(255),
    traffic_ssn int primary key unique not null,
    foreign key (traffic_ssn) references Employees (essn)
);

drop table if exists Plane;
create table Plane (
	reg_no int not null,
    pname varchar(255),
    ptype int not null,
    primary key (reg_no),
    foreign key (ptype) references Model (model_no)
);

drop table if exists Test;
create table Test (
    FAA_no int not null,
	score int,
    tname varchar(255),
    primary key(FAA_no)
);

drop table if exists Test_info;
create table Test_info (
	hours int,
    score int,
    tdate varchar(255),
    tech_ssn int not null,
    reg_no int not null,
    FAA_no int not null,
    foreign key (tech_ssn) references Technician (tech_ssn),
    foreign key (reg_no) references Plane (reg_no),
    foreign key (FAA_no) references Test (FAA_no),
    primary key (tech_ssn, reg_no, FAA_no)
);

drop table if exists Monitor;
create table Monitor (
	most_recent_date varchar(255),
    manager_ssn int not null,
    tech_ssn int not null,
    reg_no int not null,
    FAA_no int not null,
    foreign key (tech_ssn) references Test_info (tech_ssn),
    foreign key (reg_no) references Test_info (reg_no),
    foreign key (FAA_no) references Test_info (FAA_no),
    foreign key (manager_ssn) references Manager (manager_ssn),
    primary key (tech_ssn, reg_no, FAA_no, manager_ssn)
);
