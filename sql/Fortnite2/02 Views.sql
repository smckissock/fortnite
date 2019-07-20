USE Fortnite2
GO


EXEC DropView 'WeekView'
GO
CREATE VIEW WeekView AS
SELECT 
	w.ID,
	'Week ' + CONVERT(nvarchar(2), w.ID) Name,
	f.Name Format,
	m.Name Match 
FROM Week w
JOIN Format f ON w.FormatID = f.ID
JOIN Match m ON w.MatchID = m.ID
GO



EXEC DropView 'PlacemenentView'
GO
CREATE VIEW PlacemenentView  -- 124947
--- 165,521 after joining on PlayerPlacement
AS
SELECT 
	p.ID,
	w.Name Week,
	w.Format Format,
	r.Name Region,
	pl.CurrentName Player,
	p.Rank,
	p.Payout, -- Not Populated
	p.Points,
	p.Elims -- Not Populated
FROM Placement p
JOIN WeekView w ON p.WeekID = w.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN Player pl ON pp.PlayerID = pl.ID 


