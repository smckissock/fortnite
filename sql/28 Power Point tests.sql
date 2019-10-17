USE Fortnite
GO



CREATE OR ALTER VIEW PowerPointTestView
AS

SELECT 
	s.Event, s.Region,
	FORMAT(SUM(Payout), '#,#') Payout, 
	FORMAT(SUM(RawPowerPoints), '#,#') PowerPoints, 
	FORMAT(SUM(Payout) - SUM(RawPowerPoints), '#,#') Difference,
	FORMAT(((SUM(Payout) - SUM(RawPowerPoints)) / SUM(Payout)), 'P') PercentageDifference
FROM StatsWithPlayerInfoView s
GROUP BY s.Event, s.Region 



SELECT * FROM PowerPointTestView

SELECT * FROM PowerPointTestView ORDER BY Event, Region


SELECT * FROM StatsWithPlayerInfoView WHERE Event = 'CS Week 2' AND Region = 'NA East' ORDER BY Rank
SELECT * FROM StatsWithPlayerInfoView WHERE Player = 'Posick'


SELECT * FROM RankPayoutTier
WHERE RegionID = (SELECT ID FROM Region WHERE Name = 'NA East') 
AND EventID = (SELECT ID FROM Event WHERE Name = 'CS Week 2') 



SELECT Event, Region, Rank, Payout FROM PayoutTierView WHERE Event = 'CS Week 2' AND Region = 'NA East' ORDER BY Rank





