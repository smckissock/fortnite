USE Fortnite
GO



-- 02import_player_playerWeek
SELECT COUNT(*) FROM Player		--  66055  66316    66515
SELECT COUNT(*) FROM PlayerWeek -- 168013  171134  174246

-- 03import_leaderboard
SELECT COUNT(*) FROM Placement			-- 126111   127159   128198
SELECT COUNT(*) FROM PlayerPlacement	-- 168746   171886   175000
SELECT COUNT(*) FROM Game				-- 1172718 1182590  1192395

-- 04import_tiers
SELECT COUNT(*) FROM RankPayoutTier -- 1004  1143  1182
SELECT COUNT(*) FROM RankPointTier  -- 933   1626  2319
 GO

SELECT * FROM Week


SELECT * FROM RankPayoutTier WHERE WeekID = 14 ORDER BY RegionID, Rank, Payout


SELECT * FROM ImportError ORDER BY ID DESC

SELECT * fROM Week

