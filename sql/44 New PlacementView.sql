USE [Fortnite]
GO


CREATE OR ALTER VIEW [dbo].[PlacementView]  
AS
SELECT 
	p.ID,
	e.ID EventID,
	e.Name Event,
	e.Format Format,
	r.Name Region,
	pl.CurrentName Player,
	p.Rank,
	p.Payout, 
	p.Points,
	p.Elims,
	p.Wins,
	pl.ID PlayerID
FROM Placement p
JOIN EventView e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN Player pl ON pp.PlayerID = pl.ID 
GO


