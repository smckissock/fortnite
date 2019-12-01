


INSERT INTO Event VALUES (1006, 4, 'CS Squads Heat #1', 22, '2019-12-07')
INSERT INTO Event VALUES (1006, 4, 'CS Squads Heat #2', 22, '2019-12-07')
INSERT INTO Event VALUES (1006, 4, 'CS Squads Heat #3', 22, '2019-12-07')
INSERT INTO Event VALUES (1006, 4, 'CS Squads Heat #4', 22, '2019-12-07')


ALTER TABLE Squad ADD Heat INT NOT NULL DEFAULT 0
ALTER TABLE Squad ADD RANK INT NOT NULL DEFAULT 0



--SELECT (SELECT Name FROM Region WHERE ID = RegionID), Count(*) Squads
--FROM SquadPlacement sp
--JOIN Placement p ON p.ID = sp.PlacementID
--WHERE (p.EventID = (SELECT ID FROM Event WHERE Name = 'CS Squads Heat #4'))
--GROUP BY RegionID


--SELECT (SELECT Name FROM Region WHERE ID = RegionID), Count(*) Squads
--FROM SquadPlacement sp
--JOIN Placement p ON p.ID = sp.PlacementID
--WHERE (p.EventID = (SELECT ID FROM Event WHERE Name = 'CS Squads Heat #4')) AND (p.RegionID = (SELECT ID FROM Region WHERE Name = 'NA East'))
--GROUP BY RegionID 


--SELECT SquadID, RegionID, EventID - 2043 Heat, Rank
--FROM SquadPlacement sp
--JOIN Placement p ON p.ID = sp.PlacementID
--WHERE EventID IN (2044, 2045, 2046, 2047)



UPDATE Squad
SET 
	Squad.Rank = s.Rank,
	Squad.Heat = s.Heat
FROM Squad
JOIN 
(SELECT SquadID, RegionID, EventID - 2043 Heat, Rank
FROM SquadPlacement sp
JOIN Placement p ON p.ID = sp.PlacementID
WHERE EventID IN (2044, 2045, 2046, 2047)) s
ON s.SquadID = Squad.ID
	

