USE [Fortnite]
GO


ALTER VIEW [dbo].[PlayerView]
AS

SELECT 
	p.ID
	, p.Name
	, p.CsvName
	, p.Age
	, t.Name Team
	, n.Name Nationality
	, k.Name KbmOrController
	, p.Twitter
FROM Player p
JOIN Team t ON p.TeamID = t.ID
JOIN Nationality n ON p.NationalityID = n.ID
JOIN KbmOrController k ON p.KbmOrControllerID = k.ID
GO





EXEC DropView 'AirtablePlayerView2'
GO

CREATE VIEW AirtablePlayerView2
AS

SELECT DISTINCT 
	p.Player,
	p.RegionCode, 
	pl.Team,
	pl.Nationality,
	pl.KbmOrController, 
	pl.Age,
	pl.Twitter 
FROM Placement p
LEFT JOIN PlayerView pl ON p.PlayerID = pl.ID
WHERE p.Player <> ''


SELECT * FROM AirtablePlayerView2 ORDER BY RegionCode, Player




SELECT * FROM Player


SELECT DISTINCT PLayer FROM Placement WHERE Player NOT IN (SELECT Name FROM Player)  

SELECT Name, Name, 1, 1, 1, '', '' FROM Player


INSERT INTO Player
SELECT DISTINCT Player, Player, 1, 1, 1, '', '' 
FROM Placement WHERE Player NOT IN (SELECT Name FROM Player)  




UPDATE Player SET Age = '', Twitter = '', NationalityID = (SELECT ID FROM Nationality WHERE Name = ''), TeamID = (SELECT ID FROM Team WHERE Name = 'Free Agent'), KbmOrControllerID = (SELECT ID FROM KbmOrController WHERE Name = '') WHERE Name = N'100 Ping No Wall'

SELECT * FROM Player


SELECT Count(*) FROM Player

SELECT * fROM Team
SELECT * FROM Player WHERE Name Like 'Ty%'
SELECT DISTINCT Player FROM Placement

SELECT Count(*) FROM AirtablePlayerView2