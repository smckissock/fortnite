USE Fortnite
GO



-- 02import_player_playerWeek
SELECT COUNT(*) FROM Player		--  66055  66316    66515	66693
SELECT COUNT(*) FROM PlayerWeek -- 168013  171134  174246  177374

-- 03import_leaderboard
SELECT COUNT(*) FROM Placement			-- 126111   127159   128198	  129243 
SELECT COUNT(*) FROM PlayerPlacement	-- 168746   171886   175000	  178137
SELECT COUNT(*) FROM Game				-- 1172718 1182590  1192395  1202369

-- 04import_tiers
SELECT COUNT(*) FROM RankPayoutTier -- 1004  1143  1182
SELECT COUNT(*) FROM RankPointTier  -- 933   1626  2319
 GO

SELECT * FROM Week


SELECT * FROM RankPayoutTier WHERE WeekID = 14 ORDER BY RegionID, Rank, Payout


SELECT * FROM ImportError ORDER BY ID DESC

SELECT * fROM Week

SELECT * FROM PLayerPlacement


INSERT INTO PlayerWeek VALUES( (SELECT ID FROM Player WHERE EpicGuid = 'c62fd294dcd243208e87017e186ad4cc'), 15, (SELECT ID FROM Region WHERE EpicCode = 'NAE'))

SELECT top 10 * FROM Placement ORDER BY ID DESC


SELECT WeekID, RegionID, Rank, Count(*) 
FROM Placement 
GROUP BY WeekID, RegionID, Rank ORDER BY COUnt(*) DESC 


SELECT * FROM Placement WHERE WeekID = 11 AND RegionID = 3 AND Rank = 3


DELETE FROM PLacement WHERE ID = 124955  


DELETE FROM Placement WHERE ID IN (129103, 129102)