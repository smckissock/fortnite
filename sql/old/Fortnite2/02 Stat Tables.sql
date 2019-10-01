USE Fortnite
GO

EXEC DropTable 'StatIndex'
GO  

CREATE TABLE [dbo].[StatIndex](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PlacementID] [int] NOT NULL,
	[StatIndex] [nvarchar](30) NOT NULL,
	[PointsEarned] [int] NOT NULL,
	[TimesAchieved] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[StatIndex]  WITH CHECK ADD FOREIGN KEY([PlacementID])
REFERENCES [dbo].[Placement] ([ID])
GO


EXEC DropView 'PlacementCountView'
GO
CREATE VIEW [dbo].[PlacementCountView]
AS
SELECT Count(*) Placements, SoloOrDuo, WeekNumber 
FROM Placement
GROUP BY SoloOrDuo, WeekNumber 
--ORDER BY SoloOrDuo, WeekNumber 
GO



EXEC DropTable 'Stat'
GO
CREATE TABLE Stat (
	ID [int] IDENTITY(1,1) NOT NULL,
	PlacementID int NOT NULL REFERENCES Placement(ID),
	StatIndex nvarchar(30) NOT NULL,
	PointsEarned int NOT NULL,
	TimesAchieved int NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO



EXEC DropView 'PointsTestView'
GO

CREATE VIEW PointsTestView
AS 
WITH PointCalc (PlacementID, Points)
AS (
	SELECT PlacementID, SUM(PointsEarned)
	FROM Stat
	GROUP BY PlacementID
)

SELECT 
	p.ID,
	p.WeekNumber,
	p.SoloOrDuo,
	p.Player,
	p.RegionCode,
	p.Points,
	c.Points PointsFromStats
FROM Placement p 
JOIN PointCalc c ON c.PlacementID = p.ID 


-- Should have no results
-- SELECT * FROM PointsTestView WHERE Points <> PointsFromStats

SELECT * FROM PLacementCountView
EXEC DropView 'StatView'
GO


CREATE VIEW StatView 
AS

WITH PointCalc (PlacementID, Points)
AS (
	SELECT PlacementID, SUM(PointsEarned)
	FROM Stat
	GROUP BY PlacementID
),
Wins (PlacementID, Points)
AS (
	SELECT PlacementID, SUM(PointsEarned)
	FROM Stat
	WHERE StatIndex = 'PLACEMENT_STAT_INDEX:1'
	GROUP BY PlacementID
),
Elim (PlacementID, Points)
AS (
	SELECT PlacementID, SUM(PointsEarned)
	FROM Stat
	WHERE StatIndex LIKE '%ELIMS%' 
	GROUP BY PlacementID
)

SELECT 
	--p.ID,
	REPLACE(WeekNumber, 'k', 'k ') week,
	p.soloOrDuo,
	p.player,
	r.Name region,
	rank,
	p.points,
	CASE WHEN SoloOrDuo = 'Solo' THEN Payout ELSE Payout / 2 END payout,
	--c.Points PointsFromStats,
	ISNULL(w.Points, 0) wins,
	ISNULL(e.Points, 0) elims,
	ISNULL(p.Points, 0) - ISNULL(e.Points, 0) placementPoints 
FROM Placement p 
JOIN Region r ON p.RegionCode = r.Code 		
LEFT JOIN PointCalc c ON c.PlacementID = p.ID
LEFT JOIN Wins w ON w.PlacementID = p.ID 
LEFT JOIN Elim e ON e.PlacementID = p.ID 
		
