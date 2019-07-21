USE Fortnite2
GO



CREATE VIEW [dbo].[StatsWithPlayerInfoViewX] 
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
	ISNULL(w.Points, 0) wins,
	ISNULL(e.Points, 0) elims,
	ISNULL(p.Points, 0) - ISNULL(e.Points, 0) placementPoints,
	CASE WHEN Qualification = 1 THEN 1 ELSE 0 END +
	CASE WHEN EarnedQualification = 1 THEN 1 ELSE 0 END EarnedQualification,
	pv.Team,
	pv.Nationality   
FROM Placement p 
JOIN PlayerView pv ON pv.ID = p.PlayerID 
JOIN Region r ON p.RegionCode = r.Code 		
LEFT JOIN PointCalc c ON c.PlacementID = p.ID
LEFT JOIN Wins w ON w.PlacementID = p.ID 
LEFT JOIN Elim e ON e.PlacementID = p.ID 
GO


EXEC DropView 'StatsWithPlayerInfoView'
GO
CREATE VIEW [dbo].StatsWithPlayerInfoView  
AS
SELECT 
	w.Name week,
	0 soloWeek,
	0 duoWeek, 
	w.Format  soloOrDuo,
	pl.CurrentName player,
	r.Name region,
	p.Rank rank,
	p.Points points,
	p.Payout payout,
	p.Wins,
	p.Elims elims,
	p.Points - p.elims placementPoints
FROM Placement p
JOIN WeekView w ON p.WeekID = w.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN Player pl ON pp.PlayerID = pl.ID 
GO

SELECT * FROM Placement

SELECT top 10 * FROM FOrtnite..StatsWithPlayerInfoView ORDER BY Week, Rank, region 
SELECT top 10 * FROM StatsWithPlayerInfoView ORDER BY Week, Rank, region



SELECT Count(*) FROM Placement WHERE Wins <> 0


SELECT GameRank FROM Game WHERE PlacementID = 4 ORDER BY EndTime


SELECT * FROM Placement WHERE ID = 4	

