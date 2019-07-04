USE Fortnite
GO



EXEC DropTable 'Player'
GO

CREATE TABLE Player (
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL DEFAULT '',
	[CsvName] [nvarchar](100) NOT NULL DEFAULT '',
	[NationalityID] [int] NOT NULL DEFAULT 1 REFERENCES Nationality(ID),
	[TeamID] [int] NOT NULL DEFAULT 1 REFERENCES Team(ID),
	KbmOrControllerID [int] NOT NULL DEFAULT 1 REFERENCES KbmOrController(ID),
	Age [nvarchar](2) NOT NULL DEFAULT ''
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20190703-112625] ON [dbo].[Player]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


INSERT INTO Player
SELECT DISTINCT 
	Player,
	Player CsvName, 
	(SELECT ID FROM Nationality WHERE Name = Nationality) NationalityID, 
	(SELECT ID FROM Team WHERE Name = Team) TeamID, 
	(SELECT ID FROM KbmOrController WHERE Name = KbmOrController) KbmOrControllerID, 
	Age 
FROM PlayerInfo



ALTER TABLE Placement ADD PlayerID INT NOT NULL DEFAULT 1 REFERENCES Player(ID)



--SELECT DISTINCT PLayer FROM Placement WHERE Player IN (SELECT Name FROM Player)


UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Clipnode') WHERE Player = 'Clipnode' 
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'CoverH') WHERE Player = 'CoverH'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Eclipsae') WHERE Player = 'Eclipsae'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Erouce') WHERE Player = 'Erouce'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Fledermoys') WHERE Player = 'Fledermoys'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'GusTavox8') WHERE Player = 'GusTavox8'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Kawzmik') WHERE Player = 'Kawzmik'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Legedien') WHERE Player = 'Legedien'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Lnuef') WHERE Player = 'Lnuef'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'lolb0om') WHERE Player = 'lolb0om'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Nate Hill') WHERE Player = 'Nate Hill'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Nittle') WHERE Player = 'Nittle'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'pfzin') WHERE Player = 'pfzin'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Reverse2k') WHERE Player = 'Reverse2k'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'RoAtDW') WHERE Player = 'RoAtDW'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Slackes') WHERE Player = 'Slackes'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Snayzy') WHERE Player = 'Snayzy'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Tetchra') WHERE Player = 'Tetchra'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Tfue') WHERE Player = 'Tfue'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'Touzii') WHERE Player = 'Touzii'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'wisheydp') WHERE Player = 'wisheydp'
UPDATE Placement SET PlayerID = (SELECT ID FROM Player WHERE Name = 'XXiF') WHERE Player = 'XXiF'