drop database if exists project;
create database if not exists project;

use project;

drop table if exists URLs;
drop table if exists HashTags;
drop table if exists Mention;
drop table if exists Tweets;
drop table if exists Users;

create table Users(
	screen_name varchar(80),
	user_name varchar(80),
	category varchar(80),
	subcategory varchar(80),
	state varchar(80),
	numFollowers int,
	numFollowing int,
	primary key(screen_name));
	
create table Tweets(
	tid BIGINT,
	post_day int,
	post_month int,
	post_year int,
	texts varchar(160),
	retweetCt int,
	user_screen_name varchar(80) not null,
	primary key(tid),
	foreign key(user_screen_name) references Users(screen_name));
    

create table HashTags(
    tid BIGINT,
	name varchar(80),
	primary key(tid, name),
    foreign key(tid) references Tweets(tid));

create table URLs(
    tid BIGINT,
    -- 80 is not enough for URL_text
	address varchar(480), -- Should be less than 800
	primary key(tid, address),
    foreign key(tid) references Tweets(tid));

create table Mentions(
	tid BIGINT,
	screen_name varchar(80),
	primary key(tid, screen_name),
	foreign key(tid) references Tweets(tid),
	foreign key(screen_name) references Users(screen_name));

select count(distinct name) from HashTags;
select distinct count(name) from HashTags;



