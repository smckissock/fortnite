USE [Fortnite]
GO

/****** Object:  View [dbo].[StatsWithPlayerInfoView]    Script Date: 11/6/2019 6:18:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE     VIEW [dbo].[StatsWithPlayerInfoView]  
AS
SELECT 
	p.ID
	, e.Name Event
	, CASE WHEN Qualification = 1 AND e.Format = 'Solo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END SoloWeek
	, CASE WHEN Qualification = 1 AND e.Format = 'Duo' THEN CAST(REPLACE(e.Name, 'WC Week ', '') AS INT) ELSE 0 END DuoWeek
	, e.Format  soloOrDuo
	, pl.Name player
	, pl.RegionID regionId  -- RegionID of the player
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
AND pl.Name <> '' -- 58,288
GO

SELECT * FROM StatsWithPlayerINfoView WHERe RegionID = 1 

UPDATE 

SELECT PlayerID, Region FROM StatsWithPlayerINfoView WHERE RegionID = 1 


SELECT 'UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = ''', Region, ''') WHERE ID = ', PlayerID   FROM StatsWithPlayerINfoView WHERE RegionID = 1 



UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Europe') WHERE ID = 	167700
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Asia') WHERE ID = 	168363
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Middle East') WHERE ID = 	171846
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Middle East') WHERE ID = 	171846
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Middle East') WHERE ID = 	177900
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Middle East') WHERE ID = 	178087
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Middle East') WHERE ID = 	178197
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'NA East') WHERE ID = 	178309
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'NA East') WHERE ID = 	178309
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'NA East') WHERE ID = 	178309
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Brazil') WHERE ID = 	180666
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'Brazil') WHERE ID = 	180666
UPDATE Player SET RegionID = (SELECT ID FROM Region WHERe Name = 'NA East') WHERE ID = 	181411


SELECT * fROM PLayer WHERE CurrentName = 'Viable Justice'   166801


-- Good one
CREATE OR ALTER VIEW PlayerRegionView 
AS
SELECT p.ID PlayerID, p.RegionID, SUM(Payout) Payout  
FROM PlayerPlacement pp
JOIN Placement p ON pp.PlacementID = p.ID 
WHERE p.RegionID NOT IN (1, 9)
GROUP BY p.ID, p.RegionID


SELECT * FROM PlayerRegionView WHERE PLayerID =  166801
 


SELECT * FROM PlayerRegionView WHERe RegionID = 1

WHERE pp.PlayerID = 166801  




CREATE   VIEW [dbo].[PlayerRegionView]
AS

SELECT 
	s.PlayerID, s.RegionID, SUM(s.Payout) Payout  
FROM StatsWithPlayerInfoView s
WHERE s.RegionID <> 9
GROUP BY s.PlayerID, s.RegionID
GO



SELECT PlayerID, RegionID, Payout FROM PlayerRegionView ORDER BY PlayerID, Payout ASC
