USE Fornite
GO

--ALTER TABLE Placement ADD EarnedQualification bit NOT NULL DEFAULT 0

DECLARE @week nvarchar(10)
SET @week = 'Week10' 
SELECT top 100 * FROM Placement WHERE WeekNumber = @week ORDER BY Rank

UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32106
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 35701
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 35702
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32201
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32203
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 33701
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32906
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32905
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32907
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32908
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 35901 
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 35902
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 35905
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 35906
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 35911
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 35912
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 40401
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 40402
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32303
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32305
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 35304
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36101
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36102
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36103
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36104
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36105
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36106
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32401
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32402
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 32403
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 33902	
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 33305
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 33306
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 34801
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 34802
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36303
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36304
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36305
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 36306


SELECT * FROM StatView 

SELECT * FROM Placement WHERe Qualification = 1 AND WeekNumber = 'Week10' AND RegionCode = 'EU'  

ORDER BY RegionCode