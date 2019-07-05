USE [Fortnite]
GO

EXEC DropView 'PlayerView'
GO

CREATE VIEW PlayerView
AS
SELECT 
	p.ID
	, p.Name
	, p.CsvName
	, p.Age
	, t.Name Team
	, n.Name Nationality
	, k.Name KbmOrController
FROM Player p
JOIN Team t ON p.TeamID = t.ID
JOIN Nationality n ON p.NationalityID = n.ID
JOIN KbmOrController k ON p.KbmOrControllerID = k.ID

SELECT * FROM PlayerView


SELECT * FROM StatsWithPlayerInfoView -- 9000


EXEC DropView 'StatsWithPlayerInfoView'
GO
CREATE VIEW [dbo].[StatsWithPlayerInfoView] 
AS

WITH PointCalc (PlacementID, Points)
AS (
	SELECT PlacementID, SUM(PointsEarned)
	FROM Stat
	GROUP BY PlacementID
),
Wins (PlacementID, Points)
AS (
	SELECT PlacementID, SUM(PointsEarned) / 3
	FROM Stat
	WHERE StatIndex = 'PLACEMENT_STAT_INDEX:1'
	GROUP BY PlacementID
),
Elim (PlacementID, Points)
AS (
	SELECT PlacementID, SUM(PointsEarned)
	FROM Stat
	WHERE StatIndex LIKE '%ELIMS%' 
	GROUP BY PlacementID
)

SELECT 
	--p.ID,
	REPLACE(WeekNumber, 'k', 'k ') week,
	CASE WHEN Qualification = 1 AND SoloOrDuo = 'Solo' THEN CAST(REPLACE(WeekNumber, 'Week', '') AS INT) ELSE 0 END SoloWeek,
	CASE WHEN Qualification = 1 AND SoloOrDuo = 'Duo' THEN CAST(REPLACE(WeekNumber, 'Week', '') AS INT) ELSE 0 END DuoWeek, 
	p.soloOrDuo,
	p.player,
	r.Name region,
	rank,
	p.points,
	payout,
	-- NO - the payout for duos is already divided by 2 in the Epic data!!
	--CASE WHEN SoloOrDuo = 'Solo' THEN Payout ELSE Payout / 2 END payout,
	--c.Points PointsFromStats,
	ISNULL(w.Points, 0) wins,
	ISNULL(e.Points, 0) elims,
	ISNULL(p.Points, 0) - ISNULL(e.Points, 0) placementPoints,
	CASE WHEN Qualification = 1 THEN 1 ELSE 0 END +
	CASE WHEN EarnedQualification = 1 THEN 1 ELSE 0 END EarnedQualification,
	pv.Team,
	pv.Nationality   
FROM Placement p 
JOIN Region r ON p.RegionCode = r.Code 		
LEFT JOIN PointCalc c ON c.PlacementID = p.ID
LEFT JOIN Wins w ON w.PlacementID = p.ID 
LEFT JOIN Elim e ON e.PlacementID = p.ID 
LEFT JOIN PlayerView pv ON pv.ID = p.PlayerID  		
GO


