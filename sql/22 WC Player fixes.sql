USE Fortnite
GO


CREATE OR ALTER VIEW [dbo].[PlayerPlacementView] 
AS
SELECT 
	p.ID PlacementID,
	pp.PlayerID PlayerID,
	p.RegionID,
	p.EventID,
	pp.ID PlayerPlacementID,
	pp.Player,
	p.Payout,
	p.Rank,
	e.Name Event
FROM Placement p
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN Event e ON p.EventID = e.ID
GO

SELECT * FROM PLacement WHERE ID = 125014


SELECT * FROM StatsWithPlayerINfoView WHERE Payout = 375000 Order by player


SELECT * FROM PlayerPLacementView WHERE PLacementID = 125014

UPDATE PlayerPLacement SET PlayerID = 29790 WHERE ID = 166644


SELECT * FROM PlayerPLacementView WHERE  PLacementID = 125014


SELECT * FROM PlayerPlacement WHERe Player = 'nqyte'	


SELECT * fROM Player WHERE ID = 29790




SELECT * FROM PLayerEvent WHERe PLayerName = 'nqyte'
											  

SELECT * FROM PlayerPlacementView WHERe Player = '%YTT%'




SELECT  * FROM PlayerPlacement WHERe PlayerID IN (1169
,11108
,29790
,165420) ORDER BY PLacementID

-- Fix Nayte 
UPDATE PlayerPLacement SET PlayerID = 29790 WHERE PlacementID IN (83897, 85200)

UPDATE PlayerPLacement SET PlayerID = 29790 WHERE PlacementID IN (83897)
UPDATE PlayerPLacement SET PlayerID = 29790 WHERE ID = 84421

SELECT * FROM PLayerPlacement WHERE PLacementID = 83897


SELECT * FROM PLayerPLacementView WHERE PLayerID = 29790 ORDER BY PLacementID 





SELECT * FROM PlayerEvent



UPDATE Player SET CurrentName = (SELECT PlayerName FROM PlayerEvent WHERE PlayerID = 8420 AND EventID = 6) WHERE ID = 8420


SELECT * FROM Player WHERE ID = 8420



SELECT * FROM PLayer WHERE CurrentName Like '%commandment%'


SELECT * FROM PLayerEvent  WHERE PlayerName Like '% command%'


UPDATE Player SET CurrentName = (SELECT N'PlayerName' FROM PlayerEvent WHERE PlayerID = 8420 AND EventID = 6) WHERE ID = 8420



SELECT * FROM PLayer WHERE CurrentName Like '%gg %'

SELECT PlayerID, Max(EventID) EventID FROM PlayerEvent GROUP BY PlayerID, PlayerName HAVING PlayerID = 169

SELECT * FROM PLayerEvent


SELECT * FROM PlayerFrontEndChampionSeriesView




