USE [Fortnite]
GO


--CREATE OR ALTER VIEW [dbo].[PayoutTierView]
--AS

--SELECT 
--	e.Name Event,
--	r.Name Region,
--	Rank,
--	Payout
--FROM RankPayoutTier p
--JOIN Region r on p.RegionID = r.ID
--JOIN Event e ON e.ID = p.EventID
--GO



CREATE OR ALTER VIEW [dbo].[PayoutTierView]
AS

SELECT 
	e.Name Event,
	r.Name Region,
	Rank,
	Payout,
	e.FormatID TeamSize -- 1 = Solo, 2 = Duo, 3 = Trio, 4 = Squad 
FROM RankPayoutTier p
JOIN Region r on p.RegionID = r.ID
JOIN Event e ON e.ID = p.EventID
GO
