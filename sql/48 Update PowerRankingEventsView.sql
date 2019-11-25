


USE [Fortnite]
GO

/****** Object:  View [dbo].[PowerRankingEventsView]    Script Date: 11/18/2019 6:21:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Needs to be updated each week!!
CREATE OR ALTER      VIEW [dbo].[PowerRankingEventsView] 
AS
SELECT 
	e.Name,
	m.Name Match
FROM Event e 
JOIN Match m ON m.ID = e.MatchID
WHERE m.PowerRankings = 1 AND e.WeekID < 22
GO


SELECT  * FROM Week