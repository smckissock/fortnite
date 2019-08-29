USE [Fortnite]
GO



UPDATE Placement SET Payout = 50000 WHERE WeekID = 12

--SELECT 'UPDATE Placement SET Payout =  WHERE ID = ' + CONVERT(varchar(20), ID) + ' -- Rank = ' + CONVERT(varchar(20), Rank)   
--FROM Placement WHERE WeekID = 12 AND Rank < 21 
--ORDER BY Rank

UPDATE Placement SET Payout = 3000000 WHERE ID = 125007 -- Rank = 1
UPDATE Placement SET Payout = 1800000 WHERE ID = 125008 -- Rank = 2
UPDATE Placement SET Payout = 1200000 WHERE ID = 125009 -- Rank = 3
UPDATE Placement SET Payout = 1050000 WHERE ID = 125010 -- Rank = 4
UPDATE Placement SET Payout =  900000 WHERE ID = 125011 -- Rank = 5
UPDATE Placement SET Payout =  600000 WHERE ID = 125012 -- Rank = 6
UPDATE Placement SET Payout =  525000 WHERE ID = 125013 -- Rank = 7
UPDATE Placement SET Payout =  375000 WHERE ID = 125014 -- Rank = 8
UPDATE Placement SET Payout =  300000 WHERE ID = 125015 -- Rank = 9
UPDATE Placement SET Payout =  225000 WHERE ID = 125016 -- Rank = 10
UPDATE Placement SET Payout =  150000 WHERE ID = 125017 -- Rank = 11
UPDATE Placement SET Payout =  150000 WHERE ID = 125018 -- Rank = 12
UPDATE Placement SET Payout =  150000 WHERE ID = 125019 -- Rank = 13
UPDATE Placement SET Payout =  150000 WHERE ID = 125020 -- Rank = 14
UPDATE Placement SET Payout =  150000 WHERE ID = 125021 -- Rank = 15
UPDATE Placement SET Payout =  112500 WHERE ID = 125022 -- Rank = 16
UPDATE Placement SET Payout =  112500 WHERE ID = 125023 -- Rank = 17
UPDATE Placement SET Payout =  112500 WHERE ID = 125024 -- Rank = 18
UPDATE Placement SET Payout =  112500 WHERE ID = 125025 -- Rank = 19
UPDATE Placement SET Payout =  112500 WHERE ID = 125026 -- Rank = 20

--SELECT SUM(Payout) FROM Placement WHERE WeekID = 12
--SELECT * FROM Placement WHERE WeekID = 12 ORDER BY Rank



UPDATE Placement SET Payout = 100000 WHERE WeekID = 11

--SELECT 'UPDATE Placement SET Payout =  WHERE ID = ' + CONVERT(varchar(20), ID) + ' -- Rank = ' + CONVERT(varchar(20), Rank)   
--FROM Placement WHERE WeekID = 11 --AND Rank < 9 
--ORDER BY Rank


-- 0s for for glitchy extra records

UPDATE Placement SET Payout = 3000000 WHERE ID = 124956 -- Rank = 1
UPDATE Placement SET Payout = 0 WHERE ID = 124953 -- Rank = 1  NO PLayerPlacement
UPDATE Placement SET Payout = 0 WHERE ID = 124954 -- Rank = 2  NO PLayerPlacement
UPDATE Placement SET Payout = 2250000 WHERE ID = 124957 -- Rank = 2
UPDATE Placement SET Payout = 1800000 WHERE ID = 124958 -- Rank = 3
UPDATE Placement SET Payout =  0 WHERE ID = 124955 -- Rank = 3  NO PLayerPlacement
UPDATE Placement SET Payout = 1500000 WHERE ID = 124959 -- Rank = 4
UPDATE Placement SET Payout =  900000 WHERE ID = 124960 -- Rank = 5
UPDATE Placement SET Payout =  450000 WHERE ID = 124961 -- Rank = 6
UPDATE Placement SET Payout =  375000 WHERE ID = 124962 -- Rank = 7
UPDATE Placement SET Payout =  225000 WHERE ID = 124963 -- Rank = 8



--SELECT SUM(Payout) FROM Placement WHERE WeekID = 12

--SELECT 14700000 + 15287500 --  = 29987500



SELECT Week, SUM(Payout) FROM StatsWIthPlayerInfoView GROUP BY Week ORDER BY SUM(Payout)

