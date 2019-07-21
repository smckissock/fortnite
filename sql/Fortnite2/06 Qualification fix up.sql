



SELECT top 10 * FROM FOrtnite..StatsWithPlayerInfoView ORDER BY Week, Rank, region 
SELECT top 10 * FROM StatsWithPlayerInfoView ORDER BY Week, Rank, region


SELECT COUNT(*) FROM FOrtnite..StatsWithPlayerInfoView 
SELECT COUNT(*) FROM StatsWithPlayerInfoView WHERE Payout > 0



UPDATE Placement SET Qualification = 1 WHERE WeekID = 1 AND RegionID = 3 AND Rank = 1
UPDATE Placement SET Qualification = 1 WHERE WeekID = 1 AND RegionID = 3 AND Rank = 1


SELECT RegionCode, WeekNumber FROM Fortnite..Placement WHERE Qualification = 1

SELECT DISTINCT p.ID, pl1.RegionCode, pl1.WeekNumber  FROM Player p  JOIN Fortnite..Player p1 ON p.CurrentName = p1.Name  JOIN Fortnite..Placement pl1 ON pl1.PlayerID = p1.ID WHERE pl1.Qualification = 1



UPDATE Placement SET Qualification = 0 



SELECT top 10 * FROM FOrtnite..StatsWithPlayerInfoView WHERE SoloWeek ORDER BY Week, Rank, region 
SELECT top 10 * FROM StatsWithPlayerInfoView ORDER BY Week, Rank, region




SELECT * FROM FOrtnite..StatsWithPlayerInfoView WHERE SoloWeek <> 0 ORDER BY Week, Rank, region 



