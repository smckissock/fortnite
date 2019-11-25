



CREATE OR ALTER VIEW SquadPlacementView
AS
SELECT 
	PlacementID, 
	SquadID, 
	Rank, 
	Payout, 
	EventID   
FROM SquadPlacement sp
JOIN Placement p ON p.ID = sp.PlacementID
GO


CREATE OR ALTER  VIEW [dbo].[SquadStatsView]
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

	, w1.Rank W1Rank
	, w2.Rank W2Rank
	, w3.Rank W3Rank
	, w4.Rank W4Rank

	, ((w1.Rank + w2.Rank + w3.Rank) / 3 ) AverageRank 	
	, ((p1.PowerPoints + p2.PowerPoints + p3.PowerPoints + p4.PowerPoints) / 4 ) AveragePowerPoints 

	, RANK () OVER ( 
		PARTITION BY s.RegionID
		ORDER BY w1.Rank + w2.Rank + w3.Rank 
	) PlacementRank

	, RANK () OVER ( 
		PARTITION BY s.RegionID
		ORDER BY p1.PowerPoints + p2.PowerPoints + p3.PowerPoints + p4.PowerPoints DESC
	) PowerPointRank

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

LEFT JOIN (SELECT SquadID, PlacementID, Rank, Payout FROM SquadPlacementView WHERE EventID = 2035) w1 ON w1.SquadID = s.ID   
LEFT JOIN (SELECT SquadID, PlacementID, Rank, Payout FROM SquadPlacementView WHERE EventID = 2036) w2 ON w2.SquadID = s.ID   
LEFT JOIN (SELECT SquadID, PlacementID, Rank, Payout FROM SquadPlacementView WHERE EventID = 2037) w3 ON w3.SquadID = s.ID   
LEFT JOIN (SELECT SquadID, PlacementID, Rank, Payout FROM SquadPlacementView WHERE EventID = 2038) w4 ON w4.SquadID = s.ID   

WHERE (w1.Rank IS NOT NULL) AND (w2.Rank IS NOT NULL) AND (w3.Rank IS NOT NULL)
GO

SELECT * FROM SquadStatsView

CREATE OR ALTER VIEW PlayerPlacementIdView 
AS
SELECT
	ID PlacementID,
	EventID,
	PlayerID,	
	RegionID,
	RANK () OVER ( 
		PARTITION BY ID
		ORDER BY PlayerID ASC
	) PlayerNum
FROM PlacementView	 
GO



CREATE  OR ALTER  VIEW [dbo].[SquadTestView]
AS
SELECT 
	Region, 
	Player, 
	SUM(Payout) Payout, 
	SUM(RawPowerPoints) PowerPoints 
FROM StatsView 
WHERE Region <> 'All' 
GROUP BY Region, Player
GO




CREATE OR ALTER   VIEW [dbo].[SquadView]
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
GO

