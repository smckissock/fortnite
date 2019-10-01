USE Fortnite
GO


SELECT * FROM Placement

DECLARE @week nvarchar(10)
SET @week = 'Week1' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

-- Week1
UPDATE Placement SET Qualification = 1 WHERE ID = 32001
UPDATE Placement SET Qualification = 1 WHERE ID = 32002 
UPDATE Placement SET Qualification = 1 WHERE ID = 32003
UPDATE Placement SET Qualification = 1 WHERE ID = 32004 
UPDATE Placement SET Qualification = 1 WHERE ID = 32005
UPDATE Placement SET Qualification = 1 WHERE ID = 32006
UPDATE Placement SET Qualification = 1 WHERE ID = 33501
UPDATE Placement SET Qualification = 1 WHERE ID = 33502
UPDATE Placement SET Qualification = 1 WHERE ID = 35001
UPDATE Placement SET Qualification = 1 WHERE ID = 35002
UPDATE Placement SET Qualification = 1 WHERE ID = 35003
UPDATE Placement SET Qualification = 1 WHERE ID = 35004
UPDATE Placement SET Qualification = 1 WHERE ID = 35005
UPDATE Placement SET Qualification = 1 WHERE ID = 35006
UPDATE Placement SET Qualification = 1 WHERE ID = 35007
UPDATE Placement SET Qualification = 1 WHERE ID = 35008
UPDATE Placement SET Qualification = 1 WHERE ID = 36501
UPDATE Placement SET Qualification = 1 WHERE ID = 38001
UPDATE Placement SET Qualification = 1 WHERE ID = 39501 


DECLARE @week nvarchar(10)
SET @week = 'Week2' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 10 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 32502
UPDATE Placement SET Qualification = 1 WHERE ID = 32501
UPDATE Placement SET Qualification = 1 WHERE ID = 32504
UPDATE Placement SET Qualification = 1 WHERE ID = 32503
UPDATE Placement SET Qualification = 1 WHERE ID = 32506
UPDATE Placement SET Qualification = 1 WHERE ID = 32505
UPDATE Placement SET Qualification = 1 WHERE ID = 34002
UPDATE Placement SET Qualification = 1 WHERE ID = 34001
UPDATE Placement SET Qualification = 1 WHERE ID = 35502
UPDATE Placement SET Qualification = 1 WHERE ID = 35501
UPDATE Placement SET Qualification = 1 WHERE ID = 35504
UPDATE Placement SET Qualification = 1 WHERE ID = 35503
UPDATE Placement SET Qualification = 1 WHERE ID = 35506
UPDATE Placement SET Qualification = 1 WHERE ID = 35505
UPDATE Placement SET Qualification = 1 WHERE ID = 35508
UPDATE Placement SET Qualification = 1 WHERE ID = 35507
UPDATE Placement SET Qualification = 1 WHERE ID = 37002
UPDATE Placement SET Qualification = 1 WHERE ID = 37001
UPDATE Placement SET Qualification = 1 WHERE ID = 38502
UPDATE Placement SET Qualification = 1 WHERE ID = 38501
UPDATE Placement SET Qualification = 1 WHERE ID = 40002
UPDATE Placement SET Qualification = 1 WHERE ID = 40001



DECLARE @week nvarchar(10)
SET @week = 'Week3' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 32101
UPDATE Placement SET Qualification = 1 WHERE ID = 32102
UPDATE Placement SET Qualification = 1 WHERE ID = 32103
UPDATE Placement SET Qualification = 1 WHERE ID = 32104
UPDATE Placement SET Qualification = 1 WHERE ID = 32105
UPDATE Placement SET Qualification = 1 WHERE ID = 32107
UPDATE Placement SET Qualification = 1 WHERE ID = 33601
UPDATE Placement SET Qualification = 1 WHERE ID = 33602
UPDATE Placement SET Qualification = 1 WHERE ID = 35101
UPDATE Placement SET Qualification = 1 WHERE ID = 35102
UPDATE Placement SET Qualification = 1 WHERE ID = 35103
UPDATE Placement SET Qualification = 1 WHERE ID = 35104
UPDATE Placement SET Qualification = 1 WHERE ID = 35105
UPDATE Placement SET Qualification = 1 WHERE ID = 35106
UPDATE Placement SET Qualification = 1 WHERE ID = 35107
UPDATE Placement SET Qualification = 1 WHERE ID = 35108
UPDATE Placement SET Qualification = 1 WHERE ID = 36601 
UPDATE Placement SET Qualification = 1 WHERE ID = 38101
UPDATE Placement SET Qualification = 1 WHERE ID = 38102
UPDATE Placement SET Qualification = 1 WHERE ID = 39601
UPDATE Placement SET Qualification = 1 WHERE ID = 39602


