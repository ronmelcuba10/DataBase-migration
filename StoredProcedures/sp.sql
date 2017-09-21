USE [SchedulerProduction]
GO
/****** Object:  StoredProcedure [dbo].[Configuration_Update]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Configuration_Update]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@IntValue INT,
	@StringValue VARCHAR(50)
AS
BEGIN
	UPDATE [dbo].[Configuration] SET IntValue=@IntValue, StringValue=@StringValue WHERE Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[EventStatus_GetMonitorList]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 
-- Description:			Selects the status to be shown in the monitor view
-- =============================================
CREATE PROCEDURE [dbo].[EventStatus_GetMonitorList]
AS
BEGIN
	SELECT *
	FROM [EventStatus]
	WHERE [Name] IN ('Starting', 'Started', 'Stopping')
	ORDER BY [Id]
END
GO
/****** Object:  StoredProcedure [dbo].[EventStatus_GetList]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 
-- Description:			Returns the list of status
-- =============================================
CREATE PROCEDURE [dbo].[EventStatus_GetList]

AS
BEGIN
	SELECT *
	FROM [EventStatus]
	WHERE [Id] > 0
	-- Show all the status but Id = 0 -> 'All'. Is used in the scheduler to show all the status in the table
	ORDER BY [Id]
END
GO
/****** Object:  StoredProcedure [dbo].[Host_InsertUpdateByLicenseKey]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Host_InsertUpdateByLicenseKey]
	@Name VARCHAR(50),
	@SerialNumber VARCHAR(20),
	@CompanyId UNIQUEIDENTIFIER,
	@LicenseKey VARCHAR(50),
	@IPAddress VARCHAR(50),
	@MacAddress VARCHAR(50),
	@Version VARCHAR(50),
	@TunnelIP VARCHAR(50),
	@ApiPort VARCHAR(50),
	@ApiPassword VARCHAR(50),
	@LanIPAddress VARCHAR(50),
	@LastCheckin DATETIME
AS
BEGIN
	IF NOT EXISTS(SELECT *
	FROM Host
	WHERE LicenseKey=@LicenseKey)
	BEGIN
		INSERT INTO Host
			(
			[Name],
			[SerialNumber],
			[CompanyId],
			[LicenseKey],
			[IPAddress],
			[MacAddress],
			[Version],
			[TunnelIP],
			[ApiPort],
			[ApiPassword],
			[LanIPAddress],
			[LastCheckin]
			)
		VALUES
			(
				@Name,
				@SerialNumber,
				@CompanyId,
				@LicenseKey,
				@IPAddress,
				@MacAddress,
				@Version,
				@TunnelIP,
				@ApiPort,
				@ApiPassword,
				@LanIPAddress,
				@LastCheckIn
		)
	END
	ELSE
	BEGIN
		UPDATE [dbo].[Host] SET
			[Name]=@Name, 
			[SerialNumber]=@SerialNumber, 
			[CompanyId]=@CompanyId, 
			[IPAddress]=@IPAddress, 
			[MacAddress]=@MacAddress, 
			[Version]=@Version,
			[TunnelIP]=@TunnelIP,
			[ApiPassword]= @ApiPassword,
			[ApiPort]= @ApiPort,
			[LanIPAddress]= @LanIPAddress,
			[LastCheckIn]= @LastCheckIn
		WHERE [LicenseKey]=@LicenseKey
	END
	SELECT [Id]
	FROM [dbo].[Host]
	WHERE [LicenseKey]=@LicenseKey
END
GO
/****** Object:  StoredProcedure [dbo].[Button_InsertUpdate]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Button_InsertUpdate]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@ImageId UNIQUEIDENTIFIER,
	@IsHome BIT = 0
AS
BEGIN
	If EXISTS(SELECT * 	FROM [dbo].[Button]	WHERE [Id]<>@Id AND [Name]=@Name)
		SELECT 1 AS Successful
	ELSE If EXISTS(SELECT *	FROM [dbo].[Button]	WHERE [Id]=@Id AND [IsHome]=1 AND @IsHome=0)
			SELECT 2 AS Successful
		ELSE
			BEGIN
				BEGIN TRY
					BEGIN TRANSACTION
						IF EXISTS(SELECT * FROM [dbo].[Button] WHERE [Id]=@Id)
							UPDATE [dbo].[Button] SET 
								[Name]=@Name, 
								[ImageId]=@ImageId, 
								[IsHome]=@IsHome 
							WHERE [Id]=@Id
						ELSE
							INSERT INTO [dbo].[Button](
								[Id],
								[Name],
								[ImageId],
								[IsHome])
							VALUES(
									@Id,
									@Name,
									@ImageId,
									@IsHome)

						IF @IsHome=1
							UPDATE [dbo].[Button] SET IsHome=0 WHERE Id<>@Id
						SELECT 0 AS Successful
					COMMIT TRANSACTION
				END TRY
				BEGIN CATCH
					IF @@TRANCOUNT > 0
					BEGIN
						ROLLBACK TRANSACTION
						SELECT -2 AS Successful
					END
				END CATCH
			END
END
GO
/****** Object:  StoredProcedure [dbo].[RoleCompany_InsertUpdate]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RoleCompany_InsertUpdate]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@CompanyId UNIQUEIDENTIFIER,
	@RoleTypeId UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[RoleCompany]	WHERE [Id]=@Id)
	BEGIN
		IF EXISTS(SELECT * FROM [dbo].[RoleCompany]	WHERE [Id]<>@Id AND [Name]=@Name)
			SELECT 1 AS Successful
		ELSE
			UPDATE [dbo].[RoleCompany] SET 
				[Name]=@Name, 
				[CompanyId]=@CompanyId, 
				[RoleTypeId]=@RoleTypeId 
				WHERE [Id]=@Id
			SELECT 0 AS Successful
	END
	ELSE
		BEGIN
			IF EXISTS(SELECT * FROM [dbo].[RoleCompany]	WHERE [Id]<>@Id AND [Name]=@Name)
				SELECT 1 AS Successful
			ELSE
				BEGIN
					INSERT INTO [dbo].[RoleCompany]
						(
						[Id],
						[Name],
						[CompanyId],
						[RoleTypeId])
					VALUES(
							@Id,
							@Name,
							@CompanyId,
							@RoleTypeId)
					SELECT 0 AS Successful
				END
		END
END
GO
/****** Object:  StoredProcedure [dbo].[Scope_GetListByCompanyIdGridButtonId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Scope_GetListByCompanyIdGridButtonId]
	@CompanyId UNIQUEIDENTIFIER,
	@GridButtonId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageUrl VARCHAR(100)
	SELECT @PageUrl=[Url]
	FROM [dbo].[Page]
	WHERE [Id]=(SELECT [PageId]
	FROM [dbo].[PageButton]
	WHERE [Id]=@GridButtonId)
	SELECT [Id],
		[Name],
		[Value]
	FROM [dbo].[Scope]
	WHERE (((SELECT [Id]
		FROM [dbo].[Company]
		WHERE [IsMaster]=1)=@CompanyId) OR [Value]<>(SELECT MAX([Value])
		FROM [dbo].[Scope]))
		AND ([Value]<>1 OR (@PageUrl='Monitor.aspx') OR (@PageUrl='Scheduling.aspx'))
	ORDER BY [Value]
END
GO
/****** Object:  StoredProcedure [dbo].[Role_RemoveObject]    Script Date: 09/07/2017 14:00:15 ******/
-- this needs to be modified for every table*****************************************************************************************************
/*
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_RemoveObject]
	@ObjectId	UNIQUEIDENTIFIER,
	@RoleCompanyId UNIQUEIDENTIFIER
AS
BEGIN
	DELETE RoleObjectScope WHERE ObjectId=@ObjectId AND RoleCompanyId=@RoleCompanyId
END
GO
*/
-- this will be removed *****************************************************************************************************
/****** Object:  StoredProcedure [dbo].[Role_RemoveBrand]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 		9-15-2017
-- Description:			Removes a brand from role-scope
-- =============================================
CREATE PROCEDURE [dbo].[Role_RemoveBrand]
	@BrandId	UNIQUEIDENTIFIER,
	@RoleCompanyId 	UNIQUEIDENTIFIER
AS
BEGIN
	DELETE BrandRoleScope WHERE BrandId=@PageButtonId AND RoleCompanyId=@RoleCompanyId
END
GO
/****** Object:  StoredProcedure [dbo].[Role_RemoveGridButton]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 		9-15-2017
-- Description:			Removes a gridbutton from role-scope
-- =============================================
CREATE PROCEDURE [dbo].[Role_RemoveGridButton]
	@GridButtonId	UNIQUEIDENTIFIER,
	@RoleCompanyId 	UNIQUEIDENTIFIER
AS
BEGIN
	DELETE GridButtonRoleScope WHERE GridButtonId=@PageButtonId AND RoleCompanyId=@RoleCompanyId
END
GO
/****** Object:  StoredProcedure [dbo].[Role_RemovePageButton]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 		9-15-2017
-- Description:			Removes a pagebutton from role-scope
-- =============================================
CREATE PROCEDURE [dbo].[Role_RemovePageButton]
	@PageButtonId	UNIQUEIDENTIFIER,
	@RoleCompanyId 	UNIQUEIDENTIFIER
AS
BEGIN
	DELETE PageButtonRoleScope WHERE PageButtonId=@PageButtonId AND RoleCompanyId=@RoleCompanyId
END
GO
/****** Object:  StoredProcedure [dbo].[Role_RemoveMenuItem]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 		9-15-2017
-- Description:			Removes a menuitem from role-scope
-- =============================================
CREATE PROCEDURE [dbo].[Role_RemoveMenuItem]
	@MenuItemId		UNIQUEIDENTIFIER,
	@RoleCompanyId 	UNIQUEIDENTIFIER
AS
BEGIN
	DELETE [dbo].[MenuItemRoleScope] WHERE [MenuItemId]=@MenuItemId AND [RoleCompanyId]=@RoleCompanyId
END
GO
/****** Object:  StoredProcedure [dbo].[Role_RemovePage]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 		9-15-2017
-- Description:			Removes a page from role-scope
-- =============================================
CREATE PROCEDURE [dbo].[Role_RemovePage]
	@PageId			UNIQUEIDENTIFIER,
	@RoleCompanyId 	UNIQUEIDENTIFIER
AS
BEGIN
	DELETE [dbo].[PageRoleScope] WHERE [PageId]=@PageId AND [RoleCompanyId]=@RoleCompanyId
END
GO
/****** Object:  StoredProcedure [dbo].[PageButtonRoleScope_UpdateByRoleIdGridButtonIdScopeId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageButtonRoleScope_UpdateByRoleIdGridButtonIdScopeId]
	@Id UNIQUEIDENTIFIER,
	@GridButtonId UNIQUEIDENTIFIER,
	@ScopeId UNIQUEIDENTIFIER
AS
BEGIN
	DELETE [dbo].[PageButtonRoleScope] WHERE [RoleCompanyId]=@Id AND [PageButtonId]=@GridButtonId
	INSERT INTO [dbo].[PageButtonRoleScope]
		(
		[RoleCompanyId],
		[PageButtonId],
		[ScopeId])
	VALUES(
			@Id,
			@GridButtonId,
			@ScopeId)
END
GO
/****** Object:  StoredProcedure [dbo].[PLEServerConfig_InsertUpdate_HostId_ConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLEServerConfig_InsertUpdate_HostId_ConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100),
	@InputName VARCHAR(32),
	@BindIP VARCHAR(32),
	@Port INT,
	@LanIPAddress VARCHAR(16),
	@AltIPAddress VARCHAR(16)
AS
BEGIN
	IF EXISTS(SELECT [Id]
	FROM [dbo].[PLEServerConfig]
	WHERE [HostId]=@HostId AND [ConfigFileName]=@ConfigFileName)
	UPDATE [dbo].[PLEServerConfig] SET
		[InputName]=@InputName,
		[BindIP]=@BindIP,
		[Port]=@Port,
		[ModifiedOn]=CURRENT_TIMESTAMP,
		[LanIPAddress]=@LanIPAddress,
		[AltIPAddress]=@AltIPAddress,
		[Deleted]=0
	WHERE [HostId]=@HostId AND [ConfigFileName]=@ConfigFileName
ELSE
	INSERT INTO [dbo].[PLEServerConfig]
		(
		[HostId],
		[ConfigFileName],
		[InputName],
		[BindIP],
		[Port],
		[ModifiedOn],
		[LanIPAddress],
		[AltIPAddress]
		)
	VALUES(
		@HostId,
		@ConfigFileName,
		@InputName,
		@BindIP,
		@Port,
		CURRENT_TIMESTAMP,
		@LanIPAddress,
		@AltIPAddress
	)
END
GO
/****** Object:  StoredProcedure [dbo].[PLEClientStreamConfig_InsertUpdate_HostId_ConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLEClientStreamConfig_InsertUpdate_HostId_ConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100),
	@InputName VARCHAR(32),
	@StartMode INT,
	@ClientIndex VARCHAR(8),
	@LocalPort INT,
	@LocalIP VARCHAR(32),
	@LanIPAddress VARCHAR(16),
	@InputMulticast BIT,
	@InputMulticastIP VARCHAR(16),
	@InputMulticastIFace VARCHAR(16),
	@MultiIPAddress VARCHAR(16)
AS
BEGIN
	IF EXISTS(SELECT [Id] FROM [dbo].[PLEClientStreamConfig] WHERE [HostId]=@HostId AND [ConfigFileName]=@ConfigFileName)
	UPDATE [dbo].[PLEClientStreamConfig] SET
		[InputName]=@InputName,
		[StartMode]=@StartMode,
		[ClientIndex]=@ClientIndex,
		[LocalPort]=@LocalPort,
		[ModifiedOn]=CURRENT_TIMESTAMP,
		[LocalIP]=@LocalIP,
		[LanIPAddress]=@LanIPAddress,
		[InputMulticast]=@InputMulticast,
		[InputMulticastIP]=@InputMulticastIP,
		[InputMulticastIFace]=@InputMulticastIFace,
		[MultiIPAddress]=@MultiIPAddress,
		[Deleted]=0
	WHERE [HostId]=@HostId AND [ConfigFileName]=@ConfigFileName
ELSE
	INSERT INTO PLEClientStreamConfig
		(
		[HostId],
		[ConfigFileName],
		[InputName],
		[StartMode],
		[ClientIndex],
		[LocalPort],
		[ModifiedOn],
		[LocalIP],
		[LanIPAddress],
		[InputMulticast],
		[InputMulticastIP],
		[InputMulticastIFace],
		[MultiIPAddress]
		)
	VALUES(
		@HostId,
		@ConfigFileName,
		@InputName,
		@StartMode,
		@ClientIndex,
		@LocalPort,
		CURRENT_TIMESTAMP,
		@LocalIP,
		@LanIPAddress,
		@InputMulticast,
		@InputMulticastIP,
		@InputMulticastIFace,
		@MultiIPAddress
	)
END
GO
/****** Object:  StoredProcedure [dbo].[Role_AddObject]    Script Date: 09/07/2017 14:00:15 ******/
/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
-- needs to be more specific for the new tables involved
-- there is not more "Object" but Brand,Page,PageButton,MenuItem..
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_AddObject]
	@ObjectId	UNIQUEIDENTIFIER,
	@RoleCompanyId UNIQUEIDENTIFIER
AS
BEGIN
	INSERT INTO [dbo].[RoleObjectScope]
		([RoleCompanyId], [ObjectId])
	VALUES(@RoleCompanyId, @ObjectId)
