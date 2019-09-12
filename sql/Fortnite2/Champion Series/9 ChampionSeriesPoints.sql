USE Fortnite
GO


--1st Place - 500 Series Points
--2nd Place - 450 Series Points
--3rd Place - 400 Series Points
--4th Place - 375 Series Points
--5th Place - 350 Series Points
--6th Place - 300 Series Points
--7th Place - 275 Series Points
--8th Place - 250 Series Points
--9th Place - 225 Series Points
--10th Place - 200 Series Points
--11th-25th Place - 175 Series Points
--26th-50th Place - 150 Series Points
--51st-100th Place - 125 Series Points
--101st-150th Place - 100 Series Points
--151st-500th Place - 75 Series Points
--501st-1000th Place - 50 Series Points
--1001st-2000th Place - 40 Series Points
--2001st-3000th Place - 30 Series Points
--3001st-5000th Place - 20 Series Points
--5001st-10000th Place - 10 Series Points
--10001st-25000th Place - 5 Series Points
--25001st-50000th Place - 3 Series Points
--50001st-100000th Place - 1 Series Point

--2	450
--28	150
--50	150


CREATE OR ALTER FUNCTION dbo.ChampionSeriesPoints (@rank INT)
RETURNS INT AS
BEGIN
RETURN 
	CASE 
		WHEN @rank = 1 THEN 500
		WHEN @rank = 2 THEN 450
		WHEN @rank = 3 THEN 400
		WHEN @rank = 4 THEN 375
		WHEN @rank = 5 THEN 350
		WHEN @rank = 6 THEN 300
		WHEN @rank = 7 THEN 275
		WHEN @rank = 8 THEN 250
		WHEN @rank = 9 THEN 225
		WHEN @rank = 10 THEN 200
		WHEN @rank > 10 AND @Rank < 26 THEN 175
		WHEN @rank > 25 AND @Rank < 51 THEN 150
		WHEN @rank > 50 AND @Rank < 101 THEN 125
		WHEN @rank > 100 AND @Rank <  151 THEN 100
		WHEN @rank > 150 AND @Rank <  501 THEN 75
		WHEN @rank > 500 AND @Rank <  1001 THEN 50
		WHEN @rank > 1000 AND @Rank < 2001 THEN 40
		WHEN @rank > 2000 AND @Rank < 3001 THEN 30
		WHEN @rank > 3000 AND @Rank < 5001 THEN 20
		WHEN @rank > 5000 AND @Rank < 10001 THEN 10
		WHEN @rank > 10000 AND @Rank < 25001 THEN 5
		WHEN @rank > 25000 AND @Rank < 50000 THEN 3
		WHEN @rank > 50000 AND @Rank < 100000 THEN 1
		ELSE 0
	END
END


SELECT dbo.ChampionSeriesPoints(2) + dbo.ChampionSeriesPoints(28) + dbo.ChampionSeriesPoints(50) 