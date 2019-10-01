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
	ISNULL(p.Points, 0) - ISNULL(e.Points, 0) placementPoints 
FROM Placement p 
JOIN Region r ON p.RegionCode = r.Code 		
LEFT JOIN PointCalc c ON c.PlacementID = p.ID
LEFT JOIN Wins w ON w.PlacementID = p.ID 
LEFT JOIN Elim e ON e.PlacementID = p.ID 
		
GO

SELECT * FROM Placement

DECLARE @week nvarchar(10)
SET @week = 'Week1' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

-- Week1
UPDATE Placement SET Qualification = 1 WHERE ID = 24001
UPDATE Placement SET Qualification = 1 WHERE ID = 24002
UPDATE Placement SET Qualification = 1 WHERE ID = 24003
UPDATE Placement SET Qualification = 1 WHERE ID = 24004
UPDATE Placement SET Qualification = 1 WHERE ID = 24006
UPDATE Placement SET Qualification = 1 WHERE ID = 25201
UPDATE Placement SET Qualification = 1 WHERE ID = 25202
UPDATE Placement SET Qualification = 1 WHERE ID = 26401 
UPDATE Placement SET Qualification = 1 WHERE ID = 26402
UPDATE Placement SET Qualification = 1 WHERE ID = 26403
UPDATE Placement SET Qualification = 1 WHERE ID = 26404
UPDATE Placement SET Qualification = 1 WHERE ID = 26405
UPDATE Placement SET Qualification = 1 WHERE ID = 26406
UPDATE Placement SET Qualification = 1 WHERE ID = 26407
UPDATE Placement SET Qualification = 1 WHERE ID = 26408
UPDATE Placement SET Qualification = 1 WHERE ID = 27601
UPDATE Placement SET Qualification = 1 WHERE ID = 28801
UPDATE Placement SET Qualification = 1 WHERE ID = 30001


DECLARE @week nvarchar(10)
SET @week = 'Week2' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 24402
UPDATE Placement SET Qualification = 1 WHERE ID = 24401
UPDATE Placement SET Qualification = 1 WHERE ID = 24404
UPDATE Placement SET Qualification = 1 WHERE ID = 24403
UPDATE Placement SET Qualification = 1 WHERE ID = 24406
UPDATE Placement SET Qualification = 1 WHERE ID = 24405
UPDATE Placement SET Qualification = 1 WHERE ID = 25601
UPDATE Placement SET Qualification = 1 WHERE ID = 25602
UPDATE Placement SET Qualification = 1 WHERE ID = 26802
UPDATE Placement SET Qualification = 1 WHERE ID = 26801
UPDATE Placement SET Qualification = 1 WHERE ID = 26804
UPDATE Placement SET Qualification = 1 WHERE ID = 26803
UPDATE Placement SET Qualification = 1 WHERE ID = 26806
UPDATE Placement SET Qualification = 1 WHERE ID = 26805
UPDATE Placement SET Qualification = 1 WHERE ID = 26808
UPDATE Placement SET Qualification = 1 WHERE ID = 26807
UPDATE Placement SET Qualification = 1 WHERE ID = 28002
UPDATE Placement SET Qualification = 1 WHERE ID = 28001
UPDATE Placement SET Qualification = 1 WHERE ID = 29202 
UPDATE Placement SET Qualification = 1 WHERE ID = 29201
UPDATE Placement SET Qualification = 1 WHERE ID = 30402
UPDATE Placement SET Qualification = 1 WHERE ID = 30401



