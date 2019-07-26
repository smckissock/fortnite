USE Fortnite2
GO

EXEC DropView 'TimelineView'
GO

CREATE VIEW TimelineView 
AS

SELECT
	g.PlacementID,
	g.SecondsAlive,
	g.GameRank,
	g.EndTime,
	g.Elims,
	pl.Points PlacementPoints,
	pl.WeekID,
	pl.Player,
	pl.Region,
	DATEDIFF(SECOND, '19700101', g.EndTime) EndSeconds
FROM Game g
JOIN PlacementView pl on pl.ID = g.PlacementID
WHERE pl.Rank < 21 
AND pl.Region = 'NA East' 
AND pl.Week = 'Week 10' 
GO




