USE Fornite
GO


SELECT MAX(ID) FROM Squad

SELECT * FROM Squad
SELECT * FROM SquadPlayer
SELECT * FROM SquadPlacement



CREATE OR ALTER VIEW SquadPlayerView
AS

SELECT 
	sp.ID 
	, sp.PlayerID
	, sp.SquadID
	, p.CurrentName PlayerName
	, p.PowerPoints
FROM SquadPlayer sp
JOIN Player p ON p.ID = sp.PlayerID
GO



CREATE OR ALTER VIEW SquadView
AS
WITH Player (SquadID, PlayerID, PlayerName, PowerPoints, SquadRank) AS ( 
	SELECT SquadID, PlayerID, PlayerName, PowerPoints, SquadRank FROM (
		SELECT
			SquadID,
			PlayerID,
			PlayerName,
			PowerPoints,
			RANK () OVER ( 
				PARTITION BY SquadID
				ORDER BY PowerPoints DESC, ID
			) SquadRank
		FROM
			SquadPlayerView
	) t 
)
SELECT
	r.Name Region

	, ((p1.PowerPoints + p2.PowerPoints + p3.PowerPoints + p4.PowerPoints) / 4 ) AveragePowerPoints 

	, p1.PlayerName Player1
	, p1.PowerPoints PowerPoints1 
	, p2.PlayerName Player2
	, p2.PowerPoints PowerPoints2
	, p3.PlayerName Player3
	, p3.PowerPoints PowerPoints3
	, p4.PlayerName Player4
	, p4.PowerPoints PowerPoints4

	, p1.PlayerID Player1ID
	, p2.PlayerID Player2ID
	, p3.PlayerID Player3ID
	, p4.PlayerID Player4ID
	, s.ID
	, s.RegionID
FROM Squad s
JOIN Region r ON r.ID = s.RegionID
LEFT JOIN (SELECT SquadID, PlayerName, PowerPoints, PlayerID FROM Player WHERE SquadRank = 1) p1 ON p1.SquadID = s.ID
LEFT JOIN (SELECT SquadID, PlayerName, PowerPoints, PlayerID FROM Player WHERE SquadRank = 2) p2 ON p2.SquadID = s.ID
LEFT JOIN (SELECT SquadID, PlayerName, PowerPoints, PlayerID FROM Player WHERE SquadRank = 3) p3 ON p3.SquadID = s.ID
LEFT JOIN (SELECT SquadID, PlayerName, PowerPoints, PlayerID FROM Player WHERE SquadRank = 4) p4 ON p4.SquadID = s.ID


SELECT * FROM SquadView

SELECT DISTINCT Player, PlayerID, * FROM StatsView WHERE SoloOrDuo = 'Squad' AND RegionID = 3


SELECT * FROM Player WHERE ID IN (SELECT DISTINCT PlayerID FROM StatsView WHERE SoloOrDuo = 'Squad') 


AND CurrentName Like '%mis%'
ORDER BY PowerPoints


SELECT * FROM SquadPlacement

SELECT * fROM Event WHERE EventID = 2035

SELECT * FROM Placement WHERE EventID = 2035

SELECT * FROM PlayerPlacementView WHERE Event = 'CS Squads #1'


SELECT Region, AveragePowerPoints, PowerPoints1, Player1, PowerPoints2, Player2, PowerPoints3, Player3, PowerPoints4, Player4 FROM SquadView ORDER BY Region



SELECT * FROM Player WHERe PowerPoints IS NULL