USE Fortnite
GO



CREATE       VIEW [dbo].[StatsView]  
AS
SELECT 
	p.ID
	, e.Name Event
	, CASE WHEN Qualification = 1 AND e.Format = 'Solo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END SoloWeek
	, CASE WHEN Qualification = 1 AND e.Format = 'Duo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END DuoWeek
	, e.Format  soloOrDuo
	, pl.Name player
	--, pl.RegionID regionId  -- RegionID of the player
	, CASE WHEN p.RegionID NOT IN (1, 9) THEN p.RegionID ELSE pl.RegionID END regionId  -- RegionID of the placement
	, p.Rank rank
	, p.Points points
	, p.Payout payout
	, p.Wins
	, p.Elims elims
	, p.Points - p.elims placementPoints
	, CASE WHEN Qualification = 1 THEN 1 ELSE 0 END +
	  CASE WHEN EarnedQualification = 1 THEN 1 ELSE 0 END EarnedQualification
	, pl.Team Team
	, pl.Nationality
	, p.PowerPoints RawPowerPoints 
	, pp.player EventPlayerName
	, pl.ID PlayerID
	, e.ID EventID
	, r.Name region -- RegionID for payout tier ("ALL" (9) from WC finals)
FROM Placement p
JOIN EventView e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE Payout > 0
AND pl.Name NOT IN ('', '?') -- 58,288
GO




CREATE OR ALTER    VIEW [dbo].[PlayerFrontEndChampionSeriesView] 
AS

WITH 
  AveragePlacement (Player, CsAverage)
  AS
  (
    SELECT Player, CAST(AVG(CAST(Rank AS DECIMAL(10,1))) AS DECIMAL(10,1)) CsPlacement
	FROM StatsWithPlayerInfoView p
	WHERE Event IN ('CS Week 1', 'CS Week 2', 'CS Week 3', 'CS Week 4', 'CS Week 5')
	GROUP BY Player HAVING Count(*) = 5 
  )

SELECT DISTINCT
	p.ID,
	p.name,
	p.nationality,
	p.team,
	p.age,
	ISNULL(a.CsAverage, 0) CsAverage,
	p.RegionID
FROM PlayerInfoView p
JOIN StatsView s ON p.Name = s.player
LEFT JOIN AveragePlacement a ON p.Name = a.Player
WHERE (p.nationality <> '') OR (p.team <> '') OR (p.age <> '')  
GO



CREATE OR ALTER  VIEW [dbo].[PlayerFrontEndView] 
AS
SELECT DISTINCT
	p.name,
	p.nationality,
	p.team,
	p.age
FROM PlayerInfoView p
JOIN StatsView s ON p.Name = s.player 
WHERE (p.nationality <> '') OR (p.team <> '') OR (p.age <> '')  
GO



CREATE OR ALTER   VIEW [dbo].[PowerPointEventRegionTestView]
AS
SELECT
	e.WeekID,
	e.Match, 
	s.Event,
	s.Region,
	FORMAT(SUM(Payout), '#,#') Payout, 
	FORMAT(SUM(RawPowerPoints), '#,#') PowerPoints, 
	FORMAT(SUM(Payout) - SUM(RawPowerPoints), '#,#') Difference,
	FORMAT(((SUM(Payout) - SUM(RawPowerPoints)) / SUM(Payout)), 'P') PercentageDifference
FROM StatsView s
JOIN EventView e ON s.EventID = e.ID 
GROUP BY e.WeekID, e.Match, s.Event, s.Region
GO



CREATE OR ALTER   VIEW [dbo].[PowerPointEventTestView]
AS
SELECT
	e.WeekID,
	e.Match, 
	s.Event,
	FORMAT(SUM(Payout), '#,#') Payout, 
	FORMAT(SUM(RawPowerPoints), '#,#') PowerPoints, 
	FORMAT(SUM(Payout) - SUM(RawPowerPoints), '#,#') Difference,
	FORMAT(((SUM(Payout) - SUM(RawPowerPoints)) / SUM(Payout)), 'P') PercentageDifference
FROM StatsView s
JOIN EventView e ON s.EventID = e.ID 
GROUP BY e.WeekID, e.Match, s.Event
GO



CREATE OR ALTER   VIEW [dbo].[PowerPointTestView]
AS

SELECT 
	s.Event, s.Region,
	FORMAT(SUM(Payout), '#,#') Payout, 
	FORMAT(SUM(RawPowerPoints), '#,#') PowerPoints, 
	FORMAT(SUM(Payout) - SUM(RawPowerPoints), '#,#') Difference,
	FORMAT(((SUM(Payout) - SUM(RawPowerPoints)) / SUM(Payout)), 'P') PercentageDifference
FROM StatsView s
GROUP BY s.Event, s.Region 
GO



CREATE OR ALTER  VIEW [dbo].[SquadTestView]
AS
SELECT 
	Region, 
	Player, 
	SUM(Payout) Payout, 
	SUM(RawPowerPoints) PowerPoints 
FROM StatsView 
WHERE Region <> 'All' 
GROUP BY Region, Player
GO




