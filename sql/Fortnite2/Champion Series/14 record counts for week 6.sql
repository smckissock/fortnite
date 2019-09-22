USE Fortnite
GO


-- 02import_player_playerEvent                                            Wed 1-4 
SELECT COUNT(*) FROM Player		--  66055  66316    66515	66693	668838  89434
SELECT COUNT(*) FROM PlayerEvent -- 168013  171134  174246  177374  180492 231580

-- 03import_leaderboard                                                              Wed 1-4       
SELECT COUNT(*) FROM Placement			-- 126111   127159   128198	  129243  130285  182285
SELECT COUNT(*) FROM PlayerPlacement	-- 168746   171886   175000	  178137  181261  232386
SELECT COUNT(*) FROM Game				-- 1172718 1182590  1192395  1202369 1212267 1938168

-- 04import_tiers                                                     Wed 1-4  
SELECT COUNT(*) FROM RankPayoutTier -- 1004  1143  1182  1221  1260  1372
SELECT COUNT(*) FROM RankPointTier  -- 933   1626  2319  3012  3705  3817
 GO
 
--                                                      Wed 1-4 
 SELECT COUNT(*) FROM StatsWithPlayerInfoView -- 55732  55997


 SELECT Count(*) FROM Game

 SELECT * FROM PLacement WHERE WeekID = 16


 SELECT * FROM EventID

 SELECT * FROM RankPayoutTier WHERE EventID = 1019


 SELECT * FROM Event WHERE  Name IN ('CC Wednesday #1', 'CC Wednesday #2', 'CC Wednesday #3', 'CC Wednesday #4') 



 SELECT * FROM StatsWithPlayerInfoView -- 55732

 SELECT SUM(Payout) FROM StatsWithPlayerInfoView WHERE Event = 'CC Wednesday #4'