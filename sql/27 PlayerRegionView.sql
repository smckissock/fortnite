USE Fortnite
GO


CREATE OR ALTER VIEW PlayerRegionView
AS

SELECT 
	s.PlayerID, s.RegionID, SUM(s.Payout) Payout  
FROM StatsWithPlayerInfoView s
WHERE s.RegionID <> 9
GROUP BY s.PlayerID, s.RegionID

-
SELECT * FROM Placement WHERE EventID = (SELECT ID FROM Event WHERE Name = 'Duo Final')  
SELECT * FROM Placement WHERE EventID = (SELECT ID FROM Event WHERE Name = 'Solo Final')  

UPDATE Placement SET RegionID = 9 WHERE EventID = 11
UPDATE Placement SET RegionID = 9 WHERE EventID = 12

GO



CREATE OR ALTER  VIEW [dbo].[PlayerView] 
AS
SELECT
	p.ID,
	p.CurrentName Name,
	n.Name Nationality,
	t.Name Team,
	k.Name KbmOrController,
	p.RegionID,
	r.Name Region
FROM Player p
JOIN Nationality n ON n.ID = p.NationalityID
JOIN Team t ON t.ID = p.TeamID
JOIN Region r ON p.RegionID = r.ID 
JOIN KbmOrController k ON k.ID = p.KbmOrControllerID
GO




CREATE OR ALTER   VIEW [dbo].[StatsWithPlayerInfoView]  
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



-- I'm just going to put these guys in Asia!!

--SELECT * FROM StatsWithPLayerInfoView WHERE RegionID = 9 ORDER BY Event,  Rank
--124982	Duo Final	0	0	Duo	KBB	9	27	18	50000	0	13	5	0			108498.82	KBB	165364	11
--124982	Duo Final	0	0	Duo	YuWang	9	27	18	50000	0	13	5	0			108498.82	YuWang	165365	11
--124997	Duo Final	0	0	Duo	Ming	9	42	8	50000	0	5	3	0			40687.06	Ming	165394	11
--124997	Duo Final	0	0	Duo	Puzz	9	42	8	50000	0	5	3	0			40687.06	Puzz	165306	11
--125051	Solo Final	0	0	Solo	DRG	9	45	14	50000	0	4	10	0			149547.72	DRG	165457	12
--125052	Solo Final	0	0	Solo	PrisiOn3rO	9	46	13	50000	0	8	5	0			146877.23	PrisiOn3rO	165458	12
--125060	Solo Final	0	0	Solo	Evilmare	9	54	12	50000	0	6	6	0			125513.27	Evilmare	165466	12
--125072	Solo Final	0	0	Solo	Emqu	9	66	10	50000	0	5	5	0			93467.33	Emqu	165478	12
--125074	Solo Final	0	0	Solo	sozmann	9	68	6	50000	0	6	0	0			88126.34	sozmann	165480	12
--125080	Solo Final	0	0	Solo	snow	9	74	5	50000	0	2	3	0			72103.37	snow	165486	12
--125081	Solo Final	0	0	Solo	drakiNz	9	75	5	50000	0	2	3	0			69432.87	drakiNz	165487	12
--125084	Solo Final	0	0	Solo	slaya	9	78	4	50000	0	1	3	0			61421.39	slaya	165490	12
--125090	Solo Final	0	0	Solo	marteen	9	84	3	50000	0	3	0	0			45398.42	marteen	165496	12
--125091	Solo Final	0	0	Solo	karhu	9	85	2	50000	0	2	0	0			42727.92	karhu	165497	12
--125096	Solo Final	0	0	Solo	Revers2k	9	90	1	50000	0	1	0	0			29375.45	Revers2k	165502	12
--125099	Solo Final	0	0	Solo	Hornet	9	93	1	50000	0	1	0	0			21363.96	Hornet	165505	12
--125103	Solo Final	0	0	Solo	Herrions	9	97	0	50000	0	0	0	0			10681.98	Herrions	165509	12



--SELECT PlayerID FROM StatsWithPLayerInfoView WHERE RegionID = 9 
UPDATE Player Set RegionID = 7 WHERE ID IN (SELECT PlayerID FROM StatsWithPLayerInfoView WHERE RegionID = 9)




SELECT * FROM region



SELECT s.ID, r.Name Region, Event, Rank FROM StatsWithPlayerInfoView s JOIN Region r ON s.RegionID = r.ID

SELECT s.ID, r.Name Region, Event, Rank FROM StatsWithPlayerInfoView s JOIN Region r ON s.RegionID = r.ID WHERE 


SELECT s.ID, r.Name Region, Event, Rank FROM StatsWithPlayerInfoView s JOIN Region r ON s.RegionID = r.ID WHERE Event IN ('Solo Final', 'Duo Final')


SELECT 