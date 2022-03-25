use master;
go
drop database SmashBros;
create database SmashBros;
go
use SmashBros;

--drop table Playstyle;
create table Playstyle(
	PlayID int identity primary key,
	playstyleType nvarchar(25) not null
);

--drop table Franchise;
create table Franchise(
	FranID int identity primary key,
	FranName nvarchar(50) unique,
	GamesInFranchise int not null
);

--drop table Character;
create table Character(
	CharID int identity primary key,
	CharName nvarchar(30) not null,
	Height int not null,
	Weight int not null,
	Ranking nvarchar(3),
	PlayID int references Playstyle(PlayID) not null,
	FranID int references Franchise(FranID) not null
);

--Create view that sections off the Light charcters if an end user would want to parse 
--them further.
--drop view LightChars
go
create view LightChars as
select char.CharName,char.Weight,play.playstyleType
from Character char inner JOIN Playstyle play on char.PlayID=play.PlayID
where Weight <= 89;
go
--Create view that sections off the Heavyweight charcters if an end user would want to parse 
--them further.
--drop view HeavyChars
go
create view HeavyChars as
select char.CharName,char.Weight,play.playstyleType
from Character char inner JOIN Playstyle play on char.PlayID=play.PlayID
where Weight >= 101;
go
--Create view that sections off the Middleeight if an end user would want to parese them further
--drop view MiddleChars;
go
create view MiddleChars as 
select CharName,Weight
from Character
where Weight between 90 and 100;
go

--Procedure to update the rank of a charcter as the META develops
--drop procedure updateRanking;
go
create procedure updateRanking
	@character nvarchar(30),
	@newranking nvarchar(3)
AS
BEGIN
update Character
set Ranking=@newranking
where CharName=@character;
END;
go
--Procedure to update the height of a character if it ever updates in the game
--drop procedure updateHeight;
go
create procedure updateHeight
	@character nvarchar(30),
	@newHeight int
AS
BEGIN
update Character
set Height=@newHeight
where CharName=@character;
END;
go
--Procedure to update the weight of a character if it ever updates in the game
--drop procedure updateWeight;
go
create procedure updateWeight
	@character nvarchar(30),
	@newWeight int
AS
BEGIN
update Character
set Weight=@newWeight
where CharName=@character;
END;
go

--insterting values into Playstyle
insert into Playstyle(playstyleType) values ('RushDown');
insert into Playstyle(playstyleType) values ('Grappler');
insert into Playstyle(playstyleType) values ('Hit and Run');
insert into Playstyle(playstyleType) values ('Half-Grappler');

--inserting values into Franchise
insert into Franchise(FranName,GamesInFranchise) values ('Super Mario', 216);
insert into Franchise(FranName,GamesInFranchise) values ('Persona', 6);

--insterting values into characters
insert into Character(CharName,Height,Weight,Ranking,PlayID,FranID) values ('Mario',145,98,10,1,1);
insert into Character(CharName,Height,Weight,Ranking,PlayID,FranID) values ('Luigi',165,97,15,2,1);
insert into Character(CharName,Height,Weight,Ranking,PlayID,FranID) values ('Wario',150,107,20,3,1);
insert into Character(CharName,Height,Weight,Ranking,PlayID,FranID) values ('Peach',160,89,8,4,1);
insert into Character(CharName,Height,Weight,Ranking,PlayID,FranID) values ('Joker',175,93,5,1,2);

--Create index of weight
create index idx_Char_Name on Character(CharName);