USE Fortnite
GO

-- BEFORE THIS, MADE d:\Fortnite\Fortnitedb\August 29.bak

-- Set All WC Finalists to NA East for now
UPDATE Placement SET RegionID = 3 WHERE WeekID = 12
UPDATE Placement SET RegionID = 3 WHERE WeekID = 11

-- For wrong format for WC Solo
UPDATE Week SET FormatID = 1 WHERE ID = 12


UPDATE PlayerPlacement Set PlayerID = 31 WHERE ID = 166637 -- Bugha


SELECT * FROM Player WHERE CurrentName LIKE 'SEN%'  -- 31

SELECT * FROM Player WHERE CurrentName LIKE 'Bug%'  -- 165412


SELECT * FROM Placement WHERE WeekID = 12  

SELECT * FROM PLayerPlacement WHERe PlacementID = 125007



SELECT * 
FROM PlayerPlacementView ppv 
JOIN PlayerView p ON p.ID = ppv.PLayerID
WHERE WeekID = 11




SELECT * FROM Player WHERE CurrentName Like 'Sen%'


SELECT * FROM PlayerWeek WHERE PlayerID = 31







UPDATE Placement