DECLARE @week nvarchar(10)
SET @week = 'Week3' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 24101 
UPDATE Placement SET Qualification = 1 WHERE ID = 24102 
UPDATE Placement SET Qualification = 1 WHERE ID = 24103
UPDATE Placement SET Qualification = 1 WHERE ID = 24104
UPDATE Placement SET Qualification = 1 WHERE ID = 24105 
UPDATE Placement SET Qualification = 1 WHERE ID = 24107
UPDATE Placement SET Qualification = 1 WHERE ID = 25301
UPDATE Placement SET Qualification = 1 WHERE ID = 25302
UPDATE Placement SET Qualification = 1 WHERE ID = 26501
UPDATE Placement SET Qualification = 1 WHERE ID = 26502
UPDATE Placement SET Qualification = 1 WHERE ID = 26503
UPDATE Placement SET Qualification = 1 WHERE ID = 26504
UPDATE Placement SET Qualification = 1 WHERE ID = 26505
UPDATE Placement SET Qualification = 1 WHERE ID = 26506 
UPDATE Placement SET Qualification = 1 WHERE ID = 26507 
UPDATE Placement SET Qualification = 1 WHERE ID = 26508
UPDATE Placement SET Qualification = 1 WHERE ID = 27701 
UPDATE Placement SET Qualification = 1 WHERE ID = 28901
UPDATE Placement SET Qualification = 1 WHERE ID = 28902
UPDATE Placement SET Qualification = 1 WHERE ID = 30101  
UPDATE Placement SET Qualification = 1 WHERE ID = 30102


DECLARE @week nvarchar(10)
SET @week = 'Week4' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 10 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 24602
UPDATE Placement SET Qualification = 1 WHERE ID = 24601
UPDATE Placement SET Qualification = 1 WHERE ID = 24604
UPDATE Placement SET Qualification = 1 WHERE ID = 24603
UPDATE Placement SET Qualification = 1 WHERE ID = 24606
UPDATE Placement SET Qualification = 1 WHERE ID = 24605 
UPDATE Placement SET Qualification = 1 WHERE ID = 25802
UPDATE Placement SET Qualification = 1 WHERE ID = 25801
UPDATE Placement SET Qualification = 1 WHERE ID = 28202
UPDATE Placement SET Qualification = 1 WHERE ID = 28201

UPDATE Placement SET Qualification = 1 WHERE ID = 27004
UPDATE Placement SET Qualification = 1 WHERE ID = 27003
UPDATE Placement SET Qualification = 1 WHERE ID = 27005
UPDATE Placement SET Qualification = 1 WHERE ID = 27006
UPDATE Placement SET Qualification = 1 WHERE ID = 27008
UPDATE Placement SET Qualification = 1 WHERE ID = 27007
UPDATE Placement SET Qualification = 1 WHERE ID = 27010  
UPDATE Placement SET Qualification = 1 WHERE ID = 27009 


DECLARE @week nvarchar(10)
SET @week = 'Week5' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 24202
UPDATE Placement SET Qualification = 1 WHERE ID = 24204
UPDATE Placement SET Qualification = 1 WHERE ID = 24205
UPDATE Placement SET Qualification = 1 WHERE ID = 24206 
UPDATE Placement SET Qualification = 1 WHERE ID = 24207
UPDATE Placement SET Qualification = 1 WHERE ID = 24208
UPDATE Placement SET Qualification = 1 WHERE ID = 25402
UPDATE Placement SET Qualification = 1 WHERE ID = 25403
UPDATE Placement SET Qualification = 1 WHERE ID = 26601
UPDATE Placement SET Qualification = 1 WHERE ID = 26602
UPDATE Placement SET Qualification = 1 WHERE ID = 26603
UPDATE Placement SET Qualification = 1 WHERE ID = 26604
UPDATE Placement SET Qualification = 1 WHERE ID = 26605
UPDATE Placement SET Qualification = 1 WHERE ID = 26606 
UPDATE Placement SET Qualification = 1 WHERE ID = 26607 
UPDATE Placement SET Qualification = 1 WHERE ID = 26608
UPDATE Placement SET Qualification = 1 WHERE ID = 27801 
UPDATE Placement SET Qualification = 1 WHERE ID = 29001 
UPDATE Placement SET Qualification = 1 WHERE ID = 30201


