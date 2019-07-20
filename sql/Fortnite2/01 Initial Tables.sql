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


EXEC DropTable 'Game';
EXEC DropTable 'PlayerPlacement'
EXEC DropTable 'PlayerWeek'
EXEC DropTable 'Player'
EXEC DropTable 'Placement'
EXEC DropTable 'Region'
EXEC DropTable 'Week'
EXEC DropTable 'Match'
EXEC DropTable 'Format'




CREATE TABLE dbo.Format (
	ID int IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(100) NOT NULL
)

INSERT INTO Format VALUES ('Solo')
INSERT INTO Format VALUES ('Duo')
INSERT INTO Format VALUES ('Trio')
INSERT INTO Format VALUES ('Squad')


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
	FormatID int NOT NULL REFERENCES Format(ID),
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

INSERT INTO Region VALUES ('TBD', 'TBD')
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
	RegionID int NOT NULL REFERENCES Region(ID),
	PlayerName nvarchar(500) NOT NULL
)
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20190719-230012] ON [dbo].[PlayerWeek]
(
	[PlayerID] ASC,
	[WeekID] ASC,
	[RegionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

GO


CREATE TABLE dbo.Placement (
	ID int IDENTITY(1,1) PRIMARY KEY,
	WeekID int NOT NULL REFERENCES Week(ID),
	RegionID int NOT NULL REFERENCES Region(ID),
	Rank int NOT NULL DEFAULT 0,
	Payout int NOT NULL DEFAULT 0,
	Points int NOT NULL DEFAULT 0,
	Elims int NOT NULL DEFAULT 0
)

-- This is ID 1 - the "blank" or TBD placement 
INSERT INTO Placement (WeekID, RegionID) VALUES (1, 1)
GO


CREATE TABLE dbo.PlayerPlacement (
	ID int IDENTITY(1,1) PRIMARY KEY,
	PlayerID int NOT NULL REFERENCES Player(ID),
	PlacementID int NOT NULL REFERENCES Placement(ID)
)
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20190719-231121] ON [dbo].[PlayerPlacement]
(
	[PlayerID] ASC,
	[PlacementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)


CREATE TABLE Game (
	ID int IDENTITY(1,1) PRIMARY KEY,
	PlacementID int NOT NULL REFERENCES Placement(ID),
	EndTime datetime NOT NULL,
	SecondsAlive int NOT NULL DEFAULT 0, 
	GameRank int NOT NULL,
	Elims int NOT NULL,
	Tiebreaker int NOT NULL
) 



EXEC DropTable 'RankPointTier'
EXEC DropTable 'RankPayoutTier'

CREATE TABLE dbo.RankPointTier (
	ID int IDENTITY(1,1) PRIMARY KEY,
	WeekID int NOT NULL REFERENCES Week(ID),
	RegionID int NOT NULL REFERENCES Region(ID),
	Rank int NOT NULL DEFAULT 0,
	Points int NOT NULL DEFAULT 0
)
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20190720-021911] ON [dbo].[RankPointTier]
(
	[WeekID] ASC,
	[RegionID] ASC,
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)


CREATE TABLE dbo.RankPayoutTier (
	ID int IDENTITY(1,1) PRIMARY KEY,
	WeekID int NOT NULL REFERENCES Week(ID),
	RegionID int NOT NULL REFERENCES Region(ID),
	Rank int NOT NULL DEFAULT 0,
	Payout int NOT NULL DEFAULT 0
)
CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20190720-021910] ON [dbo].[RankPayoutTier]
(
	[WeekID] ASC,
	[RegionID] ASC,
	[Rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)

SELECT * FROM RankPayoutTier
SELECT * FROM RankPointTier


SELECT * FROM RankPayoutTier ORDER BY Payout DESC


-- 02 Import
-- SELECT COUNT(*) FROM Player
-- SELECT COUNT(*) FROM PlayerWeek

-- Duos                                       Added Page 0 HTML   I don't know why these are lower, but have to move on...
--SELECT * FROM Player          --  44,397    45,167              44,733
--SELECT * FROM PlayerPlacement --  76,522    82,780              82,015

-- Then Solos
--SELECT * FROM Player         --	 65,439   65,513			  65,513
--SELECT * FROM PlayerPlacement -- 156,309   165,290             164,789


-- 03 Import 
SELECT COUNT(*) FROM Placement
SELECT COUNT(*) FROM PlayerPlacement
SELECT COUNT(*) FROM game

-- Solos
--SELECT COUNT(*) FROM Placement          83,369
--SELECT COUNT(*) FROM PlayerPlacement    82,847
--SELECT COUNT(*) FROM game              772,032

-- Duos
-- SELECT COUNT(*) FROM Placement           124,949
-- SELECT COUNT(*) FROM PlayerPlacement     165,521
-- SELECT COUNT(*) FROM game              1,162,245   

