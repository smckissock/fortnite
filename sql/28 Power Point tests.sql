USE Fortnite
GO



CREATE OR ALTER VIEW PowerPointEventTestView
AS

SELECT 
	s.Event,
	FORMAT(SUM(Payout), '#,#') Payout, 
	FORMAT(SUM(RawPowerPoints), '#,#') PowerPoints, 
	FORMAT(SUM(Payout) - SUM(RawPowerPoints), '#,#') Difference,
	FORMAT(((SUM(Payout) - SUM(RawPowerPoints)) / SUM(Payout)), 'P') PercentageDifference
FROM StatsWithPlayerInfoView s
GROUP BY s.Event



SELECT * FROM PowerPointTestView

SELECT * FROM PowerPointTestView ORDER BY Event, Region


SELECT * FROM StatsWithPlayerInfoView WHERE Event = 'CC Friday #2' AND Region = 'NA East' ORDER BY Rank


SELECT * FROM StatsWithPlayerInfoView WHERE Player = 'Posick'


SELECT * FROM RankPayoutTier
WHERE RegionID = (SELECT ID FROM Region WHERE Name = 'NA East') 
AND EventID = (SELECT ID FROM Event WHERE Name = 'CC Friday #2') 

SELECT * FROM RankPayoutTier
WHERE RegionID = (SELECT ID FROM Region WHERE Name = 'NA East') 
AND EventID = (SELECT ID FROM Event WHERE Name = 'CS Week 3') 



SELECT Event, Region, Rank, Payout FROM PayoutTierView WHERE Event = 'CS Week 2' AND Region = 'NA East' ORDER BY Rank


SELECT 200 / 20


SELECT * FROM Match

SELECT 1000 / 150


SELECT 200 * 150



SELECT * FROM PayoutTierView ORDER BY Event, Region, Rank



SELECT * FROM Event



