
-- 02import_player_playerWeek
SELECT COUNT(*) FROM Player		--  55713   66055 
SELECT COUNT(*) FROM PlayerWeek -- 164989   166053

-- 03import_leaderboard
SELECT COUNT(*) FROM Placement			-- 125102
SELECT COUNT(*) FROM PlayerPlacement	-- 165720
SELECT COUNT(*) FROM Game				-- 1163157

-- 04import_tiers
SELECT COUNT(*) FROM RankPayoutTier -- 1065
SELECT COUNT(*) FROM RankPointTier  -- 240


SELECT 166053 - 164989  


SELECT COUNT(*) FROM ImportError

SELECT * FROM ImportError



SELECT * FROM Player



SELECT * FROM PlayerWeek ORDER By WeekID DESC


SELECT * FROM Week