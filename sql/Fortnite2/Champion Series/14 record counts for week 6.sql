USE Fortnite
GO


-- 02import_player_playerEvent                                            Wed 1-4  Thurs 1-4  Fri 1-4
SELECT COUNT(*) FROM Player		--  66055  66316    66515	66693	668838  89434      94966   105342
SELECT COUNT(*) FROM PlayerEvent -- 168013  171134  174246  177374  180492 231580     280903   363023

-- 03import_leaderboard                                                              Wed 1-4  Thurs 1-4   Fri 1-4    
SELECT COUNT(*) FROM Placement			-- 126111   127159   128198	  129243  130285  182285     231802   260120
SELECT COUNT(*) FROM PlayerPlacement	-- 168746   171886   175000	  178137  181261  232386     281725   366540
SELECT COUNT(*) FROM Game				-- 1172718 1182590  1192395  1202369 1212267 1938168    2540624  2902407

-- 04import_tiers                                                 Wed 1-4  Thurs 1-4  Fri 1-4
SELECT COUNT(*) FROM RankPayoutTier -- 1004  1143  1182  1221  1260  1372       1664     1876
SELECT COUNT(*) FROM RankPointTier  -- 933   1626  2319  3012  3705  3817       3929     4049
 GO
 
--                                                     Wed 1-4  Thurs 1-4  Fri 1-4
SELECT COUNT(*) FROM StatsWithPlayerInfoView -- 55732  55997        56605    57661


SELECT Event, SUM(Payout) FROM StatsWithPlayerInfoView WHERE Event Like 'CC%' GROUP BY Event

SELECT * FROM Event WHERE  Name IN ('CC Friday #1', 'CC Friday #2', 'CC Friday #3', 'CC Friday #4') 

SELECT * FROM StatsWithPlayerInfoView WHERE Event = 'CC Friday #4' ORDER BY Payout desc 




SELECT Event, Region, Player, SUM(Payout) Payout, Count(*) Count
FROM StatsWithPlayerInfoView 
WHERE Event Like 'CC%' 
GROUP BY Event, Region, Player


SELECT * FROM StatSWithPLayerINfoView

SELECT * FROM Format
SELECT * FROM Event

UPDATE Event SET FormatID = 3 WHERE Name IN ('CC Friday #1', 'CC Friday #2', 'CC Friday #3', 'CC Friday #4')