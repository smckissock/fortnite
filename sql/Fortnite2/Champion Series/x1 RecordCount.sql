
-- 02import_player_playerWeek
SELECT COUNT(*) FROM Player		--  66055 
SELECT COUNT(*) FROM PlayerWeek -- 168013

-- 03import_leaderboard
SELECT COUNT(*) FROM Placement			-- 126111
SELECT COUNT(*) FROM PlayerPlacement	-- 168746
SELECT COUNT(*) FROM Game				-- 1172718

-- 04import_tiers
SELECT COUNT(*) FROM RankPayoutTier -- 1004
SELECT COUNT(*) FROM RankPointTier  -- 933




-- picks up 400 for posick week 13
SELECT * 
FROM PlayerPlacement pp
JOIN Placement p ON pp.PlacementID = p.ID 
WHERE PlayerID = 169

SELECT * FROM RankPayoutTier WHERE RegionID = 3 
ORDER BY WeekID DESC
DELETE FROM RankPayoutTier WHERE WeekID = 13


SELECT * FROM RankPointTier ORDER BY WeekID DESC
DELETE FROM RankPointTier WHERE WeekID = 13

SELECT * FROM Week



SELECT 
	w.Name week
	, CASE WHEN Qualification = 1 AND w.Format = 'Solo' THEN CAST(REPLACE(w.Name, 'WC Week ', '') AS INT) ELSE 0 END SoloWeek
	, CASE WHEN Qualification = 1 AND w.Format = 'Duo' THEN CAST(REPLACE(w.Name, 'WC Week ', '') AS INT) ELSE 0 END DuoWeek
	, w.Format  soloOrDuo
	, pl.Name player
	, r.Name region
	, p.Rank rank
	, p.Points points
	, p.Payout payout
	, p.Wins
	, p.Elims elims
	, p.Points - p.elims placementPoints
	, CASE WHEN Qualification = 1 THEN 1 ELSE 0 END +
	  CASE WHEN EarnedQualification = 1 THEN 1 ELSE 0 END EarnedQualification
	, pl.Team Team
	, pl.Nationality
FROM Placement p
JOIN WeekView w ON p.WeekID = w.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE pl.ID = 169
WHERE Payout > 0




