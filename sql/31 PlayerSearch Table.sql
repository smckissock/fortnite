USE [Fortnite]
GO


CREATE TABLE [dbo].[PlayerSearch](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PlayerID] int NOT NULL REFERENCES Player(ID),
	SearchDate Date NOT NULL, 
	[TotalEvents] int NOT NULL,
	[UniqueEvents] int NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


EXEC DropTable 'PlayerSearchView'
GO

CREATE OR ALTER VIEW PlayerSearchView 
AS
SELECT 
	p.Name, 
	p.Region,
	s.SearchDate,
	s.TotalEvents,
	s.UniqueEvents
FROM PlayerView p
JOIN PlayerSearch s ON p.ID = s.PlayerID


SELECT * FROM PlayerSearchView 


SELECT 
	Name, 
	SUM(TotalEvents)
FROM 
	PLayerSearchView
GROUP BY Name
ORDER BY SUM(TotalEvents) DESC



