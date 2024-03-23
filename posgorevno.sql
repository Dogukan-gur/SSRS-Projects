USE [DOGUKANSSIS]
GO

/****** Object:  StoredProcedure [dbo].[POSGOREVNO]    Script Date: 23.03.2024 21:57:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




 CREATE PROCEDURE [dbo].[POSGOREVNO]
    @GorevNo NVARCHAR(255)
	AS
	BEGIN 
	
 (
 SELECT
  P.ID
  ,P.POS_NR
  ,P.POS_KOMMISSION
  ,P.POS_KUNDENPOS
  ,P.PROD_BEZ1
  ,P.PROD_BEZ2
  ,P.PROD_BEZ3
  ,P.PP_QM_FAKT
  ,P.PP_LFM_FAKT
  ,P.PP_MENGE
  ,P.PP_BREITE
  ,P.PP_HOEHE
  ,P.FI_PREIS_ME_BASE
  ,P.PROD_ID
  ,I.BA_PRODUKT
  ,CASE WHEN I.BA_PRODUKTGRP='Ayna' THEN 'Mirror'  
	WHEN I.BA_PRODUKTGRP='Bombeli Lamine �retim Cam�' THEN 'Curved Laminated Glass' 
	WHEN I.BA_PRODUKTGRP='Buzlu Cam' THEN 'Pattern Glass'
	WHEN I.BA_PRODUKTGRP='D�z Cam' THEN 'Float Glass'
	WHEN I.BA_PRODUKTGRP='Folyo' THEN 'Foil'
	WHEN I.BA_PRODUKTGRP='Haz�r Lamine' THEN 'Lamex'
	WHEN I.BA_PRODUKTGRP='Kontra Sald�r� �niteler' THEN 'Ballistic Unit'
	WHEN I.BA_PRODUKTGRP='Lamine �retim Cam�' THEN 'Laminated Glass'
	WHEN I.BA_PRODUKTGRP='Reflekte Kaplamal� Cam' THEN 'Reflective Coated Glass'
	WHEN I.BA_PRODUKTGRP='Temperli Cam' THEN 'Tempered Monolithic Glass'
	WHEN I.BA_PRODUKTGRP='Yal�t�m Cam�' THEN 'Insulated Glass'
	WHEN I.BA_PRODUKTGRP='Yumu�ak Kaplamal� Cam (s�y�rmal�)' THEN 'Soft Coated Glass With Edge Deletion'
	WHEN I.BA_PRODUKTGRP='Yumu�ak kaplamal� Yal�t�m Cam�' THEN 'Soft Coated Insulated Glass'
	ELSE '' END AS PRODUKTGOUP

FROM
  [dbo].[ITEM_DG] AS I
  INNER JOIN [dbo].[ALFAK_POS_DG] AS P
    ON I.BA_PRODUKT = P.PROD_ID
WHERE
  P.DATUM > N'2024-01-01T00:00:00'
  AND P.POS_BIT != 0
  AND ID IN (
			SELECT CAST( VALUE AS INT) AS VALUE 
			FROM
			SplitStringDG(
@GorevNo,','))
  )
  END
GO


