USE Fortnite
GO


-- 02import_player_playerEvent                                            Wed 1-4  Thurs 1-4  Fri 1-4  CS Finals  Week 1
SELECT COUNT(*) FROM Player		--  66055  66316    66515	66693	668838  89434      94966   105342     105342  105342  105360
SELECT COUNT(*) FROM PlayerEvent -- 168013  171134  174246  177374  180492 231580     280903   363023     363694  364105  364386  -- only 281 difference? should be 1200?

-- 03import_leaderboard                                                              Wed 1-4  Thurs 1-4   Fri 1-4  CS Finals  Week 1    
SELECT COUNT(*) FROM Placement			-- 126111   127159   128198	  129243  130285  182285     231802   260120      260342   260515
SELECT COUNT(*) FROM PlayerPlacement	-- 168746   171886   175000	  178137  181261  232386     281725   366540      367211   367903   
SELECT COUNT(*) FROM Game				-- 1172718 1182590  1192395  1202369 1212267 1938168    2540624  2902407     2903718  2904720


-- 04import_tiers                                                 Wed 1-4  Thurs 1-4  Fri 1-4 CS Finals  Week 1	
SELECT COUNT(*) FROM RankPayoutTier -- 1004  1143  1182  1221  1260  1372       1664     1876      1940  1947 -- too few!!
SELECT COUNT(*) FROM RankPointTier  -- 933   1626  2319  3012  3705  3817       3929     4049      4084  4119
 GO
 
--                                                     Wed 1-4  Thurs 1-4  Fri 1-4 CS Finals Week 1
SELECT COUNT(*) FROM StatsWithPlayerInfoView -- 55732  55997        56605    57661     58288

SELECT * fROM RankPayoutTier ORDER BY ID DESC
SELECT * fROM RankPointTier ORDER BY ID DESC


SELECT 364105 -  364386

INSERT INTO PlayerPlacement VALUES((SELECT ID FROM Player WHERE EpicGuid= '14172e753af34ab4abe3c2de6348bc23'), (SELECT MAX(ID) FROM Placement), (SELECT PLayerName FROM LookupNameView WHERE EpicGuid= '14172e753af34ab4abe3c2de6348bc23' AND EventName = 'CS Squads #1'))
INSERT INTO PlayerPlacement VALUES((SELECT ID FROM Player WHERE EpicGuid= '14172e753af34ab4abe3c2de6348bc23'), (SELECT MAX(ID) FROM Placement), (SELECT PLayerName FROM LookupNameView WHERE EpicGuid= '14172e753af34ab4abe3c2de6348bc23' AND EventName = 'CS Squads #1'))

SELECT * FROM Event


INSERT INTO PlayerPlacement VALUES((SELECT ID FROM Player WHERE EpicGuid= 'a851fb5bdc324a71b7288d06a3b5f647'), (SELECT MAX(ID) FROM Placement), (SELECT PLayerName FROM LookupNameView WHERE EpicGuid= 'a851fb5bdc324a71b7288d06a3b5f647' AND EventName = 'CS Squads #1'))