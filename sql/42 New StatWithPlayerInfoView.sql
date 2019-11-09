USE [Fortnite]
GO

/****** Object:  View [dbo].[StatsWithPlayerInfoView]    Script Date: 11/6/2019 6:52:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  OR ALTER    VIEW [dbo].[StatsWithPlayerInfoView]  
AS
SELECT 
	p.ID
	, e.Name Event
	, CASE WHEN Qualification = 1 AND e.Format = 'Solo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END SoloWeek
	, CASE WHEN Qualification = 1 AND e.Format = 'Duo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END DuoWeek
	, e.Format  soloOrDuo
	, pl.Name player
	--, pl.RegionID regionId  -- RegionID of the player
	, CASE WHEN p.RegionID NOT IN (1, 9) THEN p.RegionID ELSE pl.RegionID END regionId  -- RegionID of the placement
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
	, p.PowerPoints RawPowerPoints 
	, pp.player EventPlayerName
	, pl.ID PlayerID
	, e.ID EventID
	, r.Name region -- RegionID for payout tier ("ALL" (9) from WC finals)
FROM Placement p
JOIN EventView e ON p.EventID = e.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE Payout > 0
AND pl.Name NOT IN ('', '?') -- 58,288
GO


--SELECT * fROM Placement WHERE RegionID = 1 



--SELECT * FROM StatsWithPLayerInfoView WHERE RegionID IN (1, 9)



SELECT * FROM Player WHERE CurrentName Like '%HighSky%' -- 78
SELECT * FROM Team -- 49

UPDATE PLayer SET TeamID = 49 WHERE ID = 78 

SELECT * FROM Team

INSERT INTO Team VALUES ('Built by Gamers')
SELECT * FROM Team WHERE Name = 'Built by Gamers' -- 83

SELECT * fROM Player WHERE CurrentName Like '%Posi%' -- 169
SELECT * fROM Player WHERE CurrentName Like 'BBG%' -- 169



SELECT * FROM PLayer WHERE TeamID = 83

UPDATE Player SET TeamID = 83 WHERE ID IN ( 1281
,43
,92
,169
,199
,904
,1007
,1245
,1281
,5531
,11342
,18300
,56390
,188639
,190474
,190886
,191648
,245109
,247909
,298511)



UPDATE PLayer SET TeamID = 83 WHERE ID = 169 




SELECT PlayerID, Max(PlacementID) PlacementID FROM PlayerPlacement GROUP BY PlayerID, Player
HAVING PlayerID = 169







SELECT * fROM Team