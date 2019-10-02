USE Fortnite
GO


SELECT * FROM PlayerPlacement WHERE PLayerID = 165314 -- Roho Duo Winner

SELECT * FROM PLayer WHERE ID = 28861 -- LazaruS
SELECT * FROM PLayer WHERE ID = 165314 -- New guy, wrong


-- ROJO FIX
UPDATE PlayerPlacement SET PlayerID = 28861 WHERE ID = 166538

SELECT * FROM 


SELECT DISTINCT PlayerName FROM PlayerEvent WHERE PlayerName Like '%deadr%'
SELECT * FROM PlayerEvent WHERE PlayerName Like '%GO deadr%'  -- PlayerID = 28759

SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%Deadra%' -- PlacementID = 124966
SELECT * FROM PlayerPlacement WHERE PlacementID =  124966 
SELECT * FROM Player WHERE ID IN (165332, 28830) -- 165332 Final PlacementID


-- Deadra fix
UPDATE PlayerPlacement SET PlayerID = 28759 WHERE ID = 165332
UPDATE Player SET CurrentName = 'GO Deadra' WHERE CurrentName = 'Deadra'



SELECT * FROM PLayerPLacement WHERe ID = 165332 
SELECT * FROM Placement WHERE  ID = 124353


SELECT * fROM PLacement WHERe ID = 165332

SELECT * FROM PlayerPlacement WHERE ID = 165332

SELECT * fROM Placement WHERE  ID = 124353


SELECT * FROM PlayerPlacement WHERE PLayerID = 165332
SELECT * fROM StatsWithPlayerInfoView WHERE ID = 124966


SELECT * FROM PlayerPlacement WHERE 


SELECT * FROM Player WHERe ID = 28759


-- SOLO - PrisiOn3rO
SELECT * FROM Player WHERE CurrentName = 'PrisiOn3rO'	







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












