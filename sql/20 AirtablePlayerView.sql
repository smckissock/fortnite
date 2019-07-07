USE Fortnite 
GO


EXEC DropView 'AirtablePlayerView'
GO

CREATE VIEW AirtablePlayerView
AS

SELECT DISTINCT
	pl.Player,
	RegionCode,
	CsvName,
	Age, 
	Team,
	Nationality,
	KbmOrController
FROM PlayerView p
JOIN Placement pl ON p.ID = Pl.PlayerID 
WHERE Qualification = 1
AND Name <> ''

UNION ALL

SELECT DISTINCT 
	Player, RegionCode, '', '', '', '', '' 
FROM Placement 
WHERE Qualification = 1 
AND Player NOT IN (SELECT Name FROM PlayerView) 





SELECT * FROM AirtablePlayerView
ORDER BY RegionCode, Player 



SELECT * FROM Placement WHERE Player Like '%calc%'



SELECT * FROM Player WHERE Name Like '%ani%'