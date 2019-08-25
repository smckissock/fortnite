USE Fortnite
GO

-- INSERT INTO Match VALUES ('Fortnite World Cup Duos Final', 'LAN', 'Event2')
-- INSERT INTO Week VALUES (2, 2, 'Duo Final') -- ID = 11

SELECT * FROM Week

SET IDENTITY_INSERT Fortnite.dbo.Match ON;
INSERT INTO Match (ID, Name, EpicName, EventName) VALUES (4, 'Fortnite Champion Series', 'OnlineOpen', 'Event3')
SET IDENTITY_INSERT Fortnite.dbo.Match OFF

SELECT * FROM Match

SET IDENTITY_INSERT Fortnite.dbo.Week ON;  

INSERT INTO Week (ID, MatchID, FormatID, Name) VALUES (13, (SELECT ID FROM Match WHERE Name = 'Fortnite Champion Series'), (SELECT ID FROM Format WHERE Name = 'Trio'), 'CS WK 1')
INSERT INTO Week (ID, MatchID, FormatID, Name) VALUES (14, (SELECT ID FROM Match WHERE Name = 'Fortnite Champion Series'), (SELECT ID FROM Format WHERE Name = 'Trio'), 'CS WK 2')
INSERT INTO Week (ID, MatchID, FormatID, Name) VALUES (15, (SELECT ID FROM Match WHERE Name = 'Fortnite Champion Series'), (SELECT ID FROM Format WHERE Name = 'Trio'), 'CS WK 3')
INSERT INTO Week (ID, MatchID, FormatID, Name) VALUES (16, (SELECT ID FROM Match WHERE Name = 'Fortnite Champion Series'), (SELECT ID FROM Format WHERE Name = 'Trio'), 'CS WK 4')
INSERT INTO Week (ID, MatchID, FormatID, Name) VALUES (17, (SELECT ID FROM Match WHERE Name = 'Fortnite Champion Series'), (SELECT ID FROM Format WHERE Name = 'Trio'), 'CS WK 5')

UPDATE Week SET Name = REPLACE(Name, 'Week', 'WC WK')

UPDATE Week SET Name = REPLACE(Name, 'WC WK', 'WC Week')


-- ugh
UPDATE Week SET Name = 'CS Week 1' WHERE ID = 13
UPDATE Week SET Name = 'CS Week 2' WHERE ID = 14
UPDATE Week SET Name = 'CS Week 3' WHERE ID = 15
UPDATE Week SET Name = 'CS Week 4' WHERE ID = 16
UPDATE Week SET Name = 'CS Week 5' WHERE ID = 17



GO
ALTER VIEW [dbo].[WeekView] AS
SELECT 
	w.ID,
	w.Name, --'Week ' + CONVERT(nvarchar(2), w.ID) Name,
	f.Name Format,
	m.Name Match 
FROM Week w
JOIN Format f ON w.FormatID = f.ID
JOIN Match m ON w.MatchID = m.ID
GO



ALTER VIEW [dbo].[StatsWithPlayerInfoView]  
AS
--    9,000 for top 100
--  165,621 for all placements
--   46,432 all with payouts
SELECT 
	w.Name week
	, CASE WHEN Qualification = 1 AND w.Format = 'Solo' THEN CAST(REPLACE(w.Name, 'WC Week ', '') AS INT) ELSE 0 END SoloWeek
	, CASE WHEN Qualification = 1 AND w.Format = 'Duo' THEN CAST(REPLACE(w.Name, 'WC Week ', '') AS INT) ELSE 0 END DuoWeek
	, w.Format  soloOrDuo
	, pl.Name player
	, r.Name region
	, p.Rank rank
	, p.Points points
	, p.Payout payout
	, p.Wins
	, p.Elims elims
	, p.Points - p.elims placementPoints
	, CASE WHEN Qualification = 1 THEN 1 ELSE 0 END +
	  CASE WHEN EarnedQualification = 1 THEN 1 ELSE 0 END EarnedQualification
	, pl.Team Team
	, pl.Nationality
FROM Placement p
JOIN WeekView w ON p.WeekID = w.ID
JOIN Region r ON p.RegionID = r.ID
JOIN PlayerPlacement pp ON pp.PlacementID = p.ID 
JOIN PlayerView pl ON pp.PlayerID = pl.ID 
WHERE Payout > 0
GO



CREATE TABLE [dbo].[ImportError](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SQL] [nvarchar](1000) NOT NULL,
	[Message] [nvarchar](1000) NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


SELECT * FROM Region
SELECT * FROM Week

INSERT INTO Region VALUES ('Middle East', 'ME')