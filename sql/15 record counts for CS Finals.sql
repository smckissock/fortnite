USE Fortnite
GO


-- 02import_player_playerEvent                                            Wed 1-4  Thurs 1-4  Fri 1-4  CS Finals  Week 1
SELECT COUNT(*) FROM Player		--  66055  66316    66515	66693	668838  89434      94966   105342     105342  105342  105342
SELECT COUNT(*) FROM PlayerEvent -- 168013  171134  174246  177374  180492 231580     280903   363023     363694  364105  364368  -- only 263 difference? should be 1200?

-- 03import_leaderboard                                                              Wed 1-4  Thurs 1-4   Fri 1-4  CS Finals  Week 1    
SELECT COUNT(*) FROM Placement			-- 126111   127159   128198	  129243  130285  182285     231802   260120      260342   
SELECT COUNT(*) FROM PlayerPlacement	-- 168746   171886   175000	  178137  181261  232386     281725   366540      367211     
SELECT COUNT(*) FROM Game				-- 1172718 1182590  1192395  1202369 1212267 1938168    2540624  2902407     2903718


-- 04import_tiers                                                 Wed 1-4  Thurs 1-4  Fri 1-4 CS Finals  Week 1
SELECT COUNT(*) FROM RankPayoutTier -- 1004  1143  1182  1221  1260  1372       1664     1876      1940
SELECT COUNT(*) FROM RankPointTier  -- 933   1626  2319  3012  3705  3817       3929     4049      4084
 GO
 
--                                                     Wed 1-4  Thurs 1-4  Fri 1-4 CS Finals Week 1
SELECT COUNT(*) FROM StatsWithPlayerInfoView -- 55732  55997        56605    57661     58288



SELECT 364105 - 364368 
SELECT * FROM Event

INSERT INTO PlayerPlacement VALUES((SELECT ID FROM Player WHERE EpicGuid= '616cb69e8c8b4f45a831ea392f97c8e3'), (SELECT MAX(ID) FROM Placement), 'WEWE')

INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Fortnite Champion Series'), 3, 'CS Final', 17, '2019-09-22')

SELECT * FROM Week
SELECT * FROM Match

SELECT Event, SUM(Payout) FROM StatsWithPlayerInfoView WHERE Event Like 'CC%' GROUP BY Event



SELECT Event, Region, Player, SUM(Payout) Payout, Count(*) Count
FROM StatsWithPlayerInfoView 
WHERE Event Like 'CC%' 
GROUP BY Event, Region, Player

UPDATE Event SET Name = REPLACE(Name, 'Wednesday', 'Wed')
UPDATE Event SET Name = REPLACE(Name, 'Thursday', 'Thurs')
UPDATE Event SET Name = REPLACE(Name, 'Friday', 'Fri')
SELECT 




SELECT Event, Region, Player, SUM(Payout) Payout, Count(*) Count
FROM StatsWithPlayerInfoView 
WHERE Event Like 'CS Final%' 
GROUP BY Event, Region, Player ORDER By Payout DESC




SELECT Player, SUM(Payout) Payout, Count(*) Count
FROM StatsWithPlayerInfoView 
WHERE Event Like 'CC%' 
GROUP BY Player
ORDER By COunt(*) DESC





