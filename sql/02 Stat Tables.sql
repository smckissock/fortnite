USE Fortnite
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
	StatIndex varchar(30) NOT NULL,
	PointsEarned int NOT NULL,
	TimesAchieved int NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

