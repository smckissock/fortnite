USE [Fortnite]
GO



CREATE OR ALTER VIEW [dbo].[EventView] AS
SELECT 
	e.ID,
	e.Name, 
	f.Name Format,
	m.Name Match,
	w.ID WeekID,
FROM Event e
JOIN Format f ON e.FormatID = f.ID
JOIN Match m ON e.MatchID = m.ID
JOIN Week w ON w.ID = e.WeekID
GO


