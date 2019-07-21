USE Fortnite2
GO



CREATE TABLE [dbo].[Nationality](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CsvName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Nationality] ADD  DEFAULT ('') FOR [Name]
GO

ALTER TABLE [dbo].[Nationality] ADD  DEFAULT ('') FOR [CsvName]
GO


INSERT INTO Nationality VALUES (N'', N'')
INSERT INTO Nationality VALUES (N'Argentina', N'Argentina')
INSERT INTO Nationality VALUES (N'Australia', N'Australia [b]')
INSERT INTO Nationality VALUES (N'Austria', N'Austria')
INSERT INTO Nationality VALUES (N'Belarus', N'Belarus')
INSERT INTO Nationality VALUES (N'Belgium', N'Belgium')
INSERT INTO Nationality VALUES (N'Brazil', N'Brazil')
INSERT INTO Nationality VALUES (N'Canada', N'Canada')
INSERT INTO Nationality VALUES (N'China', N'China')
INSERT INTO Nationality VALUES (N'Czechia', N'Czechia [i]')
INSERT INTO Nationality VALUES (N'Denmark', N'Denmark')
INSERT INTO Nationality VALUES (N'Finland', N'Finland')
INSERT INTO Nationality VALUES (N'France', N'France [l]')
INSERT INTO Nationality VALUES (N'Germany', N'Germany')
INSERT INTO Nationality VALUES (N'Iraq', N'Iraq')
INSERT INTO Nationality VALUES (N'Ireland', N'Ireland')
INSERT INTO Nationality VALUES (N'Japan', N'Japan')
INSERT INTO Nationality VALUES (N'South Korea', N'Korea (the Republic of) [p]')
INSERT INTO Nationality VALUES (N'Latvia', N'Latvia')
INSERT INTO Nationality VALUES (N'Lithuania', N'Lithuania')
INSERT INTO Nationality VALUES (N'Netherlands', N'Netherlands (the)')
INSERT INTO Nationality VALUES (N'New Zealand', N'New Zealand')
INSERT INTO Nationality VALUES (N'Norway', N'Norway')
INSERT INTO Nationality VALUES (N'Philippines', N'Philippines (the)')
INSERT INTO Nationality VALUES (N'Poland', N'Poland')
INSERT INTO Nationality VALUES (N'Russia', N'Russian Federation (the) [v]')
INSERT INTO Nationality VALUES (N'Slovenia', N'Slovenia')
INSERT INTO Nationality VALUES (N'Spain', N'Spain')
INSERT INTO Nationality VALUES (N'Sweden', N'Sweden')
INSERT INTO Nationality VALUES (N'Switzerland', N'Switzerland')
INSERT INTO Nationality VALUES (N'United Kingdom', N'United Kingdom of Great Britain and Northern Ireland (the)')
INSERT INTO Nationality VALUES (N'United States', N'United States of America (the)')
INSERT INTO Nationality VALUES (N'Viet Nam', N'Viet Nam [ae]')
INSERT INTO Nationality VALUES (N'Peru', N'Peru')



CREATE TABLE [dbo].[Team](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Team] ADD  DEFAULT ('') FOR [Name]
GO