DECLARE @week nvarchar(10)
SET @week = 'Week4' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 14 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 32702
UPDATE Placement SET Qualification = 1 WHERE ID = 32701
UPDATE Placement SET Qualification = 1 WHERE ID = 32704
UPDATE Placement SET Qualification = 1 WHERE ID = 32703 
UPDATE Placement SET Qualification = 1 WHERE ID = 32706
UPDATE Placement SET Qualification = 1 WHERE ID = 32705
UPDATE Placement SET Qualification = 1 WHERE ID = 34202
UPDATE Placement SET Qualification = 1 WHERE ID = 34201
UPDATE Placement SET Qualification = 1 WHERE ID = 35704
UPDATE Placement SET Qualification = 1 WHERE ID = 35703
UPDATE Placement SET Qualification = 1 WHERE ID = 35706
UPDATE Placement SET Qualification = 1 WHERE ID = 35705
UPDATE Placement SET Qualification = 1 WHERE ID = 35708
UPDATE Placement SET Qualification = 1 WHERE ID = 35707 

UPDATE Placement SET Qualification = 1 WHERE ID = 35710
UPDATE Placement SET Qualification = 1 WHERE ID = 35709 


DECLARE @week nvarchar(10)
SET @week = 'Week5' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 12 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 32202
UPDATE Placement SET Qualification = 1 WHERE ID = 32204
UPDATE Placement SET Qualification = 1 WHERE ID = 32205
UPDATE Placement SET Qualification = 1 WHERE ID = 32206
UPDATE Placement SET Qualification = 1 WHERE ID = 32207
UPDATE Placement SET Qualification = 1 WHERE ID = 32208

UPDATE Placement SET Qualification = 1 WHERE ID = 33702
UPDATE Placement SET Qualification = 1 WHERE ID = 33703

UPDATE Placement SET Qualification = 1 WHERE ID = 35201
UPDATE Placement SET Qualification = 1 WHERE ID = 35202
UPDATE Placement SET Qualification = 1 WHERE ID = 35203
UPDATE Placement SET Qualification = 1 WHERE ID = 35204
UPDATE Placement SET Qualification = 1 WHERE ID = 35205
UPDATE Placement SET Qualification = 1 WHERE ID = 35206
UPDATE Placement SET Qualification = 1 WHERE ID = 35207
UPDATE Placement SET Qualification = 1 WHERE ID = 35208

UPDATE Placement SET Qualification = 1 WHERE ID = 36701

UPDATE Placement SET Qualification = 1 WHERE ID = 38201

UPDATE Placement SET Qualification = 1 WHERE ID = 39701


