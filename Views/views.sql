USE [SchedulerProduction]
GO
/****** Object:  View [dbo].[View_Country_US_First]    Script Date: 09/12/2017 11:20:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Country_US_First]
AS

SELECT Id, Name, '+' + Code + ' (' + Name +')' Code, [Order] FROM Country  --WHERE Id='D4E7D7D5-D7BF-4F81-B2FE-C7CA3D03C533'
--UNION 
--SELECT Id, Name, '+' + Code + ' (' + Name +')' Code FROM
--(
--	SELECT TOP 240 Id, Name, Code FROM Country WHERE Id<>'D4E7D7D5-D7BF-4F81-B2FE-C7CA3D03C533' ORDER BY Name
--) x
GO
/****** Object:  View [dbo].[View_HostDevice]    Script Date: 09/12/2017 11:20:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_HostDevice]
AS
	SELECT [Id], 
	[HostId], 
	[ConfigFileName], 
	[InputName] AS Name, 
	CASE WHEN LocalIP='lo-config' THEN 'Encoder Internal' ELSE 'Encoder External' END AS Type 
	FROM [PLEClientStreamConfig] WHERE [Deleted]=0
	UNION
	SELECT [Id], 
	[HostId], 
	[ConfigFileName], 
	[InputName] AS Name, 
	CASE WHEN EXISTS(SELECT * 
				FROM [PLEServerStream] 
				WHERE [HostId]=[PLEServerConfig].[HostId] AND [ConfigFileName] 
				LIKE REPLACE	([PLEServerConfig].[ConfigFileName], '-config', '') + '_stream_%' AND [OutputMulticast]=1 AND [OutputMulticastIFace]='lo-config') THEN 'Decoder Internal' ELSE 'Decoder External' END AS Type
	FROM [PLEServerConfig] WHERE [Deleted]=0
GO
/****** Object:  View [dbo].[View_Person_FullName_Email]    Script Date: 09/12/2017 11:20:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Person_FullName_Email]
AS

	SELECT [Person].[Id], CASE WHEN [Prefix] IS NULL OR [Prefix]='' THEN '' ELSE [Prefix] + ' ' END
	 + CASE WHEN [FirstName] IS NULL OR [FirstName]='' THEN '' ELSE [FirstName] + ' ' END
	 + CASE WHEN [MiddleName] IS NULL OR [MiddleName]='' THEN '' ELSE [MiddleName] + '. ' END
	 + CASE WHEN [LastName] IS NULL OR [LastName]='' THEN '' ELSE [LastName] + ' ' END
	 + CASE WHEN [Suffix] IS NULL OR [Suffix]='' THEN '' ELSE [Suffix] + ' ' END AS Name
	, [Email]
      ,[Phone].[CountryId] AS PhoneCountryId
      ,[Phone].[AreaCode]
      ,[Phone].[Number]
	FROM [Person]
	LEFT OUTER JOIN [Phone] ON [Phone].[PersonId]=[Person].[Id] AND [Phone].[PhoneType]=0
GO
/****** Object:  View [dbo].[View_Company]    Script Date: 09/12/2017 11:20:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_Company]
AS
SELECT [Company].[Id]
      ,[Company].[Name]
      ,[Company].[Website]
      ,[Address].[Address1]
      ,[Address].[Address2]
      ,CASE WHEN [Address].StateId IS NULL THEN [Address].[StateProvince] ELSE (SELECT [Name] FROM STATE WHERE Id=[Address].[StateId]) END AS State
      ,[Address].[City]
      ,[Address].[Zip]
      ,[Address].[CountryId]
      ,[Phone].[CountryId] AS PhoneCountryId
      ,[Phone].[AreaCode]
      ,[Phone].[Number]
      ,[Company].[IsMaster]
      ,[Company].[Contact]
      ,[Company].[Email]
      ,[Company].[AccountingEmail]
      ,[Company].[AccountingNotifications]
      ,[Company].[EventEmail]
      ,[Company].[EventNotifications]
      ,[Company].[Enabled]
FROM Company
LEFT OUTER JOIN [ADDRESS] ON [Address].[Id]=[Company].[AddressId]
LEFT OUTER JOIN [Phone] ON [Phone].[CompanyId]=[Company].[Id] AND [Phone].[PhoneType]=2
GO
