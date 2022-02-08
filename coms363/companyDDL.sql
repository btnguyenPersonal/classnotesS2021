/*
  Authors: Teaching staff COMS 363
  SPR 2022
*/
-- Remove the entire database using DROP database.
-- Using MySQL Workbench, you may need to do a refresh to see the change
DROP database if exists `company`;

-- Create a new database if the database does not exist.
-- If the database exists, DBMS moves on to the next statement
CREATE DATABASE if not exists `company`;

-- Tell DBMS which database to use for the following commands
-- Otherwise, you will have to refer to each table using the database name followed by a dot and a table name.
-- For example, company.Departments.
-- Notice that all the table names are converted to lowercase (in Windows OS).

USE company;

-- Need to consider the order the tables are created due to the specification of the foreign key.

-- This drop table is not needed if you already drop the entire database, but it is provided here as 
-- an example how to drop a table.

drop table if exists Departments;

-- This table represents the Department entity set and the manages relationship set.
-- Manages relationship set
-- mgrssn attribute is introduced to implement the key constraint and 
-- we later need to make mgrssn a foreign key to Employees(ssn) since Employees does not exist yet.
-- mgrssn is also made not null to implement total participation.
-- mgrssn is also made unique to ensure that no two departments have the same manager due to the 1:1 relationship 
-- between Employee and Department entity sets.

-- dname  attribute is made unique and not null since it is a candidate key
-- Notice that tables need to be created in a certain order as the referenced table must exist 
-- before the foreign key is defined to reference it. Notice that the data types of the 
-- referencing attribute and the referenced attribute must match.

create table Departments(
dno int, 
dname varchar(40) not null,
mgrssn char(11) not null,
primary key(dno),
startdate date,
unique(dname),
unique(mgrssn)
);

drop table if exists Employees;

-- This table represents Employee entity set, supervision relationship set, and work_for relationship set.
-- Works_for relationship set: 
-- 	Notice dno as an attribute for the key constraint and it is made a foreign key to departments(dno).
-- 	dno is made not null due to total participation 
CREATE TABLE Employees(
ssn char(11),
fname varchar(40),
mname varchar(20),
lname varchar(40),
bdate date,
address varchar(80),
gender char(1),
salary float,
supervisorssn char(11),
picture blob,
dno int NOT NULL,
primary key(ssn),
foreign key(dno) references Departments(dno)
);

-- modify the constraints that we could not do before 
-- this is for the supervision relationship set
-- reserved terms like "alter", "add" are case insensitive.
-- MySQL converts the 

alter table Employees
add foreign key (supervisorssn) references Employees(ssn);

-- now we can implement the manages relationship set
alter table Departments
add foreign key(mgrssn) references Employees(ssn);

-- 4. If we have the Dependent weak entity set and the dependents_of relationship set. 
-- For the Dependent weak entity set and the dependents_of relationship set 
-- We use essn as a foreign key to implement the key constraint
-- essn is also part of the primary key because the partial key, name, is not enough to uniquely identify 
-- all the dependents.
-- Since essn is part of the primary key, it cannot be null. Therefore, the total participation of Dependents is also enforced.
-- Notice that on delete cascade indicates that if the referenced Employees.ssn is deleted, their dependents are deleted also.

drop table if exists Dependents;

create table Dependents(
essn varchar(11),
name varchar(80),
gender char(1),
bdate date,
relationship varchar(10),
primary key(essn,name),
foreign key(essn) references Employees(ssn) on delete cascade
);

-- Locations entity set
drop table if exists Locations;
create table Locations(
locid int,
address varchar(40),
primary key(locid)
);

-- This table needs to be created after its referenced relations are created.
drop table if exists Department_locations;
create table Department_locations(
dno int,
locid int,
primary key(dno,locid),
foreign key(dno) references Departments(dno),
foreign key(locid) references Locations(locid)
);

--- 
-- unique and not null on pname is defined for the candidate key
-- The key constraint is implemented through the attribute controldno as
-- the foreign key.
-- not null constraint on controldno is to ensure total participation
drop table if exists Projects;
create table Projects(
pno int,
pname varchar(20) unique not null,
site varchar(40),
controldno int not null,
primary key(pno),
foreign key(controldno) references Departments(dno)
);

/*
  -- See that total participation from Employees and Projects cannot be enforced only by the schema design or table constraints
  -- because we do not know how many ssn there are in Employees table and how many projects there are 
  -- in projects table
  -- Later one we will look at a datbase trigger to enforce a total participation without a key constraint
*/
drop table if exists works_on;

create table Works_on(
essn char(11),
pno int,
hours  decimal(4,1),
primary key(essn , pno),
foreign key(essn) references Employees(ssn),
foreign key(pno) references Projects(pno)
);


/* 
  Examples not related to the ER diagram given in the class participation.
*/
-- example to create auto_increment id
-- this has nothing to do with the ER diagram in the class participation
-- Check constraint ensures that dno is a positive integer; this is not originally in the ER diagram.
-- check was recognized but MySQL version lower than 8.0.16, but it does not do any checking.

drop table if exists test3;
CREATE TABLE test3(a3 INT NOT NULL AUTO_INCREMENT PRIMARY KEY, a4 int check(a4>0));
-- insert one row
insert into test3(a3, a4) values (1,2);