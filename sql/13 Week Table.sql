USE Fortnite
GO

EXEC DropTable 'Week'
GO

CREATE TABLE [dbo].[Week](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL UNIQUE,
	[Index] [int] NOT NULL UNIQUE,
	Comment varchar(1000)
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


INSERT INTO Week VALUES('WC Week 1', 1, '')
INSERT INTO Week VALUES('WC Week 2', 2, '')
INSERT INTO Week VALUES('WC Week 3', 3, '')
INSERT INTO Week VALUES('WC Week 4', 4, '')
INSERT INTO Week VALUES('WC Week 5', 5, '')
INSERT INTO Week VALUES('WC Week 6', 6, '')
INSERT INTO Week VALUES('WC Week 7', 7, '')
INSERT INTO Week VALUES('WC Week 8', 8, '')
INSERT INTO Week VALUES('WC Week 9', 9, '')
INSERT INTO Week VALUES('WC Week 10', 10, '')
INSERT INTO Week VALUES('WC Final', 11, '')
INSERT INTO Week VALUES('CS Week 1', 12, '')
INSERT INTO Week VALUES('CS Week 2', 13, '')
INSERT INTO Week VALUES('CS Week 3', 14, '')
INSERT INTO Week VALUES('CS Week 4', 15, '')
INSERT INTO Week VALUES('CS Week 5', 16, '')



ALTER TABLE Event ADD WeekID INT;

UPDATE Event SET WeekID = ID

UPDATE Event SET WeekID = ID - 1 WHERE ID > 11

ALTER TABLE Event
  ADD CONSTRAINT FK_Event_Week FOREIGN KEY (WeekId)     
      REFERENCES dbo.Week (ID)


INSERT INTO Match VALUES ('Contender''s Cash Cup Wednesday Solos', 'Online Open', 'Event5') 
INSERT INTO Match VALUES ('Champions''s Solos Cash Cup Thursday', 'Online Open', 'Event5')
INSERT INTO Match VALUES ('Champions''s Cash Cup Friday Trios', 'Online Open', 'Event4')

UPDATE Match SET Name = 'Champions''s Cash Cup Thursday Solos' WHERE Name = 'Champions''s Solos Cash Cup Thursday'

UPDATE Event SET EventDate = '2019-08-18' WHERE Name = 'CS Week 1' 
UPDATE Event SET EventDate = '2019-08-24' WHERE Name = 'CS Week 2'  
UPDATE Event SET EventDate = '2019-09-01' WHERE Name = 'CS Week 3'  
UPDATE Event SET EventDate = '2019-09-08' WHERE Name = 'CS Week 4'  
UPDATE Event SET EventDate = '2019-09-15' WHERE Name = 'CS Week 5'  

INSERT INTO Week VALUES ('CS Final', 17, '')


INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Contender''s Cash Cup Wednesday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Wednesday #1', (SELECT ID FROM Week WHERE Name = 'CS Week 1'), '2019-08-21')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Contender''s Cash Cup Wednesday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Wednesday #2', (SELECT ID FROM Week WHERE Name = 'CS Week 2'), '2019-08-28')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Contender''s Cash Cup Wednesday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Wednesday #3', (SELECT ID FROM Week WHERE Name = 'CS Week 3'), '2019-09-04')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Contender''s Cash Cup Wednesday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Wednesday #4', (SELECT ID FROM Week WHERE Name = 'CS Week 4'), '2019-09-11')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Contender''s Cash Cup Wednesday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Wednesday #5', (SELECT ID FROM Week WHERE Name = 'CS Week 5'), '2019-09-18')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Contender''s Cash Cup Wednesday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Wednesday #6', (SELECT ID FROM Week WHERE Name = 'CS Final'), '2019-09-25')

INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Thursday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Thursday #1', (SELECT ID FROM Week WHERE Name = 'CS Week 1'), '2019-08-22')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Thursday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Thursday #2', (SELECT ID FROM Week WHERE Name = 'CS Week 2'), '2019-08-29')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Thursday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Thursday #3', (SELECT ID FROM Week WHERE Name = 'CS Week 3'), '2019-09-05')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Thursday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Thursday #4', (SELECT ID FROM Week WHERE Name = 'CS Week 4'), '2019-09-12')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Thursday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Thursday #5', (SELECT ID FROM Week WHERE Name = 'CS Week 5'), '2019-09-19')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Thursday Solos'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Thursday #6', (SELECT ID FROM Week WHERE Name = 'CS Final'), '2019-09-26')

INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Friday Trios'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Friday #1', (SELECT ID FROM Week WHERE Name = 'CS Week 1'), '2019-08-23')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Friday Trios'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Friday #2', (SELECT ID FROM Week WHERE Name = 'CS Week 2'), '2019-08-30')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Friday Trios'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Friday #3', (SELECT ID FROM Week WHERE Name = 'CS Week 3'), '2019-09-06')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Friday Trios'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Friday #4', (SELECT ID FROM Week WHERE Name = 'CS Week 4'), '2019-09-13')
--INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Friday Trios'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Friday #5', (SELECT ID FROM Week WHERE Name = 'CS Week 5'), '2019-09-18')
--INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Champions''s Cash Cup Friday Trios'), (SELECT ID FROM Format WHERE Name = 'Solo'), 'CC Friday #6', (SELECT ID FROM Week WHERE Name = 'CS Final'), '2019-09-25')



SELECT * FROM RankPayoutTier







