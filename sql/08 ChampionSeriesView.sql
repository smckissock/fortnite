


ALTER VIEW [dbo].[PlacementView]  -- 124947
--- 165,521 after joining on PlayerPlacement
AS
SELECT 
	p.ID,
	w.ID WeekID,
	w.Name Week,
	w.Format Format,
	r.Name Region,
	pl.CurrentName Player,
	p.Rank,
	p.Payout, 
	p.Points,
	p.Elims,
	p.Wins
FROM Placement p
JOIN WeekView w ON p.WeekID = w.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN Player pl ON pp.PlayerID = pl.ID 
GO




EXEC DropView 'ChampionSeriesPlacementView'
GO

CREATE VIEW [dbo].[ChampionSeriesPlacementView] 
AS
SELECT  
	p.ID,
	p.Week,
	p.Region,
	STRING_AGG(player,', ') WITHIN GROUP (ORDER BY player) players,
	MAX(p.Rank) Rank,
	MAX(dbo.ChampionSeriesPoints(p.Rank)) ChampionSeriesPoints,
	MAX(p.Payout) Payout,
	MAX(p.Points) Points,
	MAX(p.Elims) Elims,
	MAX(p.Wins) Wins
FROM PlacementView p
WHERE WeekID IN (13, 14, 15, 16, 17)
GROUP BY p.ID, p.Week, p.Region



SELECT * FROM ChampionSeriesPlacementView WHERE Players Like '%Posi%'




CREATE OR ALTER VIEW [dbo].[ChampionSeriesRankingView] 
AS
SELECT 
	--Week,
	Region,
	Players,
	COUNT(Rank) PlayCount,
	SUM(ChampionSeriesPoints) ChampionSeriesPoints,
	STR(AVG(CONVERT(decimal, Rank)), 10, 1) AverageRank,
	MIN(Rank) BestRank,
	MAX(Rank) WorstRank,
	SUM(Wins) Wins,
	SUM(Payout) Payout,
	SUM(Elims) Elims,
	SUM(Points) Points
FROM ChampionSeriesPlacementView
GROUP BY Region, Players
--HAVING Region = 'NA East' AND COUNT(Rank) = 4 AND MAX(Rank) < 101
--ORDER BY Region, AverageRank 
GO
