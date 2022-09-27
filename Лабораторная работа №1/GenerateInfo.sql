use Cinema
GO

DECLARE @CharList CHAR(52) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz',
		@Position INT,
		@index INT,
		@OneLink INT,
		@ManyLink INT,
		@NameLimit INT,
		@MaxLimit INT,
		@MinLimit INT,
		@RowCount INT,
		@AgeLimit INT,
		@FilmDuration INT,

		@FilmProductionName NVARCHAR(70),
		@CountryFilmProductionName NVARCHAR(70),
		@CountryName NVARCHAR(70),
		@GenreName NVARCHAR(50),
		@Name NVARCHAR(50),
		@SurName NVARCHAR(50),
		@MiddleName NVARCHAR(50),
		@FilmName NVARCHAR(50),
		@FilmDescription NVARCHAR(400),
		@GenreId INT,
		@ActorCastId INT,
		@ActorId INT,
		@FilmProductionId INT,
		@CountryProductionId INT,
		@FilmId INT


SET @OneLink = 500
SET @ManyLink = 20000
SET @index = 1
SET @MaxLimit = 35
SET @MinLimit = 10
SET @RowCount = 1


/*Генерация значений в таблицу - Жанры/Страна-производитель/Компания-производитель/Актеры*/
SET @RowCount = 1

WHILE @RowCount <= @OneLink
	BEGIN 
		
		SET @index = 1
		/*Жанры*/
		SET @GenreName = ''
		SET @NameLimit = @MinLimit + RAND()*(@MaxLimit - @MinLimit)
		WHILE @index <= @NameLimit
		BEGIN
			SET @Position = RAND()*52
			SET @GenreName = @GenreName + SUBSTRING(@CharList , @Position , 1)
			SET @index = @index + 1
		END;

		/*Страна-производитель*/
		SET @CountryName = ''
		SET @index = 1
		SET @NameLimit = @MinLimit + RAND()*(@MaxLimit - @MinLimit)
		WHILE @index <= @NameLimit
		BEGIN
			SET @Position = RAND()*52
			SET @CountryName = @CountryName + SUBSTRING(@CharList , @Position , 1)
			SET @index = @index + 1
		END

		/*Компания-производитель*/
		SET @CountryFilmProductionName = ''
		SET @FilmName = ''
		SET @index = 1
		SET @NameLimit = @MinLimit + RAND()*(@MaxLimit - @MinLimit)
		WHILE @index <= @NameLimit
		BEGIN
			SET @Position = RAND()*52
			SET @CountryFilmProductionName = @CountryName + SUBSTRING(@CharList , @Position , 1)
			SET @Position = RAND()*52
			SET @FilmName = @FilmName + SUBSTRING(@CharList , @Position , 1)
			SET @index = @index + 1
		END

		/*Актеры*/
		SET @index = 1
		SET @Name = ''
		SET @MiddleName = ''
		SET @SurName = ''
		SET @NameLimit = @MinLimit + RAND()*(@MaxLimit - @MinLimit)
		WHILE @index <= @NameLimit
		BEGIN
			SET @Position = RAND()*52
			SET @Name = @Name + SUBSTRING(@CharList , @Position , 1)
			SET @Position = RAND()*52
			SET @MiddleName = @MiddleName + SUBSTRING(@CharList , @Position , 1)
			SET @Position = RAND()*52
			SET @SurName = @SurName + SUBSTRING(@CharList , @Position , 1)
			SET @index = @index + 1
		END

		INSERT INTO Genres(Name) VALUES (@GenreName)
		INSERT INTO CountryProductions(Name) VALUES(@CountryName)
		INSERT INTO FilmProductions(Name, Country) VALUES(@FilmName ,@CountryName)
		INSERT INTO Actors(Name, MiddleName, Surname) VALUES(@Name , @MiddleName , @SurName)

		SET @RowCount +=1
	END

/*Генерация значений в таблицу - Актерские группы/Фильмы*/
SET @RowCount = 1

WHILE @RowCount <= @ManyLink
	BEGIN 
		/*Актерские группы*/
		SET @ActorId = 1+RAND()*(@OneLink-1)
		SET @FilmId = 1+RAND()*(@ManyLink-1)
		INSERT INTO ActorCasts(ActorId, FilmId) VALUES(@ActorId , @FilmId)
		SET @RowCount +=1
	END
	

SET @RowCount = 1
WHILE @RowCount <= @ManyLink
	BEGIN
		SET @index = 1

		/*Фильмы*/
		SET @GenreId = 1+RAND()*(@OneLink-1)
		SET @ActorCastId = 1+RAND()*(@ManyLink-1)
		SET @FilmProductionId = 1+RAND()*(@OneLink-1)
		SET @CountryProductionId = 1+RAND()*(@OneLink-1)
		SET @AgeLimit = 6+RAND()*(32-6)
		SET @FilmDuration = 60+RAND()*(300 - 60)

		SET @NameLimit = @MinLimit + RAND()*(@MaxLimit - @MinLimit)
		SET @FilmDescription = ''
		SET @FilmName = ''
		WHILE @index <= @NameLimit
		BEGIN
			SET @Position = RAND()*52
			SET @FilmDescription = @FilmDescription + SUBSTRING(@CharList , @Position , 1)
			SET @Position = RAND()*52
			SET @FilmName = @FilmName + SUBSTRING(@CharList , @Position , 1)
			SET @index = @index + 1
		END
		INSERT INTO Films(Name, GenreId, ActorCastId, Duration, FilmProductionId, CountryProductionId, AgeLimit, Description) 
		VALUES (@FilmName, @GenreId, @ActorCastId, @FilmDuration, @FilmProductionId , @CountryProductionId, @AgeLimit, @FilmDescription)
		
		SET @RowCount +=1
	END

