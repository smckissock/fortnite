USE [Fortnite]
GO


CREATE   VIEW [dbo].[PlayerRegionView]
AS

SELECT 
	s.PlayerID, s.RegionID, SUM(s.Payout) Payout  
FROM StatsWithPlayerInfoView s
WHERE s.RegionID <> 9
GROUP BY s.PlayerID, s.RegionID
GO


