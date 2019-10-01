USE Fortnite
GO


SELECT * FROM PlayerPlacement WHERE PLayerID = 165314 -- Roho Duo Winner

SELECT * FROM PLayer WHERE ID = 28861 -- LazaruS
SELECT * FROM PLayer WHERE ID = 165314 -- New guy, wrong


-- This is the Rojo fix
UPDATE PLayerPLacement SET PlayerID = 28861 WHERE ID = 166538




-- SOLO - PrisiOn3rO
SELECT * FROM Player WHERE CurrentName = 'PrisiOn3rO'	


SELECT * FROM PlayerPlacement WHERE ID = 165458


-- SOLO - commandment
-- DUO - Deadra
-- DUO - Calculator
-- Duo - Spades
-- SOLO - DRG
-- Solo - Evilmare
-- Duo - YuWang
-- DUO - KBB
-- DUO - Nikof
-- Solo Emqu
-- SOlo - sozmann
-- Solo - snow
-- Solo - drakiNz
-- Solo - slaya

-- TWEET: Itemm and Derox WC 


SELECT * FROM StatsWithPLayerInfoView WHERe Duo Week 



WITH WinCounts(Player, num) 
AS (
	SELECT Player, Count(*) num 
	FROM StatsWithPlayerInfoView GROUP BY Player 
)

SELECT 
	p.Player
	, w.Num
	--, p.* 
FROM StatsWithPlayerInfoView p 
JOIN WinCounts w ON w.Player = p.Player  
WHERE p.DuoWeek <> 0 

SELECT Player, Count(*) FROM StatsWithPlayerInfoView GROUP BY Player ORDER BY Count(*) DESC








