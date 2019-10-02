USE Fortnite
GO


ALTER TABLE PlayerPlacement ADD Player NVARCHAR(200) NOT NULL DEFAULT ''




CREATE OR ALTER  VIEW [dbo].[PlayerPlacementView] 
AS
SELECT 
	p.ID PlacementID,
	pp.PlayerID PlayerID,
	p.RegionID,
	p.EventID,
	pp.ID PlayerPlacementID
FROM Placement p
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
GO




CREATE OR ALTER VIEW UpdateNameView 
AS
SELECT DISTINCT pp.PlayerID, pp.EventID, pp.RegionID, pe.PlayerName, pp.PLayerPLacementID 
FROM PlayerPlacementView pp
JOIN PlayerEvent pe 
JOIN PLayer p ON pe.PLayerID = p.ID
ON 
	pe.PlayerID = pp.PlayerID AND 
	pe.EventID = pp.EventID AND 
	pe.RegionID = pe.RegionID -- 363.662


SELECT * FROM UpdateNameView -- 366,940

SELECT * FROM PLayerPLacementView


SELECT * fROM PLayerPLacement

UPDATE PLayerPLacement SET PLayer = ''


SELECT * FROM Player WHERE CurrentName = 'Posick'


SELECT * FROM PlayerPlacement WHERE PlayerID = 169


SELECT * FROM PlayerEvent WHERE PlayerID = 169


SELECT * FROM PLayerPlacement WHERE Player = ''