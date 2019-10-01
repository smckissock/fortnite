USE Fortnite
GO


CREATE TABLE [dbo].[Placement3](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WeekNumber] [nvarchar](10) NOT NULL,
	[SoloOrDuo] [nvarchar](4) NOT NULL,
	[Player] [nvarchar](500) NOT NULL,
	[RegionCode] [nvarchar](4) NOT NULL,
	[Rank] [int] NOT NULL,
	[Payout] [int] NOT NULL,
	[Points] [int] NOT NULL,
	[Qualification] [bit] NOT NULL,
	[EarnedQualification] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Placement3] ADD  DEFAULT ((0)) FOR [Qualification]
GO

ALTER TABLE [dbo].[Placement3] ADD  DEFAULT ((0)) FOR [EarnedQualification]
GO

SET IDENTITY_INSERT Placement3 ON

INSERT INTO Placement3
(
	ID,
	WeekNumber,
	SoloOrDuo,
	Player,
	RegionCode,
	[Rank],
	Payout,
	Points,
	Qualification,
	EarnedQualification 
) 
SELECT *
FROM Placement
SET IDENTITY_INSERT Placement3 OFF

sp_help 'placement'




CREATE TABLE [dbo].[Stat3](
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

ALTER TABLE [dbo].[Stat3]  WITH CHECK ADD FOREIGN KEY([PlacementID])
REFERENCES [dbo].[Placement3] ([ID])
GO



SET IDENTITY_INSERT Stat3 ON

INSERT INTO Stat3
(
	ID,
	PlacementID,
	StatIndex,
	PointsEarned,
	TimesAchieved
) 
SELECT *
FROM Stat
SET IDENTITY_INSERT Stat3 OFF

SELECT * fROM Stat3

DELETE FROM Stat
DELETE FROM Placement



 