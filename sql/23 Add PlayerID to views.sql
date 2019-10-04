USE [Fortnite]
GO



CREATE OR ALTER VIEW [dbo].[StatsWithPlayerInfoView]  
AS
SELECT 
	p.ID
	, e.Name Event
	, CASE WHEN Qualification = 1 AND e.Format = 'Solo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END SoloWeek
	, CASE WHEN Qualification = 1 AND e.Format = 'Duo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END DuoWeek
	, e.Format  soloOrDuo
	, pl.Name player
	--, pp.player
	, r.Name region
	, p.Rank rank
	, p.Points points
	, p.Payout payout
	, p.Wins
	, p.Elims elims
	, p.Points - p.elims placementPoints
	, CASE WHEN Qualification = 1 THEN 1 ELSE 0 END +
	  CASE WHEN EarnedQualification = 1 THEN 1 ELSE 0 END EarnedQualification
	, pl.Team Team
	, pl.Nationality
	, p.PowerPoints
	, pp.player EventPlayerName
	, pl.ID PlayerID
FROM Placement p
JOIN EventView e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE Payout > 0
AND pl.Name <> '' -- 58,288
GO




CREATE OR ALTER  VIEW [dbo].[PlayerInfoView] 
AS
SELECT
	p.ID,
	p.CurrentName Name,
	n.Name Nationality,
	t.Name Team,
	p.Age,
	p.RegionID
FROM Player p
JOIN Nationality n ON n.ID = p.NationalityID
JOIN Team t ON t.ID = p.TeamID
JOIN KbmOrController k ON k.ID = p.KbmOrControllerID
GO



CREATE OR ALTER  VIEW [dbo].[PlayerFrontEndChampionSeriesView] 
AS

WITH 
  AveragePlacement (Player, CsAverage)
  AS
  (
    SELECT Player, CAST(AVG(CAST(Rank AS DECIMAL(10,1))) AS DECIMAL(10,1)) CsPlacement
	FROM StatsWithPlayerInfoView p
	WHERE Event IN ('CS Week 1', 'CS Week 2', 'CS Week 3', 'CS Week 4', 'CS Week 5')
	GROUP BY Player HAVING Count(*) = 5 
  )

SELECT DISTINCT
	p.ID,
	p.name,
	p.nationality,
	p.team,
	p.age,
	ISNULL(a.CsAverage, 0) CsAverage,
	p.RegionID
FROM PlayerInfoView p
JOIN StatsWithPlayerInfoView s ON p.Name = s.player
LEFT JOIN AveragePlacement a ON p.Name = a.Player
WHERE (p.nationality <> '') OR (p.team <> '') OR (p.age <> '')  
GO





-----
ALTER TABLE Player ADD RegionID INT NOT NULL DEFAULT 1 REFERENCES Region(ID)



SELECT * FROM Region

SELECT * FROM PlayerPLacementView

SELECT * FROM StatsWithPlayerInfoView


SELECT 
	RegionID, Count(*) RegionCount
FROM PlayerPlacementView WHERE PLayerID = 12
GROUP BY RegionID ORDER BY RegionCount DESC 
ORDER By PlayerID


SELECT * FROM StatsWithPlayerInfoView WHERE Event IN ('Solo Final', 'Duo Final') AND Region = 'All'



SELECT * fROM Event


SELECT PlacementID, PlayerID FROM PlayerPlacementView WHERE Event IN ('Solo Final', 'Duo Final')

SELECT PlacementID, PlayerID FROM PlayerPlacementView WHERE Event IN('Solo Final', 'Duo Final')

SELECT 
	PlayerID, 
	RegionID, 
	Count(*) RegionCount



	SELECT * FROM PlayerPLacement WHERE PLayer Like '%Comadon%'