DECLARE @week nvarchar(10)
SET @week = 'Week6' 
SELECT top 10 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 16 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 24802
UPDATE Placement SET Qualification = 1 WHERE ID = 24801 
UPDATE Placement SET Qualification = 1 WHERE ID = 24804
UPDATE Placement SET Qualification = 1 WHERE ID = 24803
UPDATE Placement SET Qualification = 1 WHERE ID = 24810
UPDATE Placement SET Qualification = 1 WHERE ID = 24809
UPDATE Placement SET Qualification = 1 WHERE ID = 26002
UPDATE Placement SET Qualification = 1 WHERE ID = 26001
UPDATE Placement SET Qualification = 1 WHERE ID = 27204
UPDATE Placement SET Qualification = 1 WHERE ID = 27203
UPDATE Placement SET Qualification = 1 WHERE ID = 27208
UPDATE Placement SET Qualification = 1 WHERE ID = 27207
UPDATE Placement SET Qualification = 1 WHERE ID = 27210
UPDATE Placement SET Qualification = 1 WHERE ID = 27209
UPDATE Placement SET Qualification = 1 WHERE ID = 27214
UPDATE Placement SET Qualification = 1 WHERE ID = 27213
UPDATE Placement SET Qualification = 1 WHERE ID = 28401 
UPDATE Placement SET Qualification = 1 WHERE ID = 28402 
UPDATE Placement SET Qualification = 1 WHERE ID = 29602
UPDATE Placement SET Qualification = 1 WHERE ID = 29601
UPDATE Placement SET Qualification = 1 WHERE ID = 30803
UPDATE Placement SET Qualification = 1 WHERE ID = 30804 


DECLARE @week nvarchar(10)
SET @week = 'Week7' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 12 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 24301
UPDATE Placement SET Qualification = 1 WHERE ID = 24302
UPDATE Placement SET Qualification = 1 WHERE ID = 24304
UPDATE Placement SET Qualification = 1 WHERE ID = 24306 
UPDATE Placement SET Qualification = 1 WHERE ID = 24307
UPDATE Placement SET Qualification = 1 WHERE ID = 24308
UPDATE Placement SET Qualification = 1 WHERE ID = 25501
UPDATE Placement SET Qualification = 1 WHERE ID = 25502
UPDATE Placement SET Qualification = 1 WHERE ID = 26701
UPDATE Placement SET Qualification = 1 WHERE ID = 26702
UPDATE Placement SET Qualification = 1 WHERE ID = 26703
UPDATE Placement SET Qualification = 1 WHERE ID = 26705
UPDATE Placement SET Qualification = 1 WHERE ID = 26706
UPDATE Placement SET Qualification = 1 WHERE ID = 26707
UPDATE Placement SET Qualification = 1 WHERE ID = 26708
UPDATE Placement SET Qualification = 1 WHERE ID = 26709
UPDATE Placement SET Qualification = 1 WHERE ID = 27901 
UPDATE Placement SET Qualification = 1 WHERE ID = 29101 
UPDATE Placement SET Qualification = 1 WHERE ID = 29102
UPDATE Placement SET Qualification = 1 WHERE ID = 30301 
UPDATE Placement SET Qualification = 1 WHERE ID = 30302


DECLARE @week nvarchar(10)
SET @week = 'Week8' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 16 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 25002
UPDATE Placement SET Qualification = 1 WHERE ID = 25001
UPDATE Placement SET Qualification = 1 WHERE ID = 25004
UPDATE Placement SET Qualification = 1 WHERE ID = 25003
UPDATE Placement SET Qualification = 1 WHERE ID = 25005
UPDATE Placement SET Qualification = 1 WHERE ID = 25006
UPDATE Placement SET Qualification = 1 WHERE ID = 26204
UPDATE Placement SET Qualification = 1 WHERE ID = 26203
UPDATE Placement SET Qualification = 1 WHERE ID = 27407
UPDATE Placement SET Qualification = 1 WHERE ID = 27408
UPDATE Placement SET Qualification = 1 WHERE ID = 27410
UPDATE Placement SET Qualification = 1 WHERE ID = 27409
UPDATE Placement SET Qualification = 1 WHERE ID = 27411
UPDATE Placement SET Qualification = 1 WHERE ID = 27412
UPDATE Placement SET Qualification = 1 WHERE ID = 27414
UPDATE Placement SET Qualification = 1 WHERE ID = 27413


SELECT * FROM StatView ORDER BY DuoWeek DESC