SELECT 'INSERT INTO Team VALUES (N''' + Name + ''')'   
FROM fortnite..team

INSERT INTO Team VALUES (N'')
INSERT INTO Team VALUES (N'100 Thieves')
INSERT INTO Team VALUES (N'4RaiF')
INSERT INTO Team VALUES (N'9z')
INSERT INTO Team VALUES (N'AGO Esports')
INSERT INTO Team VALUES (N'Arcane Esports')
INSERT INTO Team VALUES (N'Bastille Legacy')
INSERT INTO Team VALUES (N'Become Legends')
INSERT INTO Team VALUES (N'Breakaway Esports')
INSERT INTO Team VALUES (N'Chiefs Esports')
INSERT INTO Team VALUES (N'Chiefs Esports Club')
INSERT INTO Team VALUES (N'Cloud 9')
INSERT INTO Team VALUES (N'compLexity Gaming')
INSERT INTO Team VALUES (N'Cooler Esport')
INSERT INTO Team VALUES (N'Counter Logic Gaming')
INSERT INTO Team VALUES (N'Crazy Raccoon')
INSERT INTO Team VALUES (N'Devils.One')
INSERT INTO Team VALUES (N'Dynamind')
INSERT INTO Team VALUES (N'E11 Gaming')
INSERT INTO Team VALUES (N'ePunks')
INSERT INTO Team VALUES (N'Executors One')
INSERT INTO Team VALUES (N'FaZe Clan')
INSERT INTO Team VALUES (N'Fnatic')
INSERT INTO Team VALUES (N'Free Agent')
INSERT INTO Team VALUES (N'FunPlus Phoenix')
INSERT INTO Team VALUES (N'Gambit Esports')
INSERT INTO Team VALUES (N'Gamers Origen')
INSERT INTO Team VALUES (N'Gamers Origin')
INSERT INTO Team VALUES (N'Ghost Gaming')
INSERT INTO Team VALUES (N'Global Esports')
INSERT INTO Team VALUES (N'Helsinki Reds')
INSERT INTO Team VALUES (N'JAM')
INSERT INTO Team VALUES (N'Lazarus Esports')
INSERT INTO Team VALUES (N'Legacy Esports')
INSERT INTO Team VALUES (N'LeStream Esport')
INSERT INTO Team VALUES (N'Lootboy eSport')
INSERT INTO Team VALUES (N'Luminosity Gaming')
INSERT INTO Team VALUES (N'Meta Gaming')
INSERT INTO Team VALUES (N'Mindfreak')
INSERT INTO Team VALUES (N'Misfits Gaming')
INSERT INTO Team VALUES (N'Newbee')
INSERT INTO Team VALUES (N'NRG Esports')
INSERT INTO Team VALUES (N'OP GAMING')
INSERT INTO Team VALUES (N'QUASAR')
INSERT INTO Team VALUES (N'Raised By Kings')
INSERT INTO Team VALUES (N'RED Canids')
INSERT INTO Team VALUES (N'Renegades')
INSERT INTO Team VALUES (N'Riot Squad Esports')
INSERT INTO Team VALUES (N'Sentinels')
INSERT INTO Team VALUES (N'SK Telecom T1')
INSERT INTO Team VALUES (N'Solary')
INSERT INTO Team VALUES (N'T1')
INSERT INTO Team VALUES (N'Team Atlantis')
INSERT INTO Team VALUES (N'Team Envy')
INSERT INTO Team VALUES (N'Team KGA')
INSERT INTO Team VALUES (N'Team KNG')
INSERT INTO Team VALUES (N'Team Liquid')
INSERT INTO Team VALUES (N'Team Overtime')
INSERT INTO Team VALUES (N'Team Queso')
INSERT INTO Team VALUES (N'Team Secret')
INSERT INTO Team VALUES (N'Team Singularity')
INSERT INTO Team VALUES (N'Team Solomid')
INSERT INTO Team VALUES (N'Team WE')
INSERT INTO Team VALUES (N'Tempo Storm')
INSERT INTO Team VALUES (N'The Boys Esports')
INSERT INTO Team VALUES (N'Train Hard')
INSERT INTO Team VALUES (N'Trigger QQ')
INSERT INTO Team VALUES (N'Valhalla Vikings')
INSERT INTO Team VALUES (N'Virtus pro')
INSERT INTO Team VALUES (N'W7M Gaming')
INSERT INTO Team VALUES (N'Warriors Esports')
INSERT INTO Team VALUES (N'WClick')
INSERT INTO Team VALUES (N'World Best Gaming')
INSERT INTO Team VALUES (N'World Gaming Star Storm')



CREATE TABLE [dbo].[KbmOrController](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[KbmOrController] ADD  DEFAULT ('') FOR [Name]
GO


SELECT * FROM Fortnite..KbmOrController

INSERT INTO KbmOrController VALUES ('')

INSERT INTO KbmOrController VALUES ('Controller')
INSERT INTO KbmOrController VALUES ('KB&M')


ALTER TABLE Player ADD NationalityID int NOT NULL DEFAULT 1 REFERENCES Nationality(ID) 
ALTER TABLE PLayer ADD TeamID int NOT NULL DEFAULT 1 REFERENCES Team(ID) 
ALTER TABLE PLayer ADD KbmOrController int NOT NULL DEFAULT 1 REFERENCES KbmOrController(ID) 


UPDATE 
	NewPlayer  
SET 
	NewPlayer.TeamID = oldPlayer.TeamID
FROM 
	Fortnite..player as oldPlayer
INNER JOIN player AS NewPlayer ON oldPlayer.Name = newPLayer.currentName


UPDATE 
	NewPlayer  
SET 
	NewPlayer.TeamID = oldPlayer.TeamID
FROM 
	Fortnite..player as oldPlayer
INNER JOIN player AS NewPlayer ON oldPlayer.Name = newPLayer.currentName




UPDATE 
	NewPlayer  
SET 
	NewPlayer.NationalityID = oldPlayer.NationalityID
FROM 
	Fortnite..player as oldPlayer
INNER JOIN player AS NewPlayer ON oldPlayer.Name = newPLayer.currentName


ALTER TABLE Placement ADD Wins int NOT NULL DEFAULT 0


ALTER TABLE Player ADD Twitter nvarchar(100) NOT NULL DEFAULT ''

ALTER TABLE Player ADD Age nvarchar(2) NOT NULL DEFAULT ''

SELECT * FROM PlacementView

SELECT * FROM Player


SELECT Player, RegionCode, WeekNumber, Rank FROM Fortnite..Placement WHERE Qualification = 1

SELECT Name, TeamID
FROM Fortnite..Player WHERE TeamID <> 1 AND TeamID <> 17 ORDER BY teamID


SELECT 'UPDATE Player SET TeamID = ' + CONVERT(nVARCHAR(100), TeamID)  +  ' WHERE CurrentName = 'N'' + Name + ''''   
FROM Fortnite..Player WHERE TeamID <> 1 AND TeamID <> 17



SELECT 'UPDATE Player SET TeamID = ' + CONVERT(nVARCHAR(100), TeamID) + ' WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = ' + CONVERT(VarChar(10), ID)  + ')'   
FROM Fortnite..Player WHERE TeamID <> 1 AND TeamID <> 17

UPDATE PLayer SET TeamID = 1

UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2)
UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3)
UPDATE Player SET TeamID = 6 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 5)
UPDATE Player SET TeamID = 6 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 6)
UPDATE Player SET TeamID = 33 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 9)
UPDATE Player SET TeamID = 9 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 10)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 11)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 12)
UPDATE Player SET TeamID = 52 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 13)
UPDATE Player SET TeamID = 65 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 16)
UPDATE Player SET TeamID = 65 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 21)
UPDATE Player SET TeamID = 53 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 22)
UPDATE Player SET TeamID = 34 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 25)
UPDATE Player SET TeamID = 39 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 26)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 28)
UPDATE Player SET TeamID = 30 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 30)
UPDATE Player SET TeamID = 18 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 31)
UPDATE Player SET TeamID = 47 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 32)
UPDATE Player SET TeamID = 29 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 33)
UPDATE Player SET TeamID = 29 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 34)
UPDATE Player SET TeamID = 47 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 35)
UPDATE Player SET TeamID = 25 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 39)
UPDATE Player SET TeamID = 45 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 40)
UPDATE Player SET TeamID = 22 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 41)
UPDATE Player SET TeamID = 49 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 44)
UPDATE Player SET TeamID = 24 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 45)
UPDATE Player SET TeamID = 20 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 46)
UPDATE Player SET TeamID = 37 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 47)
UPDATE Player SET TeamID = 20 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 48)
UPDATE Player SET TeamID = 24 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 49)
UPDATE Player SET TeamID = 37 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 50)
UPDATE Player SET TeamID = 8 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 52)
UPDATE Player SET TeamID = 49 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 53)
UPDATE Player SET TeamID = 24 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 54)
UPDATE Player SET TeamID = 19 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 59)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 60)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 62)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 64)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 66)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 67)
UPDATE Player SET TeamID = 36 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 68)
UPDATE Player SET TeamID = 31 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 69)
UPDATE Player SET TeamID = 31 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 70)
UPDATE Player SET TeamID = 27 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 71)
UPDATE Player SET TeamID = 27 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 72)
UPDATE Player SET TeamID = 44 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 73)
UPDATE Player SET TeamID = 14 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 74)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 76)
UPDATE Player SET TeamID = 72 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 79)
UPDATE Player SET TeamID = 7 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 81)
UPDATE Player SET TeamID = 7 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 82)
UPDATE Player SET TeamID = 72 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 83)
UPDATE Player SET TeamID = 30 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 85)
UPDATE Player SET TeamID = 9 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 86)
UPDATE Player SET TeamID = 40 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 87)
UPDATE Player SET TeamID = 4 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 88)
UPDATE Player SET TeamID = 12 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 90)
UPDATE Player SET TeamID = 52 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 91)
UPDATE Player SET TeamID = 19 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 92)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 93)
UPDATE Player SET TeamID = 43 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 95)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 96)
UPDATE Player SET TeamID = 51 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 97)
UPDATE Player SET TeamID = 51 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 98)
UPDATE Player SET TeamID = 32 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 100)
UPDATE Player SET TeamID = 73 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 101)
UPDATE Player SET TeamID = 14 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 102)
UPDATE Player SET TeamID = 14 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 103)
UPDATE Player SET TeamID = 9 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 104)
UPDATE Player SET TeamID = 37 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 105)
UPDATE Player SET TeamID = 37 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 106)
UPDATE Player SET TeamID = 24 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 107)
UPDATE Player SET TeamID = 30 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 108)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 110)
UPDATE Player SET TeamID = 25 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 111)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 112)
UPDATE Player SET TeamID = 16 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 113)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 114)
UPDATE Player SET TeamID = 2 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 117)
UPDATE Player SET TeamID = 35 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 118)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 120)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 121)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 122)
UPDATE Player SET TeamID = 48 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 123)
UPDATE Player SET TeamID = 39 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 124)
UPDATE Player SET TeamID = 35 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 125)
UPDATE Player SET TeamID = 2 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 127)
UPDATE Player SET TeamID = 48 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 129)
UPDATE Player SET TeamID = 28 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 131)
UPDATE Player SET TeamID = 46 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 132)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 134)
UPDATE Player SET TeamID = 2 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 136)
UPDATE Player SET TeamID = 40 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 137)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 139)
UPDATE Player SET TeamID = 40 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 142)
UPDATE Player SET TeamID = 2 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 145)
UPDATE Player SET TeamID = 23 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 146)
UPDATE Player SET TeamID = 8 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 147)
UPDATE Player SET TeamID = 40 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 149)
UPDATE Player SET TeamID = 40 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 150)
UPDATE Player SET TeamID = 8 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 152)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 153)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 154)
UPDATE Player SET TeamID = 54 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 156)
UPDATE Player SET TeamID = 10 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 157)
UPDATE Player SET TeamID = 54 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 160)
UPDATE Player SET TeamID = 41 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 161)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 164)
UPDATE Player SET TeamID = 28 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 165)
UPDATE Player SET TeamID = 42 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 168)
UPDATE Player SET TeamID = 26 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 172)
UPDATE Player SET TeamID = 40 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 173)
UPDATE Player SET TeamID = 46 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 174)
UPDATE Player SET TeamID = 41 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 175)
UPDATE Player SET TeamID = 46 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 176)
UPDATE Player SET TeamID = 50 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 177)
UPDATE Player SET TeamID = 50 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 178)
UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1353)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1356)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1357)
UPDATE Player SET TeamID = 9 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1366)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1367)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1368)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1372)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1373)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1374)
UPDATE Player SET TeamID = 20 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1375)
UPDATE Player SET TeamID = 20 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1376)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1379)
UPDATE Player SET TeamID = 24 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1385)
UPDATE Player SET TeamID = 24 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1388)
UPDATE Player SET TeamID = 27 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1391)
UPDATE Player SET TeamID = 9 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1393)
UPDATE Player SET TeamID = 30 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1394)
UPDATE Player SET TeamID = 71 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1396)
UPDATE Player SET TeamID = 28 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1399)
UPDATE Player SET TeamID = 35 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1400)
UPDATE Player SET TeamID = 71 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1402)
UPDATE Player SET TeamID = 37 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1406)
UPDATE Player SET TeamID = 64 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1408)
UPDATE Player SET TeamID = 31 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1412)
UPDATE Player SET TeamID = 46 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1413)
UPDATE Player SET TeamID = 2 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1428)
UPDATE Player SET TeamID = 2 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1429)
UPDATE Player SET TeamID = 2 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1431)
UPDATE Player SET TeamID = 54 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1446)
UPDATE Player SET TeamID = 54 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1451)
UPDATE Player SET TeamID = 60 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1474)
UPDATE Player SET TeamID = 60 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1475)
UPDATE Player SET TeamID = 60 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1476)
UPDATE Player SET TeamID = 60 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1477)
UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1493)
UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1494)
UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1496)
UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1497)
UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1498)
UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1499)
UPDATE Player SET TeamID = 3 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1500)
UPDATE Player SET TeamID = 62 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1544)
UPDATE Player SET TeamID = 62 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1545)
UPDATE Player SET TeamID = 62 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1546)
UPDATE Player SET TeamID = 62 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1547)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1707)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1708)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1709)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1711)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1712)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1714)
UPDATE Player SET TeamID = 38 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1715)
UPDATE Player SET TeamID = 41 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 1967)
UPDATE Player SET TeamID = 59 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2026)
UPDATE Player SET TeamID = 74 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2056)
UPDATE Player SET TeamID = 9 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2073)
UPDATE Player SET TeamID = 9 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2074)
UPDATE Player SET TeamID = 9 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2075)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2089)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2090)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2091)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2092)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2093)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2094)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2095)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2096)
UPDATE Player SET TeamID = 11 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2097)
UPDATE Player SET TeamID = 57 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2298)
UPDATE Player SET TeamID = 57 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2299)
UPDATE Player SET TeamID = 57 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2300)
UPDATE Player SET TeamID = 57 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2301)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2331)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2332)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2333)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2335)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2336)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2340)
UPDATE Player SET TeamID = 13 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2341)
UPDATE Player SET TeamID = 14 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2387)
UPDATE Player SET TeamID = 56 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2390)
UPDATE Player SET TeamID = 56 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2391)
UPDATE Player SET TeamID = 65 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2441)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2485)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2486)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2488)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2489)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2490)
UPDATE Player SET TeamID = 15 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2491)
UPDATE Player SET TeamID = 16 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2550)
UPDATE Player SET TeamID = 16 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2551)
UPDATE Player SET TeamID = 16 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2552)
UPDATE Player SET TeamID = 19 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2632)
UPDATE Player SET TeamID = 19 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2633)
UPDATE Player SET TeamID = 19 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2634)
UPDATE Player SET TeamID = 19 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2635)
UPDATE Player SET TeamID = 19 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2636)
UPDATE Player SET TeamID = 59 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2654)
UPDATE Player SET TeamID = 59 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2655)
UPDATE Player SET TeamID = 59 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2656)
UPDATE Player SET TeamID = 59 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2657)
UPDATE Player SET TeamID = 59 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2658)
UPDATE Player SET TeamID = 59 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2659)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2671)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2673)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2674)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2676)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2677)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2678)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2679)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2680)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2681)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2682)
UPDATE Player SET TeamID = 21 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2683)
UPDATE Player SET TeamID = 66 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 2946)
UPDATE Player SET TeamID = 70 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3073)
UPDATE Player SET TeamID = 70 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3074)
UPDATE Player SET TeamID = 24 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3208)
UPDATE Player SET TeamID = 26 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3215)
UPDATE Player SET TeamID = 41 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3243)
UPDATE Player SET TeamID = 41 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3244)
UPDATE Player SET TeamID = 41 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3245)
UPDATE Player SET TeamID = 23 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3337)
UPDATE Player SET TeamID = 23 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3338)
UPDATE Player SET TeamID = 23 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3341)
UPDATE Player SET TeamID = 27 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3438)
UPDATE Player SET TeamID = 27 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3439)
UPDATE Player SET TeamID = 27 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3441)
UPDATE Player SET TeamID = 28 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3514)
UPDATE Player SET TeamID = 28 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3515)
UPDATE Player SET TeamID = 28 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3516)
UPDATE Player SET TeamID = 28 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3517)
UPDATE Player SET TeamID = 29 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3578)
UPDATE Player SET TeamID = 29 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3579)
UPDATE Player SET TeamID = 64 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3698)
UPDATE Player SET TeamID = 68 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3858)
UPDATE Player SET TeamID = 74 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3859)
UPDATE Player SET TeamID = 54 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3887)
UPDATE Player SET TeamID = 63 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3888)
UPDATE Player SET TeamID = 63 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3889)
UPDATE Player SET TeamID = 63 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3890)
UPDATE Player SET TeamID = 63 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3891)
UPDATE Player SET TeamID = 71 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3904)
UPDATE Player SET TeamID = 32 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3930)
UPDATE Player SET TeamID = 32 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3933)
UPDATE Player SET TeamID = 32 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3934)
UPDATE Player SET TeamID = 58 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3952)
UPDATE Player SET TeamID = 58 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3953)
UPDATE Player SET TeamID = 58 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3955)
UPDATE Player SET TeamID = 58 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 3956)
UPDATE Player SET TeamID = 33 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4013)
UPDATE Player SET TeamID = 33 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4014)
UPDATE Player SET TeamID = 33 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4015)
UPDATE Player SET TeamID = 44 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4132)
UPDATE Player SET TeamID = 44 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4133)
UPDATE Player SET TeamID = 44 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4134)
UPDATE Player SET TeamID = 35 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4140)
UPDATE Player SET TeamID = 35 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4141)
UPDATE Player SET TeamID = 30 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4358)
UPDATE Player SET TeamID = 30 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4377)
UPDATE Player SET TeamID = 44 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4402)
UPDATE Player SET TeamID = 64 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4410)
UPDATE Player SET TeamID = 64 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4411)
UPDATE Player SET TeamID = 64 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4412)
UPDATE Player SET TeamID = 64 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4413)
UPDATE Player SET TeamID = 64 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4415)
UPDATE Player SET TeamID = 31 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4545)
UPDATE Player SET TeamID = 31 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4546)
UPDATE Player SET TeamID = 31 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4547)
UPDATE Player SET TeamID = 31 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4548)
UPDATE Player SET TeamID = 43 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4562)
UPDATE Player SET TeamID = 49 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4564)
UPDATE Player SET TeamID = 49 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4565)
UPDATE Player SET TeamID = 49 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4566)
UPDATE Player SET TeamID = 49 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4567)
UPDATE Player SET TeamID = 49 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4568)
UPDATE Player SET TeamID = 49 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4569)
UPDATE Player SET TeamID = 46 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4590)
UPDATE Player SET TeamID = 46 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4591)
UPDATE Player SET TeamID = 46 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4592)
UPDATE Player SET TeamID = 70 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4716)
UPDATE Player SET TeamID = 51 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4832)
UPDATE Player SET TeamID = 51 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4833)
UPDATE Player SET TeamID = 51 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4834)
UPDATE Player SET TeamID = 51 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4836)
UPDATE Player SET TeamID = 54 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4901)
UPDATE Player SET TeamID = 54 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4902)
UPDATE Player SET TeamID = 61 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4903)
UPDATE Player SET TeamID = 61 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4904)
UPDATE Player SET TeamID = 61 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4905)
UPDATE Player SET TeamID = 61 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4906)
UPDATE Player SET TeamID = 61 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4907)
UPDATE Player SET TeamID = 67 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4919)
UPDATE Player SET TeamID = 69 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4921)
UPDATE Player SET TeamID = 69 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4922)
UPDATE Player SET TeamID = 69 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4923)
UPDATE Player SET TeamID = 69 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4924)
UPDATE Player SET TeamID = 69 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4925)
UPDATE Player SET TeamID = 69 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 4926)
UPDATE Player SET TeamID = 66 WHERE CurrentName = (SELECT Name FROM Fortnite..Player WHERE ID = 5107)

