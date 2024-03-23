USE [DOGUKANSSIS]
GO

/****** Object:  UserDefinedFunction [dbo].[SplitStringDG]    Script Date: 23.03.2024 21:59:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[SplitStringDG](

		@FullString NVARCHAR(MAX)
		,@Separator NVARCHAR(1)
		)
RETURNS @t TABLE(VALUE NVARCHAR(MAX))
AS 
BEGIN

	DECLARE @SingleString NVARCHAR(MAX)
	DECLARE @SeparatorPosition INT =CHARINDEX(@Separator, @FullString)
		
		WHILE @SeparatorPosition >0 
			BEGIN
				SET @SingleString= LEFT(@FullString,@SeparatorPosition -1)
				INSERT INTO @t VALUES (@SingleString)
				SET @FullString= SUBSTRING(@FullString,@SeparatorPosition + 1, LEN(@FullString))
				SET @SeparatorPosition = CHARINDEX(@Separator, @FullString)
			END
	INSERT INTO @t VALUES (@FullString)

	RETURN
END
GO


