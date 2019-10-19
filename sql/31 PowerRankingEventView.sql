USE Fortnite
GO


ALTER TABLE Match ADD PowerRankings bit NOT NULL DEFAULT 1 

UPDATE Match SET PowerRankings = 0 WHERE Name IN ('Contender''s Cash Cup Wednesday Solos', 'Champions''s Cash Cup Thursday Solos', 'Champions''s Cash Cup Friday Trios')


CREATE OR ALTER VIEW PowerRankingEventsView 
AS
SELECT 
	e.Name 
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