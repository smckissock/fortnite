USE Fortnite
GO


--Saved Report: Searches by Player and Date

SELECT MIN(SearchDate) Earliest, MAX(SearchDate) Latest   FROM PlayerSearch -- 2019-10-20
SELECT SUM(TotalEvents), SUM(UniqueEvents) FROM PlayerSearch -- 5512
SELECT  COUNT(*) FROM PlayerSearch -- 3432



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
	

