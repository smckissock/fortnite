USE Fortnite
GO


--SELECT EventID, Count(*) FROM RankPayoutTier GROUP BY EventID

--(SELECT ID FROM Event WHERE Name = 'Solo Final')
--(SELECT ID FROM Event WHERE Name = 'Duo Final')


--SELECT ID FROM Region WHERe Name = 'Oceania' 
--SELECT ID FROM Region WHERe Name = 'NA East'
--SELECT ID FROM Region WHERe Name = 'NA West'
--SELECT ID FROM Region WHERe Name = 'Europe'
--SELECT ID FROM Region WHERe Name = 'Brazil'
--SELECT ID FROM Region WHERe Name = 'Asia'



INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 1, 3000000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 2, 1800000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 3, 1200000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 4, 1050000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 5, 900000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 6, 600000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 7, 525000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 8, 375000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 9, 300000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 10, 225000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 16, 150000)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 20, 112500)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Solo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 100, 50000)

INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Duo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 1, 3000000 / 2)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Duo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 2, 2250000/ 2)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Duo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 3, 1800000/ 2)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Duo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 4, 1500000/ 2)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Duo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 5, 900000/ 2)
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Duo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 6, 450000/ 2)

INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Duo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 8,  375000 / 2)

INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Duo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 10, 225000 / 2 )
INSERT INTO RankPayoutTier VALUES ((SELECT ID FROM Event WHERE Name = 'Duo Final'), (SELECT ID FROM Region WHERe Name = 'All'), 20, 50000 / 2)



SELECT * FROM RankPayoutTier WHERE EventID = (SELECT ID FROM Event WHERE Name = 'Duo Final')

UPDATE RankPayoutTier SET Rank = 50 WHERE ID = 4044


SELECT SUM(PowerPoints) FROM StatsWithPlayerInfoView -- 18,303,044.96
SELECT SUM(PowerPoints) FROM StatsWithPlayerInfoView WHERE Region = 'All' -- NULL


-- Put the World Cup regions in the "All" region
-- May have been using "RegionID" in placements to color world cup games. Can't do that anymore.
UPDATE Placement SET RegionID = 9  WHERE EventID = (SELECT ID FROM Event WHERE Name = 'Solo Final')
UPDATE Placement SET RegionID = 9  WHERE EventID = (SELECT ID FROM Event WHERE Name = 'Duo Final')


-- Remove Duplicate WC placements with 0 payout 


SELECT * FROM GAME WHERE PlacementID IN (124954, 124953) -- Bad Placements 
SELECT * FROM GAME WHERE PlacementID IN (124956, 124957) -- Good Placements 

DELETE FROM GAME WHERE PlacementID IN (124954, 124953) -- Bad Placements 

DELETE FROM Placement WHERE ID IN (124954, 124953)


SELECT * FROM Placement WHERe EventID = 11 ORDER By Rank


SELECT ID, Region, Event, Rank FROM StatsWithPlayerInfoView


SELECT Event, Region, Rank, Payout FROM PayoutTierView


SELECT DISTINCT(Region) FROM PayoutTierView




SELECT * FROM StatsWithPlayerInfoView WHERe Player Like '%SEN Bu%'


SELECT SUM(PowerPoints) FROM StatsWithPlayerInfoView WHERe Player Like '%SEN Bu%'

