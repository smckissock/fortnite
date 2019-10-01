USE [Fortnite]
GO

EXEC sp_rename 'Week', 'Event'
GO

EXEC sp_rename 'PlayerWeek', 'PlayerEvent'
GO

EXEC sp_rename 'RankPointTier.WeekID', 'EventID', 'COLUMN'; 
EXEC sp_rename 'RankPayoutTier.WeekID', 'EventID', 'COLUMN';
EXEC sp_rename 'PlayerEvent.WeekID', 'EventID', 'COLUMN';
EXEC sp_rename 'PLacement.WeekID', 'EventID', 'COLUMN';


CREATE VIEW [dbo].[EventView] AS
SELECT 
	e.ID,
	e.Name, 
	f.Name Format,
	m.Name Match 
FROM Event e
JOIN Format f ON e.FormatID = f.ID
JOIN Match m ON e.MatchID = m.ID
GO

DROP VIEW WeekView
GO


CREATE OR ALTER VIEW [dbo].[PlacementView]  -- 124947
--- 165,521 after joining on PlayerPlacement
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
	p.Wins
FROM Placement p
JOIN EventView e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN Player pl ON pp.PlayerID = pl.ID 
GO


CREATE OR ALTER VIEW [dbo].[ChampionSeriesPlacementView] 
AS
SELECT  
	p.ID,
	p.Event,
	p.Region,
	STRING_AGG(player,', ') WITHIN GROUP (ORDER BY player) players,
	MAX(p.Rank) Rank,
	MAX(dbo.ChampionSeriesPoints(p.Rank)) ChampionSeriesPoints,
	MAX(p.Payout) Payout,
	MAX(p.Points) Points,
	MAX(p.Elims) Elims,
	MAX(p.Wins) Wins
FROM PlacementView p
WHERE EventID IN (13, 14, 15, 16, 17)
GROUP BY p.ID, p.Event, p.Region
GO


CREATE OR ALTER VIEW [dbo].[ChampionSeriesRankingView] 
AS
SELECT 
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


CREATE OR ALTER VIEW [dbo].[ChampionSeriesView]
AS
SELECT
	p.ID,
	e.Name Event,
	r.Name Region,
	p.Rank,
	p.Points,
	p.Payout,
	p.Elims
FROM Placement p 
JOIN Event e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID 
WHERE EventID IN (13, 14, 15, 16, 17)
AND Payout > 0
GO


CREATE OR ALTER VIEW [dbo].[ChampionSeriesView]
AS
SELECT
	p.ID,
	e.Name Event,
	r.Name Region,
	p.Rank,
	p.Points,
	p.Payout,
	p.Elims
FROM Placement p 
JOIN Event e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID 
WHERE EventID IN (13, 14, 15, 16, 17)
AND Payout > 0
GO



USE [Fortnite]
GO

