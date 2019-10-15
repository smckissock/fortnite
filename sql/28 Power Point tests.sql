USE Fortnite
GO



CREATE OR ALTER VIEW PowerPointTestView
AS

SELECT 
	s.Event, 
	FORMAT(SUM(Payout), '#,#') Payout, 
	FORMAT(SUM(RawPowerPoints), '#,#') PowerPoints, 
	FORMAT(SUM(Payout) - SUM(RawPowerPoints), '#,#') Difference,
	FORMAT(((SUM(Payout) - SUM(RawPowerPoints)) / SUM(Payout)), 'P') PercentageDifference
FROM StatsWithPlayerInfoView s
GROUP BY s.Event 


