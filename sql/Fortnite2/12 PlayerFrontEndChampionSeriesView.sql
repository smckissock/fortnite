USE [Fortnite]
GO




CREATE OR ALTER VIEW [dbo].[PlayerFrontEndChampionSeriesView] 
AS

WITH 
  AveragePlacement (Player, CsAverage)
  AS
  (
    SELECT Player, CAST(AVG(CAST(Rank AS DECIMAL(10,1))) AS DECIMAL(10,1)) CsPlacement
	FROM StatsWithPlayerInfoView p
	WHERE week IN ('CS Week 1', 'CS Week 2', 'CS Week 3', 'CS Week 4', 'CS Week 5')
	GROUP BY Player HAVING Count(*) = 5 
  )

SELECT DISTINCT
	p.name,
	p.nationality,
	p.team,
	p.age,
	ISNULL(a.CsAverage, 0) CsAverage
FROM PlayerInfoView p
JOIN StatsWithPlayerInfoView s ON p.Name = s.player
LEFT JOIN AveragePlacement a ON p.Name = a.Player
WHERE (p.nationality <> '') OR (p.team <> '') OR (p.age <> '')  

GO



SELECT * FROM PlayerFrontEndChampionSeriesView
