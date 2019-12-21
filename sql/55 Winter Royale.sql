SELECT * FROM Week

INSERT INTO Week VALUES ('Winter Royale 1', 23, '')
INSERT INTO Week VALUES ('Winter Royale 2', 24, '')
INSERT INTO Week VALUES ('Winter Royale 3', 25, '')

INSERT INTO Match VALUES ('Winter Royale', 'Online Open', 'Event1-3', 1)

INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Winter Royale'), 2, 'WR #1', 23, '2019-12-21')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Winter Royale'), 2, 'WR #2', 24, '2019-12-22')
INSERT INTO Event VALUES ((SELECT ID FROM Match WHERE Name = 'Winter Royale'), 2, 'WR #3', 25, '2019-12-23')


UPDATE Event SET EventDate = '2019-12-20' WHERE ID = 2048
UPDATE Event SET EventDate = '2019-12-21' WHERE ID = 2049
UPDATE Event SET EventDate = '2019-12-22' WHERE ID = 2050