USE Fortnite
GO

ALTER TABLE Placement ADD PowerPoints DECIMAL (10, 2) NOT NULL DEFAULT 0.0
GO


CREATE OR ALTER VIEW [dbo].[StatsWithPlayerInfoView]  
AS
--    9,000 for top 100
--  165,621 for all placements
--   46,432 all with payouts
SELECT 
	p.ID
	, e.Name Event
	, CASE WHEN Qualification = 1 AND e.Format = 'Solo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END SoloWeek
	, CASE WHEN Qualification = 1 AND e.Format = 'Duo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END DuoWeek
	, e.Format  soloOrDuo
	, pl.Name player
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
	, p.PowerPoints
FROM Placement p
JOIN EventView e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE Payout > 0
AND pl.Name <> ''
GO



SELECT * FROM StatsWithPlayerInfoView



SELECT 
	e.Name Event,
	r.Name Region,
	Rank,
	Payout
FROM RankPayoutTier p
JOIN Region r on p.RegionID = r.ID
JOIN Event e ON e.ID = p.EventID
GO

SELECT * fROM Event

SELECT * FROM PayoutTier

SELECT * FROM RankPayoutTier WHERE EventID = 13 

SELECT Event, Region, Rank, Payout FROM PayoutTierView WHERE Event = 'Solo Final' AND Region = 'NA East' ORDER BY Rank



SELECT EventID, Count(*) FROM RankPayoutTier GROUP BY EventID
