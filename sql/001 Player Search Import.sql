USE Fortnite
GO


--Saved Report: Searches by Player and Date
--                                                                          -- 11/1        11/8
SELECT MIN(SearchDate) Earliest, MAX(SearchDate) Latest   FROM PlayerSearch -- 10/14-11/1  11/7
SELECT SUM(TotalEvents), SUM(UniqueEvents) FROM PlayerSearch				-- 16,219      20,494
SELECT  COUNT(*) FROM PlayerSearch											-- 10415       13,276



SELECT PlayerID, SearchDate, Count(*) 
FROM PlayerSearch
GROUP BY PlayerID, SearchDate
ORDER BY COUNT(*) DESC


SELECT DISTINCT PlayerID FROM PlayerSearch  



SELECT SearchDate, Count(*) 
FROM PlayerSearch
GROUP BY SearchDate
ORDER BY SEARCHDate


SELECT * FROM PLayerSearchView


SELECT * FROM StatsWithPlayerInfoView
	

