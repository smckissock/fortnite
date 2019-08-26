USE Fortnite
GO



-- 02import_player_playerWeek
SELECT COUNT(*) FROM Player		--  66055  16316
SELECT COUNT(*) FROM PlayerWeek -- 168013  171134

-- 03import_leaderboard
SELECT COUNT(*) FROM Placement			-- 126111   127159
SELECT COUNT(*) FROM PlayerPlacement	-- 168746   171886
SELECT COUNT(*) FROM Game				-- 1172718 1182590

-- 04import_tiers
SELECT COUNT(*) FROM RankPayoutTier -- 1004
SELECT COUNT(*) FROM RankPointTier  -- 933
GO

SELECT * FROM Week


SELECT * FROM RankPayoutTier WHERE WeekID = 14 ORDER BY RegionID, Rank, Payout


SELECT * FROM ImportError



