USE [Fortnite]
GO




CREATE OR ALTER VIEW [dbo].[StatsWithPlayerInfoView]  
AS
SELECT 
	p.ID
	, e.Name Event
	, CASE WHEN Qualification = 1 AND e.Format = 'Solo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END SoloWeek
	, CASE WHEN Qualification = 1 AND e.Format = 'Duo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END DuoWeek
	, e.Format  soloOrDuo
	, pl.Name player
	--, pp.player
	, r.Name region
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
FROM Placement p
JOIN EventView e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE Payout > 0
AND pl.Name <> '' -- 58,288
GO


SELECT TOP 2000 * FROM StatsWithPlayerInfoView WHERE EventID = 1 AND region = 'NA East' ORDER BY ID




