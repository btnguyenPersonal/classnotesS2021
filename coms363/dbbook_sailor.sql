drop database if exists dbbook;
create database dbbook;
use dbbook;
create table sailors(
	sid int primary key,
	sname varchar(30),
	rating integer,
	age real
	);

insert into sailors (sid, sname, rating, age)
values 
(18,'jones',3,30),
(41,'jonah',6,56),
(22,'ahab',7,44),
(63,'moby',6,15);

create table Boats(
bid integer,
bname char(10),
color char(10), primary key(bid));

insert into Boats values (101, 'Interlake', 'red');
insert into Boats values (102, 'Clipper', 'green');
insert into Boats values (103, 'Marine', 'red');

create table Reserves(
sid integer,
bid integer,
day date, 
primary key(sid,bid),
foreign key (sid) references Sailors (sid),
foreign key (bid) references Boats (bid)
);

insert into Reserves values (18, 101, null);
insert into Reserves values (22, 102, null);
insert into Reserves values (22, 103, null);