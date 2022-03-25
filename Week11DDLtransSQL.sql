use master;
go
drop database week11DDLtrans;
go
create database week11DDLtrans;
go
use week11DDLtrans;
EXEC dbo.sp_changedbowner @loginame = N'sa', @map = false 

create table Book(
BID int identity primary key,
Title varchar(50) not null,
ISBN varchar(17) not null unique
);

create table Author(
AID int identity primary key,
Fname varchar(25) not null,
Mi varchar(1),
Lname varchar(25)
);

create table BookAuthor(
BID int references Book(BID),
AID int references Author(AID),
primary key (BID,AID)
);