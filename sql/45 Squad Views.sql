USE Fornite
GO



SELECT MAX(ID) FROM Squad

SELECT * FROM Squad
SELECT * FROM SquadPlayer
SELECT * FROM SquadPlacement


SELECT RegionID, Count(*) FROM Squad GROUP BY RegionID


SELECT * FROM (
 SELECT
 product_id,
 product_name,
 brand_id,
 list_price,
 RANK () OVER ( 
 PARTITION BY brand_id
 ORDER BY list_price DESC
 ) price_rank 
 FROM
 production.products
) t
WHERE price_rank <= 3;



SELECT SquadID, PlayerID FROM (
	SELECT
		SquadID,
		PlayerID,
		RANK () OVER ( 
			PARTITION BY SquadID
			ORDER BY PlayerID DESC
		) SquadRank
	FROM
		SquadPlayer
) t WHERE t.SquadRank = 4


SELECT ID, PlayerID, SquadID, RANK () 
OVER ( PARTITION BY SquadID ORDER BY PlayerID DESC) PlayerRank
FROM SquadPlayer WHERE PlayerRank = 1


WITH Player1 (SquadID, PlayerID) AS ( 
	SELECT SquadID, PlayerID FROM (
		SELECT
			SquadID,
			PlayerID,
			RANK () OVER ( 
				PARTITION BY SquadID
				ORDER BY PlayerID DESC
			) SquadRank
		FROM
			SquadPlayer
	) t WHERE t.SquadRank = 1
)
SELECT p1.SquadID, p1.PlayerID
FROM Player1 p1




WITH Players (SquadID, PlayerID, SquadRank) AS ( 
	SELECT SquadID, PlayerID, SquadRank FROM (
		SELECT
			SquadID,
			PlayerID,
			RANK () OVER ( 
				PARTITION BY SquadID
				ORDER BY PlayerID DESC
			) SquadRank
		FROM
			SquadPlayer
	) t 
)
SELECT 
	p.SquadID, 
	p.PlayerID 
FROM Players p
