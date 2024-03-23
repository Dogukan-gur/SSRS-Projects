WITH CTE1 AS 
(
    SELECT ID, MAX(STL_PRODART) AS MAKSART, MIN(POS_NR) AS MAXPOS
    FROM [ARDMAIN].[SYSADM].[BW_AUFTR_STKL]
    WHERE STL_PRODART IN (1, 2) 
    GROUP BY ID
)

	SELECT 
	STKL.ID,
	STKL.POS_NR,
	STKL.STL_BEZ ,
	STKL.STL_PRODART,
	STKL.STL_PRODGRP,
	PR_MEEINHEIT AS BIRIM,
	VER_PREIS_ME AS BIRIMFIYAT,
	VER_NETTO_GES AS HESAPLANMISFIYAT,
	KOPF.DATUM_ERF,
	STKL.ROWID,
	STKL.BOM_PRODUKT
	FROM [ARDMAIN].[SYSADM].[BW_AUFTR_STKL] AS STKL
	INNER JOIN CTE1 ON STKL.ID = CTE1.ID
	INNER JOIN [SYSADM].[BW_AUFTR_KOPF] AS KOPF ON STKL.ID=KOPF.ID

	WHERE 
	(	(STL_BIT=12 AND STL_PRODART IN (1,2, 30, 60, 10, 11, 12, 20, 40, 3) AND STL_MOD=1
        OR (STL_PRODART IN (1, 3, 10, 11, 12, 20, 30, 40, 60) AND STL_BEZ LIKE '%Lameks%') 							) 
		
		OR(
        STL_PRODART IN (CTE1.MAKSART, 30, 60, 10, 11, 12, 20, 40, 3)
        OR (STL_PRODART IN (1, 3, 10, 11, 12, 20, 30, 40, 60) AND STL_BEZ LIKE '%Lameks%')
    ))
	AND POS_NR = CTE1.MAXPOS
	AND KOPF.DATUM_ERF >DATEADD(MONTH, -1, GETDATE())
	AND LEN(STKL.ID) > 4
	--AND STKL.ID=226999

--SELECT * FROM [ARDMAIN].[SYSADM].[BW_AUFTR_STKL] WHERE ID=729333