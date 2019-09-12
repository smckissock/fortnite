


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
	MAX(dbo.ChampionSeriesPoints(p.Rank)) ChampionSeriesRank,
	MAX(p.Payout) Payout,
	MAX(p.Points) Points,
	MAX(p.Elims) Elims,
	MAX(p.Wins) Wins
FROM PlacementView p
WHERE WeekID IN (13, 14, 15, 16, 17)
GROUP BY p.ID, p.Week, p.Region



SELECT * FROM ChampionSeriesPlacementView WHERE Players Like '%Posi%'





EXEC DropView 'ChampionSeriesRankingView'
GO

CREATE VIEW [dbo].[ChampionSeriesRankingView] 
AS
SELECT 
	--Week,
	Region,
	Players,
	COUNT(Rank) PlayCount,
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

SELECT  * FROM ChampionSeriesRankingView



SELECT 
	Players,
	AverageRank,
	BestRank,
	WorstRank,
	Payout,
	Points,
	Wins,
	Elims, 0
FROM ChampionSeriesRankingView
WHERE Region = 'NA West' AND PlayCount = 4 AND WorstRank < 101
ORDER BY Region, AverageRank 



SELECT * FROM ChampionSeriesPlacementView WHERE Players LIKE '%FLY curney%'

, FLY curney, FLY Faultur


SELECT * FROM PlayerPlacement WHERE PlacementID = 126017


SELECT * FROM Player WHERE ID IN (188
,166563
,95)
 