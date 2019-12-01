

--SELECT * FROM SquadDisplayView ORDER BY Region, [FNCS Rank]




CREATE  OR ALTER  VIEW [dbo].[SquadStatsView]
AS
WITH Player (SquadID, PlayerID, PlayerName, PowerPoints, SquadRank, PlayerRank) AS ( 
		SELECT SquadID, PlayerID, PlayerName, PowerPoints, SquadRank, PlayerRank FROM (
			SELECT
				SquadID,
				PlayerID,
				PlayerName,
				PowerPoints,
				RANK () OVER ( 
					PARTITION BY SquadID
					ORDER BY PowerPoints DESC, ID
				) SquadRank,
				RANK () OVER ( 
					PARTITION BY RegionID
					ORDER BY PowerPoints DESC, ID
				) PlayerRank
			FROM
				SquadPlayerView
		) t 
)
SELECT
	r.Name Region
	, s.Heat
	, s.Rank

	, w1.Rank W1Rank
	, w2.Rank W2Rank
	, w3.Rank W3Rank
	, w4.Rank W4Rank

	, ((CONVERT(DECIMAL(10, 1), w1.Rank) + w2.Rank + w3.Rank + w4.Rank) / 4 ) AverageRank 	
	, ((CONVERT(DECIMAL(10, 1), p1.PowerPoints) + p2.PowerPoints + p3.PowerPoints + p4.PowerPoints) / 4 ) AveragePowerPoints 

	, RANK () OVER ( 
		PARTITION BY s.RegionID
		ORDER BY w1.Rank + w2.Rank + w3.Rank 
	) PlacementRank
	
	, RANK () OVER ( 
		PARTITION BY s.RegionID
		ORDER BY p1.PowerPoints + p2.PowerPoints + p3.PowerPoints + p4.PowerPoints DESC
	) PowerPointRank

	, p1.PlayerName Player1
	, p1.PlayerRank PlayerRank1
	, p1.PowerPoints PowerPoints1 
	
	, p2.PlayerName Player2
	, p2.PlayerRank PlayerRank2
	, p2.PowerPoints PowerPoints2
	
	, p3.PlayerName Player3
	, p3.PlayerRank PlayerRank3
	, p3.PowerPoints PowerPoints3
	
	, p4.PlayerName Player4
	, p4.PlayerRank PlayerRank4
	, p4.PowerPoints PowerPoints4

	, p1.PlayerID Player1ID
	, p2.PlayerID Player2ID
	, p3.PlayerID Player3ID
	, p4.PlayerID Player4ID
	, s.ID
	, s.RegionID
FROM Squad s
JOIN Region r ON r.ID = s.RegionID
LEFT JOIN (SELECT SquadID, PlayerName, PowerPoints, PlayerRank, PlayerID FROM Player WHERE SquadRank = 1) p1 ON p1.SquadID = s.ID
LEFT JOIN (SELECT SquadID, PlayerName, PowerPoints, PlayerRank, PlayerID FROM Player WHERE SquadRank = 2) p2 ON p2.SquadID = s.ID
LEFT JOIN (SELECT SquadID, PlayerName, PowerPoints, PlayerRank, PlayerID FROM Player WHERE SquadRank = 3) p3 ON p3.SquadID = s.ID
LEFT JOIN (SELECT SquadID, PlayerName, PowerPoints, PlayerRank, PlayerID FROM Player WHERE SquadRank = 4) p4 ON p4.SquadID = s.ID

LEFT JOIN (SELECT SquadID, PlacementID, Rank, Payout FROM SquadPlacementView WHERE EventID = 2035) w1 ON w1.SquadID = s.ID   
LEFT JOIN (SELECT SquadID, PlacementID, Rank, Payout FROM SquadPlacementView WHERE EventID = 2036) w2 ON w2.SquadID = s.ID   
LEFT JOIN (SELECT SquadID, PlacementID, Rank, Payout FROM SquadPlacementView WHERE EventID = 2037) w3 ON w3.SquadID = s.ID   
LEFT JOIN (SELECT SquadID, PlacementID, Rank, Payout FROM SquadPlacementView WHERE EventID = 2038) w4 ON w4.SquadID = s.ID   

WHERE w1.Rank + w2.Rank + w3.Rank + w4.Rank IS NOT NULL
GO



CREATE OR ALTER    VIEW [dbo].[SquadDisplayView]
AS

SELECT 
	Region
	, Heat
	, Rank
		
	, PlayerRank1 P1
	, Player1 + ' ' + CONVERT(nvarchar(100), FORMAT((PowerPoints1 / 1000), 'N1')) + 'k' [Player 1]

	, PlayerRank2 P2
	, Player2 + ' ' + CONVERT(nvarchar(100), FORMAT((PowerPoints2 / 1000), 'N1')) + 'k' [Player 2]
	
	, PlayerRank3 P3
	, Player3 + ' ' + CONVERT(nvarchar(100), FORMAT((PowerPoints3 / 1000), 'N1')) + 'k' [Player 3]
	
	, PlayerRank4 P4
	, Player4 + ' ' + CONVERT(nvarchar(100), FORMAT((PowerPoints4 / 1000), 'N1')) + 'k' [Player 4]
	
	, CONVERT(nvarchar(100), W1Rank)  + ' - ' +  CONVERT(nvarchar(100), W2Rank) + ' - ' + CONVERT(nvarchar(100), W3Rank) + ' - ' + CONVERT(nvarchar(100), W4Rank) +'  Avg: ' +  FORMAT(AverageRank, 'N1') [FNCS Placements]
			
	, PlacementRank [FNCS Rank]
	, PowerPointRank [Power Rank]
	, PowerPointRank - PlacementRank  [Chemistry]
FROM SquadStatsView 
GO

