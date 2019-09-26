USE Fortnite

CREATE OR ALTER VIEW PayoutTierView
AS

SELECT 
	EpicCode,
	e.Name,
	Rank,
	Payout
FROM RankPayoutTier p
JOIN Region r on p.RegionID = r.ID
JOIN Event e ON e.ID = p.EventID