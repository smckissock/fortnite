USE Fortnite
GO



CREATE OR ALTER VIEW SquadTestView
AS
SELECT 
	Region, 
	Player, 
	SUM(Payout) Payout, 
	SUM(RawPowerPoints) PowerPoints 
FROM StatsWithPlayerInfoView 
WHERE Region <> 'All' 
GROUP BY Region, Player

ORDER BY Region, Payout DESC




SELECT * FROM SquadTestView 
