create database task3;
use task3;

create table ifttt_user(
	username varchar(50) not null,
    password varchar(50) not null,
    sex char(10) not null,
    email varchar(50) not null,
    level int(11) not null,
    account int(10) unsigned not null
);

insert into ifttt_user values("admin", "123456", "F", "12345@qq.com", 1, 1000);

create table message(
	id int not null,
	recvname varchar(50) not null,
	noticetext varchar(200) not null,
	public boolean not null,
	messageread boolean not null,
	sdate date not null
);


create table task(
	id int not null,
    username varchar(50),
	This int not null,
	That int not null,
	alarm varchar(20),
    period int,
	thisId varchar(30),
	thisPassw varchar(30),
	thisContent varchar(140),
	thatId varchar(30),
	thatPassw varchar(30),
	thatContent varchar(140),
	thatToAddrs varchar(30),
    primary key(id));
 
 create table consumption(
	username varchar(50) not null,
    taskdetail varchar(200),
    cost int,
    alarm varchar(20),
    account int(10)unsigned
);

