USE Fornite
GO

--ALTER TABLE Placement ADD EarnedQualification bit NOT NULL DEFAULT 0

DECLARE @week nvarchar(10)
SET @week = 'Week9' 
SELECT top 50 * FROM Placement WHERE WeekNumber = @week ORDER BY Payout DESC

UPDATE Placement SET EarnedQualification = 1 WHERE ID = 24106
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27001
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27002
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 24203
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 24201
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 25401
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 24805
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 24806
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 24808
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 24807
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27201
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27202
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27205
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27206
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27211
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27212
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 24303
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 24305
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 26704
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27401
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27402
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27403
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27404
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27405
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 27406
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 31401
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 31402
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 31403
UPDATE Placement SET EarnedQualification = 1 WHERE ID = 31502


