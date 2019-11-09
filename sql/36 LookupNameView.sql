USE Fortnite
GO



CREATE OR ALTER VIEW LookupNameView
AS

-- Given Event Name and Epic Guid, find the name they used
SELECT 
	pe.PlayerName, 
	p.EpicGuid, 
	e.Name EventName
FROM PlayerEvent pe
JOIN Player p ON pe.PlayerID = p.ID
JOIN Event e ON e.ID = pe.EventID



--SELECT * FROM LookupNameView

--INSERT INTO PlayerPlacement VALUES((SELECT ID FROM Player WHERE EpicGuid= '14172e753af34ab4abe3c2de6348bc23'), (SELECT MAX(ID) FROM Placement), 
--(SELECT PLayerName FROM LookupNameView WHERE EpicGuid= '14172e753af34ab4abe3c2de6348bc23' AND EventName = 'CS Squads #1'))

SELECT * FROM Week

INSERT INTO PlayerPlacement VALUES((SELECT ID FROM Player WHERE EpicGuid= 'a851fb5bdc324a71b7288d06a3b5f647'), (SELECT MAX(ID) FROM Placement), 

(SELECT PLayerName FROM LookupNameView WHERE EpicGuid= 'a851fb5bdc324a71b7288d06a3b5f647' AND EventName = 'CS Squads #1'))



SELECT * FROM Player WHERe EpicGUID = 'a851fb5bdc324a71b7288d06a3b5f647'


SELECT Name, WeekID FROM Event WHERE WeekID <= 18



SELECT * fROM Player


INSERT INTO Player VALUES('a851fb5bdc324a71b7288d06a3b5f647', '', 1, 1, 1, '', '')

INSERT INTO Player VALUES('a851fb5bdc324a71b7288d06a3b5f647', '', 1, 1, 1, '', '', (SELECT ID FROM Region WHERE EpicCode = 'NAE'))

	