/****** Object:  View [dbo].[StatsWithPlayerInfoView]    Script Date: 9/21/2019 4:12:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE OR ALTER VIEW [dbo].[StatsWithPlayerInfoView]  
AS
--    9,000 for top 100
--  165,621 for all placements
--   46,432 all with payouts
SELECT 
	e.Name Event
	, CASE WHEN Qualification = 1 AND e.Format = 'Solo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END SoloWeek
	, CASE WHEN Qualification = 1 AND e.Format = 'Duo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END DuoWeek
	, e.Format  soloOrDuo
	, pl.Name player
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
FROM Placement p
JOIN EventView e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE Payout > 0
AND pl.Name <> ''
GO


CREATE OR ALTER VIEW [dbo].[PlayerFrontEndView] 
AS
SELECT DISTINCT
	p.name,
	p.nationality,
	p.team,
	p.age
FROM PlayerInfoView p
JOIN StatsWithPlayerInfoView s ON p.Name = s.player 
WHERE (p.nationality <> '') OR (p.team <> '') OR (p.age <> '')  
GO


CREATE OR ALTER VIEW [dbo].[PlayerInfoView] 
AS
SELECT
	p.CurrentName Name,
	n.Name Nationality,
	t.Name Team,
	p.Age
FROM Player p
JOIN Nationality n ON n.ID = p.NationalityID
JOIN Team t ON t.ID = p.TeamID
JOIN KbmOrController k ON k.ID = p.KbmOrControllerID
GO


CREATE OR ALTER VIEW [dbo].[PlayerPlacementView] 
AS
SELECT 
	p.ID PlacementID,
	pp.PlayerID PlayerID,
	p.RegionID,
	p.EventID 
FROM Placement p
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
GO

CREATE OR ALTER VIEW [dbo].[PlayerView] 
AS
SELECT
	p.ID,
	p.CurrentName Name,
	n.Name Nationality,
	t.Name Team,
	k.Name KbmOrController   
FROM Player p
JOIN Nationality n ON n.ID = p.NationalityID
JOIN Team t ON t.ID = p.TeamID
JOIN KbmOrController k ON k.ID = p.KbmOrControllerID
GO






CREATE OR ALTER VIEW [dbo].[PlayerFrontEndChampionSeriesView] 
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



CREATE OR ALTER VIEW [dbo].[TimelineDuoView] 
AS

SELECT
	g.PlacementID,
	g.SecondsAlive,
	g.GameRank,
	pl.Rank PlacementRank,
	g.EndTime,
	g.Elims,
	pl.Points PlacementPoints,
	pl.EventID,
	pl.Player,
	pl.Region,
	DATEDIFF(SECOND, '19700101', g.EndTime) EndSeconds
FROM Game g
JOIN PlacementView pl on pl.ID = g.PlacementID
WHERE pl.Rank < 101 
AND pl.Region = 'TBD' 
AND pl.Event = 'Week 11'  -- 1890
GO


CREATE OR ALTER VIEW [dbo].[TimelineSoloView] 
AS

SELECT
	g.PlacementID,
	g.SecondsAlive,
	g.GameRank,
	pl.Rank PlacementRank,
	g.EndTime,
	g.Elims,
	pl.Points PlacementPoints,
	pl.EventID,
	pl.Player,
	pl.Region,
	DATEDIFF(SECOND, '19700101', g.EndTime) EndSeconds
FROM Game g
JOIN PlacementView pl on pl.ID = g.PlacementID
WHERE pl.Rank < 101 
AND pl.Region = 'TBD' 
AND pl.Event = 'Week 12'  -- 600 Duo
GO



CREATE OR ALTER VIEW [dbo].[TimelineView] 
AS
-- WC both solos and Duo
SELECT
	g.PlacementID,
	g.SecondsAlive,
	g.GameRank,
	pl.Rank PlacementRank,
	g.EndTime,
	g.Elims,
	pl.Points PlacementPoints,
	pl.EventID,
	pl.Player,
	pl.Region,
	DATEDIFF(SECOND, '19700101', g.EndTime) EndSeconds
FROM Game g
JOIN PlacementView pl on pl.ID = g.PlacementID
WHERE pl.Rank < 101 
AND pl.Region = 'TBD' 
AND (pl.Event = 'Week 11') OR (pl.Event = 'Week 12')  
GO



CREATE OR ALTER VIEW [dbo].[WorldCupFinalView] 
AS
-- WC both solos and Duo
SELECT
	g.PlacementID,
	g.SecondsAlive,
	g.GameRank,
	pl.Rank PlacementRank,
	g.EndTime,
	g.Elims,
	pl.Points PlacementPoints,
	pl.EventID,
	pl.Player,
	pl.Region,
	DATEDIFF(SECOND, '19700101', g.EndTime) EndSeconds
FROM Game g
JOIN PlacementView pl on pl.ID = g.PlacementID
WHERE pl.Rank < 101 
AND pl.Region = 'TBD' 
AND (pl.Event = 'Week 11') OR (pl.Event = 'Week 12')  

GO