END
GO
/*||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||*/
/****** Object:  StoredProcedure [dbo].[PageButton_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageButton_DeleteById]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @ForGridUse BIT
	DECLARE @Index INT
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=PageId, @ForGridUse=ForGridUse, @Index=[Index] FROM PageButton WHERE Id=@Id
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DELETE [dbo].[PageButton] WHERE [Id]=@Id
				UPDATE [dbo].[PageButton] SET [Index]=[Index]-1 WHERE [PageId]=@PageId AND [ForGridUse]=@ForGridUse AND [Index]>@Index
				DELETE [dbo].[PageButtonRoleScope] WHERE [PageButtonId]=@Id
				SELECT 0 AS Successful
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION
					SELECT -2 AS Successful
				END
		END CATCH
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Brand_ReadByUrl]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Brand_ReadByUrl]
	@URL VARCHAR(100)
AS
BEGIN
	DECLARE @BrandId UNIQUEIDENTIFIER
	SELECT @BrandId=[BrandId] FROM [dbo].[BrandUrl]	WHERE [Url]=@Url
	IF @BrandId IS NOT NULL
		SELECT [Id]
		  , [Name]
		  , [LoginBannerImageId]
		  , [LoginTagImageId]
		  , [PortalImageId]
		  , [FaviconImageId]
		  , [FooterCaption]
		  , [IsDefault]
		  , (SELECT [Url] FROM [dbo].[Images] WHERE [Id]=[dbo].[Brand].[LoginBannerImageId]) AS LoginBannerURL
		  , (SELECT [Url] FROM [dbo].[Images] WHERE [Id]=[dbo].[Brand].[LoginTagImageId]) AS LoginTagURL
		  , (SELECT [Url] FROM [dbo].[Images] WHERE [Id]=[dbo].[Brand].[PortalImageId]) AS PortalImageURL
		  , (SELECT [Url] FROM [dbo].[Images] WHERE [Id]=[dbo].[Brand].[FaviconImageId]) AS FaviconURL
		FROM [dbo].[Brand] WHERE [ID]=@BrandId
	ELSE
		SELECT [Id]
		  , [Name]
		  , [LoginBannerImageId]
		  , [LoginTagImageId]
		  , [PortalImageId]
		  , [FaviconImageId]
		  , [FooterCaption]
		  , [IsDefault]
		  , (SELECT [Url] FROM [dbo].[Images] WHERE [Id]=[dbo].[Brand].[LoginBannerImageId]) AS LoginBannerURL
		  , (SELECT [Url] FROM [dbo].[Images] WHERE [Id]=[dbo].[Brand].[LoginTagImageId]) AS LoginTagURL
		  , (SELECT [Url] FROM [dbo].[Images] WHERE [Id]=[dbo].[Brand].[PortalImageId]) AS PortalImageURL
		  , (SELECT [Url] FROM [dbo].[Images] WHERE [Id]=[dbo].[Brand].[FaviconImageId]) AS FaviconURL
		FROM [dbo].[Brand] WHERE [IsDefault]=1
END
GO
/****** Object:  StoredProcedure [dbo].[Brand_InsertUpdate]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Brand_InsertUpdate]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(100),
	@LoginBannerImageId UNIQUEIDENTIFIER,
	@LoginTagImageId UNIQUEIDENTIFIER,
	@PortalImageId UNIQUEIDENTIFIER,
	@FaviconImageId UNIQUEIDENTIFIER,
	@FooterCaption VARCHAR(100),
	@IsDefault BIT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Brand WHERE Id=@Id)
	BEGIN
		DECLARE @SystemAdministratorId UNIQUEIDENTIFIER = (SELECT [Id] FROM RoleCompany	WHERE [Name] = '212B9E56-6AD4-4612-B294-309E000DC4F6')
		BEGIN TRY
			BEGIN TRANSACTION
				INSERT INTO [dbo].[Brand](
					[Id],
					[Name],
					[LoginBannerImageId],
					[LoginTagImageId],
					[PortalImageId[, 
					[FaviconImageId],
					[FooterCaption],
					[IsDefault])
				VALUES(
					@Id,
					@Name,
					@LoginBannerImageId,
					@LoginTagImageId,
					@PortalImageId,
					@FaviconImageId,
					@FooterCaption,
					@IsDefault)
					
				INSERT INTO [dbo].[BrandRoleScope](
					[BrandId],
					[RoleCompanyId])
				VALUES(
					@Id,
					@SystemAdministratorId)
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION
					SELECT -2 AS Successful
				END
		END CATCH
	END
	ELSE
		UPDATE [dbo].[Brand]
		SET [Name]=@Name
		  ,[LoginBannerImageId]=@LoginBannerImageId
		  ,[LoginTagImageId]=@LoginTagImageId
		  ,[PortalImageId]=@PortalImageId
		  ,[FaviconImageId]=@FaviconImageId
		  ,[FooterCaption]=@FooterCaption
		  ,[IsDefault]=@IsDefault
		WHERE [Id]=@Id

	IF @IsDefault=1
		UPDATE [dbo].[Brand] SET [IsDefault]=0 WHERE [Id]<>@Id
END
GO
/****** Object:  StoredProcedure [dbo].[BrandUrl_Update]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BrandUrl_Update]
	@Id UNIQUEIDENTIFIER,
	@Url VARCHAR(100)
AS
BEGIN
	UPDATE BrandUrl SET [Url]=@Url WHERE Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[BrandUrl_Insert]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BrandUrl_Insert]
	@BrandId UNIQUEIDENTIFIER,
	@Url VARCHAR(100)
AS
BEGIN
	INSERT INTO BrandUrl
		([BrandId],[Url])
	VALUES(@BrandId, @Url)
END
GO
/****** Object:  StoredProcedure [dbo].[Company_InsertUpdate]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Company_InsertUpdate]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@AddressId UNIQUEIDENTIFIER,
	@Website VARCHAR(100),
	@IsMaster BIT,
	@Contact VARCHAR(50),
	@Email VARCHAR(100),
	@AccountingEmail VARCHAR(100),
	@AccountingNotifications BIT,
	@EventEmail VARCHAR(100),
	@EventNotifications BIT,
	@Enabled BIT
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[Company]	WHERE [Id]=@Id)
		UPDATE [dbo].[Company] SET 
			[Name]=@Name,
			[AddressId]=@AddressId,
			[Website]=@Website,
			[IsMaster]=@IsMaster,
			[Contact]=@Contact,
			[Email]=@Email,
			[AccountingEmail]=@AccountingEmail,
			[AccountingNotifications]=@AccountingNotifications,
			[EventEmail]=@EventEmail,
			[EventNotifications]=@EventNotifications,
			[Enabled]=@Enabled
		WHERE [Id]=@Id
	ELSE
		BEGIN
			DECLARE @SystemAdministrator VARCHAR(50) = 'System Administrators'
			DECLARE @Everyone VARCHAR(50) = 'Everyone'
			DECLARE @SystemAdministratorRoleId UNIQUEIDENTIFIER = (SELECT [Id] FROM [RoleType] WHERE [Name] = @SystemAdministrator)
			DECLARE @EveryoneId UNIQUEIDENTIFIER = (SELECT [Id] FROM [RoleType]	WHERE [Name] = @Everyone)
			BEGIN TRY
				BEGIN TRANSACTION
					INSERT INTO [dbo].[Company](
						[Id],
						[Name],
						[AddressId],
						[Website],
						[IsMaster],
						[Contact],
						[Email],
						[AccountingEmail],
						[AccountingNotifications],
						[EventEmail],
						[EventNotifications],
						[Enabled])
					VALUES(
						@Id,
						@Name,
						@AddressId,
						@Website,
						@IsMaster,
						@Contact,
						@Email,
						@AccountingEmail,
						@AccountingNotifications,
						@EventEmail,
						@EventNotifications,
						@Enabled)
														
					INSERT INTO [dbo].[RoleCompany](
						[Id],
						[Name],
						[CompanyId],
						[RoleTypeId])
					VALUES(
						NEWID(),
						@SystemAdministrator,
						@Id,
						@SystemAdministratorRoleId)
								
					DECLARE @RoleCompanyId UNIQUEIDENTIFIER = NEWID()
					INSERT INTO [dbo].[RoleCompany](
						[Id],
						[Name],
						[CompanyId],
						[RoleTypeId])
					VALUES(
						@RoleCompanyId,
						@Everyone,
						@Id,
						@EveryoneId)
							
					INSERT INTO [dbo].[MenuItemRoleScope](
						[MenuItemId],
						[RoleCompanyId])
					SELECT
						[Id] AS MenuItemId,
						@RoleCompanyId AS RoleCompanyId
					FROM [dbo].[MenuItem] WHERE [ParentId] IS NULL

					SELECT 0 AS Successful
				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
					BEGIN
						ROLLBACK TRANSACTION
						SELECT -2 AS Successful
					END
			END CATCH
		END
		IF @IsMaster=1
			UPDATE [dbo].[Company] SET [IsMaster]=0 WHERE [Id]<>@Id
END
GO
/****** Object:  StoredProcedure [dbo].[BrandUrl_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BrandUrl_DeleteById]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	DELETE [dbo].[BrandUrl] WHERE [Id]=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[Brand_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Brand_DeleteById]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[Brand] WHERE [Id]=@Id AND [IsDefault]=1)
		SELECT 1 AS Success
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DELETE [dbo].[BrandUrl] WHERE [BrandId]=@Id
				DELETE [dbo].[BrandRoleScope] WHERE [BrandId]=@Id
				DELETE [dbo].[Brand] WHERE [Id]=@Id
				SELECT 0 AS Success
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
			ROLLBACK TRANSACTION
			SELECT -2 AS Successful
		END
		END CATCH
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Button_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Button_DeleteById]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	If EXISTS(SELECT * FROM [dbo].[PageButton] WHERE [ButtonId]=@Id)
		SELECT 1 AS Successful
	ELSE If EXISTS(SELECT *	FROM [dbo].[Button]	WHERE [Id]=@Id AND [IsHome]=1)
			SELECT 2 AS Successful
		ELSE
			BEGIN
				DELETE [dbo].[Button] WHERE [Id]=@Id
				SELECT 0 AS Successful
			END
END
GO
/****** Object:  StoredProcedure [dbo].[OutputStream_ReadEncoderByHostIdDestinationPort]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OutputStream_ReadEncoderByHostIdDestinationPort]
	@HostId UNIQUEIDENTIFIER,
	@DestinationPort INT
AS
BEGIN
	SELECT [Id]
		  ,[HostId]
		  ,[ConfigFileName]
		  ,[StreamName]
		  ,[StreamEnabled]
		  ,[Outputformat]
		  ,[VBitRate]
		  ,[VideoTranscodeMethod]
		  ,[VideoOutputFormat]
		  ,[GopSize]
		  ,[ScalingMode]
		  ,[FrameRateMode]
		  ,[Deinterlace]
		  ,[TsRateControl]
		  ,[TsBitRateMin]
		  ,[TsBitRateMax]
		  ,[AudioTranscodingType]
		  ,[ABitRate]
		  ,[ARate]
		  ,[AudioChannels]
		  ,[AProfile]
		  ,[DestinationIP]
		  ,[DestinationPort]
		  ,[ModifiedOn]
		  ,[OutputProto]
		  ,[OutputMulticast]
		  ,[OutputMulticastIFace]
		  ,[Deleted]
	FROM [dbo].[OutputStream] 
	WHERE 
		[HostId]=@HostId
		AND(LEFT([ConfigFileName], LEN('decklink_stream')) ='decklink_stream' OR 
			LEFT([ConfigFileName], LEN('aja_stream'))='aja_stream' OR 
			LEFT([ConfigFileName], LEN('asi_stream'))='asi_stream')
		AND CHARIndex('-config-', [ConfigFileName])>0
		AND [DestinationPort]=@DestinationPort
END
GO
/****** Object:  StoredProcedure [dbo].[OutputStream_InsertUpdate_HostId_ConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OutputStream_InsertUpdate_HostId_ConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100),
	@StreamName VARCHAR(40),
	@StreamEnabled BIT,
	@Outputformat VARCHAR(32),
	@VBitRate VARCHAR(16),
	@VideoTranscodeMethod VARCHAR(32),
	@VideoOutputFormat VARCHAR(32),
	@GopSize INT,
	@ScalingMode VARCHAR(32),
	@FrameRateMode VARCHAR(32),
	@Deinterlace VARCHAR(8),
	@TsRateControl VARCHAR(8),
	@TsBitRateMin VARCHAR(16),
	@TsBitRateMax VARCHAR(16),
	@AudioTranscodingType VARCHAR(32),
	@ABitRate VARCHAR(16),
	@ARate VARCHAR(16),
	@AudioChannels VARCHAR(16),
	@AProfile VARCHAR(32),
	@DestinationIP VARCHAR(16),
	@DestinationPort INT,
	@OutputProto VARCHAR(40),
	@OutputMulticast BIT,
	@OutputMulticastIFace VARCHAR(16)
AS
BEGIN
	IF EXISTS(SELECT [Id] FROM OutputStream	WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName)
		UPDATE [dbo].[OutputStream] SET
			[StreamName]=@StreamName,
			[StreamEnabled]=@StreamEnabled,
			[Outputformat]=@Outputformat,
			[VBitRate]=@VBitRate,
			[VideoTranscodeMethod]=@VideoTranscodeMethod,
			[VideoOutputFormat]=@VideoOutputFormat,
			[GopSize]=@GopSize,
			[ScalingMode]=@ScalingMode,
			[FrameRateMode]=@FrameRateMode,
			[Deinterlace]=@Deinterlace,
			[TsRateControl]=@TsRateControl,
			[TsBitRateMin]=@TsBitRateMin,
			[TsBitRateMax]=@TsBitRateMax,
			[AudioTranscodingType]=@AudioTranscodingType,
			[ABitRate]=@ABitRate,
			[ARate]=@ARate,
			[AudioChannels]=@AudioChannels,
			[AProfile]=@AProfile,
			[DestinationIP]=@DestinationIP,
			[DestinationPort]=@DestinationPort,
			[ModifiedOn]=CURRENT_TIMESTAMP,
			[OutputProto]=@OutputProto,
			[OutputMulticast]=@OutputMulticast,
			[OutputMulticastIFace]=@OutputMulticastIFace,
			[Deleted]=0
		WHERE [HostId]=@HostId AND [ConfigFileName]=@ConfigFileName
	ELSE
		INSERT INTO [dbo].[OutputStream](
			[HostId],
			[ConfigFileName],
			[StreamName],
			[StreamEnabled],
			[Outputformat],
			[VBitRate],
			[VideoTranscodeMethod],
			[VideoOutputFormat],
			[GopSize],
			[ScalingMode],
			[FrameRateMode],
			[Deinterlace],
			[TsRateControl],
			[TsBitRateMin],
			[TsBitRateMax],
			[AudioTranscodingType],
			[ABitRate],
			[ARate],
			[AudioChannels],
			[AProfile],
			[DestinationIP],
			[DestinationPort],
			[ModifiedOn],
			[OutputProto],
			[OutputMulticast],
			[OutputMulticastIFace])
		VALUES(
			@HostId,
			@ConfigFileName,
			@StreamName,
			@StreamEnabled,
			@Outputformat,
			@VBitRate,
			@VideoTranscodeMethod,
			@VideoOutputFormat,
			@GopSize,
			@ScalingMode,
			@FrameRateMode,
			@Deinterlace,
			@TsRateControl,
			@TsBitRateMin,
			@TsBitRateMax,
			@AudioTranscodingType,
			@ABitRate,
			@ARate,
			@AudioChannels,
			@AProfile,
			@DestinationIP,
			@DestinationPort,
			CURRENT_TIMESTAMP,
			@OutputProto,
			@OutputMulticast,
			@OutputMulticastIFace)
END
GO
/****** Object:  StoredProcedure [dbo].[OutputStream_GetListByHostIdPLEConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OutputStream_GetListByHostIdPLEConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100)
AS
BEGIN
	SELECT [Id]
      , [HostId]
      , [ConfigFileName]
      , [StreamName]
      , [StreamEnabled]
      , [Outputformat]
      , [VBitRate]
      , [VideoTranscodeMethod]
      , [VideoOutputFormat]
      , [GopSize]
      , [ScalingMode]
      , [FrameRateMode]
      , [Deinterlace]
      , [TsRateControl]
      , [TsBitRateMin]
      , [TsBitRateMax]
      , [AudioTranscodingType]
      , [ABitRate]
      , [ARate]
      , [AudioChannels]
      , [AProfile]
      , [DestinationIP]
      , [DestinationPort]
      , [ModifiedOn]
      , [OutputProto]
      , [OutputMulticast]
      , [OutputMulticastIFace]
	FROM [OutputStream]
	WHERE [HostId]=@HostId 
		AND [ConfigFileName] LIKE @ConfigFileName + '-%'
		AND ([Outputformat] LIKE 'hdsdi%' OR [Outputformat] LIKE 'asi%')
		AND [Deleted]=0
	ORDER BY [dbo].[ConfigFileName]
END
GO
/****** Object:  StoredProcedure [dbo].[InputStream_ReadDecoderByHostIdLocalPort]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InputStream_ReadDecoderByHostIdLocalPort]
	@HostId UNIQUEIDENTIFIER,
	@LocalPort INT
AS
BEGIN
	SELECT [Id]
		  , [HostId]
		  , [ConfigFileName]
		  , [InputName]
		  , [SdiAspectRatio]
		  , [SdiVideoMode]
		  , [SdiAudioConf]
		  , [ARate]
		  , [AudioChannels]
		  , [ModifiedOn]
		  , [LocalIP]
		  , [LocalPort]
		  , [InputMulticast]
		  , [InputMulticastIP]
		  , [InputMulticastIFace]
		  , [Deleted]
	FROM [InputStream]
	WHERE [HostId]=@HostId
		AND LEFT([ConfigFileName], LEN('net_stream'))='net_stream' AND RIGHT([ConfigFileName], LEN('-config'))='-config'
		AND [LocalPort]=@LocalPort
		AND EXISTS( SELECT * FROM [dbo].[OutputStream] 
					WHERE [HostId]=@HostId
						AND [ConfigFileName] LIKE [InputStream].[ConfigFileName]+'-%'
						AND (LEFT([Outputformat], LEN('hdsdi'))='hdsdi' 
							 AND (RIGHT([Outputformat], LEN('sdi'))='sdi' OR RIGHT([Outputformat], LEN('aja'))='aja') 
							 OR LEFT([Outputformat], LEN('asi'))='asi' 
							 AND RIGHT([Outputformat], LEN('ts'))='ts')
			)
END
GO
/****** Object:  StoredProcedure [dbo].[InputStream_InsertUpdate_HostId_ConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InputStream_InsertUpdate_HostId_ConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100),
	@InputName VARCHAR(32),
	@SdiAspectRatio VARCHAR(16),
	@SdiVideoMode VARCHAR(24),
	@SdiAudioConf VARCHAR(24),
	@ARate VARCHAR(24),
	@AudioChannels INT,
	@LocalIP VARCHAR(32),
	@LocalPort INT,
	@InputMulticast BIT,
	@InputMulticastIP VARCHAR(16),
	@InputMulticastIFace VARCHAR(16)
AS
BEGIN
	IF EXISTS(SELECT Id FROM InputStream WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName)
	UPDATE [dbo].[InputStream] SET
		[InputName]=@InputName,
		[SdiAspectRatio]=@SdiAspectRatio,
		[SdiVideoMode]=@SdiVideoMode,
		[SdiAudioConf]=@SdiAudioConf,
		[ARate]=@ARate,
		[AudioChannels]=@AudioChannels,
		[ModifiedOn]=CURRENT_TIMESTAMP,
		[LocalIP]=@LocalIP,
		[LocalPort]=@LocalPort,
		[InputMulticast]=@InputMulticast,
		[InputMulticastIP]=@InputMulticastIP,
		[InputMulticastIFace]=@InputMulticastIFace,
		[Deleted]=0
	WHERE [HostId]=@HostId AND [ConfigFileName]=@ConfigFileName
ELSE
	INSERT INTO [dbo].[InputStream](
		[HostId],
		[ConfigFileName],
		[InputName],
		[SdiAspectRatio],
		[SdiVideoMode],
		[SdiAudioConf],
		[ARate],
		[AudioChannels],
		[ModifiedOn],
		[LocalIP],
		[LocalPort],
		[InputMulticast],
		[InputMulticastIP],
		[InputMulticastIFace])
	VALUES(
		@HostId,
		@ConfigFileName,
		@InputName,
		@SdiAspectRatio,
		@SdiVideoMode,
		@SdiAudioConf,
		@ARate,
		@AudioChannels,
		CURRENT_TIMESTAMP,
		@LocalIP,
		@LocalPort,
		@InputMulticast,
		@InputMulticastIP,
		@InputMulticastIFace)
END
GO
/****** Object:  StoredProcedure [dbo].[MenuItems_MoveUp]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MenuItems_MoveUp]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @PrevId UNIQUEIDENTIFIER
			DECLARE @PrevIndex INT
			DECLARE @MaxIndex INT
			SELECT @MaxIndex = Max([Index])	FROM [dbo].[MenuItem] WHERE ParentId=(SELECT ParentId FROM [dbo].[MenuItem]	WHERE Id=@Id)
			SELECT 
				@PrevId=Id, 
				@PrevIndex=[Index] 
			FROM [dbo].[MenuItem]	
			WHERE [ParentId]=(SELECT [ParentId] FROM [dbo].[MenuItem] WHERE Id=@Id) 
				AND [Index]=(SELECT [Index]-1 FROM [dbo].[MenuItem]	WHERE Id=@Id)
				
			UPDATE [dbo].[MenuItem] SET	[Index] = @MaxIndex + 1	WHERE [Id]=@Id
			UPDATE [dbo].[MenuItem]	SET [Index] = [Index] + 1	WHERE [Id]=@PrevId
			UPDATE [dbo].[MenuItem]	SET [Index] = @PrevIndex	WHERE [Id]=@Id
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT -2 AS Successful
		END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[MenuItems_MoveDown]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MenuItems_MoveDown]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @NextId UNIQUEIDENTIFIER
			DECLARE @NextIndex INT
			DECLARE @MaxIndex INT
			SELECT @MaxIndex = Max([Index]) FROM [dbo].[MenuItem] WHERE [ParentId]=(SELECT [ParentId] FROM [dbo].[MenuItem] WHERE Id=@Id)
			
			SELECT 
				@NextId=Id, 
				@NextIndex=[Index] 
			FROM [dbo].[MenuItem] 
			WHERE ParentId=(SELECT [ParentId] FROM [dbo].[MenuItem] WHERE Id=@Id) 
				AND [Index]=(SELECT [Index]+1 FROM [dbo].[MenuItem] WHERE Id=@Id)
				
			UPDATE [dbo].[MenuItem] SET [Index] = @MaxIndex + 1 WHERE Id=@Id
			UPDATE [dbo].[MenuItem] SET [Index] = [Index] - 1 	WHERE Id=@NextId
			UPDATE [dbo].[MenuItem]	SET [Index] = @NextIndex 	WHERE Id=@Id
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT -2 AS Successful
		END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[MenuItems_InsertUpdate]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MenuItems_InsertUpdate]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@ParentId UNIQUEIDENTIFIER,
	@Title VARCHAR(50),
	@ToolTip VARCHAR(100),
	@ImageId UNIQUEIDENTIFIER,
	@PageId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @RootId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[MenuItem] WHERE [Name] = 'Root')
	IF @ParentId IS NOT NULL AND @ParentId NOT IN (SELECT [Id] FROM [dbo].[MenuItem] WHERE ParentId IS NULL OR ParentId=@RootId)
		SELECT 2 AS Successful	-- Invalid ParentId
	ELSE IF @ImageId IS NOT NULL AND @ImageId NOT IN (SELECT [Id] FROM Image)
			SELECT 3 AS Successful	-- Invalid ImageId
		ELSE IF @PageId IS NOT NULL AND @PageId NOT IN (SELECT [Id] FROM Page)
				SELECT 4 AS Successful	-- Invalid PageId
			ELSE IF EXISTS(SELECT *	FROM [dbo].[MenuItem] WHERE [Id]<>@Id AND [Name]=@Name)
					SELECT 5 AS Successful	-- Duplicated Name
				ELSE IF EXISTS(SELECT *	FROM [dbo].[MenuItem] WHERE [Id]=@Id)
						BEGIN
							UPDATE [dbo].[MenuItem] SET
								[Name] = @Name,
								[ParentId] = @ParentId,
								[Title] = @Title,
								[ToolTip] = @ToolTip,
								[ImageId] = @ImageId,
								[PageId] = @PageId
							WHERE [Id]=@Id
							SELECT 1 AS Successful
						-- Update successful
						END
					ELSE
						BEGIN
							DECLARE @SystemAdministratorId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[RoleCompany]	WHERE [Name] = 'System Administrators')
							BEGIN TRY
								BEGIN TRANSACTION
									DECLARE @Index INT
									SELECT @Index=MAX([Index])+1 FROM [dbo].[MenuItem] WHERE [ParentId] IS NULL AND @ParentId IS NULL OR [ParentId]=@ParentId
									IF @Index IS NULL
										SET @Index=0
										INSERT [dbo].[MenuItem](
											[Id], 
											[Name],
											[ParentId],
											[Title], 
											[Index],
											[ToolTip],
											[ImageId],
											[PageId])
										VALUES(
											@Id, 
											@Name,
											@ParentId,
											@Title,
											@Index,
											@ToolTip,
											@ImageId,
											@PageId)
											
										INSERT INTO [dbo].[MenuItemRoleScope](
											[MenuItemId], 
											[RoleCompanyId])
										VALUES(
											@Id, 
											@SystemAdministratorId)
										SELECT 0 AS Successful	-- Insert successful
								COMMIT TRANSACTION
							END TRY
							BEGIN CATCH
								IF @@TRANCOUNT > 0
								BEGIN
									ROLLBACK TRANSACTION
									SELECT -2 AS Successful
							END
							END CATCH
						END
END
GO
/****** Object:  StoredProcedure [dbo].[MenuItems_GetParentList]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MenuItems_GetParentList]
AS
BEGIN
	DECLARE @RootMenuItemId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[MenuItem] WHERE [Name] = 'Root')
	SELECT [Id]
		, [Name]
		, [ParentId]
		, [Title]
		, [Index]
		, [ToolTip]
		, [ImageId]
		, [PageId]
	FROM [dbo].[MenuItem]
	WHERE [ParentId] IS NULL OR [ParentId]=@RootMenuItemId
	ORDER BY [ParentId], [Index]
END
GO
/****** Object:  StoredProcedure [dbo].[MenuItems_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MenuItems_DeleteById]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[MenuItem] WHERE ParentId=@Id)
		SELECT 1 AS Successful
	ELSE
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION
					DECLARE @ParentId UNIQUEIDENTIFIER
					DECLARE @Index INT
					
					SELECT 
						@ParentId=ParentId, 
						@Index=[Index]
					FROM [dbo].[MenuItem] WHERE [Id]=@Id
					
					DELETE [dbo].[MenuItem] WHERE Id=@Id
					UPDATE [dbo].[MenuItem] SET 
						[Index]=[Index]-1 
					WHERE ([ParentId] IS NULL AND @ParentId IS NULL OR [ParentId]=@ParentId) 
						AND [Index]>@Index
					DELETE [dbo].[MenuItemRoleScope] WHERE [MenuItemId]=@Id
					SELECT 0 AS Successful
				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION
					SELECT -2 AS Successful
				END
			END CATCH
		END
END
GO
/****** Object:  StoredProcedure [dbo].[Image_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Image_DeleteById]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT [ImageId] FROM [dbo].[Button] WHERE [ImageId]=@Id)
		SELECT 1 AS Successful
	ELSE IF EXISTS(SELECT [ImageId] FROM [dbo].[Page] WHERE [ImageId]=@Id)
			SELECT 2 AS Successful
		ELSE IF EXISTS(SELECT [ImageId] FROM [dbo].[MenuItem] WHERE [ImageId]=@Id)
				SELECT 3 AS Successful
			ELSE
				BEGIN
					DELETE [dbo].[Images] WHERE [Id]=@Id
					SELECT 0 AS Successful
				END
END
GO
/****** Object:  StoredProcedure [dbo].[PLEServerStream_InsertUpdate_HostId_ConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLEServerStream_InsertUpdate_HostId_ConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100),
	@StreamName VARCHAR(40),
	@PLEServerIndex VARCHAR(8),
	@StreamEnabled BIT,
	@DestinationIP VARCHAR(16),
	@DestinationPort INT,
	@OutputMulticast BIT,
	@OutputMulticastIP VARCHAR(16),
	@OutputMulticastIFace VARCHAR(16),
	@MultiIPAddress VARCHAR(16)
AS
BEGIN
	IF EXISTS(SELECT [Id] FROM [dbo].[PLEServerStream] WHERE [HostId]=@HostId AND [ConfigFileName]=@ConfigFileName)
		UPDATE [dbo].[PLEServerStream] SET
			[StreamName]=@StreamName,
			[PLEServerIndex]=@PLEServerIndex,
			[StreamEnabled]=@StreamEnabled,
			[DestinationIP]=@DestinationIP,
			[DestinationPort]=@DestinationPort,
			[ModifiedOn]=CURRENT_TIMESTAMP,
			[OutputMulticast]=@OutputMulticast,
			[OutputMulticastIP]=@OutputMulticastIP,
			[OutputMulticastIFace]=@OutputMulticastIFace,
			[MultiIPAddress]=@MultiIPAddress,
			[Deleted]=0
		WHERE [HostId]=@HostId AND [ConfigFileName]=@ConfigFileName
	ELSE
		INSERT INTO [dbo].[PLEServerStream](
			[HostId],
			[ConfigFileName],
			[StreamName],
			[PLEServerIndex],
			[StreamEnabled],
			[DestinationIP],
			[DestinationPort],
			[ModifiedOn],
			[OutputMulticast],
			[OutputMulticastIP],
			[OutputMulticastIFace],
			[MultiIPAddress])
		VALUES(
			@HostId,
			@ConfigFileName,
			@StreamName,
			@PLEServerIndex,
			@StreamEnabled,
			@DestinationIP,
			@DestinationPort,
			CURRENT_TIMESTAMP,
			@OutputMulticast,
			@OutputMulticastIP,
			@OutputMulticastIFace,
			@MultiIPAddress)
END
GO
/****** Object:  StoredProcedure [dbo].[PLEServerStream_GetListByHostIdPLEConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLEServerStream_GetListByHostIdPLEConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100)
AS
BEGIN
	SELECT [Id]
		  , [HostId]
		  , [ConfigFileName]
		  , [StreamName]
		  , [PLEServerIndex]
		  , [StreamEnabled]
		  , [DestinationIP]
		  , [DestinationPort]
		  , [ModifiedOn]
		  , [OutputMulticast]
		  , [OutputMulticastIP]
		  , [OutputMulticastIFace]
		  , [MultiIPAddress]
	FROM [PLEServerStream]
	WHERE [HostId]=@HostId AND [ConfigFileName] LIKE REPLACE(@ConfigFileName, '-config', '') + '_stream_%' AND [Deleted]=0
	ORDER BY [ConfigFileName]
END
GO
/****** Object:  StoredProcedure [dbo].[PageButton_Update]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageButton_Update]
	@Id UNIQUEIDENTIFIER,
	@PageId UNIQUEIDENTIFIER,
	@ButtonId UNIQUEIDENTIFIER,
	@ToolTip VARCHAR(50),
	@RedirectPageId UNIQUEIDENTIFIER=NULL,
	@ForGridUse BIT=0
AS
BEGIN
	IF @PageId IS NULL OR @PageId NOT IN (SELECT [Id] FROM [dbo].[Page])
		SELECT 1 AS Successful
	ELSE IF @ButtonId IS NULL OR @ButtonId NOT IN (SELECT [Id] FROM [dbo].[Button])
			SELECT 2 AS Successful
		ELSE
			BEGIN
				UPDATE [dbo].[PageButton] SET 
					[PageId]=@PageId, 
					[ButtonId]=@ButtonId, 
					[ToolTip]=@ToolTip, 
					[RedirectPageId]=@RedirectPageId 
				WHERE [Id]=@Id
				SELECT 0 AS Successful
			END
END
GO
/****** Object:  StoredProcedure [dbo].[PageButton_MoveUpDown]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageButton_MoveUpDown]
	@Id UNIQUEIDENTIFIER,
	@Up BIT
AS
BEGIN
	DECLARE @ForGridUse BIT
	DECLARE @Index INT
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT 
		@PageId=PageId, 
		@Index=[Index]
	FROM [dbo].[PageButton]	WHERE [Id]=@Id
	DECLARE @MaxIndexPlusOne INT = (SELECT MAX([Index]) + 1 FROM [dbo].[PageButton] WHERE [PageId]=@PageId)
	IF @Up=1 -- up
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION
					DECLARE @PrevId UNIQUEIDENTIFIER=(SELECT [Id] 
														FROM [dbo].[PageButton] 
														WHERE [PageId]=@PageId 
															AND [ForGridUse]=@ForGridUse 
															AND [Index]=@Index-1)
					UPDATE [dbo].[PageButton] SET [Index]=@MaxIndexPlusOne WHERE [Id]=@Id
					UPDATE [dbo].[PageButton] SET [Index]=[Index]+1 WHERE [Id]=@PrevId
					UPDATE [dbo].[PageButton] SET [Index]=@Index-1 WHERE [Id]=@Id
					SELECT 0 AS Successful
				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION
					SELECT -2 AS Successful
				END
			END CATCH
		END
	ELSE -- up = 0 => down
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION
					DECLARE @NextId UNIQUEIDENTIFIER
					SELECT @NextId=[Id] FROM [dbo].[PageButton]	WHERE [PageId]=@PageId 
																	AND [ForGridUse]=@ForGridUse 
																	AND [Index]=@Index+1
																	
					UPDATE [dbo].[PageButton] SET [Index]=@MaxIndexPlusOne WHERE [Id]=@Id
					UPDATE [dbo].[PageButton] SET [Index]=[Index]-1 WHERE [Id]=@NextId
					UPDATE [dbo].[PageButton] SET [Index]=@Index+1 WHERE [Id]=@Id
					SELECT 0 AS Successful
				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION
					SELECT -2 AS Successful
				END
			END CATCH
		END
END
GO
/****** Object:  StoredProcedure [dbo].[PageButton_Insert]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageButton_Insert]
	@PageId UNIQUEIDENTIFIER,
	@ButtonId UNIQUEIDENTIFIER,
	@ToolTip VARCHAR(50),
	@RedirectPageId UNIQUEIDENTIFIER = NULL
AS
BEGIN
	IF @PageId IS NULL OR @PageId NOT IN (SELECT [Id] FROM [dbo].[Page])
		SELECT 1 AS Successful
	ELSE IF @ButtonId IS NULL OR @ButtonId NOT IN (SELECT [Id] FROM [dbo].[Button])
			SELECT 2 AS SUCCESSFUL
		ELSE
			BEGIN
				BEGIN TRY
					BEGIN TRANSACTION
						DECLARE @Id UNIQUEIDENTIFIER = NEWID()
						
						DECLARE @SystemAdministratorRoleId UNIQUEIDENTIFIER = (SELECT [Id] FROM [RoleType] WHERE [Name] = 'System Administrators')
						DECLARE @Index INT=(SELECT MAX([Index])+1 FROM [dbo].[PageButton] WHERE [PageId]=@PageId)
						IF @Index IS NULL
							SET @Index=0
							INSERT INTO [dbo].[PageButton](
								[Id],
								[PageId],
								[ButtonId],
								[Index],
								[ToolTip],
								[RedirectPageId])
							VALUES(
								@Id,
								@PageId,
								@ButtonId,
								@Index,
								@ToolTip,
								@RedirectPageId,
								@ForGridUse)
							IF @ForGridUse=0
								INSERT INTO [dbo].[PageButtonRoleScope](
									[PageButtonId], 
									[RoleCompanyId])
								SELECT 
									@Id AS PageButtonId,
									[Id] AS RoleCompanyId
								FROM [dbo].[RoleCompany]
								WHERE [CompanyId]=(SELECT [Id] FROM [dbo].[Company]	WHERE [IsMaster]=1) AND RoleTypeId=@SystemAdministratorRoleId 
								SELECT 0 AS SUCCESSFUL
					COMMIT TRANSACTION
				END TRY
				BEGIN CATCH
					IF @@TRANCOUNT > 0
						BEGIN
							DECLARE @ErrorMessage NVARCHAR(4000);
							DECLARE @ErrorSeverity INT;
							DECLARE @ErrorState INT;

							SELECT @ErrorMessage = ERROR_MESSAGE(),
								@ErrorSeverity = ERROR_SEVERITY(),
								@ErrorState = ERROR_STATE();

							-- Use RAISERROR inside the CATCH block to return 
							-- error information about the original error that 
							-- caused execution to jump to the CATCH block.
							RAISERROR (@ErrorMessage, -- Message text.
							   @ErrorSeverity, -- Severity.
							   @ErrorState -- State.
							   );
							ROLLBACK TRANSACTION
							SELECT -2 AS SUCCESSFUL
						END
				END CATCH
			END
END
GO
/****** Object:  StoredProcedure [dbo].[Scope_GetListByUserIdGridButtonId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Scope_GetListByUserIdGridButtonId]
	@UserId UNIQUEIDENTIFIER,
	@GridButtonId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageUrl VARCHAR(100) = (SELECT [Url] 
										FROM [dbo].[Page] 
										WHERE [Id]=(SELECT [PageId] 
													FROM [dbo].[GridButton] 
													WHERE [Id]=@GridButtonId))
	SELECT 
		[Id],
		[Name],
		[Value]
	FROM [dbo].[Scope]
	WHERE (((SELECT [Id] FROM [dbo].[Company] WHERE IsMaster=1)=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId))
						OR [Value]<>(SELECT MAX([Value]) FROM [dbo].[Scope]))
			AND ([Value]<>1 OR (@PageUrl='Monitor.aspx') OR (@PageUrl='Scheduling.aspx'))
	ORDER BY [Value]
END
GO
/****** Object:  StoredProcedure [dbo].[Role_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT * FROM [dbo].[RoleCompany]
	WHERE EXISTS(SELECT [Name] FROM [dbo].[Company]
								WHERE [Id]=(SELECT [CompanyId]
											FROM [dbo].[User]
											WHERE [Id]=@UserId) AND [IsMaster]=1)
		OR [CompanyId]=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)
	ORDER BY [CompanyId], [RoleTypeId]
END
GO
/****** Object:  StoredProcedure [dbo].[Role_GetListByObjectIdUserId]    Script Date: 09/07/2017 14:00:15 ******/
-- needs to be fixed |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_GetListByObjectIdUserId]
	@UserId UNIQUEIDENTIFIER,
	@ObjectId UNIQUEIDENTIFIER,
	@In BIT = 1
