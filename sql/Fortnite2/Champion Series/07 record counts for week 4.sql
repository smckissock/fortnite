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
SELECT COUNT(*) FROM RankPayoutTier -- 1004  1143  1182  1221
SELECT COUNT(*) FROM RankPointTier  -- 933   1626  2319  3012
 GO



 SELECT * FROM PLacement WHERE WeekID = 16
