USE [DOGUKANSSIS]
GO

/****** Object:  StoredProcedure [dbo].[KOMBIGOREV]    Script Date: 23.03.2024 21:55:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



  CREATE PROCEDURE [dbo].[KOMBIGOREV]
    @GorevNo NVARCHAR(255)
AS
SELECT  [ID]
      ,[CUSTOMER]
      ,[TOTSQM]
      ,[ENTRYDATE]
      ,[QUANTITY]
      ,[KOMBINASYON]
      ,[rowid]
  FROM [dbo].[GOREVKOMBINASYONLARI]
WHERE ID IN (
			SELECT CAST( VALUE AS INT) AS VALUE 
			FROM
			SplitStringDG(
@GorevNo,','))

GO