AS
BEGIN
	DECLARE @SystemAdministratorRoleId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[RoleType] WHERE [Name] = 'System Administrators')
	IF @In=1
		SELECT 
			[Id], 
			[Name],
			[CompanyId], 
			[RoleTypeId]
		FROM [dbo].[RoleCompany]
		WHERE [Id] IN (SELECT [dbo].[RoleCompanyId]	FROM [dbo].[RoleObjectScope] WHERE [ObjectId]=@ObjectId)
				AND ((SELECT [Id] FROM [dbo].[Company] WHERE [IsMaster]=1)
						=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId) 
					OR [CompanyId]=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId))
				AND [Id] NOT IN (SELECT [Id] 
									FROM [dbo].[RoleCompany] 
									WHERE [CompanyId]=(SELECT [Id] 
														FROM [dbo].[Company] 
														WHERE [IsMaster]=1) 
															AND [RoleTypeId]=@SystemAdministratorRoleId
								)
		-- Host System Administrators can't be removed, not showing
		ORDER BY [CompanyId], [RoleTypeId]
	ELSE
		SELECT * FROM [dbo].[RoleCompany]
		WHERE [Id] NOT IN (SELECT [RoleCompanyId]
							FROM [dbo].[RoleObjectScope]
							WHERE ObjectId=@ObjectId)
				AND ((SELECT [Id] FROM [dbo].[Company] WHERE [IsMaster]=1)
						=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId) 
					OR [CompanyId]=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId))
		ORDER BY [CompanyId], [RoleTypeId]