DECLARE @week nvarchar(10)
SET @week = 'Week6'  
SELECT top 10 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 14 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 4 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 32902
UPDATE Placement SET Qualification = 1 WHERE ID = 32901
UPDATE Placement SET Qualification = 1 WHERE ID = 32904
UPDATE Placement SET Qualification = 1 WHERE ID = 32903
UPDATE Placement SET Qualification = 1 WHERE ID = 32910
UPDATE Placement SET Qualification = 1 WHERE ID = 32909
UPDATE Placement SET Qualification = 1 WHERE ID = 34402
UPDATE Placement SET Qualification = 1 WHERE ID = 34401
UPDATE Placement SET Qualification = 1 WHERE ID = 35904
UPDATE Placement SET Qualification = 1 WHERE ID = 35903
UPDATE Placement SET Qualification = 1 WHERE ID = 35908
UPDATE Placement SET Qualification = 1 WHERE ID = 35907
UPDATE Placement SET Qualification = 1 WHERE ID = 35910
UPDATE Placement SET Qualification = 1 WHERE ID = 35909
UPDATE Placement SET Qualification = 1 WHERE ID = 35914 
UPDATE Placement SET Qualification = 1 WHERE ID = 35913 
UPDATE Placement SET Qualification = 1 WHERE ID = 37402
UPDATE Placement SET Qualification = 1 WHERE ID = 37401
UPDATE Placement SET Qualification = 1 WHERE ID = 38902
UPDATE Placement SET Qualification = 1 WHERE ID = 38901
UPDATE Placement SET Qualification = 1 WHERE ID = 40404
UPDATE Placement SET Qualification = 1 WHERE ID = 40403


DECLARE @week nvarchar(10)
SET @week = 'Week7' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 10 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 32301 
UPDATE Placement SET Qualification = 1 WHERE ID = 32302
UPDATE Placement SET Qualification = 1 WHERE ID = 32304
UPDATE Placement SET Qualification = 1 WHERE ID = 32306
UPDATE Placement SET Qualification = 1 WHERE ID = 32307
UPDATE Placement SET Qualification = 1 WHERE ID = 32308
UPDATE Placement SET Qualification = 1 WHERE ID = 33801
UPDATE Placement SET Qualification = 1 WHERE ID = 33802
UPDATE Placement SET Qualification = 1 WHERE ID = 35301
UPDATE Placement SET Qualification = 1 WHERE ID = 35302
UPDATE Placement SET Qualification = 1 WHERE ID = 35303
UPDATE Placement SET Qualification = 1 WHERE ID = 35305
UPDATE Placement SET Qualification = 1 WHERE ID = 35306
UPDATE Placement SET Qualification = 1 WHERE ID = 35307
UPDATE Placement SET Qualification = 1 WHERE ID = 35308
UPDATE Placement SET Qualification = 1 WHERE ID = 35309
UPDATE Placement SET Qualification = 1 WHERE ID = 36801
UPDATE Placement SET Qualification = 1 WHERE ID = 38301
UPDATE Placement SET Qualification = 1 WHERE ID = 38302
UPDATE Placement SET Qualification = 1 WHERE ID = 39801
UPDATE Placement SET Qualification = 1 WHERE ID = 39802


DECLARE @week nvarchar(10)
SET @week = 'Week8' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 14 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 33102
UPDATE Placement SET Qualification = 1 WHERE ID = 33101
UPDATE Placement SET Qualification = 1 WHERE ID = 33104 
UPDATE Placement SET Qualification = 1 WHERE ID = 33103
UPDATE Placement SET Qualification = 1 WHERE ID = 33106
UPDATE Placement SET Qualification = 1 WHERE ID = 33105
UPDATE Placement SET Qualification = 1 WHERE ID = 34602
UPDATE Placement SET Qualification = 1 WHERE ID = 34601
UPDATE Placement SET Qualification = 1 WHERE ID = 36108
UPDATE Placement SET Qualification = 1 WHERE ID = 36107
UPDATE Placement SET Qualification = 1 WHERE ID = 36110
UPDATE Placement SET Qualification = 1 WHERE ID = 36109
UPDATE Placement SET Qualification = 1 WHERE ID = 36112
UPDATE Placement SET Qualification = 1 WHERE ID = 36111
UPDATE Placement SET Qualification = 1 WHERE ID = 36114
UPDATE Placement SET Qualification = 1 WHERE ID = 36113


DECLARE @week nvarchar(10)
SET @week = 'Week9' 
SELECT top 12 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 10 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 32404
UPDATE Placement SET Qualification = 1 WHERE ID = 32405
UPDATE Placement SET Qualification = 1 WHERE ID = 32406
UPDATE Placement SET Qualification = 1 WHERE ID = 32407
UPDATE Placement SET Qualification = 1 WHERE ID = 32408
UPDATE Placement SET Qualification = 1 WHERE ID = 32409

