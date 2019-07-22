

SELECT COUNT(*) FROM FOrtnite..StatsWithPlayerInfoView WHERE EarnedQualification <> 0
SELECT COUNT(*) FROM StatsWithPlayerInfoView WHERE EarnedQualification <> 0

SELECT * FROM 



SELECT week, region, player, rank, Points FROM Fortnite..StatsWithPlayerInfoView WHERE SoloWeek <> 0
AND Player NOT IN (
SELECT PLayer FROM StatsWithPlayerInfoView WHERE SoloWeek <> 0
) ORDER BY Week, Region

Week 1	Europe	LеStrеam Nayte	6	61
Week 3	Brazil	Lasers is bad	1	79
Week 5	NA West	1400 Rhux UwU	2	76
Week 7	Asia	T1 がちがち Arius	2	85
Week 7	NA East	Astоnish	4	62
Week 9	Europe	HORT_LYGHT	4	66
Week 9	Oceania	sozmann 奧	1	82


SELECT * FROM StatsWithPlayerInfoView WHERE Week = 'Week 9' AND Region = 'Oceania' ORDER BY Week, Region, Rank
UPDATE Placement SET Qualification = 1 WHERE ID =  
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
UPDATE Placement SET Qualification = 1 WHERE ID =
vUPDATE Placement SET Qualification = 1 WHERE ID =


UPDATE Placement SET Qualification = 1 WHERE ID = 28677 
UPDATE Placement SET Qualification = 1 WHERE ID = 72036 
UPDATE Placement SET Qualification = 1 WHERE ID = 20184
UPDATE Placement SET Qualification = 1 WHERE ID = 63852
UPDATE Placement SET Qualification = 1 WHERE ID = 8698
UPDATE Placement SET Qualification = 1 WHERE ID = 40674
UPDATE Placement SET Qualification = 1 WHERE ID = 53693


SELECT * FROM StatsWithPlayerInfoView