END
GO
-- needs to be fixed |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
/****** Object:  StoredProcedure [dbo].[Company_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Company_DeleteById]
	@Id	UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT [CompanyId] FROM [dbo].[Host] WHERE [CompanyId]=@Id)
		SELECT 1 AS SUCCESSFUL  -- if the company has a devicecaster 
	ELSE IF EXISTS(SELECT [CompanyId] FROM [dbo].[User] WHERE [CompanyId]=@Id)
			SELECT 2 AS SUCCESSFUL -- if any user is in the company
		ELSE IF EXISTS(SELECT [Name] FROM [dbo].[Company] WHERE [Id]=@Id AND [IsMaster]=1)
				SELECT 3 AS SUCCESSFUL -- if the company exists
			ELSE
				BEGIN
					BEGIN TRY
						BEGIN TRANSACTION
							DELETE [dbo].[RoleCompany] WHERE [CompanyId]=@Id
							DELETE [dbo].[Company] WHERE [Id]=@Id
							SELECT 0 AS SUCCESSFUL
						COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						IF @@TRANCOUNT > 0
							BEGIN
								ROLLBACK TRANSACTION	
								SELECT -2 AS SUCCESSFUL
							END
					END CATCH
				END
END
GO
/****** Object:  StoredProcedure [dbo].[Event_GetListByDeviceId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_GetListByDeviceId]
	@DeviceId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @CancelledId INT = (SELECT [Id]	FROM [dbo].[EventStatus] WHERE [Name] = 'Cancelled')
	SELECT [Id]							-- 0
      , [Name]							-- 1
      , [CompanyId]						-- 2
      , [SourceDeviceId]				-- 3
      , [DestinationDeviceId]			-- 4
      , [StartTime]						-- 5
      , [EndTime]						-- 6
      , [CreatorId]						-- 7
      , [CreatedOn]						-- 9
      , [VideoProfileId]				--10
      , [ParentId]						--11
      , [RTT]							--12
      , [PLEClientStreamConfigId]		--13
      , [PLEServerStreamId]				--14
      , [PLEServerConfigId]				--15
      , [InputStreamId]					--16
      , [OutputStreamId]					--17
      , DATEDIFF(SECOND, CURRENT_TIMESTAMP, [StartTime]) AS StartTimeDiffSecond	--18
      , CASE WHEN [EndTime] IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, [EndTime]) END AS EndTimeDiffSecond		--19
      , [SourceAcknowledgement]			--20
      , [DestinationAcknowledgement]		--21
      , [EventStatusId]					--22
      , [VBitRate]							--23
      , [AudioChannels]					--24
      , [OwnerId]							--25
      , [ActualStarted]					--26
      , [ActualEnded]						--27
      , [ClosedCaption]					--28
      , [SerialNumber]					--29
      , [Tx]								--30
      , [Rx]								--31
      , CAST(0 AS BIT) AS AllDay
	FROM [dbo].[Event]
	WHERE ([PLEClientStreamConfigId]=@DeviceId OR [PLEServerConfigId]=@DeviceId)
		--AND ActualEnded IS NULL 
		AND ([EventStatusId]<>@CancelledId)
	ORDER BY [StartTime] DESC, [EndTime] DESC
END
GO
/****** Object:  StoredProcedure [dbo].[Event_UpdateTx]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_UpdateTx]
	@Id UNIQUEIDENTIFIER,
	@Tx INT
AS
BEGIN
	UPDATE [dbo].[Event] SET [Tx] = @Tx
	WHERE [Id] = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[Event_UpdateStatusById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_UpdateEventStatusById]
	@Id UNIQUEIDENTIFIER,
	@StatusId INT
AS
BEGIN
	UPDATE [dbo].[Event]
	SET [EventStatusId] = @EventStatusId
	WHERE [Id] = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[Event_UpdateRx]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_UpdateRx]
	@Id UNIQUEIDENTIFIER,
	@Rx INT
AS
BEGIN
	UPDATE [dbo].[Event]
	SET [Rx] = @Rx
	WHERE [Id] = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[Event_Update]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_Update]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@CompanyId UNIQUEIDENTIFIER,
	@SourceDeviceId UNIQUEIDENTIFIER,
	@DestinationDeviceId UNIQUEIDENTIFIER,
	@StartTime DATETIME,
	@EndTime DATETIME,
	@CreatorId UNIQUEIDENTIFIER,
	@CreatedOn DATETIME,
	@VideoProfileId UNIQUEIDENTIFIER,
	@RTT INT,
	@PLEClientStreamConfigId UNIQUEIDENTIFIER,
	@PLEServerStreamId UNIQUEIDENTIFIER,
	@PLEServerConfigId UNIQUEIDENTIFIER,
	@InputStreamId UNIQUEIDENTIFIER,
	@OutputStreamId UNIQUEIDENTIFIER,
	@SourceAcknowledgement INT,
	@DestinationAcknowledgement INT,
	@EventStatusId INT,
	@VBitRate VARCHAR(16),
	@AudioChannels VARCHAR(16),
	@OwnerId UNIQUEIDENTIFIER,
	@ActualStarted DATETIME,
	@ActualEnded DATETIME,
	@ClosedCaption BIT,
	@Tx INT,
	@Rx INT
AS
BEGIN
	UPDATE [dbo].[Event] SET 
		[Name] = @Name
		,[CompanyId] = @CompanyId
        ,[SourceDeviceId] = @SourceDeviceId
        ,[DestinationDeviceId] = @DestinationDeviceId
        ,[StartTime] = @StartTime
        ,[EndTime] = @EndTime
        ,[CreatorId] = @CreatorId
        ,[CreatedOn] = @CreatedOn
        ,[VideoProfileId] = @VideoProfileId
        ,[RTT] = @RTT
        ,[PLEClientStreamConfigId] = @PLEClientStreamConfigId 
        ,[PLEServerStreamId] = @PLEServerStreamId
        ,[PLEServerConfigId] = @PLEServerConfigId
        ,[InputStreamId] = @InputStreamId
        ,[OutputStreamId] = @OutputStreamId
        ,[SourceAcknowledgement] = @SourceAcknowledgement
        ,[DestinationAcknowledgement] = @DestinationAcknowledgement
        ,[EventStatusId] = @EventStatusId
        ,[VBitRate] = @VBitRate
        ,[AudioChannels] = @AudioChannels
        ,[OwnerId] = @OwnerId
        ,[ActualStarted] = @ActualStarted
        ,[ActualEnded] = @ActualEnded
	WHERE [Id] = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[InputStream_DeleteByHostIdConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InputStream_DeleteByHostIdConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100)
AS
BEGIN
	DECLARE @Id UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[InputStream] WHERE [HostId]=@HostId AND [ConfigFileName]=@ConfigFileName)
	IF @Id IS NOT NULL
	BEGIN
		IF EXISTS(SELECT [Id] FROM [dbo].[Event] WHERE [InputStreamId]=@Id)
			UPDATE [dbo].[InputStream] SET [Deleted]=1 WHERE [Id]=@Id
		ELSE
			DELETE [dbo].[InputStream] WHERE [Id]=@Id
	END
END
GO
/****** Object:  StoredProcedure [dbo].[MenuItems_GetListByUserIdParentId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MenuItems_GetListByUserIdParentId]
	@UserId UNIQUEIDENTIFIER,
	@ParentId UNIQUEIDENTIFIER = NULL
AS
BEGIN
	IF @ParentId IS NULL
		SELECT 
			[Id],
			[Name],
			[ParentId],
			[Title],
			[Index], 
			[ToolTip],
			[ImageId],
			[PageId]
		FROM [dbo].[MenuItem]
		WHERE [Id] IN (SELECT [MenuItemId] 
						FROM [dbo].[MenuItemRoleScope] 
						WHERE [RoleCompanyId] IN(SELECT [RoleCompanyId] FROM [dbo].[UserRole] WHERE UserId=@UserId)) 
					AND ([ParentId] IS NULL)
		ORDER BY [Index]
	ELSE
		SELECT 
			[Id],
			[Name], 
			[ParentId], 
			[Title], 
			[Index], 
			[ToolTip], 
			[ImageId], 
			[PageId]
		FROM [dbo].[MenuItem]
		WHERE [Id] IN(SELECT [MenuItemId]
						FROM [dbo].[MenuItemRoleScope]
						WHERE [RoleCompanyId] IN(SELECT [RoleCompanyId]	
													FROM [dbo].[UserRole]
													WHERE [UserId]=@UserId)) 
												AND ([ParentId]=@ParentId)
		ORDER BY [Index]
END
GO
/****** Object:  StoredProcedure [dbo].[Page_GetListAvailableOnDashboardByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Page_GetListAvailableOnDashboardByUserId]
	@UserId UNIQUEIDENTIFIER='00000000-0000-0000-0000-000000000000'
AS
BEGIN
	SELECT 
		[Id]
		[Name],
        [BrowserTitle],
        [PageTitle],
        [Url],
        [AvailableOnDashboard],
        [ImageId],
        (SELECT [Url] FROM [dbo].[Image] WHERE [Id]=[dbo].[Page].[ImageId]) AS ImageUrl
	FROM [dbo].[Page]
	WHERE [Id] IN(SELECT [PageId] 
					FROM [dbo].[PageRoleScope]
					WHERE [RoleCompanyId] IN(SELECT [RoleCompanyId] FROM [dbo].[UserRole] WHERE [UserId]=@UserId))
						AND [AvailableOnDashboard]=1
						OR [Url]='Dashboard.aspx'
	ORDER BY [Url]
END
GO
/****** Object:  StoredProcedure [dbo].[Page_GetListNotInUserDashboardItemByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Page_GetListNotInUserDashboardItemByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT 
		[Id],
		[Name],
		[BrowserTitle],
		[PageTitle],
		[Url],
		[AvailableOnDashboard],
		[ImageId],
		(SELECT [Url] FROM [dbo].[Image] WHERE [Id]=[dbo].[Page].[ImageId]) AS ImageUrl
	FROM [dbo].[Page]
	WHERE [Id] IN(SELECT [PageId]
					FROM [dbo].[PageRoleScope]
					WHERE [RoleCompanyId] IN(SELECT [RoleCompanyId] FROM [dbo].[UserRole] WHERE [UserId]=@UserId))
			AND [Id] NOT IN (SELECT [PageId] FROM [dbo].[UserDashboardPage]	WHERE [UserId]=@UserId)
			AND [AvailableOnDashboard]=1
	ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[Role_RemoveUser]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_RemoveUser]
	@UserId	UNIQUEIDENTIFIER,
	@RoleCompanyId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @SystemAdministratorRoleId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[RoleType] WHERE [Name] = 'System Administrators')
	IF NOT EXISTS(SELECT * FROM [dbo].[RoleCompany]	WHERE [Id]=@RoleCompanyId AND [RoleTypeId]=@SystemAdministratorRoleId) 
			OR (SELECT COUNT(*)	FROM [dbo].[UserRole] WHERE [RoleCompanyId]=@RoleCompanyId)>1
		DELETE [dbo].[UserRole] WHERE [UserId]=@UserId AND [RoleCompanyId]=@RoleCompanyId
END
GO
/****** Object:  StoredProcedure [dbo].[Role_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_DeleteById]
	@Id	UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			-- delete from every rolescope table
			DELETE [dbo].[BrandRoleScope] WHERE [RoleCompanyId]=@Id
			DELETE [dbo].[MenuItemRoleScope] WHERE [RoleCompanyId]=@Id
			DELETE [dbo].[PageRoleScope] WHERE [RoleCompanyId]=@Id
			DELETE [dbo].[PageButtonRoleScope] WHERE [RoleCompanyId]=@Id
			
			DELETE [dbo].[RolePermissionScopeEntity] WHERE [RoleCompanyId]=@Id
			DELETE [dbo].[UserRole] WHERE [RoleCompanyId]=@Id
			DELETE [dbo].[RoleCompany] WHERE [Id]=@Id
			SELECT 0 AS SUCCESSFUL
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT -2 AS SUCCESSFUL
		END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Role_AddUser]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_AddUser]
	@UserId	UNIQUEIDENTIFIER,
	@RoleCompanyId UNIQUEIDENTIFIER
AS
BEGIN
	INSERT INTO [dbo].[UserRole](
		[UserId], 
		[RoleCompanyId])
	VALUES(
		@UserId, 
		@RoleCompanyId)
END
GO
/****** Object:  StoredProcedure [dbo].[PLEClientStreamConfig_GetListWithHostNameByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLEClientStreamConfig_GetListWithHostNameByUserId]
	@UserId UNIQUEIDENTIFIER,
	@Type INT = 0
-- 0: for create event
-- 1: for grid filter
AS
BEGIN
	SELECT 
		[Id], 
		(SELECT [Name] FROM [dbo].[Host] WHERE [Id]=[dbo].[PLEClientStreamConfig].[HostId])+': '+[InputName] AS Name
	FROM [dbo].[PLEClientStreamConfig]
	WHERE (
		[HostId] IN (SELECT [Id] FROM [dbo].[Host] WHERE [CompanyId] = (SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId))
		OR (SELECT [Id] FROM [dbo].[Company] WHERE [IsMaster]=1) = (SELECT [dbo].[CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)
		OR [Id] IN (SELECT [PLEClientStreamConfigId] FROM [dbo].[Event]	WHERE [CompanyId] = (SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)) AND @Type=1
		OR [Id] IN (SELECT [DeviceId] FROM [dbo].[DeviceSharedToCompany] WHERE [CompanyId] = (SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)) AND @Type=2
	)
		AND [Deleted]=0
	ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[PLEServerConfig_GetListWithHostNameByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PLEServerConfig_GetListWithHostNameByUserId]
	@UserId UNIQUEIDENTIFIER,
	@Type INT = 0
-- 0: for create event
-- 1: for grid filter
-- this will work only if @Type=1????????????????????
AS
BEGIN
	SELECT 
		[Id],
		(SELECT [Name] FROM [dbo].[Host] WHERE [Id]=[dbo].[PLEServerConfig].[HostId])+': '+[InputName] AS Name
	FROM [dbo].[PLEServerConfig]
	WHERE 
		([HostId] IN (SELECT [Id] FROM [dbo].[Host] WHERE [CompanyId] = (SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId))
		OR (SELECT [Id]	FROM [dbo].[Company] WHERE [IsMaster]=1) = (SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)
		OR [Id] IN (SELECT [PLEServerConfigId] FROM [dbo].[Event] WHERE [CompanyId] = (SELECT [CompanyId] FROM [dbo].[User]	WHERE [Id]=@UserId)) AND @Type=1
		OR [Id] IN (SELECT [DeviceId] FROM [dbo].[DeviceSharedToCompany] WHERE [CompanyId] = (SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)) AND @Type=2	)
		AND [Deleted]=0
	ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[User_GetListByRoleId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_GetListByRoleId]
	@RoleCompanyId UNIQUEIDENTIFIER,
	@In BIT = 1
AS
BEGIN
	IF @In=1
		SELECT 
			[Id],
			[Name],
			[Password],
			[PersonId],
			[CompanyId],
			[Registered],
			[PageId],
			[DateFormatId]
		FROM [dbo].[User]
		WHERE Id IN (SELECT [UserId] FROM [dbo].[UserRole] WHERE [RoleCompanyId]=@RoleCompanyId)
			AND [CompanyId]=(SELECT [CompanyId]	FROM [dbo].[RoleCompany] WHERE [Id]=@RoleCompanyId)
		ORDER BY [Name]
	ELSE
		SELECT 
			[Id],
			[Name],
			[Password],
			[PersonId],
			[CompanyId],
			[Registered],
			[PageId],
			[DateFormatId]
		FROM [dbo].[User]
		WHERE [Id] NOT IN (SELECT [UserId] FROM [dbo].[UserRole] WHERE [RoleCompanyId]=@RoleCompanyId)
			AND [CompanyId]=(SELECT [CompanyId] FROM [dbo].[RoleCompany] WHERE [Id]=@RoleCompanyId)
		ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[User_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_DeleteById]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[Event] WHERE [CreatorId]=@Id OR [OwnerId]=@Id)
		SELECT 1 AS Success
	ELSE IF EXISTS(SELECT *	FROM [dbo].[EventHistory] WHERE [UserId]=@Id)
				SELECT 2 AS Success
		ELSE IF EXISTS(SELECT *	FROM [dbo].[HostHistory] WHERE [UserId]=@Id)
					SELECT 3 AS Success
			ELSE
				BEGIN
					BEGIN TRY
						BEGIN TRANSACTION
							DECLARE @PersonId UNIQUEIDENTIFIER = (SELECT [PersonId] FROM [dbo].[User] WHERE [Id]=@Id)
							DELETE [dbo].[UserRole] WHERE [UserId]=@Id
							DELETE [dbo].[UserSetting] WHERE [UserId]=@Id
							DELETE [dbo].[UserDashboardItem] WHERE [UserId]=@Id
							DELETE [dbo].[User] WHERE [Id]=@Id
							DELETE [dbo].[Phone] WHERE [PersonId]=@PersonId
							DELETE [dbo].[Address] WHERE [Id]=(SELECT [AddressId] FROM [dbo].[Person] WHERE [Id]=@PersonId)
							DELETE [dbo].[Person] WHERE [Id]=@PersonId
							SELECT 0 AS Success
						COMMIT TRANSACTION
					END TRY
					BEGIN CATCH
						IF @@TRANCOUNT > 0
							BEGIN
								ROLLBACK TRANSACTION
								SELECT -2 AS SUCCESSFUL
							END
					END CATCH
				END
END
GO
/****** Object:  StoredProcedure [dbo].[Role_GetListNotIncludingEveryoneByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_GetListNotIncludingEveryoneByUserId]
	@UserId UNIQUEIDENTIFIER,
	@In BIT = 1
AS
BEGIN
	DECLARE @EveryoneRoleId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[RoleType] WHERE [Name] = 'Everyone')
	IF @In=1
		SELECT 
			[Id],
			[Name], 
			[CompanyId], 
			[RoleTypeId]
		FROM [dbo].[RoleCompany]
		WHERE Id IN (SELECT [dbo].[RoleCompanyId] FROM [dbo].[UserRole] WHERE [UserId]=@UserId)
			AND [CompanyId]=(SELECT [CompanyId]	FROM [dbo].[User] WHERE [Id]=@UserId)
			AND [RoleTypeId]<>@EveryoneRoleId
		ORDER BY [Name]
	ELSE
		SELECT 
			[Id], 
			[Name], 
			[CompanyId], 
			[RoleTypeId]
		FROM [dbo].[RoleCompany]
		WHERE [Id] NOT IN (SELECT [RoleCompanyId] FROM [dbo].[UserRole]	WHERE [UserId]=@UserId)
			AND [CompanyId]=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)
			AND [RoleTypeId]<>@EveryoneRoleId
		ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[UserPerson_IsertUpdate]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserPerson_InsertUpdate]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@Password VARCHAR(50),
	@CompanyId UNIQUEIDENTIFIER,
	@PageId UNIQUEIDENTIFIER,
	@DateFormatId UNIQUEIDENTIFIER,
	@Enabled BIT = 1,
	@EventNotifications BIT = 0,
	@PersonId UNIQUEIDENTIFIER,
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@MiddleName VARCHAR(50),
	@Prefix VARCHAR(50),
	@Suffix VARCHAR(50),
	@Email VARCHAR(250),
	@AddressId UNIQUEIDENTIFIER = NULL
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM [dbo].[User] WHERE [Id]=@Id)
	BEGIN
		BEGIN TRY
			INSERT INTO [dbo].[Person](
				[Id],
				[FirstName], 
				[LastName], 
				[MiddleName], 
				[Prefix], 
				[Suffix], 
				[Email], 
				[AddressId])
			VALUES(
				@PersonId, 
				@FirstName, 
				@LastName, 
				@MiddleName, 
				@Prefix, 
				@Suffix, 
				@Email, 
				@AddressId)
				
			INSERT INTO [dbo].[User](
				[Id], 
				[Name], 
				[Password], 
				[PersonId], 
				[CompanyId], 
				[Registered], 
				[PageId], 
				[DateFormatId], 
				[Enabled], 
				[EventNotifications])
			VALUES(
				@Id, 
				@Name, 
				@Password, 
				@PersonId, 
				@CompanyId, 
				GETDATE(), 
				@PageId, 
				@DateFormatId, 
				@Enabled, 
				@EventNotifications)
				
			INSERT [dbo].[UserRole](
				[UserId], 
				[RoleCompanyId])
			SELECT 
				@Id AS UserId, 
				[Id] AS RoleCompanyId
			FROM [dbo].[RoleCompany]
			WHERE [CompanyId]=@CompanyId AND [Name]='Everyone'
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
				BEGIN
					ROLLBACK TRANSACTION
					SELECT -2 AS SUCCESSFUL
				END
		END CATCH
	END
	ELSE
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION
					UPDATE [dbo].[User] SET 
						[Name] = @Name,
						[Password] = @Password,
						[PageId] = @PageId,
						[DateFormatId = @DateFormatId,
						[Enabled] = @Enabled,
						[EventNotifications] = @EventNotifications
					WHERE [Id] = @Id
					
					UPDATE [dbo].[Person] SET 
						[FirstName] = @FirstName,
						[LastName] = @LastName,
						[MiddleName] = @MiddleName,
						[Prefix] = @Prefix,
						[Suffix] = @Suffix,
						[Email] = @Email,
						[AddressId] = @AddressId
					WHERE [Id] = @PersonId
				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
				BEGIN
				ROLLBACK TRANSACTION
				SELECT -2 AS SUCCESSFUL
			END
			END CATCH
		END
END
GO
/****** Object:  StoredProcedure [dbo].[UserDashboardItem_UpdateById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserDashboardItem_UpdateById]
	@Id UNIQUEIDENTIFIER,
	@PageId UNIQUEIDENTIFIER
AS
BEGIN
	UPDATE [dbo].[UserDashboardItem] SET [PageId]=@PageId WHERE [Id]=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[UserDashboardItem_MoveUpDownById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserDashboardItem_MoveUpDownById]
	@Id UNIQUEIDENTIFIER,
	@UpDown INT
--0: up; 1: down
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @MaxIndex INT
			DECLARE @Index INT
			DECLARE @UserId UNIQUEIDENTIFIER
			SELECT 
				@UserId=[UserId], 
				@Index=[Index]
			FROM [dbo].[UserDashboardItem] WHERE [Id]=@Id 
			
			SELECT @MaxIndex=MAX([Index]) + 1 FROM [dbo].[UserDashboardItem] WHERE [UserId]=@UserId
			
			UPDATE [dbo].[UserDashboardItem] SET [Index]=@MaxIndex WHERE [Id]=@Id

			IF @UpDown=0 --up
				BEGIN
					UPDATE [dbo].[UserDashboardItem] SET [Index]=@Index FROM [dbo].[UserDashboardItem] WHERE [UserId]=@UserId AND [Index]=@Index-1
					UPDATE [dbo].[UserDashboardItem] SET [Index]=@Index-1 WHERE [Id]=@Id
				END
			ELSE -- down
				BEGIN
					UPDATE [dbo].[UserDashboardItem] SET [Index]=@Index FROM [dbo].[UserDashboardItem] WHERE [UserId]=@UserId AND [Index]=@Index+1
					UPDATE [dbo].[UserDashboardItem] SET [Index]=@Index+1 WHERE [Id]=@Id
				END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT -2 AS SUCCESSFUL
			END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[UserDashboardItem_Insert]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserDashboardItem_Insert]
	@UserId UNIQUEIDENTIFIER,
	@PageId UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT * FROM [dbo].[UserDashboardItem] WHERE [UserId]=@UserId AND [PageId]=@PageId)
		SELECT 1 AS SUCCESSFUL
	ELSE
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION
					DECLARE @Index INT
					IF EXISTS(SELECT * FROM [dbo].[UserDashboardItem] WHERE [UserId]=@UserId)
						SELECT @Index=MAX([Index]) + 1 FROM [dbo].[UserDashboardItem] WHERE [UserId]=@UserId
					ELSE
						SET @Index = 0
						INSERT [dbo].[UserDashboardItem](
							[Id], 
							[UserId], 
							[PageId], 
							[Index])
						VALUES(
							NEWID(),
							@UserId, 
							@PageId, 
							@Index)
						SELECT 0 AS SUCCESSFUL
				COMMIT TRANSACTION
			END TRY
			BEGIN CATCH
				IF @@TRANCOUNT > 0
					BEGIN
						ROLLBACK TRANSACTION
					SELECT -2 AS SUCCESSFUL
				END
			END CATCH
		END
END
GO
/****** Object:  StoredProcedure [dbo].[UserDashboardItem_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserDashboardItem_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT 
		[UserDashboardItem].[Id],
		[UserDashboardItem].[UserId],
		[UserDashboardItem].[PageId],
		[UserDashboardItem].[Index],
		[Page].[ImageId],
		[Page].Url AS NavigateURL,
		[Page].[Name],
		[dbo].[Image].Url AS ImageUrl,
		(SELECT MIN([MinDashboardItem].[Index])	FROM [UserDashboardItem] [MinDashboardItem]	WHERE [MinDashboardItem].[UserId] = [UserDashboardItem].[UserId]) AS MinIndex,
		(SELECT MAX([MinDashboardItem].[Index])	FROM [UserDashboardItem] [MinDashboardItem]	WHERE [MinDashboardItem].UserId = [UserDashboardItem].UserId) AS MaxIndex
	FROM [dbo].[UserDashboardItem]
	LEFT JOIN [dbo].[Page] 
		INNER JOIN [dbo].[Image] 
			ON [dbo].[Image].[Id]=[dbo].[Page].[ImageId] 
		ON [dbo].[Page].[Id] = [dbo].[UserDashboardItem].[PageId]
	WHERE [UserId]=@UserId AND [dbo].[Page].[AvailableOnDashboard]=1
	ORDER BY [UserDashboardItem].[Index]
END
GO
/****** Object:  StoredProcedure [dbo].[UserDashboardItem_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserDashboardItem_DeleteById]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @UserId UNIQUEIDENTIFIER
			DECLARE @Index INT
			SELECT 
				@UserId=[UserId], 
				@Index=[Index]
			FROM [dbo].[UserDashboardItem] WHERE [Id]=@Id
			
			DELETE [dbo].[UserDashboardItem] WHERE [Id]=@Id
			UPDATE [dbo].[UserDashboardItem] SET [Index]=[Index]-1 WHERE [UserId]=@UserId AND [Index]>@Index
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT -2 AS SUCCESSFUL
			END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Scope_ReadByUserIdPageNameButtonName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Scope_ReadByUserIdPageNameButtonName]
	@UserId UNIQUEIDENTIFIER,
	@PageName VARCHAR(50),
	@ButtonName VARCHAR(50)
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]=@PageName)
	DECLARE @GridID UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Grid] WHERE [PageId] = @PageId)
	DECLARE @ButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]=@ButtonName)
	DECLARE @GridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [GridId]=@GridId AND [ButtonId]= @ButtonId)

	SELECT dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridButtonId) AS ButtonScope
END
GO
/****** Object:  StoredProcedure [dbo].[UserPerson_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserPerson_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]='Users.aspx')
	DECLARE @GridID UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Grid] WHERE [PageId] = @PageId)
	DECLARE @EditButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Edit')
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Delete')
	DECLARE @RolesButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Roles')
	
	DECLARE @EditGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [GridId]=@GridId AND [ButtonId]=@EditButtonId) 
	DECLARE @DeleteGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [GridId]=@GridId AND [ButtonId]=@DeleteButtonId) 
	DECLARE @RolesGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [GridId]=@GridId AND [ButtonId]=@RolesButtonId) 

	SELECT 
		[User].[Id],
		[User].[Name] AS UserName,
		[User].[CompanyId],
		[User].[Registered],
		[User].[Enabled],
		[User].[DateFormatId],
		[User].[Enabled],
		[User].[EventNotifications],
		[dbo].[View_Person_FullName_Email].[Name],
		[dbo].[View_Person_FullName_Email].[Email],
		[dbo].[View_Person_FullName_Email].[PhoneCountryId],
		[dbo].[View_Person_FullName_Email].[AreaCode],
		[dbo].[View_Person_FullName_Email].[Number],
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditGridButtonId) AS EditButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @DeleteGridButtonId) AS DeleteButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @RolesGridButtonId) AS RolesButton
	FROM [dbo].[User]
	INNER JOIN [dbo].[View_Person_FullName_Email] 
		ON [View_Person_FullName_Email].[Id]=[dbo].[User].[PersonId]
	WHERE [CompanyId] = (SELECT [CompanyId]	FROM [dbo].[User] WHERE [Id]=@UserId)
		OR (SELECT [Id]	FROM [dbo].[Company] WHERE [IsMaster]=1) = (SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)
	ORDER BY [CompanyId], [UserName], [Registered]
END
GO
/****** Object:  StoredProcedure [dbo].[SConfiguration_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SConfiguration_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	
	DECLARE @SConfigPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]='SystemSettings.aspx')
	DECLARE @EditButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Edit')
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Delete')
	DECLARE @RolesButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Roles')
	
	DECLARE @EditGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [GridId]=@GridId AND [ButtonId]=@EditButtonId) 
	DECLARE @DeleteGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [GridId]=@GridId AND [ButtonId]=@DeleteButtonId) 
	DECLARE @RolesGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [GridId]=@GridId AND [ButtonId]=@RolesButtonId) 

	SELECT 
		[Id],
		[Name],
		[IntValue],
		[StringValue],
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @AddGridButtonId) AS AddButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditGridButtonId) AS EditButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @DeleteGirdButtonId) AS DeleteButton
	FROM [dbo].[Configuration]
	ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[Role_GetListByGridButtonIdUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_GetListByGridButtonIdUserId]
	@UserId UNIQUEIDENTIFIER,
	@GridButtonId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @GridButtonRolesPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]='GridButtonRoles.aspx')
	DECLARE @EditButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Edit')
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Delete')
	DECLARE @RolesButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Roles')
	DECLARE @EditGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@GridButtonRolesPageId AND [ButtonId]=@EditButtonId)
	DECLARE @DeleteGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@GridButtonRolesPageId AND [ButtonId]=@DeleteButtonId) 
	DECLARE @RolesGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@GridButtonRolesPageId AND [ButtonId]=@RolesButtonId) 
	
	SELECT 
		[Id], 
		[Name], 
		[CompanyId], 
		[RoleTypeId],
		CASE WHEN EXISTS(SELECT * 
							FROM [dbo].[GridButtonRoleScope] 
							WHERE [RoleCompanyId]=[dbo].[RoleCompany].[Id]
								AND [dbo].[GridButtonRoleScope].[GridButtonId]=@GridButtonId)
		THEN (SELECT TOP 1 [dbo].[Scope].[Id] 
				FROM [dbo].[Scope] 
				INNER JOIN [dbo].[GridButtonRoleScope] ON [dbo].[GridButtonRoleScope].[ScopeId]=[dbo].[Scope].[Id]
				WHERE [dbo].[GridButtonRoleScope].[RoleCompanyId]=[dbo].[RoleCompany].[Id]
					AND [dbo].[GridButtonRoleScope].[GridButtonId]=@GridButtonId
				ORDER BY [dbo].[Scope].[Value])
		ELSE (SELECT [Id] FROM [dbo].[Scope] WHERE Value=0) END AS ScopeId,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditGridButtonId) AS EditButton
	FROM [dbo].[RoleCompany]
	WHERE (SELECT [Id] FROM [dbo].[Company]	WHERE [IsMaster]=1)
			=(SELECT [CompanyId] FROM [dbo].[User] WHERE Id=@UserId) 
		OR [CompanyId]=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)
	ORDER BY [CompanyId], [RoleTypeId]
END
GO
/****** Object:  StoredProcedure [dbo].[PageButton_GetListByPageIdUserIdPageGrid]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 		9-19-2017
-- Description:			
-- =============================================

CREATE PROCEDURE [dbo].[GridButton_GetListByPageIdUserId]
	@PageId UNIQUEIDENTIFIER,
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	-- the button's page
	DECLARE @ButtonPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]='PageButtons.aspx')
	-- buttons
	DECLARE @AddButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Add')
	DECLARE @EditButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button]	WHERE [Name]='Edit')
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button]	WHERE [Name]='Delete')
	DECLARE @PageButtonRolesButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='PageButtonRoles')
	DECLARE @MoveDownButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Move Down')
	DECLARE @MoveUpButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Move Up')
	DECLARE @NewGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='NewGridButton')
	DECLARE @GridEditButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='GridEdit')
	DECLARE @GridDeleteButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='GridDelete')
	DECLARE @GridButtonRolesButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Grid Button Roles')
	-- grid buttons
	DECLARE @AddGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton]	WHERE [PageId]=@ButonPageId AND [ButtonId]=@AddButtonId)
	DECLARE @EditGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButonPageId AND [ButtonId]=@EditButtonId)
	DECLARE @DeleteGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButonPageId AND [ButtonId]=@DeleteButtonId)
	DECLARE @PageButtonRolesButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButonPageId AND [ButtonId]=@PageButtonRolesButtonId)
	DECLARE @MoveDownGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButonPageId AND [ButtonId]=@MoveDownButtonId)
	DECLARE @MoveUpGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButonPageId AND [ButtonId]=@MoveUpButtonId)
	DECLARE @NewGrigGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButonPageId AND [ButtonId]=@NewGridButtonId)
	DECLARE @GridEditGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButonPageId AND [ButtonId]=@GridEditButtonId)
	DECLARE @GridDeleteGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButonPageId AND [ButtonId]=@GridDeleteButtonId)
	DECLARE @GridButtonRolesGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButonPageId AND [ButtonId]=@GridButtonRolesButtonId)
	

	SELECT
		[Id],
		[PageId],
		[ButtonId],
		[Index], 
		[ToolTip], 
		CASE WHEN (SELECT [IsHome] FROM [dbo].[Button] WHERE [Id]=[dbo].[GridButton].[ButtonId])=1 
			THEN (SELECT [PageId] FROM [dbo].[User]	WHERE [Id]=@UserId) -- if it is home button show user's dashboard
			ELSE RedirectPageId 
		END																						AS RedirectPageId,
		(SELECT MIN([Index]) FROM [dbo].[GridButton] WHERE [PageId]=@PageId)					AS MinIndex, -- forgrid=0?
		(SELECT MAX([Index]) FROM [dbo].[GridButton] WHERE [PageId]=@PageId) 					AS MaxIndex, -- forgrid=0?
		(SELECT [Url] 
			FROM [dbo].[Image] 
			INNER JOIN [dbo].[Button] ON [dbo].[Button].[ImageId]=[dbo].[Image].[Id] 
			WHERE [dbo].[Button].[Id]=[dbo].[PageButton].[ButtonId])							AS ImageUrl,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridAddButtonId) 			AS AddButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridEditButtonId) 			AS EditButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridDeleteButtonId) 		AS DeleteButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridPageButtonRolesButtonId)AS PageButtonRolesButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridMoveDownButtonId) 		AS MoveDownButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridMoveUpButtonId) 		AS MoveUpButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridNewGridButtonId) 		AS NewGridButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridEditButtonId) 			AS GridEditButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridDeleteButtonId) 		AS GridDeleteButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GridButtonRolesButtonId) 	AS GridButtonRolesButton
	FROM [dbo].[GridButton]
	WHERE ([Id] IN (SELECT [GridButtonId] 
						FROM [dbo].[GridButtonRoleScope]
						WHERE [RoleCompanyId] IN (SELECT [dbo].[RoleCompanyId] 
													FROM [UserRole] 
													WHERE [UserId]=@UserId)))  
		AND [PageId]=@PageId
		AND (@PageGrid=2 OR 
			(@PageGrid=0 AND ForGridUse=0) OR 
			(@PageGrid=1 AND ForGridUse=1))
	ORDER BY [ForGridUse], [Index]
END
GO





-- this is the original procedure

/****** Object:  StoredProcedure [dbo].[PageButton_GetListByPageIdUserIdPageGrid]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageButton_GetListByPageIdUserIdPageGrid]
	@PageId UNIQUEIDENTIFIER,
	@UserId UNIQUEIDENTIFIER,
	@PageGrid INT = 2
--2: all; 1:Grid Button only; o: Page Button only
AS
BEGIN
	DECLARE @ButtonPageId uniqueidentifier
	SELECT @ButtonPageId=Id
	FROM Page
	WHERE Url='PageButtons.aspx'
	DECLARE @AddButtonId uniqueidentifier
	DECLARE @EditButtonId uniqueidentifier
	DECLARE @DeleteButtonId uniqueidentifier
	DECLARE @PageButtonRolesButtonId uniqueidentifier
	DECLARE @MoveDownButtonId uniqueidentifier
	DECLARE @MoveUpButtonId uniqueidentifier
	DECLARE @NewGridButtonId uniqueidentifier
	DECLARE @GridEditButtonId uniqueidentifier
	DECLARE @GridDeleteButtonId uniqueidentifier
	DECLARE @GridButtonRolesButtonId uniqueidentifier
	SELECT @AddButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Add') AND ForGridUse=1
	SELECT @EditButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Delete') AND ForGridUse=1
	SELECT @PageButtonRolesButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='PageButtonRoles') AND ForGridUse=1
	SELECT @MoveDownButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Move Down') AND ForGridUse=1
	SELECT @MoveUpButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Move Up') AND ForGridUse=1
	SELECT @NewGridButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='NewGridButton') AND ForGridUse=1
	SELECT @GridEditButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='GridEdit') AND ForGridUse=1
	SELECT @GridDeleteButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='GridDelete') AND ForGridUse=1
	SELECT @GridButtonRolesButtonId=Id
	FROM PageButton
	WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Grid Button Roles') AND ForGridUse=1


	SELECT
		[Id] 
		, [PageId] 
		, [ButtonId]
		, [Index] 
		, [ToolTip] 
		, CASE WHEN (SELECT IsHome
		FROM Button
		WHERE Id=PageButton.ButtonId)=1 THEN (SELECT PageId
		FROM [User]
		WHERE Id=@UserId) ELSE RedirectPageId END AS RedirectPageId
		, [ForGridUse] 
		, (SELECT MIN([Index])
		FROM [PageButton]
		WHERE PageId=@PageId AND ForGridUse=0) AS [MinIndex]
		, (SELECT MAX([Index])
		FROM [PageButton]
		WHERE PageId=@PageId AND ForGridUse=0) AS [MaxIndex]
		, (SELECT [dbo].[Image].Url
		FROM [dbo].[Image] INNER JOIN Button ON Button.ImageId=[dbo].[Image].Id
		WHERE Button.Id=PageButton.ButtonId) AS ImageUrl
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @AddButtonId) AS AddButton
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @PageButtonRolesButtonId) AS PageButtonRolesButton
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @MoveDownButtonId) AS MoveDownButton
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @MoveUpButtonId) AS MoveUpButton
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @NewGridButtonId) AS NewGridButton
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @GridEditButtonId) AS GridEditButton
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @GridDeleteButtonId) AS GridDeleteButton
		, dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @GridButtonRolesButtonId) AS GridButtonRolesButton
	FROM PageButton
	WHERE (Id IN(SELECT ObjectId
		FROM RoleObjectScope
		WHERE RoleId IN(SELECT RoleId
		FROM UserRole
		WHERE UserId=@UserId)) OR ForGridUse=1)
		AND PageId=@PageId
		AND (@PageGrid=2 OR @PageGrid=0 AND ForGridUse=0 OR @PageGrid=1 AND ForGridUse=1)
	ORDER BY ForGridUse, [Index]
END
--***************************************************************************************************************************************************
--***************************************************************************************************************************************************
--***************************************************************************************************************************************************
--***************************************************************************************************************************************************













/****** Object:  StoredProcedure [dbo].[Page_InsertUpdate]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Page_InsertUpdate]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@BrowserTitle VARCHAR(50),
	@PageTitle VARCHAR(50),
	@Url VARCHAR(100),
	@AvailableOnDashboard BIT,
	@ImageId UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT *
	FROM Page
	WHERE Id<>@Id AND Name=@Name)
		SELECT 2 AS SUCCESSFUL
	ELSE IF @ImageId IS NOT NULL AND @ImageId NOT IN (SELECT Id
		FROM [dbo].[Image])
		SELECT 3 AS SUCCESSFUL	-- Invalid ImageId
	ELSE
	BEGIN
		BEGIN TRY
			IF EXISTS(SELECT *
		FROM Page
		WHERE Id=@Id) --UPDATE
			BEGIN
			UPDATE Page SET Name = @Name,
				BrowserTitle = @BrowserTitle,
				PageTitle = @PageTitle,
				Url = @Url,
				AvailableOnDashboard = @AvailableOnDashboard,
				ImageId = @ImageId
				WHERE Id = @Id
			IF @AvailableOnDashboard=0
				BEGIN
				DECLARE @UserDashboardItemId UNIQUEIDENTIFIER
				DECLARE UserDashboardItem_Cursor CURSOR FOR
					SELECT Id
				FROM UserDashboardItem
				WHERE ObjectId=@Id
				OPEN UserDashboardItem_Cursor
				FETCH NEXT FROM UserDashboardItem_Cursor INTO @UserDashboardItemId
				WHILE @@FETCH_STATUS = 0
					BEGIN
					EXEC UserDashboardItem_DeleteById @Id=@UserDashboardItemId
					FETCH NEXT FROM UserDashboardItem_Cursor INTO @UserDashboardItemId
				END
				CLOSE UserDashboardItem_Cursor
				DEALLOCATE UserDashboardItem_Cursor
			END
			SELECT 1 AS SUCCESSFUL
		-- Update SUCCESSFUL
		END
			ELSE
			BEGIN
			INSERT INTO Page
				(Id, Name, BrowserTitle, PageTitle, Url, AvailableOnDashboard, ImageId)
			VALUES(@Id, @Name, @BrowserTitle, @PageTitle, @Url, @AvailableOnDashboard, @ImageId)
			INSERT INTO RoleObjectScope
				(ObjectId, RoleCompanyId)
			VALUES(@Id, '212B9E56-6AD4-4612-B294-309E000DC4F6')
			SELECT 0 AS SUCCESSFUL
		END
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
			ROLLBACK TRANSACTION
			SELECT -2 AS SUCCESSFUL
		END
		END CATCH
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Page_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Page_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id
	FROM Page
	WHERE Url='Pages.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	DECLARE @RolesButtonId UNIQUEIDENTIFIER
	DECLARE @PageButtonsButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Delete') AND ForGridUse=1
	SELECT @RolesButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Roles') AND ForGridUse=1
	SELECT @PageButtonsButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='PageButtons') AND ForGridUse=1
	SELECT [Id]
		  , [Name]
		  , [BrowserTitle]
		  , [PageTitle]
		  , [Url]
		  , [AvailableOnDashboard]
		  , [ImageId]
		  , (SELECT Url
		FROM [dbo].[Image]
		WHERE Id=Page.ImageId) AS ImageUrl
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditButtonId) AS EditButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @DeleteButtonId) AS DeleteButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @RolesButtonId) AS RolesButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @PageButtonsButtonId) AS PageButtonsButton
	FROM [Page]
	WHERE Id IN(SELECT ObjectId
	FROM RoleObjectScope
	WHERE RoleCompanyId IN(SELECT RoleCompanyId
	FROM UserRole
	WHERE UserId=@UserId))
	ORDER BY [Url], [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[Page_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Page_DeleteById]
	@Id UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT *
	FROM [dbo].[MenuItem]
	WHERE PageId=@Id)
		SELECT 1 AS SUCCESSFUL
	ELSE IF EXISTS(SELECT *
	FROM [User]
	WHERE PageId=@Id)
		SELECT 2 AS SUCCESSFUL
	--ELSE IF EXISTS(SELECT * FROM Grid WHERE PageId=@Id)
	--	SELECT 3 AS SUCCESSFUL
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DELETE RoleObjectScope WHERE ObjectId IN (SELECT Id
		FROM PageButton
		WHERE PageId=@Id)
				DELETE PageButton WHERE PageId=@Id OR RedirectPageId=@Id
				DELETE Grid WHERE PageId=@Id
				DELETE RoleObjectScope WHERE ObjectId=Id
					DECLARE @UserDashboardItemId UNIQUEIDENTIFIER
					DECLARE UserDashboardItem_Cursor CURSOR FOR
					SELECT Id
		FROM UserDashboardItem
		WHERE ObjectId=@Id
					OPEN UserDashboardItem_Cursor
					FETCH NEXT FROM UserDashboardItem_Cursor INTO @UserDashboardItemId
					WHILE @@FETCH_STATUS = 0
					BEGIN
			EXEC UserDashboardItem_DeleteById @Id=@UserDashboardItemId
			FETCH NEXT FROM UserDashboardItem_Cursor INTO @UserDashboardItemId
		END
					CLOSE UserDashboardItem_Cursor
					DEALLOCATE UserDashboardItem_Cursor
				DELETE Page WHERE Id=@Id

				SELECT 0 AS SUCCESSFUL

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
			CLOSE UserDashboardItem_Cursor
			DEALLOCATE UserDashboardItem_Cursor
			ROLLBACK TRANSACTION
			SELECT -2 AS SUCCESSFUL
		END
		END CATCH
	END
END
GO
/****** Object:  StoredProcedure [dbo].[MenuItems_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MenuItems_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id
	FROM Page
	WHERE Url='MenuItems.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	DECLARE @RolesButtonId UNIQUEIDENTIFIER
	DECLARE @MoveDownButtonId UNIQUEIDENTIFIER
	DECLARE @MoveUpButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Delete') AND ForGridUse=1
	SELECT @RolesButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Roles') AND ForGridUse=1
	SELECT @MoveDownButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Move Down') AND ForGridUse=1
	SELECT @MoveUpButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Move Up') AND ForGridUse=1
	SELECT Id, Name, ParentId, Title, [Index], ToolTip, ImageId, PageId,
		(SELECT MIN([MinMenuItem].[Index])
		FROM [dbo].[MenuItem] [MinMenuItem]
		WHERE [MinMenuItem].[ParentId] = [dbo].[MenuItem].[ParentId]) AS [MinIndex],
		(SELECT MAX([MaxMenuItem].[Index])
		FROM [dbo].[MenuItem] [MaxMenuItem]
		WHERE [MaxMenuItem].[ParentId] = [dbo].[MenuItem].[ParentId]) AS [MaxIndex],
		(SELECT COUNT(*)
		FROM [dbo].[MenuItem] [Children]
		WHERE [Children].[ParentId] = [dbo].[MenuItem].[Id]) AS [Children],
		(CASE
				WHEN [dbo].[MenuItem].[ParentId] IN (SELECT [RootItem].[Id]
		FROM [dbo].[MenuItem] [RootItem]
		WHERE UPPER(LTRIM(RTRIM([RootItem].[Name]))) = 'ROOT') THEN
					([dbo].[MenuItem].[Index] * 1000)
				ELSE
					(((SELECT [ParentItem].[Index]
		FROM [dbo].[MenuItem] [ParentItem]
		WHERE [ParentItem].[Id] = [dbo].[MenuItem].[ParentId]) * 1000) + [dbo].[MenuItem].[Index] + 1)
				END) AS [SortIndex],
		(SELECT Url
		FROM [dbo].[Image]
		WHERE [Id]=[dbo].[MenuItem].[ImageId]) AS ImageUrl
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditButtonId) AS EditButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @DeleteButtonId) AS DeleteButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @RolesButtonId) AS RolesButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @MoveDownButtonId) AS MoveDownButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @MoveUpButtonId) AS MoveUpButton
	FROM [dbo].[MenuItem]
	WHERE Id IN(SELECT ObjectId
		FROM RoleObjectScope
		WHERE RoleCompanyId IN(SELECT RoleCompanyId
		FROM UserRole
		WHERE UserId=@UserId)) AND (ParentId IS NOT NULL)
	ORDER BY [SortIndex]
END
GO
/****** Object:  StoredProcedure [dbo].[Host_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Host_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id
	FROM Page
	WHERE Url='Host.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @ToolButtonId UNIQUEIDENTIFIER
	DECLARE @APIButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Edit') AND ForGridUse=1
	SELECT @ToolButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Tool Destination') AND ForGridUse=1
	SELECT @APIButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='API') AND ForGridUse=1
	SELECT [Id]
      , [Name]
      , [SerialNumber]
      , [CompanyId]
      , [LicenseKey]
      , [IPAddress]
      , [MacAddress]
      , [Version]
      , TunnelIP
      , [ApiPort]
      , [ApiPassword]
      , [LanIPAddress]
      , [LastCheckIn]
      , CASE WHEN DATEDIFF(minute, LastCheckIn, CURRENT_TIMESTAMP)>20 THEN 'Red' WHEN DATEDIFF(minute, LastCheckIn, CURRENT_TIMESTAMP)>5 AND DATEDIFF(minute, LastCheckIn, CURRENT_TIMESTAMP)<=20 THEN 'Yellow' ELSE 'Green' END AS [EventStatus]
      , CASE WHEN IPAddress IS NULL THEN '' ELSE IPAddress END + '|' + CASE WHEN TunnelIP IS NULL THEN '' ELSE TunnelIP END AS WebGuiAddresses
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditButtonId) AS EditButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @ToolButtonId) AS ToolButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @APIButtonId) AS APIButton
	FROM [Host]
	WHERE ([CompanyId] = (SELECT CompanyId
		FROM [User]
		WHERE Id=@UserId) OR (SELECT Id
		FROM Company
		WHERE IsMaster=1)=(SELECT CompanyId
		FROM [User]
		WHERE Id=@UserId))
	ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[Image_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Image_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id
	FROM Page
	WHERE Url='Images.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id
	FROM PageButton
	WHERE PageId=@PageId AND ButtonId=(SELECT Id
		FROM Button
		WHERE Name='Delete') AND ForGridUse=1
	SELECT [Id]								-- 0
		  , [Name]							-- 1
		  , [Url]						-- 2
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditButtonId) AS EditButton
		, dbo.Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @DeleteButtonId) AS DeleteButton
	FROM [[dbo].[Image]]
	WHERE ((SELECT Id
	FROM Company
	WHERE IsMaster=1)=(SELECT CompanyId
	FROM [User]
	WHERE Id=@UserId))
	ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[EventHistory_GetListByEventId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EventHistory_GetListByEventId]
	@EventId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT [Id]
		  , [EventId]
		  , [UserId]
		  , [ModifiedOn]
		  , [EventActionId]
		  , ClosedCaption
		  , Name
		  , StartTime
		  , EndTime
		  , OwnerId
		  , VideoProfileId
		  , VBitRate
		  , AudioChannels
	FROM [EventHistory]
	WHERE [EventId]=@EventId
	ORDER BY [ModifiedOn] DESC
END
GO
/****** Object:  StoredProcedure [dbo].[Event_Insert]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_Insert]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@CompanyId UNIQUEIDENTIFIER,
	@SourceDeviceId UNIQUEIDENTIFIER,
	@DestinationDeviceId UNIQUEIDENTIFIER,
	@StartTime DATETIME,
	@EndTime DATETIME,
	@CreatorId UNIQUEIDENTIFIER,
	@CreatedOn DATETIME,
	@VideoProfileId UNIQUEIDENTIFIER,
	@ParentId UNIQUEIDENTIFIER,
	@RTT INT,
	@PLEClientStreamConfigId UNIQUEIDENTIFIER,
	@PLEServerStreamId UNIQUEIDENTIFIER,
	@PLEServerConfigId UNIQUEIDENTIFIER,
	@InputStreamId UNIQUEIDENTIFIER,
	@OutputStreamId UNIQUEIDENTIFIER,
	@SourceAcknowledgement INT,
	@DestinationAcknowledgement INT,
	@EventStatusId INT,
	@VBitRate VARCHAR(16),
	@AudioChannels VARCHAR(16),
	@StartNow BIT,
	@OwnerId UNIQUEIDENTIFIER,
	@ActualStarted DATETIME,
	@ActualEnded DATETIME,
	@ClosedCaption BIT,
	@Tx INT,
	@Rx INT
AS
BEGIN
	IF @StartNow = 1
		SET @StartTime = GETDATE()
	DECLARE @CancelledId INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Cancelled')
	IF EXISTS (SELECT [Name] 
				FROM [dbo].[Event] 
				WHERE ([PLEClientStreamConfigId]=@PLEClientStreamConfigId OR PLEServerConfigId=@PLEServerConfigId) 
					AND [EventStatusId]=@CancelledId 
					AND	(@StartTime>=[StartTime] 
						AND (@StartTime<=[EndTime] OR ([EndTime] IS NULL AND ActualEnded IS NULL)) 
						OR	@EndTime>[StartTime] 
						AND (@EndTime<=[EndTime] OR [EndTime] IS NULL AND ActualEnded IS NULL) 
						OR	@StartTime<=[StartTime] 
						AND (@EndTime>=[EndTime] OR @EndTime IS NULL) 
						OR ([EndTime] IS NULL OR @StartTime<=[EndTime]) 
						AND @EndTime IS NULL))
		SELECT CAST(0 AS BIT) AS SUCCESSFUL
	ELSE
		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION
				DECLARE @EventActionId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[EventAction] WHERE [Name]='Schedule')
			INSERT INTO [dbo].[Event](
				[Id],
				[Name],
				[CompanyId],
				[SourceDeviceId],
				[DestinationDeviceId],
				[StartTime],
				[EndTime],
				[CreatorId],
				[CreatedOn],
				[VideoProfileId],
				[ParentId],
				[RTT],
				[PLEClientStreamConfigId],
				[PLEServerStreamId],
				[PLEServerConfigId],
				[InputStreamId],
				[OutputStreamId],
				[SourceAcknowledgement],
				[DestinationAcknowledgement],
				[EventStatusId],
				[VBitRate],
				[AudioChannels],
				[OwnerId],
				[ActualStarted],
				[ActualEnded],
				[ClosedCaption],
				[Tx],
				[Rx])
			VALUES(
				@Id,
				@Name,
				@CompanyId,
				@SourceDeviceId,
				@DestinationDeviceId,
				@StartTime,
				@EndTime,
				@CreatorId,
				@CreatedOn,
				@VideoProfileId,
				@ParentId,
				@RTT,
				@PLEClientStreamConfigId,
				@PLEServerStreamId,
				@PLEServerConfigId,
				@InputStreamId,
				@OutputStreamId,
				@SourceAcknowledgement,
				@DestinationAcknowledgement,
				@EventStatusId,
				@VBitRate,
				@AudioChannels,
				@OwnerId,
				@ActualStarted,
				@ActualEnded,
				@ClosedCaption,
				@Tx,
				@Rx)
			
			INSERT INTO [dbo].[EventHistory](
				[Id],
				[EventId],
				[UserId],
				[ModifiedOn],
				[EventActionId],
				[ClosedCaption],
				[Name],
				[StartTime],
				[EndTime],
				[OwnerId],
				[VideoProfileId],
				[VBitRate],
				[AudioChannels])
			VALUES(
				NEWID(),
				@Id,
				@CreatorId,
				GETDATE(),
				@EventActionId,
				@ClosedCaption,
				@Name,
				@StartTime,
				@EndTime,
				@OwnerId,
				@VideoProfileId,
				@VBitRate,
				@AudioChannels)
				
			SELECT CAST(1 AS BIT) AS SUCCESSFUL
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
			ROLLBACK TRANSACTION
			SELECT CAST(0 AS BIT) AS SUCCESSFUL
		END
		END CATCH
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Event_GoodnightByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_GoodnightByUserId]
	@EventId UNIQUEIDENTIFIER,
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE [dbo].[Event] SET 
				[EventStatusId]=(SELECT [Id] FROM .[dbo].[EventStatus] WHERE [Name] = 'Goodnighting') 
			WHERE [Id]=@EventId
			
			INSERT INTO [dbo].[EventHistory](
				[Id],
				[EventId],
				[UserId],
				[ModifiedOn],
				[EventActionId],
				[ClosedCaption],
				[Name],
				[StartTime],
				[EndTime],
				[OwnerId],
				[VideoProfileId],
				[VBitRate],
				[AudioChannels])
			SELECT 
				NEWID() AS [Id],
				[Id] AS [EventId],
				@UserId,
				GETDATE() AS [ModifiedOn],
				(SELECT [Id] FROM [dbo].[EventAction] WHERE [Name]='Goodnight') AS EventActionId,
				[ClosedCaption],
				[Name],
				[StartTime],
				GETDATE() AS [EndTime],
				[OwnerId],
				[VideoProfileId],
				[VBitRate],
				[AudioChannels]
			FROM [dbo].[Event]
			WHERE [Id]=@EventId
			SELECT 0 AS SUCCESSFUL
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT -2 AS SUCCESSFUL
			END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Event_UpdateByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_UpdateByUserId]
	@EventId UNIQUEIDENTIFIER,
	@UserId UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@StartTime DATETIME,
	@EndTime DATETIME,
	@VideoProfileId UNIQUEIDENTIFIER,
	@VBitRate VARCHAR(16),
	@AudioChannels VARCHAR(16),
	@StartNow BIT,
	@OwnerId UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF @StartNow = 1
				SET @StartTime = GETDATE()
			DECLARE @PLEClientStreamConfigId UNIQUEIDENTIFIER
			DECLARE @PLEServerConfigId UNIQUEIDENTIFIER
			DECLARE @CancelledId INT = (SELECT [Id]	FROM [dbo].[EventStatus] WHERE [Name] = 'Cancelled')
			SELECT 
				@PLEClientStreamConfigId=PLEClientStreamConfigId,
				@PLEServerConfigId=PLEServerConfigId
			FROM [dbo].[Event]
			WHERE [Id]=@EventId
			IF EXISTS(SELECT [Name]	
						FROM [dbo].[Event]
						WHERE ([PLEClientStreamConfigId]=@PLEClientStreamConfigId OR [PLEServerConfigId]=@PLEServerConfigId) 
							AND [Id]<>@EventId 
							AND [EventStatusId]=@CancelledId 
							AND(@StartTime>=[StartTime] 
								AND (@StartTime<=[EndTime] OR ([EndTime] IS NULL AND ActualEnded IS NULL)) 
								OR	@EndTime>[StartTime] 
								AND (@EndTime<=[EndTime] OR [EndTime] IS NULL AND ActualEnded IS NULL) 
								OR @StartTime<=[StartTime] 
								AND (@EndTime>=[EndTime] OR @EndTime IS NULL) 
								OR ([EndTime] IS NULL OR @StartTime<=[EndTime]) 
								AND @EndTime IS NULL))
				SELECT 1 AS SUCCESSFUL
			ELSE
				BEGIN
					UPDATE [dbo].[Event] SET 
						[Name]=@Name, 
						[StartTime]=@StartTime,
						[EndTime]=@EndTime,
						[VideoProfileId]=@VideoProfileId,
						[VBitRate]=@VBitRate,
						[AudioChannels]=@AudioChannels,
						[OwnerId]=@OwnerId
					WHERE [Id]=@EventId

					INSERT INTO [dbo].[EventHistory](
						[Id],
						[EventId],
						[UserId],
						[ModifiedOn],
						[EventActionId],
						[ClosedCaption],
						[Name],
						[StartTime],
						[EndTime],
						[OwnerId],
						[VideoProfileId],
						[VBitRate],
						[AudioChannels])
					SELECT 
						NEWID() AS [Id],
						[Id] AS [EventId],
						@UserId,
						GETDATE() AS [ModifiedOn],
						(SELECT [Id] FROM [dbo].[EventAction] WHERE [Name]='Update') AS EventActionId,
						[ClosedCaption],
						[Name],
						[StartTime],
						[EndTime],
						[OwnerId],
						[VideoProfileId],
						[VBitRate],
						[AudioChannels]
					FROM [dbo].[Event] WHERE [Id]=@EventId

					SELECT 0 AS SUCCESSFUL
				END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT -2 AS SUCCESSFUL
			END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Event_GetListByUserIdStatusPageUrl]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_GetListByUserIdStatusPageUrl]
	@UserId UNIQUEIDENTIFIER,
	@Monitor_Status INT = 0,
	@PageUrl VARCHAR(100)
-- 0: all
-- 1: running;
-- 2: future;
-- 3: past
-- 4: cancelled
-- 5: cleared
AS
BEGIN

	-- Ronny 
	DECLARE @MonitorStatus_AllId INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'All')
	DECLARE @MonitorStatus_RunningId INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Running')
	DECLARE @MonitorStatus_FutureId INT	= (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Future')
	DECLARE @MonitorStatus_PastId INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Past')
	DECLARE @MonitorStatus_CancelledId INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Cancelled')
	DECLARE @MonitorStatus_ClearedId INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Cleared')

	DECLARE @All_Id INT	= (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'All')
	DECLARE @Scheduled_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Scheduled')
	DECLARE @Starting_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Starting')
	DECLARE @Started_Id INT	= (SELECT [Id] FROM [dbo].[EventStatus]	WHERE [Name] = 'Started')
	DECLARE @Stopping_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Stopping')
	DECLARE @Stopped_Id INT	= (SELECT [Id] FROM [dbo].[EventStatus]	WHERE [Name] = 'Stopped')
	DECLARE @Goodnighting_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Goodnighting')
	DECLARE @Goodnighted_Id INT	= (SELECT [Id] FROM [dbo].[EventStatus]	WHERE [Name] = 'Goodnighted')
	DECLARE @Clearing_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Clearing')
	DECLARE @Cleared_Id INT	= (SELECT [Id] FROM [dbo].[EventStatus]	WHERE [Name] = 'Cleared')
	DECLARE @Cancelled_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Cancelled')

	DECLARE @PageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]=@PageUrl)
	DECLARE @EditButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Edit'))
	DECLARE @CancelButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Cancel'))
	DECLARE @GoodnightButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Goodnight'))
	DECLARE @ExtendButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Extend'))
	DECLARE @ConnectionButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Connection'))
	DECLARE @VideoButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Video'))
	DECLARE @ClearButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Clear'))
	DECLARE @RestartEncoderButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Restart Encoder'))
	DECLARE @ToolSourceButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Tool Source'))
	DECLARE @ToolDestinationButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Tool Destination'))
	DECLARE @LogButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=(SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Log'))
	
	SELECT 
		[Event].[Id],						-- 0
		[Event].[Name],						-- 1
		[Event].[CompanyId],				-- 2
		[SourceDeviceId],					-- 3
		[DestinationDeviceId],				-- 4
		[StartTime],						-- 5
		[EndTime],							-- 6
		[CreatorId],						-- 7
		[CreatedOn],						-- 9
		[VideoProfileId],					--10
		[ParentId],							--11
		[RTT],								--12
		[PLEClientStreamConfigId],			--13
		[PLEServerStreamId],				--14
		[PLEServerConfigId],				--15
		[InputStreamId],					--16
		[OutputStreamId],					--17
		DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond,	--18
		CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond,		--19
		[SourceAcknowledgement],			--20
		[DestinationAcknowledgement],		--21
		[EventStatusId],					--22
		[VBitRate],							--23
		[AudioChannels],					--24
		[OwnerId],							--25
		[ActualStarted],					--26
		[ActualEnded],						--27
		[ClosedCaption],					--28
		[Event].[SerialNumber],				--29
		[Tx],								--30
		[Rx],								--31
		CASE WHEN [EventStatusId]=@Starting_Id THEN 'Yellow' 
			WHEN [EventStatusId]= @Started_Id THEN 'Green' 
			ELSE 'Red' 
		END AS TrafficLight,
		CASE WHEN EndTime IS NULL AND ActualEnded IS NULL THEN '&#x221e;' --???????????????????
			ELSE CASE WHEN ActualEnded IS NULL 
					THEN CONVERT(VARCHAR(15), DATEDIFF(minute, CURRENT_TIMESTAMP, EndTime)) 
					ELSE '0' 
				END 
		END AS Remaining,
		[HostSource].[IPAddress] AS SourceIp,
		[HostSource].[TunnelIP] AS SourceVpn,
		[HostDestination].[IPAddress] AS DestinationIP,
		[HostDestination].[TunnelIP] AS DestinationVpn,
		[PLEServerStream].[ConfigFileName] AS DestinationConfigFileName,		-- for log use
		CASE WHEN [ActualEnded] IS NOT NULL AND [ActualStarted] IS NOT NULL THEN DATEDIFF(minute, ActualStarted, ActualEnded) 
			ELSE NULL END AS Duration,

		-- Used in the Scheduling view
		CASE WHEN [EventStatusId] IN (@Starting_Id, @Started_Id, @Stopping_Id) THEN @MonitorStatus_RunningId		
				WHEN [EventStatusId]=@Scheduled_Id THEN @MonitorStatus_FutureId		
				WHEN [EventStatusId] IN (@Goodnighted_Id, @Stopped_Id) THEN @MonitorStatus_PastId		
				WHEN [EventStatusId] = @Cancelled_Id THEN @MonitorStatus_CancelledId	
				WHEN [EventStatusId]=@Cleared_Id THEN @MonitorStatus_ClearedId		
			END AS SchedulingStatus,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditButtonId) AS EditButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @CancelButtonId) AS CancelButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @GoodnightButtonId) AS GoodnightButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @ExtendButtonId) AS ExtendButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @ConnectionButtonId) AS ConnectionButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @VideoButtonId) AS VideoButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @ClearButtonId) AS ClearButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @RestartEncoderButtonId) AS RestartEncoderButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @ToolSourceButtonId) AS ToolSourceButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @ToolDestinationButtonId) AS ToolDestinationButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @LogButtonId) AS LogButton,
		DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), StartTime) AS StartTimeUTC,
		DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), EndTime) AS EndTimeUTC,
		DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), ActualStarted) AS ActualStartedUTC,
		DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), ActualEnded) AS ActualEndedUTC
	FROM [dbo].[Event]

	INNER JOIN [dbo].[PLEClientStreamConfig] 
		INNER JOIN [dbo].[Host] HostSource 
			ON [HostSource].[Id]=[dbo].[PLEClientStreamConfig].[HostId] 
	ON [dbo].[PLEClientStreamConfig].[Id]=[dbo].[Event].[PLEClientStreamConfigId]
	INNER JOIN [dbo].[PLEServerStream] 
		INNER JOIN [dbo].[Host] HostDestination 
			ON [HostDestination].[Id]=[dbo].[PLEServerStream].[HostId] 
	ON [dbo].[PLEServerStream].[Id]=[dbo].[Event].[PLEServerStreamId]

	WHERE ([Event].[CompanyId] = @CompanyId 
			OR (SELECT [Id] FROM [dbo].[Company] WHERE [IsMaster]=1)=@CompanyId 
			OR [HostSource].[CompanyId] = @CompanyId 
			OR [HostDestination].[CompanyId] = @CompanyId)
		AND ((@Monitor_Status = @MonitorStatus_AllId)
			OR (@Monitor_Status = @MonitorStatus_RunningId AND [EventStatusId] IN (@Starting_Id, @Started_Id, @Stopping_Id))
			OR (@Monitor_Status = @MonitorStatus_FutureId AND [EventStatusId] = @Scheduled_Id)
			OR (@Monitor_Status = @MonitorStatus_PastId AND [EventStatusId] IN (@Goodnighted_Id, @Stopped_Id))
			OR (@Monitor_Status = @MonitorStatus_CancelledId AND [EventStatusId] = @Cancelled_Id)
			OR (@Monitor_Status = @MonitorStatus_ClearedId AND [EventStatusId] = @Cleared_Id))
	ORDER BY [StartTime] DESC, [EndTime] DESC


END
GO
/****** Object:  StoredProcedure [dbo].[Event_ExtendByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_ExtendByUserId]
	@EventId UNIQUEIDENTIFIER,
	@UserId UNIQUEIDENTIFIER,
	@Timespan INT
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @StartTime DATETIME
			DECLARE @EndTime DATETIME
			DECLARE @PLEClientStreamConfigId UNIQUEIDENTIFIER
			DECLARE @PLEServerConfigId UNIQUEIDENTIFIER
			DECLARE @CancelledId INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Cancelled')
			SELECT 
				@StartTime=EndTime, 
				@EndTime=DATEADD(minute,@Timespan, EndTime),
				@PLEClientStreamConfigId=PLEClientStreamConfigId,
				@PLEServerConfigId=PLEServerConfigId
			FROM [dbo].[Event] WHERE [Id]=@EventId
			IF EXISTS (SELECT [Name] 
							FROM [dbo].[Event] 
							WHERE ([PLEClientStreamConfigId]=@PLEClientStreamConfigId OR [PLEServerConfigId]=@PLEServerConfigId) 
								AND [Id]<>@EventId AND [EventStatusId]<>@CancelledId 
								AND	(@StartTime>=[StartTime] 
										AND (@StartTime<=[EndTime] OR ([EndTime] IS NULL AND ActualEnded IS NULL))
										OR @EndTime>[StartTime] 
										AND (@EndTime<=[EndTime] OR [EndTime] IS NULL AND ActualEnded IS NULL)
										OR @StartTime<=[StartTime] 
										AND (@EndTime>=[EndTime] OR @EndTime IS NULL) 
										OR ([EndTime] IS NULL OR @StartTime<=[EndTime]) 
										AND @EndTime IS NULL))
				SELECT 1 AS SUCCESSFUL
			ELSE
				BEGIN
					UPDATE [dbo].[Event] SET [EndTime]=@EndTime WHERE [Id]=@EventId
					INSERT INTO [dbo].[EventHistory](
						[Id],
						[EventId],
						[UserId],
						[ModifiedOn],
						[EventActionId],
						[ClosedCaption],
						[Name],
						[StartTime],
						[EndTime],
						[OwnerId],
						[VideoProfileId],
						[VBitRate],
						[AudioChannels])
					SELECT 
						NEWID() AS [Id],
						[Id] AS [EventId],
						@UserId,
						GETDATE() AS [ModifiedOn],
						(SELECT [Id] FROM [dbo].[EventAction] WHERE [Name]='Extend') AS [EventActionId],
						[ClosedCaption],
						[Name],
						[StartTime],
						@EndTime AS [EndTime],
						[OwnerId],
						[VideoProfileId],
						[VBitRate],
						[AudioChannels]
					FROM [dbo].[Event] WHERE [Id]=@EventId
					SELECT 0 AS SUCCESSFUL
				END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT -2 AS SUCCESSFUL
			END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Event_CancelByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_CancelByUserId]
	@EventId UNIQUEIDENTIFIER,
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @CancelledId INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Cancelled')
			UPDATE [dbo].[Event] SET [EventStatusId]=@CancelledId WHERE Id=@EventId
			INSERT INTO [dbo].[EventHistory](
				[Id],
				[EventId],
				[UserId],
				[ModifiedOn],
				[EventActionId],
				[ClosedCaption],
				[Name],
				[StartTime],
				[EndTime],
				[OwnerId],
				[VideoProfileId],
				[VBitRate],
				[AudioChannels])
			SELECT 
				NEWID() AS [Id],
				[Id] AS [EventId],
				@UserId,
				GETDATE() AS [ModifiedOn],
				(SELECT [Id] FROM [dbo].[EventAction] WHERE [Name]='Cancel') AS EventActionId,
				[ClosedCaption],
				[Name],
				[StartTime],
				GETDATE() AS [EndTime],
				[OwnerId],
				[VideoProfileId],
				[VBitRate],
				[AudioChannels]
			FROM [dbo].[Event] WHERE [Id]=@EventId
			SELECT 0 AS SUCCESSFUL
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT -2 AS SUCCESSFUL
			END
	END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Device_GetListByHostIdUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Device_GetListByHostIdUserId]
	@HostId UNIQUEIDENTIFIER,
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]='Host.aspx')
	DECLARE @CalendarButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Calendar')
	DECLARE @PermissionsButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Device Permissions')
	DECLARE @CalendarGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=@CalendarButtonId)
	DECLARE @PermissionsGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton]	WHERE [PageId]=@PageId AND [ButtonId]=@PermissionsButtonId)

	SELECT 
		[Id], 
		[Name], 
		[HostId], 
		[ConfigFileName], 
		[Type],
		CASE [Type] WHEN 'Encoder Internal' THEN 0 WHEN 'Encoder External' THEN 1 WHEN 'Decoder Internal' THEN 2 WHEN 'Decoder External' THEN 3 END AS SortOrder,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @CalendarGridButtonId) AS CalendarButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @PermissionsGridButtonId) AS PermissionsButton,
		(SELECT [CompanyId] FROM [dbo].[Host] WHERE [Id]=[dbo].[View_HostDevice].[HostId]) AS CompanyId,
		CAST([Id] AS VARCHAR(40)) + '|' + (SELECT [Name] FROM [dbo].[Host] WHERE [Id]=@HostId) + ': ' + [Name] AS IdName
	FROM [dbo].[View_HostDevice]
	WHERE [HostId]=@HostId
	ORDER BY [SortOrder], [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[Company_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Company_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[Page] WHERE [Url]='Companies.aspx')
	DECLARE @EditButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Edit')
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[Button]	WHERE [Name]='Delete')
	DECLARE @EditGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButtonPageId AND [ButtonId]=@EditButtonId)
	DECLARE @DeleteGridButtonId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[GridButton]	WHERE [PageId]=@ButtonPageId AND [ButtonId]=@DeleteButtonId)

	SELECT
		[View_Company].*,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditButtonId) AS EditButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @DeleteButtonId) AS DeleteButton
	FROM [dbo].[View_Company]
	WHERE [Enabled]=1
		AND EXISTS(SELECT [Name] FROM [dbo].[Company] WHERE [Id]
					=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId) AND [IsMaster]=1)
		OR [Id]=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId) 
	ORDER BY [View_Company].[Name]
END
GO
/****** Object:  StoredProcedure [dbo].[Button_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Button_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]='Buttons.aspx')
	DECLARE @EditButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Edit')
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[Button]	WHERE [Name]='Delete')
	DECLARE @EditGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButtonPageId AND [ButtonId]=@EditButtonId)
	DECLARE @DeleteGridButtonId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[GridButton]	WHERE [PageId]=@ButtonPageId AND [ButtonId]=@DeleteButtonId)

	SELECT 
		[Id], 
		[Name], 
		[ImageId], 
		[IsHome], 
		(SELECT Url	FROM [dbo].[Image]	WHERE Id=Button.ImageId) AS ImageUrl,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditGridButtonId) AS EditButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @DeleteGridButtonId) AS DeleteButton
	FROM [dbo].[Button]
	WHERE (SELECT [Id] FROM [dbo].[Company] WHERE [IsMaster]=1)
			=(SELECT [CompanyId] FROM [dbo].[User] WHERE [Id]=@UserId)
	ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[BrandUrl_GetListByUserIdBrandId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[BrandUrl_GetListByUserIdBrandId]
	@UserId UNIQUEIDENTIFIER,
	@BrandId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @ButtonPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]='Brands.aspx')
	DECLARE @EditSubButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='EditSub')
	DECLARE @DeleteSubButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button]	WHERE [Name]='DeleteSub')
	DECLARE @EditSubGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButtonPageId AND [ButtonId]=@EditSubButtonId)
	DECLARE @DeleteSubGridButtonId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[GridButton]	WHERE [PageId]=@ButtonPageId AND [ButtonId]=@DeleteSubButtonId)

	SELECT 
		[Id],
      	[BrandId],
      	[Url],
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditSubGridButtonId) AS EditButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @DeleteSubGridButtonId) AS DeleteButton
	FROM [dbo].[BrandUrl]
	WHERE [BrandId]=@BrandId
	ORDER BY [Url]
END
GO
/****** Object:  StoredProcedure [dbo].[Brand_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Brand_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @ButtonPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]='Brands.aspx')
	DECLARE @EditButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Button] WHERE [Name]='Edit')
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[Button]	WHERE [Name]='Delete')
	DECLARE @EditGridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@ButtonPageId AND [ButtonId]=@EditButtonId)
	DECLARE @DeleteGridButtonId UNIQUEIDENTIFIER = (SELECT [Id]	FROM [dbo].[GridButton]	WHERE [PageId]=@ButtonPageId AND [ButtonId]=@DeleteButtonId)
	
	SELECT 
		[Id],
		[Name],
		[LoginBannerImageId],
		[LoginTagImageId],
		[PortalImageId],
		[FaviconImageId],
		[FooterCaption],
		[IsDefault],
		(SELECT [Url] FROM [dbo].[Image] WHERE [Id]=[Brand].[LoginBannerImageId]) AS LoginBannerURL,
		(SELECT [Url] FROM [dbo].[Image] WHERE [Id]=[Brand].[LoginTagImageId]) AS LoginTagURL,
		(SELECT [Url] FROM [dbo].[Image] WHERE [Id]=[Brand].[PortalImageId]) AS PortalImageURL,
		(SELECT [Url] FROM [dbo].[Image] WHERE [Id]=[Brand].[FaviconImageId]) AS FaviconURL,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @EditGridButtonId) AS EditButton,
		[dbo].Function_MaxScopeValue_ByUserIdGridButtonId(@UserId, @DeleteGridButtonId) AS DeleteButton
	FROM [dbo].[Brand] 
	WHERE [Id] IN (SELECT [BrandId] 
					FROM [dbo].[BrandRoleScope]	
					WHERE [RoleCompanyId] IN (SELECT [dbo].[RoleCompanyId]
												FROM [dbo].[UserRole] 
												WHERE [UserId]=@UserId))
	ORDER BY [Name]
END
GO
/****** Object:  StoredProcedure [dbo].[Event_Scheduled_Stop]    Script Date: 09/07/2017 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 
-- Description:			Changes the Event.EventStatus to Stopping when Event.EndTime <= now and wasw Started
-- =============================================
CREATE PROCEDURE [dbo].[Event_Scheduled_Stop]
AS
BEGIN
	DECLARE	@Started_Id INT = (SELECT [Id] FROM [dbo].[EventStatus]	WHERE [Name] = 'Started');
	DECLARE	@Stopping_Id INT = (SELECT [Id]	FROM [dbo].[EventStatus] WHERE [Name] = 'Stopping');

	-- Updates the events that were started by the DeviceCaster
	UPDATE [dbo].[Event] SET 
		[EventStatusId] = @Stopping_Id,						
		[SourceAcknowledgement] = 0,
		[DestinationAcknowledgement] = 0
	WHERE [EndTime] <= CURRENT_TIMESTAMP 
		AND [EventStatusId] = @Started_Id
END
GO
/****** Object:  StoredProcedure [dbo].[Event_Scheduled_Start]    Script Date: 09/07/2017 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 
-- Description:			Changes the Event.StatusId to Starting when Event.StartTime <= (now + booking time)
-- =============================================
CREATE PROCEDURE [dbo].[Event_Scheduled_Start]
AS
BEGIN
	DECLARE	@Scheduled_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Scheduled');
	DECLARE	@Starting_Id INT = (SELECT [Id]	FROM [dbo].[EventStatus] WHERE [Name] = 'Starting');
	DECLARE @In_Advance_Period_Minute INT = 1 -- this value is subject to possible modification

	-- Update the events that are due wiht in one minute
	UPDATE [dbo].[Event] SET 
		[EventStatusId] = @Starting_Id,
		[SourceAcknowledgement] = 0,
		[DestinationAcknowledgement] = 0					
	WHERE [StartTime] <= DATEADD(MINUTE, @In_Advance_Period_Minute, CURRENT_TIMESTAMP) 
		AND [EventStatusId] = @Scheduled_Id

END
GO
/****** Object:  StoredProcedure [dbo].[Event_Scheduled_Clear]    Script Date: 09/07/2017 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 
-- Description:			The method clears the events which Endtime was 5 min ago
-- =============================================
CREATE PROCEDURE [dbo].[Event_Scheduled_Clear]
AS
BEGIN
	DECLARE	@Starting_Id INT = (SELECT [Id]	FROM [dbo].[EventStatus] WHERE [Name] = 'Starting');
	DECLARE	@Stopping_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Stopping');
	DECLARE @Goodnighting_Id INT = (SELECT [Id]	FROM [dbo].[EventStatus] WHERE [Name] = 'Goodnighting');
	DECLARE	@Clearing_Id INT = (SELECT [Id]	FROM [dbo].[EventStatus] WHERE [Name] = 'Clearing');
	DECLARE @Grace_period_Minute INT = 5; -- this value is subject to possible modification

	-- Flag only the events that keep "ing" for 5 min after the ending time
	UPDATE [dbo].[Event] SET 
		[EventStatusId] = @Clearing_Id,	
		[SourceAcknowledgement] = 0,
		[DestinationAcknowledgement] = 0
	WHERE @Grace_period_Minute < DATEDIFF(MINUTE, [EndTime], CURRENT_TIMESTAMP) 
		AND [EventStatusId] IN (@Stopping_Id, @Starting_Id, @Goodnighting_Id)
END
GO
/****** Object:  StoredProcedure [dbo].[Event_GetStoppingListByHostId]    Script Date: 09/07/2017 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Event_GetStoppingListByHostId]
	@HostId UNIQUEIDENTIFIER

AS
BEGIN
	DECLARE	@Stopping_Id INT =	(SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Stopping');
	DECLARE @Goodnighting_Id INT = (SELECT [Id]	FROM [dbo].[EventStatus] WHERE [Name] = 'Goodnighting');


	SELECT 
		[Id],							-- 0
		[Name],							-- 1
		[CompanyId],						-- 2
		[SourceDeviceId],					-- 3
		[DestinationDeviceId],			-- 4
		[StartTime],						-- 5
		[EndTime],						-- 6
		[CreatorId],						-- 7
		[CreatedOn],						-- 9
		[VideoProfileId],					--10
		[ParentId],						--11
		[RTT],							--12
		[PLEClientStreamConfigId],		--13
		[PLEServerStreamId],				--14
		[PLEServerConfigId],				--15
		[InputStreamId],					--16
		[OutputStreamId],					--17
		DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond,	--18
		CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond,		--19
		[SourceAcknowledgement],			--20
		[DestinationAcknowledgement],		--21
		[EventStatusId],						--22
		[VBitRate],						--23
		[AudioChannels],					--24
		[OwnerId],						--25
		[ActualStarted],					--26
		[ActualEnded],					--27
		[ClosedCaption],					--28
		[SerialNumber],					--29
		[Tx],								--30
		[Rx]	--31
	FROM [dbo].[Event]
	WHERE ([PLEClientStreamConfigId] IN (SELECT [Id] FROM [PLEClientStreamConfig] WHERE [HostId]=@HostId)
				OR [PLEServerStreamId] IN (SELECT [Id] FROM [PLEServerStream] WHERE [HostId]=@HostId))
		AND ([EventStatusId]=@Stopping_Id OR [EventStatusId]=@Goodnighting_Id)
	ORDER BY [StartTime]

END
GO
/****** Object:  StoredProcedure [dbo].[Event_GetStartingListByHostId]    Script Date: 09/07/2017 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 
-- Description:			Retrieves all the events that are due to start
-- =============================================
CREATE PROCEDURE [dbo].[Event_GetStartingListByHostId]
	@HostId UNIQUEIDENTIFIER

AS
BEGIN

	DECLARE	@Starting_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Starting');

	SELECT 
		[Id],							-- 0
		[Name],							-- 1
		[CompanyId],						-- 2
		[SourceDeviceId],					-- 3
		[DestinationDeviceId],			-- 4
		[StartTime],						-- 5
		[EndTime],						-- 6
		[CreatorId],						-- 7
		[CreatedOn],						-- 9
		[VideoProfileId],					--10
		[ParentId],						--11
		[RTT],							--12
		[PLEClientStreamConfigId],		--13
		[PLEServerStreamId],				--14
		[PLEServerConfigId],				--15
		[InputStreamId],					--16
		[OutputStreamId],					--17
		DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond,	--18
		CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond,		--19
		[SourceAcknowledgement],			--20
		[DestinationAcknowledgement],		--21
		[EventStatusId],						--22
		[VBitRate],						--23
		[AudioChannels],					--24
		[OwnerId],						--25
		[ActualStarted],					--26
		[ActualEnded],					--27
		[ClosedCaption],					--28
		[SerialNumber],					--29
		[Tx],								--30
		[Rx]								--31
	FROM [dbo].[Event] 
	WHERE ([PLEClientStreamConfigId] IN (SELECT [Id] FROM [dbo].[PLEClientStreamConfig]	WHERE [HostId]=@HostId)
				OR [PLEServerStreamId] IN (SELECT [Id] FROM [dbo].[PLEServerStream] WHERE [HostId]=@HostId))
		AND [EventStatusId]= @Starting_Id
	ORDER BY [StartTime]

END
GO
/****** Object:  StoredProcedure [dbo].[Event_GetStartedListByHostId]    Script Date: 09/07/2017 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 
-- Description:			Retrieves all the events that were already started and are not due to stop
-- =============================================
CREATE PROCEDURE [dbo].[Event_GetStartedListByHostId]
	@HostId UNIQUEIDENTIFIER

AS
BEGIN

	DECLARE	@Started_Id INT = (SELECT [Id] FROM [dbo].[EventStatus]	WHERE [Name] = 'Started');
	DECLARE	@Stopping_Id INT = (SELECT [Id]	FROM [dbo].[EventStatus] WHERE [Name] = 'Stopping');

	SELECT 
		[Id],							-- 0
		[Name],							-- 1
		[CompanyId],						-- 2
		[SourceDeviceId],					-- 3
		[DestinationDeviceId],			-- 4
		[StartTime],						-- 5
		[EndTime],						-- 6
		[CreatorId],						-- 7
		[CreatedOn],						-- 9
		[VideoProfileId],					--10
		[ParentId],						--11
		[RTT],							--12
		[PLEClientStreamConfigId],		--13
		[PLEServerStreamId],				--14
		[PLEServerConfigId],				--15
		[InputStreamId],					--16
		[OutputStreamId],					--17
		DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond,	--18
		CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond,		--19
		[SourceAcknowledgement],			--20
		[DestinationAcknowledgement],		--21
		[EventStatusId],						--22
		[VBitRate],						--23
		[AudioChannels],					--24
		[OwnerId],						--25
		[ActualStarted],					--26
		[ActualEnded],					--27
		[ClosedCaption],					--28
		[SerialNumber],					--29
		[Tx],								--30
		[Rx]								--31
	FROM [dbo].[Event]
	WHERE ([PLEClientStreamConfigId] IN (SELECT [Id] FROM [dbo].[PLEClientStreamConfig] WHERE HostId=@HostId)
				OR [PLEServerStreamId]	IN (SELECT [Id] FROM [dbo].[PLEServerStream] WHERE HostId=@HostId))
		AND [EventStatusId]=@Started_Id 
		AND ([EndTime] IS NULL OR [EndTime]>CURRENT_TIMESTAMP)
	ORDER BY [StartTime]
END
GO
/****** Object:  StoredProcedure [dbo].[Event_GetClearingListByHostId]    Script Date: 09/07/2017 14:14:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date:		
-- Description:			Retrieve all the events associated with the @HostId that are due to be Cleared 
-- =============================================
CREATE PROCEDURE [dbo].[Event_GetClearingListByHostId]
	@HostId UNIQUEIDENTIFIER

AS
BEGIN
	DECLARE @Clearing_Id INT = (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = 'Clearing');

	SELECT 
		[Id],							-- 0
		[Name],							-- 1
		[CompanyId],						-- 2
		[SourceDeviceId],					-- 3
		[DestinationDeviceId],			-- 4
		[StartTime],						-- 5
		[EndTime],						-- 6
		[CreatorId],						-- 7
		[CreatedOn],						-- 9
		[VideoProfileId],					--10
		[ParentId],						--11
		[RTT],							--12
		[PLEClientStreamConfigId],		--13
		[PLEServerStreamId],				--14
		[PLEServerConfigId],				--15
		[InputStreamId],					--16
		[OutputStreamId],					--17
		DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond,	--18
		CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond,		--19
		[SourceAcknowledgement],			--20
		[DestinationAcknowledgement],		--21
		[EventStatusId],						--22
		[VBitRate],						--23
		[AudioChannels],					--24
		[OwnerId],						--25
		[ActualStarted],					--26
		[ActualEnded],					--27
		[ClosedCaption],					--28
		[SerialNumber],					--29
		[Tx],								--30
		[Rx]
	--31
	FROM [dbo].[Event]
	WHERE ([PLEClientStreamConfigId] IN (SELECT [Id] FROM [dbo].[PLEClientStreamConfig] WHERE [HostId]=@HostId)
				OR [PLEServerStreamId]	IN (SELECT [Id] FROM [dbo].[PLEServerStream] WHERE HostId=@HostId))
		AND [EventStatusId]=@Clearing_Id
	ORDER BY [StartTime]


END
GO

