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
	NewPlayer.NationalityID = oldPlayer.NationalityID
FROM 
	Fortnite..player as oldPlayer
INNER JOIN player AS NewPlayer ON oldPlayer.Name = newPLayer.currentName

