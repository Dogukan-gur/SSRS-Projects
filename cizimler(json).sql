USE [DOGUKANSSIS]
GO

/****** Object:  View [dbo].[ALCIMFOTO]    Script Date: 23.03.2024 21:54:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[ALCIMFOTO] AS (

select Q1.auftnr
 ,M.pos,m.u_pos,m.lauf,m.modellnr,'data:image/png;base64,' + Q1.skizze as PhotoAsText,Q1.RN
from 

openjson(
  (
   select auftnr,pos,u_pos,teile_nr,bearb_nr,lauf,skizzentyp,speicherzeit,skizze,ROW_NUMBER() OVER (PARTITION BY skizze ORDER BY auftnr ) AS RN
   from modelleralcim
   
   for json auto
  )
 ) with(auftnr int,pos int,u_pos int,teile_nr int,bearb_nr int,lauf int,skizzentyp int,speicherzeit date,skizze  varchar(max), RN  int ) as 
 Q1
 INNER JOIN modelleralcim AS M ON M.auftnr=Q1.auftnr
 where Q1.RN=1
 )
 


GO


