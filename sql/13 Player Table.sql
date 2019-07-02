USE [Fortnite]
GO


--CREATE TABLE [dbo].[Tracker](
--	[json] [nvarchar](max) NULL
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
--GO



EXEC DropTable 'Player'
GO

CREATE TABLE Player (
	Region nvarchar(100) NOT NULL DEFAULT '' 
	, Team nvarchar(100) NOT NULL DEFAULT '' 
	, Player nvarchar(100) NOT NULL DEFAULT ''
	, Nationality nvarchar(100) NOT NULL DEFAULT '' 
	, KbmOrController varchar(10) NOT NULL DEFAULT 0
	, Age nvarchar(2) NOT NULL DEFAULT ''
	, Solo bit NOT NULL
) ON [PRIMARY] 