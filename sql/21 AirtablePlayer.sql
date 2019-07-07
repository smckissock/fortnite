USE Fortnite
GO

--CREATE TABLE [dbo].[Player](
--	[ID] [int] IDENTITY(1,1) NOT NULL,
--	[Name] [nvarchar](100) NOT NULL,
--	[CsvName] [nvarchar](100) NOT NULL,
--	[NationalityID] [int] NOT NULL,
--	[TeamID] [int] NOT NULL,
--	[KbmOrControllerID] [int] NOT NULL,
--	[Age] [nvarchar](2) NOT NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[ID] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
--) ON [PRIMARY]
--GO

--ALTER TABLE [dbo].[Player] ADD  DEFAULT ('') FOR [Name]
--GO

--ALTER TABLE [dbo].[Player] ADD  DEFAULT ('') FOR [CsvName]
--GO

--ALTER TABLE [dbo].[Player] ADD  DEFAULT ((1)) FOR [NationalityID]
--GO

--ALTER TABLE [dbo].[Player] ADD  DEFAULT ((1)) FOR [TeamID]
--GO

--ALTER TABLE [dbo].[Player] ADD  DEFAULT ((1)) FOR [KbmOrControllerID]
--GO

--ALTER TABLE [dbo].[Player] ADD  DEFAULT ('') FOR [Age]
--GO

--ALTER TABLE [dbo].[Player]  WITH CHECK ADD FOREIGN KEY([KbmOrControllerID])
--REFERENCES [dbo].[KbmOrController] ([ID])
--GO

--ALTER TABLE [dbo].[Player]  WITH CHECK ADD FOREIGN KEY([NationalityID])
--REFERENCES [dbo].[Nationality] ([ID])
--GO

--ALTER TABLE [dbo].[Player]  WITH CHECK ADD FOREIGN KEY([TeamID])
--REFERENCES [dbo].[Team] ([ID])
--GO


EXEC DropTable 'AirtablePlayer'
GO

CREATE TABLE [dbo].[AirtablePlayer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](500) NOT NULL,
	[RegionCode] [nvarchar](100) NOT NULL,
	[CsvName] [nvarchar](100) NOT NULL,
	[Age] [nvarchar](100) NOT NULL,
	[Team] [nvarchar](100) NOT NULL,
	[Nationality] [nvarchar](100) NOT NULL,
	[KbmOrController] [nvarchar](100) NOT NULL,
	[Twitter] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED (
	[ID] ASC
)	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE Player ADD Twitter NVARCHAR(100) NOT NULL DEFAULT ''
GO

INSERT INTO Player
SELECT 
	Name,
	CsvName,
	(SELECT ID FROM Nationality WHERE Name = Nationality),
	(SELECT ID FROM Team WHERE Name = Team),
	(SELECT ID FROM KbmOrController WHERE Name = KbmOrController),
	Age,
	Twitter
FROM AirtablePlayer
WHERE Name NOT IN (SELECT Name FROM Player)


--- 

SELECT * FROM Player WHERE Name Like '%Ghost%'


SELECT * FROM AirTablePlayer WHERe Name IN (SELECT Name FROM Player)
SELECT * FROM AirTablePlayer WHERe Name NOT IN (SELECT Name FROM Placement)


SELECT Nationality FROM AirtablePLayer WHERE Nationality NOT IN (SELECT Name FROM Nationality)
SELECT Team FROM AirtablePLayer WHERE Team NOT IN (SELECT Name FROM Team) 



SELECT * FROM Team WHERe Name Like '%ex%'

