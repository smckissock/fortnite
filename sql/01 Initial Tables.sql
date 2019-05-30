USE Fortnite
GO

CREATE PROCEDURE [dbo].[DropTable](@table AS varchar(500)) 
AS
BEGIN
	DECLARE @sql nvarchar(500)
	SET @sql = 'IF OBJECT_ID(''' + @table + ''', ''U'') IS NOT NULL BEGIN DROP TABLE ' + @table + ' END'
	EXEC sp_executesql @sql
END	
GO

	
CREATE PROCEDURE [dbo].[DropView](@view AS varchar(500)) 
AS
BEGIN
	DECLARE @sql nvarchar(500)
	SET @sql = 'IF OBJECT_ID(''' + @view + ''', ''V'') IS NOT NULL BEGIN DROP VIEW ' + @view + ' END'
	EXEC sp_executesql @sql
END	
GO



EXEC DropTable 'Region'
GO
CREATE TABLE Region (
	ID [int] IDENTITY(1,1) NOT NULL,
	Code nvarchar(5) NOT NULL,
	Name nvarchar (20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO Region VALUES ('NAE', 'NA East')
INSERT INTO Region VALUES ('NAW', 'NA West')
INSERT INTO Region VALUES ('EU', 'Europe')
INSERT INTO Region VALUES ('OCE', 'Oceana')
INSERT INTO Region VALUES ('ASIA', 'Asia')
INSERT INTO Region VALUES ('BR', 'Brazil') 


EXEC DropTable 'Placement'
GO
CREATE TABLE Placement (
	ID [int] IDENTITY(1,1) NOT NULL,
	WeekNumber nvarchar(10) NOT NULL,
	SoloOrDuo nvarchar(4) NOT NULL,
	Player nvarchar(500) NOT NULL,
	RegionCode nvarchar(4) NOT NULL,
	Rank int NOT NULL,
	Payout int NOT NULL,
	Points int NOT NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

EXEC DropView 'DataView'
GO
CREATE VIEW DataView 
AS
SELECT 
	REPLACE(WeekNumber, 'k', 'k ') week,
	soloOrDuo,
	player,
	r.Name region,
	rank,
	CASE WHEN SoloOrDuo = 'Solo' THEN Payout ELSE Payout / 2 END payout,
	points
FROM Placement
JOIN Region r ON Placement.RegionCode = r.Code 				