SELECT * FROM Player WHERE CurrentName Like '9z K%'

SELECT * FROM Player WHERe CurrentName Like '9z ki%' 
UPDATE Player SET TeamID = 3 WHERE CurrentName = '9z king'
UPDATE Player SET TeamID = 3 WHERE CurrentName = N'xown iwnl-'
UPDATE Player SET TeamID = 6 WHERE CurrentName = N'hype'
UPDATE Player SET TeamID = 6 WHERE CurrentName = N'Serpennt'
UPDATE Player SET TeamID = 33 WHERE CurrentName = N'Twins iwnl'
UPDATE Player SET TeamID = 9 WHERE CurrentName = N'COOLER Aqua'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 Stompy'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 Tschiiinken'
UPDATE Player SET TeamID = 52 WHERE CurrentName = N'VP 7ssk7'
UPDATE Player SET TeamID = 65 WHERE CurrentName = N'dk iwnl'
UPDATE Player SET TeamID = 65 WHERE CurrentName = N'CODE NICKSSS'
UPDATE Player SET TeamID = 53 WHERE CurrentName = N'pfzin'
UPDATE Player SET TeamID = 34 WHERE CurrentName = N'RS Kolorful'
UPDATE Player SET TeamID = 39 WHERE CurrentName = N'Envy LeNain'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Sean'
UPDATE Player SET TeamID = 30 WHERE CurrentName = N'NRG Zayt'
UPDATE Player SET TeamID = 18 WHERE CurrentName = N'Evilmare'
UPDATE Player SET TeamID = 47 WHERE CurrentName = N'KBB'
UPDATE Player SET TeamID = 29 WHERE CurrentName = N'Newbee_xMende'
UPDATE Player SET TeamID = 29 WHERE CurrentName = N'NewbeeXXM'
UPDATE Player SET TeamID = 47 WHERE CurrentName = N'YuWang'
UPDATE Player SET TeamID = 25 WHERE CurrentName = N'Lootboy Skram'
UPDATE Player SET TeamID = 45 WHERE CurrentName = N'Th0masHD'
UPDATE Player SET TeamID = 22 WHERE CurrentName = N'hREDS BELAEU'
UPDATE Player SET TeamID = 49 WHERE CurrentName = N'TrainH BlastRR'
UPDATE Player SET TeamID = 24 WHERE CurrentName = N'LeStream Blaxou'
UPDATE Player SET TeamID = 20 WHERE CurrentName = N'Deadra'
UPDATE Player SET TeamID = 37 WHERE CurrentName = N'Solary Hunter'
UPDATE Player SET TeamID = 20 WHERE CurrentName = N'M11Z'
UPDATE Player SET TeamID = 24 WHERE CurrentName = N'LeStream Nayte'
UPDATE Player SET TeamID = 37 WHERE CurrentName = N'Solary Nikof'
UPDATE Player SET TeamID = 8 WHERE CurrentName = N'coL Punisher'
UPDATE Player SET TeamID = 49 WHERE CurrentName = N'TrainH Robabz'
UPDATE Player SET TeamID = 24 WHERE CurrentName = N'Skite'
UPDATE Player SET TeamID = 19 WHERE CurrentName = N'Gambit.fwexY'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'L–µtshe'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'bell'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'Scarl√´t'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'Cant spell'
UPDATE Player SET TeamID = 36 WHERE CurrentName = N'Arius'
UPDATE Player SET TeamID = 31 WHERE CurrentName = N'TOP_Banny Iwnl'
UPDATE Player SET TeamID = 31 WHERE CurrentName = N'Can''t type it. '
UPDATE Player SET TeamID = 27 WHERE CurrentName = N'Code Meta-Hood.J'
UPDATE Player SET TeamID = 27 WHERE CurrentName = N'Meta Peterpan'
UPDATE Player SET TeamID = 44 WHERE CurrentName = N'Secret_Domentos'
UPDATE Player SET TeamID = 14 WHERE CurrentName = N'Eon RedRush'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Mitr0'
UPDATE Player SET TeamID = 72 WHERE CurrentName = N'CoverH'
UPDATE Player SET TeamID = 7 WHERE CurrentName = N'Parpy'
UPDATE Player SET TeamID = 7 WHERE CurrentName = N'Slaya'
UPDATE Player SET TeamID = 72 WHERE CurrentName = N'Code Twizz'
UPDATE Player SET TeamID = 30 WHERE CurrentName = N'NRG MrSavageM'
UPDATE Player SET TeamID = 9 WHERE CurrentName = N'COOLER Nyhrox'
UPDATE Player SET TeamID = 40 WHERE CurrentName = N'Barl'
UPDATE Player SET TeamID = 4 WHERE CurrentName = N'JarkoS'
UPDATE Player SET TeamID = 12 WHERE CurrentName = N'dMind.Teeq'
UPDATE Player SET TeamID = 52 WHERE CurrentName = N'VP JAMSIDE'
UPDATE Player SET TeamID = 19 WHERE CurrentName = N'Gambit.letw1k3'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis K1nzell'
UPDATE Player SET TeamID = 43 WHERE CurrentName = N'TQ Prisi0n3r0'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Vorwenn'
UPDATE Player SET TeamID = 51 WHERE CurrentName = N'VHV Chapix'
UPDATE Player SET TeamID = 51 WHERE CurrentName = N'VHV Crue'
UPDATE Player SET TeamID = 32 WHERE CurrentName = N'RBK LeftEye'
UPDATE Player SET TeamID = 73 WHERE CurrentName = N'Tchub_'
UPDATE Player SET TeamID = 14 WHERE CurrentName = N'Eon Wakie'
UPDATE Player SET TeamID = 14 WHERE CurrentName = N'Eon Znappy'
UPDATE Player SET TeamID = 9 WHERE CurrentName = N'BTL 4zr'
UPDATE Player SET TeamID = 37 WHERE CurrentName = N'Solary Airwaks'
UPDATE Player SET TeamID = 37 WHERE CurrentName = N'Solary Kinstaar'
UPDATE Player SET TeamID = 24 WHERE CurrentName = N'LeStream Vato'
UPDATE Player SET TeamID = 30 WHERE CurrentName = N'NRG Benjyfishy'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 Itemm'
UPDATE Player SET TeamID = 25 WHERE CurrentName = N'Lootboy Mexe'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'Secret_Mongraal'
UPDATE Player SET TeamID = 16 WHERE CurrentName = N'Fnatic Smeef'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis Tuckz'
UPDATE Player SET TeamID = 2 WHERE CurrentName = N'Arkhram1x'
UPDATE Player SET TeamID = 35 WHERE CurrentName = N'CODE Sen-Aspect'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Aydan'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Bizzle'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 BlooTea'
UPDATE Player SET TeamID = 48 WHERE CurrentName = N'Brush'
UPDATE Player SET TeamID = 39 WHERE CurrentName = N'Envy Bucke'
UPDATE Player SET TeamID = 35 WHERE CurrentName = N'SEN Bugha'
UPDATE Player SET TeamID = 2 WHERE CurrentName = N'100T Ceice'
UPDATE Player SET TeamID = 48 WHERE CurrentName = N'CizLucky'
UPDATE Player SET TeamID = 28 WHERE CurrentName = N'MSF Clix'
UPDATE Player SET TeamID = 46 WHERE CurrentName = N'TSM_Comadon'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Dubs.'
UPDATE Player SET TeamID = 2 WHERE CurrentName = N'100T Elevate'
UPDATE Player SET TeamID = 40 WHERE CurrentName = N'EpikWhale'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZCe Funk'
UPDATE Player SET TeamID = 40 WHERE CurrentName = N'KNG Jay.'
UPDATE Player SET TeamID = 2 WHERE CurrentName = N'100T Klass'
UPDATE Player SET TeamID = 23 WHERE CurrentName = N'LZR Kreo'
UPDATE Player SET TeamID = 8 WHERE CurrentName = N'coL Lanjok'
UPDATE Player SET TeamID = 40 WHERE CurrentName = N'Leno'
UPDATE Player SET TeamID = 40 WHERE CurrentName = N'KNG Little'
UPDATE Player SET TeamID = 8 WHERE CurrentName = N'coL Mackwood'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Megga.'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'Nate Hill'
UPDATE Player SET TeamID = 54 WHERE CurrentName = N'1400 Pika'
UPDATE Player SET TeamID = 10 WHERE CurrentName = N'CLG Psalm'
UPDATE Player SET TeamID = 54 WHERE CurrentName = N'1400 Rhux uwu'
UPDATE Player SET TeamID = 41 WHERE CurrentName = N'Liquid Riversan'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Saf'
UPDATE Player SET TeamID = 28 WHERE CurrentName = N'Sceptic'
UPDATE Player SET TeamID = 42 WHERE CurrentName = N'Spadess'
UPDATE Player SET TeamID = 26 WHERE CurrentName = N'Tyler15'
UPDATE Player SET TeamID = 40 WHERE CurrentName = N'KNG Unknown'
UPDATE Player SET TeamID = 46 WHERE CurrentName = N'TSM_Vinny1x'
UPDATE Player SET TeamID = 41 WHERE CurrentName = N'Liquid Vivid'
UPDATE Player SET TeamID = 46 WHERE CurrentName = N'TSM_Zexrow'
UPDATE Player SET TeamID = 50 WHERE CurrentName = N'TriggerQQ Flame'
UPDATE Player SET TeamID = 50 WHERE CurrentName = N'TriggerQQ Uniq'
UPDATE Player SET TeamID = 3 WHERE CurrentName = N'9z k?ng'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis L?tshe'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis Mitr0'
UPDATE Player SET TeamID = 9 WHERE CurrentName = N'COOLER aqua??'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.???? bell'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.???? TAKAMURA'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Funk'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Issa'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Saf'
UPDATE Player SET TeamID = 20 WHERE CurrentName = N'GO De?dr?'
UPDATE Player SET TeamID = 20 WHERE CurrentName = N'GO M11Z'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'Klusiabtw'
UPDATE Player SET TeamID = 24 WHERE CurrentName = N'LeStream Skite'
UPDATE Player SET TeamID = 24 WHERE CurrentName = N'L?Str?am Nayte'
UPDATE Player SET TeamID = 27 WHERE CurrentName = N'Meta Hood.J'
UPDATE Player SET TeamID = 9 WHERE CurrentName = N'Noward.'
UPDATE Player SET TeamID = 30 WHERE CurrentName = N'NRG benj?fish?'
UPDATE Player SET TeamID = 71 WHERE CurrentName = N'p?rpy'
UPDATE Player SET TeamID = 28 WHERE CurrentName = N'scptc'
UPDATE Player SET TeamID = 35 WHERE CurrentName = N'SEN Bugh?'
UPDATE Player SET TeamID = 71 WHERE CurrentName = N'sl?y?'
UPDATE Player SET TeamID = 37 WHERE CurrentName = N'Solary NÓkof'
UPDATE Player SET TeamID = 64 WHERE CurrentName = N'T1 ???? Arius'
UPDATE Player SET TeamID = 31 WHERE CurrentName = N'TOP_???? FaxFox'
UPDATE Player SET TeamID = 46 WHERE CurrentName = N'TSM.Vinny1x'
UPDATE Player SET TeamID = 2 WHERE CurrentName = N'100T Kenith'
UPDATE Player SET TeamID = 2 WHERE CurrentName = N'100T Kyzui'
UPDATE Player SET TeamID = 2 WHERE CurrentName = N'100? SirD'
UPDATE Player SET TeamID = 54 WHERE CurrentName = N'1400 Joel'
UPDATE Player SET TeamID = 54 WHERE CurrentName = N'1400 Visz'
UPDATE Player SET TeamID = 60 WHERE CurrentName = N'4RaiF_GoRou'
UPDATE Player SET TeamID = 60 WHERE CurrentName = N'4RaiF_min10ns'
UPDATE Player SET TeamID = 60 WHERE CurrentName = N'4RaiF_Nagomin'
UPDATE Player SET TeamID = 60 WHERE CurrentName = N'4RaiF_Tonbo'
UPDATE Player SET TeamID = 3 WHERE CurrentName = N'9z Lagarto'
UPDATE Player SET TeamID = 3 WHERE CurrentName = N'9z Leobas'
UPDATE Player SET TeamID = 3 WHERE CurrentName = N'9z Patÿ'
UPDATE Player SET TeamID = 3 WHERE CurrentName = N'9z santidead'
UPDATE Player SET TeamID = 3 WHERE CurrentName = N'9z Twayko'
UPDATE Player SET TeamID = 3 WHERE CurrentName = N'9z zEkÿ'
UPDATE Player SET TeamID = 3 WHERE CurrentName = N'9z Zzk7'
UPDATE Player SET TeamID = 62 WHERE CurrentName = N'AE l Exterminia'
UPDATE Player SET TeamID = 62 WHERE CurrentName = N'AE l Ghost'
UPDATE Player SET TeamID = 62 WHERE CurrentName = N'AE l Meguita'
UPDATE Player SET TeamID = 62 WHERE CurrentName = N'AE l NKÿ'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'ATL khuna'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis Astro'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis Dev?l'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis Flikk'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis Ice'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis kejseR'
UPDATE Player SET TeamID = 38 WHERE CurrentName = N'Atlantis Magin'
UPDATE Player SET TeamID = 41 WHERE CurrentName = N'Cented'
UPDATE Player SET TeamID = 59 WHERE CurrentName = N'CODE GE_Eraser'
UPDATE Player SET TeamID = 74 WHERE CurrentName = N'CODE ZOTIEBOY'
UPDATE Player SET TeamID = 9 WHERE CurrentName = N'COOLER Gebber'
UPDATE Player SET TeamID = 9 WHERE CurrentName = N'COOLER loto'
UPDATE Player SET TeamID = 9 WHERE CurrentName = N'COOLER Tokarin'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.Crazy??'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.Daruma'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.Francisco'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.Scarlet No.1'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.Toppy xd'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.UyuRiru'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.VanilLa'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.Yus??'
UPDATE Player SET TeamID = 11 WHERE CurrentName = N'CR.???? RizArt'
UPDATE Player SET TeamID = 57 WHERE CurrentName = N'DV1 Hoopek'
UPDATE Player SET TeamID = 57 WHERE CurrentName = N'DV1 qln'
UPDATE Player SET TeamID = 57 WHERE CurrentName = N'DV1 Shikuni'
UPDATE Player SET TeamID = 57 WHERE CurrentName = N'DV1 V1ns'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 Boyer'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 Crippa'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 daxor.'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 Grazca'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 Joseph'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 Zino'
UPDATE Player SET TeamID = 13 WHERE CurrentName = N'E11 ??ART'
UPDATE Player SET TeamID = 14 WHERE CurrentName = N'Eon Kris'
UPDATE Player SET TeamID = 56 WHERE CurrentName = N'ePunks Ciceey'
UPDATE Player SET TeamID = 56 WHERE CurrentName = N'ePunks zus'
UPDATE Player SET TeamID = 65 WHERE CurrentName = N'ez 4 blackoutz'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Bini'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Diggy'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Jaomock'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Jarvi?'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Martoz'
UPDATE Player SET TeamID = 15 WHERE CurrentName = N'FaZe Tilt'
UPDATE Player SET TeamID = 16 WHERE CurrentName = N'Fnatic Motor'
UPDATE Player SET TeamID = 16 WHERE CurrentName = N'Fnatic Pr0v?kd'
UPDATE Player SET TeamID = 16 WHERE CurrentName = N'Fnatic Verox'
UPDATE Player SET TeamID = 19 WHERE CurrentName = N'Gambit AstroSMZ'
UPDATE Player SET TeamID = 19 WHERE CurrentName = N'Gambit Azze'
UPDATE Player SET TeamID = 19 WHERE CurrentName = N'Gambit Mawakha'
UPDATE Player SET TeamID = 19 WHERE CurrentName = N'Gambit Pate1k'
UPDATE Player SET TeamID = 19 WHERE CurrentName = N'Gambit Toose'
UPDATE Player SET TeamID = 59 WHERE CurrentName = N'GE_fa1zzy'
UPDATE Player SET TeamID = 59 WHERE CurrentName = N'GE_milfy1'
UPDATE Player SET TeamID = 59 WHERE CurrentName = N'GE_Nut'
UPDATE Player SET TeamID = 59 WHERE CurrentName = N'GE_Paengdol'
UPDATE Player SET TeamID = 59 WHERE CurrentName = N'GE_Swillium'
UPDATE Player SET TeamID = 59 WHERE CurrentName = N'GE_Zuko'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'gg thwifo'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost A??ault'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Dmo'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Ghoulx'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Kamo'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Kayuun'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Snood'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Tr?pped'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Webs'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost Z?rby'
UPDATE Player SET TeamID = 21 WHERE CurrentName = N'Ghost ?ssault'
UPDATE Player SET TeamID = 66 WHERE CurrentName = N'JAM Gheez'
UPDATE Player SET TeamID = 70 WHERE CurrentName = N'KGA backho'
UPDATE Player SET TeamID = 70 WHERE CurrentName = N'KGA SexyBoy'
UPDATE Player SET TeamID = 24 WHERE CurrentName = N'LeStream TheVic'
UPDATE Player SET TeamID = 26 WHERE CurrentName = N'LG beehive'
UPDATE Player SET TeamID = 41 WHERE CurrentName = N'Liquid POACH'
UPDATE Player SET TeamID = 41 WHERE CurrentName = N'LiquidChap'
UPDATE Player SET TeamID = 41 WHERE CurrentName = N'LiquidFiber'
UPDATE Player SET TeamID = 23 WHERE CurrentName = N'LZR Arcohs'
UPDATE Player SET TeamID = 23 WHERE CurrentName = N'LZR Kiwiface'
UPDATE Player SET TeamID = 23 WHERE CurrentName = N'LZR Vide'
UPDATE Player SET TeamID = 27 WHERE CurrentName = N'Meta Envy'
UPDATE Player SET TeamID = 27 WHERE CurrentName = N'Meta HardCarry'
UPDATE Player SET TeamID = 27 WHERE CurrentName = N'Meta Spidermon'
UPDATE Player SET TeamID = 28 WHERE CurrentName = N'MSF Famhood'
UPDATE Player SET TeamID = 28 WHERE CurrentName = N'MSF Heads'
UPDATE Player SET TeamID = 28 WHERE CurrentName = N'MSF ops qt'
UPDATE Player SET TeamID = 28 WHERE CurrentName = N'MSF Sheep'
UPDATE Player SET TeamID = 29 WHERE CurrentName = N'Newbee_uxo'
UPDATE Player SET TeamID = 29 WHERE CurrentName = N'Newbee_WenQian'
UPDATE Player SET TeamID = 64 WHERE CurrentName = N'Old Man Fulmer'
UPDATE Player SET TeamID = 68 WHERE CurrentName = N'Psyper'
UPDATE Player SET TeamID = 74 WHERE CurrentName = N'Pulgaboyola'
UPDATE Player SET TeamID = 54 WHERE CurrentName = N'quanzy.'
UPDATE Player SET TeamID = 63 WHERE CurrentName = N'QUASAR Devest_c'
UPDATE Player SET TeamID = 63 WHERE CurrentName = N'QUASAR Losted'
UPDATE Player SET TeamID = 63 WHERE CurrentName = N'QUASAR Luanzera'
UPDATE Player SET TeamID = 63 WHERE CurrentName = N'QUASAR Woodzilla'
UPDATE Player SET TeamID = 71 WHERE CurrentName = N'radius loves you'
UPDATE Player SET TeamID = 32 WHERE CurrentName = N'RBK Ritz'
UPDATE Player SET TeamID = 32 WHERE CurrentName = N'RBK Trizz'
UPDATE Player SET TeamID = 32 WHERE CurrentName = N'RBK Zyppaan'
UPDATE Player SET TeamID = 58 WHERE CurrentName = N'RED Avlr'
UPDATE Player SET TeamID = 58 WHERE CurrentName = N'RED Snow.'
UPDATE Player SET TeamID = 58 WHERE CurrentName = N'RED technoviking'
UPDATE Player SET TeamID = 58 WHERE CurrentName = N'RED ZecaPiranha'
UPDATE Player SET TeamID = 33 WHERE CurrentName = N'RNG Her?hicals'
UPDATE Player SET TeamID = 33 WHERE CurrentName = N'RNG mrfresha?ian'
UPDATE Player SET TeamID = 33 WHERE CurrentName = N'RNG_x2Jes?e'
UPDATE Player SET TeamID = 44 WHERE CurrentName = N'Secret Fuzzy'
UPDATE Player SET TeamID = 44 WHERE CurrentName = N'Secret Osmo'
UPDATE Player SET TeamID = 44 WHERE CurrentName = N'Secret_Milan'
UPDATE Player SET TeamID = 35 WHERE CurrentName = N'SEN Animal'
UPDATE Player SET TeamID = 35 WHERE CurrentName = N'SEN Carose'
UPDATE Player SET TeamID = 30 WHERE CurrentName = N'Svennoss'
UPDATE Player SET TeamID = 30 WHERE CurrentName = N'Symfuhny'
UPDATE Player SET TeamID = 44 WHERE CurrentName = N'S?cret_Osmo.'
UPDATE Player SET TeamID = 64 WHERE CurrentName = N'T1 Medusa iwnl'
UPDATE Player SET TeamID = 64 WHERE CurrentName = N'T1 Persecute'
UPDATE Player SET TeamID = 64 WHERE CurrentName = N'T1 PSANGAE'
UPDATE Player SET TeamID = 64 WHERE CurrentName = N'T1 Quickss'
UPDATE Player SET TeamID = 64 WHERE CurrentName = N'T1 Sofa'
UPDATE Player SET TeamID = 31 WHERE CurrentName = N'TOP_Aimhero_o'
UPDATE Player SET TeamID = 31 WHERE CurrentName = N'TOP_include'
UPDATE Player SET TeamID = 31 WHERE CurrentName = N'TOP_Ming'
UPDATE Player SET TeamID = 31 WHERE CurrentName = N'TOP_Puzz'
UPDATE Player SET TeamID = 43 WHERE CurrentName = N'TQ Naranj1t0'
UPDATE Player SET TeamID = 49 WHERE CurrentName = N'TrainH Alphaa'
UPDATE Player SET TeamID = 49 WHERE CurrentName = N'TrainH Falconly'
UPDATE Player SET TeamID = 49 WHERE CurrentName = N'TrainH French'
UPDATE Player SET TeamID = 49 WHERE CurrentName = N'TrainH Sayreez'
UPDATE Player SET TeamID = 49 WHERE CurrentName = N'TrainH Seth'
UPDATE Player SET TeamID = 49 WHERE CurrentName = N'TrainH Yagsou'
UPDATE Player SET TeamID = 46 WHERE CurrentName = N'TSM_Cloud.'
UPDATE Player SET TeamID = 46 WHERE CurrentName = N'TSM_Kaysid'
UPDATE Player SET TeamID = 46 WHERE CurrentName = N'TSM_Myth'
UPDATE Player SET TeamID = 70 WHERE CurrentName = N'Twitch_Kyuhan'
UPDATE Player SET TeamID = 51 WHERE CurrentName = N'VHV Dangoms'
UPDATE Player SET TeamID = 51 WHERE CurrentName = N'VHV Edr4k1ll'
UPDATE Player SET TeamID = 51 WHERE CurrentName = N'VHV IDrop'
UPDATE Player SET TeamID = 51 WHERE CurrentName = N'VHV Stuffs'
UPDATE Player SET TeamID = 54 WHERE CurrentName = N'WBG Ranger'
UPDATE Player SET TeamID = 54 WHERE CurrentName = N'WBG Wheels'
UPDATE Player SET TeamID = 61 WHERE CurrentName = N'WCK Erni'
UPDATE Player SET TeamID = 61 WHERE CurrentName = N'WCK Francholigan'
UPDATE Player SET TeamID = 61 WHERE CurrentName = N'WCK Matousky'
UPDATE Player SET TeamID = 61 WHERE CurrentName = N'WCK Onesuch'
UPDATE Player SET TeamID = 61 WHERE CurrentName = N'WCK Skiper'
UPDATE Player SET TeamID = 67 WHERE CurrentName = N'westyfishy'
UPDATE Player SET TeamID = 69 WHERE CurrentName = N'WGS_HOON'
UPDATE Player SET TeamID = 69 WHERE CurrentName = N'WGS_Horde'
UPDATE Player SET TeamID = 69 WHERE CurrentName = N'WGS_JAG'
UPDATE Player SET TeamID = 69 WHERE CurrentName = N'WGS_MacChan'
UPDATE Player SET TeamID = 69 WHERE CurrentName = N'WGS_Qoo'
UPDATE Player SET TeamID = 69 WHERE CurrentName = N'WGS_Sopra'
UPDATE Player SET TeamID = 66 WHERE CurrentName = N'zorehfishy'



