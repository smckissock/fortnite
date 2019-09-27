USE Fortnite


CREATE OR ALTER VIEW PayoutTierView
AS
SELECT 
	e.Name Event,
	r.Name Region,
	Rank,
	Payout
FROM RankPayoutTier p
JOIN Region r on p.RegionID = r.ID
JOIN Event e ON e.ID = p.EventID





--------------------

SELECT Event, Region, Rank, Payout 
FROM PayoutTierView 
ORDER BY [Event], Region, Rank




SELECT Event, Region, Count(*)  
FROM PayoutTierView 
WHERE Event NOT LIKE ('CC%')
GROUP BY Event, Region
ORDER BY Count(*) 

SELECT * FROM Region


SELECT * fROM PayoutTierView WHERE	 Event = 'CC Friday #1' AND Region = 'Brazil' 


SELECT * FROM Placement


SELECT * fROM StatsWithPlayerInfoView


SELECT * FROM Placement

SELECT Event, Region, Rank, Payout FROM PayoutTierView WHERE Event = 'CC Friday #1' AND Region = 'Europe' ORDER BY Rank


USE [Fortnite]
GO

/****** Object:  View [dbo].[StatsWithPlayerInfoView]    Script Date: 9/26/2019 9:49:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE   VIEW [dbo].[StatsWithPlayerInfoView]  
AS
--    9,000 for top 100
--  165,621 for all placements
--   46,432 all with payouts
SELECT 
	e.Name Event
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
FROM Placement p
JOIN EventView e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE Payout > 0
AND pl.Name <> ''
GO

SELECT Name, WeekID FROM Event

SELECT * FROM Event





