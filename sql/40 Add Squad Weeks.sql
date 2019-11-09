USE Fortnite
GO


--INSERT INTO Match VALUES ('Fortnite Champion Series Squads' , 'Online Open', 'Event2', 1)

--INSERT INTO Week VALUES ('CS Squads Week 1', 18, '')
INSERT INTO Week VALUES ('CS Squads Week 2', 19, '')
INSERT INTO Week VALUES ('CS Squads Week 3', 20, '')
INSERT INTO Week VALUES ('CS Squads Week 4', 21, '')
INSERT INTO Week VALUES ('CS Squads Final', 22, '')


--INSERT INTO Event VALUES (1006, 4, 'CS Squads #1', 18, '2019-11-03')

INSERT INTO Event VALUES (1006, 4, 'CS Squads #2', 19, '2019-11-10')
INSERT INTO Event VALUES (1006, 4, 'CS Squads #3', 20, '2019-11-17')
INSERT INTO Event VALUES (1006, 4, 'CS Squads #4', 21, '2019-11-24')
INSERT INTO Event VALUES (1006, 4, 'CS Squads Final', 22, '2019-12-08')




-- Squads Week 2

INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 1, 22500)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 2, 10000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 3, 7500)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 5, 5000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 10, 2500)

INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 1, 36000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 2, 16000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 3, 12000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 5, 8000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 10, 4000)

INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 1, 9000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 2, 4000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 3, 3000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 5, 2000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 10, 1000)

INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 1, 9000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 2, 4000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 3, 3000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 5, 2000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 10, 1000)

INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'ASIA'), 1, 5000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'ASIA'), 2, 3000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'ASIA'), 5, 1500)

INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'OCE'), 1, 5000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'OCE'), 2, 3000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'OCE'), 5, 1500)

INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'ME'), 1, 5000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'ME'), 2, 3000)
INSERT INTO RankPayoutTier VALUES (2036, (SELECT ID FROM Region WHERE EpicCode = 'ME'), 5, 1500)

-- Squads Week 3

INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 1, 22500)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 2, 10000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 3, 7500)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 5, 5000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 10, 2500)

INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 1, 36000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 2, 16000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 3, 12000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 5, 8000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 10, 4000)

INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 1, 9000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 2, 4000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 3, 3000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 5, 2000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 10, 1000)

INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 1, 9000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 2, 4000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 3, 3000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 5, 2000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 10, 1000)

INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'ASIA'), 1, 5000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'ASIA'), 2, 3000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'ASIA'), 5, 1500)

INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'OCE'), 1, 5000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'OCE'), 2, 3000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'OCE'), 5, 1500)

INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'ME'), 1, 5000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'ME'), 2, 3000)
INSERT INTO RankPayoutTier VALUES (2037, (SELECT ID FROM Region WHERE EpicCode = 'ME'), 5, 1500)

-- Squads Week 4

INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 1, 22500)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 2, 10000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 3, 7500)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 5, 5000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAE'), 10, 2500)

INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 1, 36000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 2, 16000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 3, 12000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 5, 8000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'EU'), 10, 4000)

INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 1, 9000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 2, 4000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 3, 3000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 5, 2000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'NAW'), 10, 1000)

INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 1, 9000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 2, 4000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 3, 3000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 5, 2000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'BR'), 10, 1000)

INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'ASIA'), 1, 5000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'ASIA'), 2, 3000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'ASIA'), 5, 1500)

INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'OCE'), 1, 5000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'OCE'), 2, 3000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'OCE'), 5, 1500)

INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'ME'), 1, 5000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'ME'), 2, 3000)
INSERT INTO RankPayoutTier VALUES (2038, (SELECT ID FROM Region WHERE EpicCode = 'ME'), 5, 1500)