UPDATE Placement SET Qualification = 1 WHERE ID = 33901
UPDATE Placement SET Qualification = 1 WHERE ID = 33903

UPDATE Placement SET Qualification = 1 WHERE ID = 35401
UPDATE Placement SET Qualification = 1 WHERE ID = 35402
UPDATE Placement SET Qualification = 1 WHERE ID = 35403
UPDATE Placement SET Qualification = 1 WHERE ID = 35404
UPDATE Placement SET Qualification = 1 WHERE ID = 35405
UPDATE Placement SET Qualification = 1 WHERE ID = 35406
UPDATE Placement SET Qualification = 1 WHERE ID = 35407
UPDATE Placement SET Qualification = 1 WHERE ID = 35408

UPDATE Placement SET Qualification = 1 WHERE ID = 36901
UPDATE Placement SET Qualification = 1 WHERE ID = 38401
UPDATE Placement SET Qualification = 1 WHERE ID = 39901

DECLARE @week nvarchar(10)
SET @week = 'Week10' 
SELECT top 8 * FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAE' ORDER BY Payout DESC
SELECT top 8 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'NAW' ORDER BY Payout DESC
SELECT top 16 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'EU' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'OCE' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'ASIA' ORDER BY Payout DESC
SELECT top 3 *  FROM Placement WHERE WeekNumber = @week AND RegionCode = 'BR' ORDER BY Payout DESC

UPDATE Placement SET Qualification = 1 WHERE ID = 33302
UPDATE Placement SET Qualification = 1 WHERE ID = 33301
UPDATE Placement SET Qualification = 1 WHERE ID = 33304
UPDATE Placement SET Qualification = 1 WHERE ID = 33303
UPDATE Placement SET Qualification = 1 WHERE ID = 33308
UPDATE Placement SET Qualification = 1 WHERE ID = 33307
UPDATE Placement SET Qualification = 1 WHERE ID = 34804
UPDATE Placement SET Qualification = 1 WHERE ID = 34803
UPDATE Placement SET Qualification = 1 WHERE ID = 36302
UPDATE Placement SET Qualification = 1 WHERE ID = 36301
UPDATE Placement SET Qualification = 1 WHERE ID = 36308
UPDATE Placement SET Qualification = 1 WHERE ID = 36307
UPDATE Placement SET Qualification = 1 WHERE ID = 36310
UPDATE Placement SET Qualification = 1 WHERE ID = 36309
UPDATE Placement SET Qualification = 1 WHERE ID = 36311
UPDATE Placement SET Qualification = 1 WHERE ID = 36312
UPDATE Placement SET Qualification = 1 WHERE ID = 40801
UPDATE Placement SET Qualification = 1 WHERE ID = 40802
UPDATE Placement SET Qualification = 1 WHERE ID = 39302
UPDATE Placement SET Qualification = 1 WHERE ID = 39301
UPDATE Placement SET Qualification = 1 WHERE ID = 37802
UPDATE Placement SET Qualification = 1 WHERE ID = 37801




SELECT 
	SoloOrDuo, WeekNumber, RegionCode, Player,  Count(*)  
FROM Placement 
WHERE Qualification = 1 

GROUP BY SoloOrDuo, WeekNumber, RegionCode, Player HAVING WeekNumber = 'Week9'
ORDER BY SoloOrDuo, WeekNumber, RegionCode, Player



SELECT * FROM  Placement WHERE Qualification = 1



	SELECT * FROM Placement WHERE Qualification = 1 AND WeekNumber = 'Week9' ORDER BY Player

SELECT 
	WeekNumber, Count(*)  
FROM Placement 
WHERE Qualification = 1 
GROUP BY WeekNumber

GROUP BY SoloOrDuo, WeekNumber, RegionCode, Player HAVING WeekNumber = 'Week7'
ORDER BY SoloOrDuo, WeekNumber, RegionCode, Player


