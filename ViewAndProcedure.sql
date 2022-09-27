/*Procedure*/
CREATE PROC ActorCreate
	@ActorName NVARCHAR(60), @Surname NVARCHAR(60), @MiddleName NVARCHAR(60)
	AS
	INSERT INTO Actors(Name , Surname , MiddleName) VALUES (@ActorName, @Surname, @MiddleName) 
GO

CREATE PROC ActorUpdate
	@ActorId INT, @ActorName NVARCHAR(60), @Surname NVARCHAR(60), @MiddleName NVARCHAR(60)
	AS
	UPDATE Actors SET Name = @ActorName, Surname = @Surname , MiddleName = @MiddleName
	WHERE Actors.Id = @ActorId				
GO

CREATE PROC GenreCreate
	@Name NVARCHAR(100)
	AS
	INSERT INTO Genres(Name) VALUES (@Name)
GO

CREATE PROC GenreUpdate
	@Name NVARCHAR(100) , @GenreId INT
	AS
	UPDATE Genres SET Genres.Name = @Name WHERE Genres.Id = @GenreId
GO

CREATE PROC FilmProductionCreate
	@ProductionName NVARCHAR(100), @ProductionCountry NVARCHAR(150)
	AS
	INSERT INTO FilmProductions(Name, Country) VALUES (@ProductionName , @ProductionCountry)
GO

CREATE PROC FilmProductionCreateUpdate
	@ProductionId INT, @ProductionName NVARCHAR(100), @ProductionCountry NVARCHAR(150)
	AS
	UPDATE FilmProductions SET Name = @ProductionName , Country = @ProductionCountry
	WHERE FilmProductions.Id = @ProductionId
GO


/*VIEW*/
GO
CREATE VIEW VwActorActorCasts
AS
	SELECT ActorCasts.Id, Actors.Name, Actors.MiddleName, Actors.Surname FROM Actors
	INNER JOIN ActorCasts ON ActorCasts.ActorId = Actors.Id
Go

CREATE VIEW VwActorActorCastsFilms
AS
	SELECT Actors.Name, Actors.MiddleName, Actors.Surname, Films.Name as FilmName , ActorCasts.Id AS CastsId
	FROM ActorCasts INNER JOIN Actors ON Actors.Id = ActorCasts.ActorId
							INNER JOIN Films ON Films.ActorCastId = ActorCasts.FilmId
GO

CREATE VIEW VwGenreFilms
AS 
	SELECT Films.Name AS FilmName, Genres.Name FROM Films INNER JOIN Genres ON Genres.Id = Films.GenreId
GO

CREATE VIEW VwGenreProductionFilms
AS 
	SELECT Films.Name AS FilmName, Films.Duration ,  Genres.Name AS GenreName, Films.AgeLimit, FilmProductions.Name AS ProductionName,
	CountryProductions.Name AS ContryProduction , Films.Description
	FROM Films INNER JOIN Genres ON Genres.Id = Films.GenreId
						INNER JOIN FilmProductions ON FilmProductions.Id = Films.FilmProductionId
						INNER JOIN CountryProductions ON CountryProductions.Id = Films.CountryProductionId
GO

CREATE VIEW VwListEventFilms
AS 
	SELECT ListEvents.Date, ListEvents.TicketPrice, Films.Name AS FilmName, Films.Duration ,  Genres.Name AS GenreName, Films.AgeLimit, FilmProductions.Name AS ProductionName,
	CountryProductions.Name AS ContryProduction , Films.Description
	FROM Films INNER JOIN Genres ON Genres.Id = Films.GenreId
						INNER JOIN FilmProductions ON FilmProductions.Id = Films.FilmProductionId
						INNER JOIN CountryProductions ON CountryProductions.Id = Films.CountryProductionId
						INNER JOIN ListEvents ON ListEvents.FilmId = Films.Id
GO

CREATE VIEW VwEventListCinemaHallPlaces
AS
	SELECT ListEvents.Name AS EventName, ListEvents.Date , CinemaHalls.HallNumber, Places.PlaceNumber , Places.TakenSeat
	FROM Places INNER JOIN CinemaHalls ON CinemaHalls.Id = Places.CinemaHallId
						INNER JOIN ListEvents ON ListEvents.Id = Places.ListEventId
GO

