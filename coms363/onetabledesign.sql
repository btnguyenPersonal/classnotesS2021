-- Author Wallapak Tavanapong
drop database if exists RDB;
create database RDB;
use RDB;
drop table if exists emp_work_dept;
create table emp_work_dept 
(eid int,
 ename varchar(50) not null,
 salary decimal(10,0),
 did int,
 dname varchar(40) not null, 
 budget decimal(10,0),
 managerid int, 
 pct_time int(11) DEFAULT 10,
 primary key (eid,did));