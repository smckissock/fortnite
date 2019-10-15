USE Fortnite
GO

-- Hornet
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%Horn%' 
-- Real Hornet = 494
-- PLacementID = 125099
SELECT * FROM PlayerPlacement WHERE PlacementID = 125099
UPDATE PLayerPlacement SET PlayerID = 494 WHERE PlacementID = 125099
 

-- (yung) calculator 
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%cula%' 
-- Real Calculator = 1173
-- PLacementID = 124971
SELECT * FROM PlayerPlacement WHERE PlacementID = 124971 AND PLayerID = 165299
UPDATE PLayerPlacement SET PlayerID = 1173 WHERE PlacementID = 124971 AND PlayerID = 165299



-- spades 
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%Spades%' 
-- Real Spades = 140
-- PLacementID = 124972
SELECT * FROM PlayerPlacement WHERE PlacementID = 124972 AND PlayerID = 165344
UPDATE PLayerPlacement SET PlayerID = 140 WHERE PlacementID = 124972 AND PLayerID = 165344



-- Nikof 
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%Solary N%' 
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%Airwaks%' 
-- Real Solary Nîkof = 28833
-- PLacementID = 124984
SELECT * FROM PlayerPlacement WHERE PlacementID = 124984 AND PlayerID = 165368
UPDATE PLayerPlacement SET PlayerID = 28833 WHERE PlacementID = 124984 AND PLayerID = 165368


-- Deadra
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%Go D%' -- Go Deadra   165332
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%Go %' 
-- Real Solary Nîkof = 28759
-- PLacementID = 124984
SELECT * FROM PlayerPlacement WHERE PlacementID = 124966 AND PlayerID = 165332
UPDATE PLayerPlacement SET PlayerID = 28759 WHERE PlacementID = 124966 AND PLayerID = 165332



-- Quinten
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%Quinten%' -- 165398
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%nten%' 
-- Real Quinten = 29301
-- PLacementID = 124984
SELECT * FROM PlayerPlacement WHERE PlacementID = 124999 AND PlayerID = 165398
UPDATE PLayerPlacement SET PlayerID = 29301 WHERE PlacementID = 124999 AND PLayerID = 165398




-- DRG
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%rg%' ORDER BY Player -- 165398
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%nten%' 
-- Real drg = 28767
-- PLacementID = 125051
SELECT * FROM PlayerPlacement WHERE PlacementID = 125051 AND PlayerID = 165457
UPDATE PLayerPlacement SET PlayerID = 28767 WHERE PlacementID = 125051 AND PLayerID = 165457




--  reverse2k
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%reve%' ORDER BY Player -- 165398
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%nten%' 
-- Real reverse2k 227
-- PLacementID = 125051
SELECT * FROM PlayerPlacement WHERE PlacementID = 125096 AND PlayerID = 165502
UPDATE PLayerPlacement SET PlayerID = 227 WHERE PlacementID = 125096 AND PLayerID = 165502




--  Snow
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%cloud%' ORDER BY Player -- 165398
SELECT * FROM StatsWithPlayerInfoView WHERE Player Like '%nten%' 
-- Real reverse2k 227
-- PLacementID = 125051
SELECT * FROM PlayerPlacement WHERE PlacementID = 125096 AND PlayerID = 165502
UPDATE PLayerPlacement SET PlayerID = 227 WHERE PlacementID = 125096 AND PLayerID = 165502