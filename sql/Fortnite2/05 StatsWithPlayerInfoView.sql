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

SELECT * FROM Fortnite..Placement
SELECT * FROM Placement 


EXEC DropView 'StatsWithPlayerInfoView'
GO
CREATE VIEW [dbo].StatsWithPlayerInfoView  
AS
--    9,000 for top 100
--  165,621 for all placements
--   46,432 all with payouts
SELECT 
	w.Name week,
	CASE WHEN Qualification = 1 AND w.Format = 'Solo' THEN CAST(REPLACE(w.Name, 'Week ', '') AS INT) ELSE 0 END SoloWeek,
	CASE WHEN Qualification = 1 AND w.Format = 'Duo' THEN CAST(REPLACE(w.Name, 'Week ', '') AS INT) ELSE 0 END DuoWeek,
	w.Format  soloOrDuo,
	pl.Name player,
	r.Name region,
	p.Rank rank,
	p.Points points,
	p.Payout payout,
	p.Wins,
	p.Elims elims,
	p.Points - p.elims placementPoints,
	CASE WHEN Qualification = 1 THEN 1 ELSE 0 END +
	CASE WHEN EarnedQualification = 1 THEN 1 ELSE 0 END EarnedQualification,
	pl.Team Team,
	pl.Nationality
FROM Placement p
JOIN WeekView w ON p.WeekID = w.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE Payout > 0

GO
