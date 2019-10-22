USE Fortnite
GO


ALTER TABLE Match ADD PowerRankings bit NOT NULL DEFAULT 1 

UPDATE Match SET PowerRankings = 0 WHERE Name IN ('Contender''s Cash Cup Wednesday Solos', 'Champions''s Cash Cup Thursday Solos', 'Champions''s Cash Cup Friday Trios')



CREATE OR ALTER  VIEW [dbo].[EventView] AS
SELECT 
	e.ID,
	e.Name, 
	f.Name Format,
	m.Name Match,
	w.ID WeekID,
	f.ID FormatID
FROM Event e
JOIN Format f ON e.FormatID = f.ID
JOIN Match m ON e.MatchID = m.ID
JOIN Week w ON w.ID = e.WeekID
GO




CREATE OR ALTER VIEW [dbo].[PayoutTierView]
AS
SELECT 
	e.Match,
	e.Name Event,
	r.Name Region,
	Rank,
	Payout,
	e.FormatID TeamSize -- 1 = Solo, 2 = Duo, 3 = Trio, 4 = Squad 
FROM RankPayoutTier p
JOIN Region r on p.RegionID = r.ID
JOIN EventView e ON e.ID = p.EventID
GO



CREATE OR ALTER VIEW PowerRankingEventsView 
AS
SELECT 
	e.Name,
	m.Name Match
FROM Event e 
JOIN Match m ON m.ID = e.MatchID
WHERE m.PowerRankings = 1
GO


CREATE OR ALTER  VIEW [dbo].[PowerPointEventTestView]
AS
SELECT
	e.WeekID,
	e.Match, 
	s.Event,
	FORMAT(SUM(Payout), '#,#') Payout, 
	FORMAT(SUM(RawPowerPoints), '#,#') PowerPoints, 
	FORMAT(SUM(Payout) - SUM(RawPowerPoints), '#,#') Difference,
	FORMAT(((SUM(Payout) - SUM(RawPowerPoints)) / SUM(Payout)), 'P') PercentageDifference
FROM StatsWithPlayerInfoView s
JOIN EventView e ON s.EventID = e.ID 
GROUP BY e.WeekID, e.Match, s.Event
GO


CREATE OR ALTER  VIEW [dbo].[PowerPointEventRegionTestView]
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
FROM StatsWithPlayerInfoView s
JOIN EventView e ON s.EventID = e.ID 
GROUP BY e.WeekID, e.Match, s.Event, s.Region
GO

 
SELECT * FROM Placement  -- 260,342
SELECT * FROM Placement WHERE PowerPoints > 0.0 -- 49,090

UPDATE Placement SET PowerPoints = 0.0;



SELECT ID, Region, Event, Rank FROM StatsWithPlayerInfoView WHERE Event IN (SELECT Name FROM PowerRankingEventsView)  


SELECT * FROM PlayerView WHERE Name Like 'E11%'



SELECT ID, Region, Event, Rank, Payout FROM StatsWithPlayerInfoView WHERE Event IN (SELECT Name FROM PowerRankingEventsView) 



SELECT * FROM PowerRankingEventsView


SELECT Match, Event, Region, Rank, Payout, TeamSize FROM PayoutTierView WHERE Event = 'CS Final' AND Region = 'All' ORDER BY Rank
