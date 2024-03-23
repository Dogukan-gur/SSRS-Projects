
WITH CTE1 AS 
(
    SELECT ID, MAX(STL_PRODART) AS MAKSART, MIN(POS_NR) AS MAXPOS
    FROM [dbo].[ALFAK_STKL_DG]
    WHERE STL_PRODART IN (1, 2) 
    GROUP BY ID
)
,
CTE2 AS (
	SELECT * 
FROM 
	(
	SELECT 
	STKL.ID,
	ISI.ACT,
	KOPF.STATUS, 
	ROW_NUMBER() OVER (PARTITION BY STKL.ID,STKL.POS_NR,STKL.BOM_PRODUKT ORDER BY STKL.ID) AS RN
	FROM [dbo].[ALFAK_STKL_DG] AS STKL
	INNER JOIN CTE1 ON STKL.ID = CTE1.ID
	INNER JOIN [dbo].[ALFAK_KOPF_DG] AS KOPF ON STKL.ID=KOPF.ID
	INNER JOIN [dbo].[ISICAM_DETAY] AS ISI ON STKL.BOM_PRODUKT=ISI.PRODUKT

	WHERE 
	(	
		(STL_BIT=12 AND STL_PRODART IN (1,2, 30, 60, 10, 11, 12, 20, 40, 3) AND STL_MOD=1
			OR (STL_PRODART IN (1, 3, 10, 11, 12, 20, 30, 40, 60) AND STL_BEZ LIKE '%Lameks%') 							) 		
			OR(
			STL_PRODART IN (CTE1.MAKSART, 30, 60, 10, 11, 12, 20, 40, 3)
			OR (STL_PRODART IN (1, 3, 10, 11, 12, 20, 30, 40, 60) AND STL_BEZ LIKE '%Lameks%'))
	)
	AND STKL.POS_NR = CTE1.MAXPOS
	AND LEN(STKL.ID) > 4
	AND KOPF.STATUS BETWEEN 389 AND 599 
	AND  ISI.PRODUKT  IN (15001,15002,15005)
	)
		q2)
,CTE3 AS
	(
			SELECT ID,DOLGU,ACT FROM 
					(
					SELECT 
					STKL.ID,
					ISI.ACT,
					CTE2.ACT AS DOLGU,
					KOPF.STATUS, 
					ROW_NUMBER() OVER (PARTITION BY STKL.ID,STKL.POS_NR,STKL.BOM_PRODUKT ORDER BY STKL.ID) AS RN
					FROM [dbo].[ALFAK_STKL_DG] AS STKL
					INNER JOIN CTE1 ON STKL.ID = CTE1.ID
					INNER JOIN [dbo].[ALFAK_KOPF_DG] AS KOPF ON STKL.ID=KOPF.ID
					RIGHT JOIN CTE2 ON STKL.ID=CTE2.ıd
					INNER JOIN [dbo].[ISICAM_DETAY] AS ISI ON STKL.BOM_PRODUKT=ISI.PRODUKT
					WHERE 
					(	(STL_BIT=12 AND STL_PRODART IN (1,2, 30, 60, 10, 11, 12, 20, 40, 3) AND STL_MOD=1
						OR (STL_PRODART IN (1, 3, 10, 11, 12, 20, 30, 40, 60) AND STL_BEZ LIKE '%Lameks%') 							) 	
						OR(
						STL_PRODART IN (CTE1.MAKSART, 30, 60, 10, 11, 12, 20, 40, 3)
						OR (STL_PRODART IN (1, 3, 10, 11, 12, 20, 30, 40, 60) AND STL_BEZ LIKE '%Lameks%')
					))
					AND STKL.POS_NR = CTE1.MAXPOS
					AND LEN(STKL.ID) > 4
					AND KOPF.STATUS BETWEEN 389 AND 599
					AND ISI.PRODUKT NOT IN (15001,15002,15005)

					)Q1
			WHERE Q1.RN=1
			) 

SELECT 
    CTE1.ID,
    ACT AS DOLGU,
    STATUS,
    STUFF(
        (
            SELECT ', ' + CTE3.ACT
            FROM CTE3 
            WHERE CTE3.ID = CTE2.ID 
            FOR XML PATH('')
        ), 1, 1, ''
    ) AS KOMBINASYON
FROM CTE2 INNER JOIN CTE1 ON CTE1.ID=CTE2.ID
	--WHERE CTE1.ID=227033
