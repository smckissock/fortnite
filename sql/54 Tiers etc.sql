USE [Fortnite]
GO

/****** Object:  View [dbo].[PowerRankingEventsView]    Script Date: 12/11/2019 4:45:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Needs to be updated each week!!
CREATE OR ALTER       VIEW [dbo].[PowerRankingEventsView] 
AS
SELECT 
	e.Name,
	m.Name Match
FROM Event e 
JOIN Match m ON m.ID = e.MatchID
WHERE m.PowerRankings = 1 AND e.WeekID < 23
GO


SELECT * FROM Week


SELECT ID, Name, WeekId FROM Event ORDER BY ID

SELECT * FROM REgion

SELECT * FROM RankPayoutTier

SELECT * FROM RankPayoutTier WHERE RegionID = (SELECT ID FROM Region WHERE Name = 'NA East') AND EventID = 2039


SELECT * FROM RankPayoutTier WHERE RegionID = (SELECT ID FROM Region WHERE Name = 'NA East') AND EventID = 2036


SELECT * FROM Event

SELECT 7500 / 4



SELECT 46875 * 4


SELECT * FROM Event