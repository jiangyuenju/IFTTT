create table message(
	id int not null,
	recvname varchar(50) not null,
	text varchar(200) not null,
	public boolean not null,
	read boolean not null,
	sdate date not null
);