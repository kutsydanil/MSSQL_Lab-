USE master
IF DB_ID('Cinema') IS NOT NULL
DROP DATABASE Cinema

USE master
CREATE DATABASE Cinema
Go

USE Cinema

/*������� ������������-�������������*/
CREATE TABLE FilmProductions(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	Country NVARCHAR(150) NOT NULL
);

/*������� �����*/
CREATE TABLE Genres(
	Id INT IDENTITY(1 , 1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
);

/*������� ������*/
CREATE TABLE Actors(
	Id INT IDENTITY(1 , 1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(60) NOT NULL,
	Surname NVARCHAR(60) NOT NULL,
	MiddleName NVARCHAR(60) NOT NULL,
);

/*������� ���������������*/
CREATE TABLE ActorCasts(
	Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	ActorId INT NOT NULL,
	FilmId INT NOT NULL,

	FOREIGN KEY(ActorId) REFERENCES Actors(Id),
);

/*������� ������-�������������*/
CREATE TABLE CountryProductions(
	Id INT IDENTITY(1 , 1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(150)
);

/*������� ������*/
CREATE TABLE Films(
	Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	GenreId INT NOT NULL,
	ActorCastId INT NOT NULL,
	Duration INT NOT NULL,
	FilmProductionId INT NOT NULL,
	CountryProductionId INT NOT NULL,
	AgeLimit INT NOT NULL CHECK(AgeLimit >= 1),
	Description NVARCHAR(350) NOT NULL

	FOREIGN KEY(CountryProductionId) REFERENCES CountryProductions(Id) ON DELETE CASCADE,
	FOREIGN KEY(ActorCastId) REFERENCES ActorCasts(Id) ON DELETE CASCADE,
	FOREIGN KEY(FilmProductionId) REFERENCES FilmProductions(Id) ON DELETE CASCADE,
	FOREIGN KEY(GenreId) REFERENCES Genres(Id) ON DELETE CASCADE,
);

/*������� ����������*/
CREATE TABLE Staffs(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(60) NOT NULL,
	Surname NVARCHAR(60) NOT NULL,
	MiddleName NVARCHAR(60) NOT NULL,
	Post NVARCHAR(150) NOT NULL,
	WorkExperience INT NOT NULL
)

/*������� ������ �����������*/
CREATE TABLE StaffCasts
(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	StaffId INT NOT NULL,
	ListEventId INT NOT NUll,
	FOREIGN KEY(StaffId) REFERENCES Staffs(Id) ON DELETE CASCADE,
);

/*������� ���������� �����������*/
CREATE TABLE ListEvents(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name NVARCHAR(150) NOT NULL,
	Date DATE NOT NULL,
	StartTime TIME NOT NULL,
	EndTime TIME NOT NULL,
	TicketPrice MONEY NOT NULL,
	StaffCastId INT NOT NULL,
	FilmId INT NOT NULL,

	FOREIGN KEY(FilmId) REFERENCES Films(Id) ON DELETE CASCADE,
	FOREIGN KEY(StaffCastId) REFERENCES StaffCasts(Id) ON DELETE CASCADE
);

/*������� ���*/
CREATE TABLE CinemaHalls(
	 Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	 HallNumber INT NOT NULL,
	 MaxPlaceNumber INT CHECK(MaxPlaceNumber >= 1) NOT NULL,
);

/*������� �����*/
CREATE TABLE Places(
	Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	ListEventId INT NOT NULL,

	CinemaHallId INT NOT NULL,
	PlaceNumber INT NOT NULL,
	TakenSeat BIT NOT NULL,

	FOREIGN KEY(CinemaHallId) REFERENCES CinemaHalls(Id) ON DELETE CASCADE,
	FOREIGN KEY(ListEventId) REFERENCES ListEvents(Id) ON DELETE CASCADE,
);





