USE Fortnite2
GO

--CREATE PROCEDURE [dbo].[DropTable](@table AS varchar(500)) 
--AS
--BEGIN
--	DECLARE @sql nvarchar(500)
--	SET @sql = 'IF OBJECT_ID(''' + @table + ''', ''U'') IS NOT NULL BEGIN DROP TABLE ' + @table + ' END'
--	EXEC sp_executesql @sql
--END	
--GO
	
--CREATE PROCEDURE [dbo].[DropView](@view AS varchar(500)) 
--AS
--BEGIN
--	DECLARE @sql nvarchar(500)
--	SET @sql = 'IF OBJECT_ID(''' + @view + ''', ''V'') IS NOT NULL BEGIN DROP VIEW ' + @view + ' END'
--	EXEC sp_executesql @sql
--END	
--GO

EXEC DropTable 'PlayerWeek'
EXEC DropTable 'Week'
EXEC DropTable 'Match'
EXEC DropTable 'MatchType'
EXEC DropTable 'Region'
EXEC DropTable 'Player'


CREATE TABLE dbo.MatchType (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(100) NOT NULL
)

INSERT INTO MatchType VALUES ('Solo')
INSERT INTO MatchType VALUES ('Duo')
INSERT INTO MatchType VALUES ('Trio')
INSERT INTO MatchType VALUES ('Squad')


CREATE TABLE dbo.Match (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(100) NOT NULL,
	EpicName nvarchar(100) NOT NULL,
	EventName nvarchar(100) NOT NULL
)

INSERT INTO Match VALUES ('Fortnite World Cup', 'OnlineOpen', 'Event2')

CREATE TABLE dbo.Week (
	ID int IDENTITY(1,1) PRIMARY KEY,
	MatchID int NOT NULL REFERENCES Match(ID),
	MatchTypeID int NOT NULL REFERENCES MatchType(ID),
	Name nvarchar(100) NOT NULL
)

INSERT INTO Week VALUES (1, 1, 'Week 1')
INSERT INTO Week VALUES (1, 2, 'Week 2')
INSERT INTO Week VALUES (1, 1, 'Week 3')
INSERT INTO Week VALUES (1, 2, 'Week 4')
INSERT INTO Week VALUES (1, 1, 'Week 5')
INSERT INTO Week VALUES (1, 2, 'Week 6')
INSERT INTO Week VALUES (1, 1, 'Week 7')
INSERT INTO Week VALUES (1, 2, 'Week 8')
INSERT INTO Week VALUES (1, 1, 'Week 9')
INSERT INTO Week VALUES (1, 2, 'Week 10')

CREATE TABLE dbo.Region (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(100) NOT NULL,
	EpicCode nvarchar(100) NOT NULL 
)

INSERT INTO Region VALUES ('Oceania', 'OCE')
INSERT INTO Region VALUES ('NA East', 'NAE')
INSERT INTO Region VALUES ('NA West', 'NAW')
INSERT INTO Region VALUES ('Europe', 'EU')
INSERT INTO Region VALUES ('Brazil', 'BR')
INSERT INTO Region VALUES ('Asia', 'ASIA')



-- An Epic account. Player name can change from week to week (it is in player week)
CREATE TABLE dbo.Player (
	ID int IDENTITY(1,1) PRIMARY KEY,
	EpicGuid char(32) NOT NULL   
)
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20190719-083914] ON [dbo].[Player] (
	[EpicGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)



CREATE TABLE dbo.PlayerWeek (
	ID int IDENTITY(1,1) PRIMARY KEY,
	PlayerID int NOT NULL REFERENCES Player(ID),
	WeekID int NOT NULL REFERENCES Week(ID),
	Name nvarchar(500) NOT NULL
)



