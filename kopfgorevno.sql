USE [DOGUKANSSIS]
GO

/****** Object:  StoredProcedure [dbo].[KOPFGOREVNO]    Script Date: 23.03.2024 21:56:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KOPFGOREVNO]
    @GorevNo NVARCHAR(255)
AS
BEGIN

		(
		SELECT
		  ID
		  ,AH_NAME1
		  ,AH_NAME2
		  ,AH_NAME3
		  ,AH_STRASSE
		  ,AH_ORT
		  ,SU_GEWICHT
		  ,FI_BETR_MWST1
		  ,SU_STUECK
		  ,SU_LFM_REAL
		  ,SU_QM_REAL
		  ,AH_IDENT
		  ,FI_MWST1_BASIS_FW
		  ,FI_WAEHRUNG
		  ,STEUERNUMMER
		  ,FI_MWST1
		  ,FI_BETR_BRUTTO
		FROM
		  [dbo].[ALFAK_KOPF_DG]
		  WHERE
        ID IN (
			SELECT CAST( VALUE AS INT) AS VALUE 
			FROM
			SplitStringDG(
@GorevNo,','))
		  )
	END
GO


