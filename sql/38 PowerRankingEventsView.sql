USE [Fortnite]
GO




-- Needs to be updated each week!!
CREATE OR ALTER   VIEW [dbo].[PowerRankingEventsView] 
AS
SELECT 
	e.Name,
	m.Name Match
FROM Event e 
JOIN Match m ON m.ID = e.MatchID
WHERE m.PowerRankings = 1 AND e.WeekID < 19
GO


