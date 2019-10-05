USE Fortnite
GO


SELECT *, (SELECT CurrentName FROM Player WHERE ID = PlayerID)  
FROM StatsWithPlayerInfoView 
WHERE Event IN ('Solo Final', 'Duo Final') 




UPDATE PlayerPlacement SET PLayer = (SELECT CurrentName FROM Player WHERE ID = PlayerID) WHERE PlacementID IN 
(SELECT ID FROM StatsWithPlayerInfoView 
WHERE Event IN ('Solo Final', 'Duo Final')) 




-- Fix 8-10 Payout on World Cup Duos

SELECT Payout, Payout * 2 Epic, * FROM Placement WHERE EventID = 11 AND RANK IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11) ORDER BY Rank

UPDATE Placement SET Payout = 187500 WHERE ID =  124963
UPDATE Placement SET Payout = 112500 WHERE ID =  124964
UPDATE Placement SET Payout = 112500 WHERE ID =  124965


