USE Fortnite
GO

EXEC DROPTABLE 'AirTableUpdate'
GO

CREATE TABLE [dbo].[AirtableUpdate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	UploadTime DateTime NOT NULL DEFAULT GETDATE(),
	Players int NOT NULL DEFAULT 0,
	Teams int NOT NULL DEFAULT 0,
	Nationalities int NOT NULL DEFAULT 0
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


EXEC DropView 'AirtableUpdateView'
GO

CREATE VIEW AirtableUpdateView
AS
SELECT GetDate(), UploadTime,  SUM(players) Players, SUM(teams) Teams, SUM(nationalities) Nationalties
FROM ( 
SELECT COUNT(*) players , 0 teams, 0 nationalities FROM Player WHERE TeamID NOT IN (1, 17)
UNION ALL
SELECT 0, COUNT(*), 0 Teams FROM Team
UNION ALL
SELECT 0, 0, COUNT(*) Nationalities FROM Nationality
) a



--INSERT INTO AirtableUpdate
--SELECT * FROM AirtableUpdateView

SELECT * FROM AirTableUpdateView