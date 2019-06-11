USE Fortnite
GO

--ALTER TABLE Placement ADD Qualification bit NOT NULL DEFAULT 0



EXEC DropView 'StatView'
GO

CREATE VIEW [dbo].[StatView] 
AS

WITH PointCalc (PlacementID, Points)
AS (
	SELECT PlacementID, SUM(PointsEarned)
	FROM Stat
	GROUP BY PlacementID
),
Wins (PlacementID, Points)
AS (
	SELECT PlacementID, SUM(PointsEarned)
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
	CASE WHEN SoloOrDuo = 'Solo' THEN Payout ELSE Payout / 2 END payout,
	--c.Points PointsFromStats,
	ISNULL(w.Points, 0) wins,
	ISNULL(e.Points, 0) elims,
	ISNULL(w.Points, 0) - ISNULL(e.Points, 0) placementPoints 
FROM Placement p 
JOIN Region r ON p.RegionCode = r.Code 		
LEFT JOIN PointCalc c ON c.PlacementID = p.ID
LEFT JOIN Wins w ON w.PlacementID = p.ID 
LEFT JOIN Elim e ON e.PlacementID = p.ID 
		
GO

SELECT * FROM Placement

DECLARE @week nvarchar(10)
SET @week = 'Week9' 
SELECT top 12 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 12 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 14 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

-- Week9
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID = 



SELECT * FROM StatView ORDER BY DuoWeek DESC