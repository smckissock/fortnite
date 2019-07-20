USE Fortnite2
GO

Backup DB

c#:
Populate Player.CurrentName FROM the most recent name in Player
Populate Placement.Payout, Placement.Elims


NOT URGENT
PlayerWeek needs to go away, and PlayerName added to PlayerPlacement 
 

 SELECT * FROM Placement

 SELECT * FROM RankPointTier



 SELECT Rank, Points FROM RankPointTier WHERE RegionID = 3 AND WeekID = 1 ORDER BY Rank DESC

 SELECT * FROM Placement
 SELECT  * FROM 

 SELECT ID, RegionID, WeekID, Rank, Points, Elims FROM Placement WHERE ID <> 1


 UPDATE Placement SET Elims = Points - 10 WHERE ID = 4


 SELECT Rank, Points 
 FROM RankPointTier rpt
  
 WHERE RegionID = 3 AND WeekID = 1 ORDER BY Rank DESC


 SELECT * FROM Game
 SELECT Rank, Points FROM Game WHERE PlacementID = 10







 SELECT Count(*) FROM Placement WHERE Elims <> 0

