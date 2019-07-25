USE [Fortnite2]
GO



EXEC DropView 'PlayerInfoView'
GO

CREATE VIEW [dbo].[PlayerInfoView] 
AS
SELECT
	p.CurrentName Name,
	n.Name Nationality,
	t.Name Team,
	p.Age
    --k.Name KbmOrController 
FROM Player p
JOIN Nationality n ON n.ID = p.NationalityID
JOIN Team t ON t.ID = p.TeamID
JOIN KbmOrController k ON k.ID = p.KbmOrControllerID
GO


EXEC DropView 'PlayerFrontEndView'
GO

CREATE VIEW [dbo].[PlayerFrontEndView] 
AS
SELECT DISTINCT
	p.name,
	p.nationality,
	p.team,
	p.age
FROM PlayerInfoView p
JOIN StatsWithPlayerInfoView s ON p.Name = s.player 
WHERE (p.nationality <> '') OR (p.team <> '') OR (p.age <> '')  

