USE [Scheduler]
GO
/****** Object:  StoredProcedure [dbo].[Configuration_Update]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Configuration_Update]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@INTValue INT,
	@StringValue VARCHAR(50)
AS
BEGIN
	UPDATE Configuration SET INTValue=@INTValue, StringValue=@StringValue WHERE Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[Status_GetMonitorList]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 
-- Description:			Selects the status to be shown in the monitor view
-- =============================================
CREATE PROCEDURE [dbo].[Status_GetMonitorList] 
AS
BEGIN
	SELECT * 
	FROM [Status] 
	WHERE [Name] IN ('Starting', 'Started', 'Stopping') 
	ORDER BY [Id]
END
GO
/****** Object:  StoredProcedure [dbo].[Status_GetList]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:				Ronny Alfonso
-- Create date: 
-- Description:			Returns the list of status
-- =============================================
CREATE PROCEDURE [dbo].[Status_GetList] 

AS
BEGIN
	SELECT * 
	FROM [Status] 
	WHERE [Id] > 0
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
	IF NOT EXISTS(SELECT * FROM Host WHERE LicenseKey=@LicenseKey)
	BEGIN
		INSERT INTO Host
		(
			Name, 
			SerialNumber, 
			CompanyId, 
			LicenseKey, 
			IPAddress, 
			MacAddress, 
			[Version],
			TunnelIP,
			ApiPort,
			ApiPassword,
			LanIPAddress,
			LastCheckin
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
			@LastCheckin
		)
	END
	ELSE
	BEGIN
		UPDATE Host SET
			Name=@Name, 
			SerialNumber=@SerialNumber, 
			CompanyId=@CompanyId, 
			IPAddress=@IPAddress, 
			MacAddress=@MacAddress, 
			[Version]=@Version,
			TunnelIP=@TunnelIP,
			ApiPassword = @ApiPassword,
			ApiPort = @ApiPort,
			LanIPAddress = @LanIPAddress,
			LastCheckin = @LastCheckin
		WHERE LicenseKey=@LicenseKey
	END
	SELECT Id FROM Host WHERE LicenseKey=@LicenseKey
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
	If EXISTS(SELECT * FROM Button WHERE Id<>@Id AND Name=@Name)
		SELECT 1 AS Successful
	ELSE If EXISTS(SELECT * FROM Button WHERE Id=@Id AND IsHome=1 AND @IsHome=0)
		SELECT 2 AS Successful
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				IF EXISTS(SELECT * FROM Button WHERE Id=@Id)
					UPDATE Button SET Name=@Name, ImageId=@ImageId, IsHome=@IsHome WHERE Id=@Id
				ELSE
					INSERT INTO Button(Id, Name,ImageId, IsHome)VALUES(@Id, @Name, @ImageId, @IsHome)

				IF @IsHome=1
					UPDATE Button SET IsHome=0 WHERE Id<>@Id

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
/****** Object:  StoredProcedure [dbo].[Role_InsertUpdate]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_InsertUpdate]
	@Id UNIQUEIDENTIFIER,
	@Name VARCHAR(50),
	@CompanyId UNIQUEIDENTIFIER,
	@Type INT
AS
BEGIN
	IF EXISTS(SELECT * FROM [Role] WHERE Id=@Id)
	BEGIN
		IF EXISTS(SELECT * FROM [Role] WHERE Id<>@Id AND Name=@Name)
		BEGIN
			SELECT 1 AS Successful
		END
		ELSE
		BEGIN
			UPDATE [Role] SET Name=@Name, CompanyId=@CompanyId, [Type]=@Type WHERE Id=@Id
			SELECT 0 AS Successful
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM [Role] WHERE Id<>@Id AND Name=@Name)
		BEGIN
			SELECT 1 AS Successful
		END
		ELSE
		BEGIN
			INSERT INTO [Role] (Id, Name, CompanyId, [Type]) VALUES(@Id, @Name, @CompanyId, @Type)
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
	SELECT @PageUrl=Url FROM Page WHERE Id=(SELECT PageId FROM PageButton WHERE Id=@GridButtonId)
	SELECT Id,
	Name,
	Value
	FROM Scope 
	WHERE (((SELECT Id FROM Company WHERE IsMaster=1)=@CompanyId) OR Value<>(SELECT MAX(Value) FROM Scope))
	AND (Value<>1 OR (@PageUrl='Monitor.aspx') OR (@PageUrl='Scheduling.aspx'))
	ORDER BY Value
END
GO
/****** Object:  StoredProcedure [dbo].[Role_RemoveObject]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_RemoveObject]
	@ObjectId	UNIQUEIDENTIFIER,
	@RoleId UNIQUEIDENTIFIER
AS
BEGIN
	DELETE RoleObjectScope WHERE ObjectId=@ObjectId AND RoleId=@RoleId
END
GO
/****** Object:  StoredProcedure [dbo].[RoleObjectScope_UpdateByRoleIdGridButtonIdScopeId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RoleObjectScope_UpdateByRoleIdGridButtonIdScopeId]
	@Id UNIQUEIDENTIFIER,
	@GridButtonId UNIQUEIDENTIFIER,
	@ScopeId UNIQUEIDENTIFIER
AS
BEGIN
	DELETE RoleObjectScope WHERE RoleId=@Id AND ObjectId=@GridButtonId
	INSERT INTO RoleObjectScope(RoleId, ObjectId, ScopeId)VALUES(@Id, @GridButtonId, @ScopeId)
END
GO
/****** Object:  StoredProcedure [dbo].[PleServerConfig_InsertUpdate_HostId_ConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PleServerConfig_InsertUpdate_HostId_ConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100),
	@InputName VARCHAR(32),
	@Bindip VARCHAR(32),
	@Port INT,
	@Lanipaddress VARCHAR(16),
	@Altipaddress VARCHAR(16)
AS
BEGIN
IF EXISTS(SELECT Id FROM PleServerConfig WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName)
	UPDATE PleServerConfig SET
	InputName=@InputName,
	Bindip=@Bindip,
	Port=@Port,
	ModifiedOn=CURRENT_TIMESTAMP,
	Lanipaddress=@Lanipaddress,
	Altipaddress=@Altipaddress,
	Deleted=0
	WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName
ELSE
	INSERT INTO PleServerConfig(
	HostId,
	ConfigFileName,
	InputName,
	Bindip,
	Port,
	ModifiedOn,
	Lanipaddress,
	Altipaddress
	)
	VALUES(
	@HostId,
	@ConfigFileName,
	@InputName,
	@Bindip,
	@Port,
	CURRENT_TIMESTAMP,
	@Lanipaddress,
	@Altipaddress
	)
END
GO
/****** Object:  StoredProcedure [dbo].[PleClientStreamConfig_InsertUpdate_HostId_ConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PleClientStreamConfig_InsertUpdate_HostId_ConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100),
	@InputName VARCHAR(32),
	@Startmode INT,
	@Clientindex VARCHAR(8),
	@LocalPort INT,
	@LocalIP VARCHAR(32),
	@Lanipaddress VARCHAR(16),
	@InputMulticast BIT,
	@InputMulticastip VARCHAR(16),
	@InputMulticastIFace VARCHAR(16),
	@MultiIPAddress VARCHAR(16)
AS
BEGIN
IF EXISTS(SELECT Id FROM PleClientStreamConfig WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName)
	UPDATE PleClientStreamConfig SET
	InputName=@InputName,
	Startmode=@Startmode,
	Clientindex=@Clientindex,
	LocalPort=@LocalPort,
	ModifiedOn=CURRENT_TIMESTAMP,
	LocalIP=@LocalIP,
	Lanipaddress=@Lanipaddress,
	InputMulticast=@InputMulticast,
	InputMulticastip=@InputMulticastip,
	InputMulticastIFace=@InputMulticastIFace,
	MultiIPAddress=@MultiIPAddress,
	Deleted=0
	WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName
ELSE
	INSERT INTO PleClientStreamConfig(
	HostId,
	ConfigFileName,
	InputName,
	Startmode,
	Clientindex,
	LocalPort,
	ModifiedOn,
	LocalIP,
	Lanipaddress,
	InputMulticast,
	InputMulticastip,
	InputMulticastIFace,
	MultiIPAddress
	)
	VALUES(
	@HostId,
	@ConfigFileName,
	@InputName,
	@Startmode,
	@Clientindex,
	@LocalPort,
	CURRENT_TIMESTAMP,
	@LocalIP,
	@Lanipaddress,
	@InputMulticast,
	@InputMulticastip,
	@InputMulticastIFace,
	@MultiIPAddress
	)
END
GO
/****** Object:  StoredProcedure [dbo].[Role_AddObject]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_AddObject]
	@ObjectId	UNIQUEIDENTIFIER,
	@RoleId UNIQUEIDENTIFIER
AS
BEGIN
	INSERT INTO RoleObjectScope(RoleId, ObjectId)VALUES(@RoleId, @ObjectId)
END
GO
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
				DELETE PageButton WHERE Id=@Id
				UPDATE PageButton SET [Index]=[Index]-1 WHERE PageId=@PageId AND ForGridUse=@ForGridUse AND [Index]>@Index
				DELETE RoleObjectScope WHERE ObjectId=@Id
				
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
SELECT @BrandId=BrandId FROM BrandUrl WHERE Url=@Url
IF @BrandId IS NOT NULL
	SELECT Id
	  , [Name]
	  , LoginBannerImageId
	  , LogINTagImageId
	  , PortalImageId
	  , FaviconImageId
      ,[FooterCaption]
      ,[Default]
      ,(SELECT Url FROM Images WHERE Id=Brand.LoginBannerImageId) AS LoginBannerURL
      ,(SELECT Url FROM Images WHERE Id=Brand.LogINTagImageId) AS LogINTagURL
      ,(SELECT Url FROM Images WHERE Id=Brand.PortalImageId) AS PortalImageURL
      ,(SELECT Url FROM Images WHERE Id=Brand.FaviconImageId) AS FaviconURL
	FROM Brand WHERE ID=@BrandId
ELSE
	SELECT Id
	  , [Name]
	  , LoginBannerImageId
	  , LogINTagImageId
	  , PortalImageId
	  , FaviconImageId
      ,[FooterCaption]
      ,[Default]
      ,(SELECT Url FROM Images WHERE Id=Brand.LoginBannerImageId) AS LoginBannerURL
      ,(SELECT Url FROM Images WHERE Id=Brand.LogINTagImageId) AS LogINTagURL
      ,(SELECT Url FROM Images WHERE Id=Brand.PortalImageId) AS PortalImageURL
      ,(SELECT Url FROM Images WHERE Id=Brand.FaviconImageId) AS FaviconURL
	FROM Brand WHERE [Default]=1
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
	@LogINTagImageId UNIQUEIDENTIFIER,
	@PortalImageId UNIQUEIDENTIFIER,
	@FaviconImageId UNIQUEIDENTIFIER,
	@FooterCaption VARCHAR(100),
	@Default BIT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM Brand WHERE Id=@Id)
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				INSERT INTO Brand(Id, Name, LoginBannerImageId, LogINTagImageId, PortalImageId, FaviconImageId, FooterCaption, [Default])
				VALUES(@Id, @Name, @LoginBannerImageId, @LogINTagImageId, @PortalImageId, @FaviconImageId, @FooterCaption, @Default)
				INSERT INTO RoleObjectScope(ObjectId, RoleId) VALUES(@Id, '212B9E56-6AD4-4612-B294-309E000DC4F6')
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
		UPDATE Brand
		SET [Name]=@Name
		  , LoginBannerImageId=@LoginBannerImageId
		  , LogINTagImageId=@LogINTagImageId
		  , PortalImageId=@PortalImageId
		  , FaviconImageId=@FaviconImageId
		  ,[FooterCaption]=@FooterCaption
		  ,[Default]=@Default
		WHERE Id=@Id

	IF @Default=1
		UPDATE Brand SET [Default]=0 WHERE Id<>@Id
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
	INSERT INTO BrandUrl([BrandId],[Url])VALUES(@BrandId, @Url)
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
	IF EXISTS(SELECT * FROM Company WHERE Id=@Id)
		UPDATE Company
		SET Name=@Name,
		AddressId=@AddressId,
		Website=@Website,
		IsMaster=@IsMaster,
		Contact=@Contact,
		Email=@Email,
		AccountingEmail=@AccountingEmail,
		AccountingNotifications=@AccountingNotifications,
		EventEmail=@EventEmail,
		EventNotifications=@EventNotifications,
		[Enabled]=@Enabled
		WHERE Id=@Id
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				INSERT INTO Company
				(Id, Name, AddressId, Website, IsMaster, Contact, Email, AccountingEmail, AccountingNotifications, EventEmail, EventNotifications, [Enabled]) 
				VALUES(@Id, @Name, @AddressId, @Website, @IsMaster, @Contact, @Email, @AccountingEmail, @AccountingNotifications, @EventEmail, @EventNotifications, @Enabled)
				INSERT INTO [Role](Id, Name, CompanyId, Type) VALUES(NEWID(), 'System Administrators', @Id, 0)
				DECLARE @RoleId UNIQUEIDENTIFIER
				SET @RoleId=NEWID()
				INSERT INTO [Role](Id, Name, CompanyId, Type) VALUES(@RoleId, 'Everyone', @Id, 1)
				INSERT INTO RoleObjectScope(ObjectId, RoleId)
				SELECT Id AS ObjectId, @RoleId AS RoleId FROM MenuItems WHERE ParentId IS NULL
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
		UPDATE Company SET IsMaster=0 WHERE Id<>@Id
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
	DELETE BrandUrl WHERE Id=@Id
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
	IF EXISTS(SELECT * FROM Brand WHERE Id=@Id AND [Default]=1)
		SELECT 1 AS Success
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DELETE BrandUrl WHERE BrandId=@Id
				DELETE RoleObjectScope WHERE ObjectId=@Id
				DELETE Brand WHERE Id=@Id
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
	If EXISTS(SELECT * FROM PageButton WHERE ButtonId=@Id)
		SELECT 1 AS Successful
	ELSE If EXISTS(SELECT * FROM Button WHERE Id=@Id AND IsHome=1)
		SELECT 2 AS Successful
	ELSE
	BEGIN
		DELETE Button WHERE Id=@Id
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
	FROM [OutputStream]
	WHERE HostId=@HostId
	AND 
	(
		LEFT([ConfigFileName], LEN('decklink_stream'))='decklink_stream' 
		OR LEFT([ConfigFileName], LEN('aja_stream'))='aja_stream' 
		OR LEFT([ConfigFileName], LEN('asi_stream'))='asi_stream')
	AND CHARINDEX('-config-', [ConfigFileName])>0
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
IF EXISTS(SELECT Id FROM OutputStream WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName)
	UPDATE OutputStream SET
	StreamName=@StreamName,
	StreamEnabled=@StreamEnabled,
	Outputformat=@Outputformat,
	VBitRate=@VBitRate,
	VideoTranscodeMethod=@VideoTranscodeMethod,
	VideoOutputFormat=@VideoOutputFormat,
	GopSize=@GopSize,
	ScalingMode=@ScalingMode,
	FrameRateMode=@FrameRateMode,
	Deinterlace=@Deinterlace,
	TsRateControl=@TsRateControl,
	TsBitRateMin=@TsBitRateMin,
	TsBitRateMax=@TsBitRateMax,
	AudioTranscodingType=@AudioTranscodingType,
	ABitRate=@ABitRate,
	ARate=@ARate,
	AudioChannels=@AudioChannels,
	AProfile=@AProfile,
	DestinationIP=@DestinationIP,
	DestinationPort=@DestinationPort,
	ModifiedOn=CURRENT_TIMESTAMP,
	OutputProto=@OutputProto,
	OutputMulticast=@OutputMulticast,
	OutputMulticastIFace=@OutputMulticastIFace,
	Deleted=0
	WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName
ELSE
	INSERT INTO OutputStream(
	HostId,
	ConfigFileName,
	StreamName,
	StreamEnabled,
	Outputformat,
	VBitRate,
	VideoTranscodeMethod,
	VideoOutputFormat,
	GopSize,
	ScalingMode,
	FrameRateMode,
	Deinterlace,
	TsRateControl,
	TsBitRateMin,
	TsBitRateMax,
	AudioTranscodingType,
	ABitRate,
	ARate,
	AudioChannels,
	AProfile,
	DestinationIP,
	DestinationPort,
	ModifiedOn,
	OutputProto,
	OutputMulticast,
	OutputMulticastIFace
	)
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
	@OutputMulticastIFace
	)
END
GO
/****** Object:  StoredProcedure [dbo].[OutputStream_GetListByHostIdPleConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OutputStream_GetListByHostIdPleConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100)
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
	FROM [OutputStream]
	WHERE HostId=@HostId AND ConfigFileName LIKE @ConfigFileName + '-%'
	AND (Outputformat LIKE 'hdsdi%' OR Outputformat LIKE 'asi%')
	AND Deleted=0
	ORDER BY ConfigFileName
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
		  ,[HostId]
		  ,[ConfigFileName]
		  ,[InputName]
		  ,[SdiAspectRatio]
		  ,[SdiVideoMode]
		  ,[SdiAudioConf]
		  ,[ARate]
		  ,[AudioChannels]
		  ,[ModifiedOn]
		  ,[LocalIP]
		  ,[LocalPort]
		  ,[InputMulticast]
		  ,[InputMulticastip]
		  ,[InputMulticastIFace]
		  ,[Deleted]
	FROM [InputStream]
	WHERE [HostId]=@HostId
	AND LEFT([ConfigFileName], LEN('net_stream'))='net_stream' AND RIGHT([ConfigFileName], LEN('-config'))='-config'
	AND [LocalPort]=@LocalPort
	AND EXISTS
	(
		SELECT * FROM OutputStream
		WHERE HostId=@HostId
		AND [ConfigFileName] LIKE [InputStream].[ConfigFileName]+'-%'
		AND (LEFT([Outputformat], LEN('hdsdi'))='hdsdi' AND (RIGHT([Outputformat], LEN('sdi'))='sdi' OR RIGHT([Outputformat], LEN('aja'))='aja')
		OR LEFT([Outputformat], LEN('asi'))='asi' AND RIGHT([Outputformat], LEN('ts'))='ts')
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
	@InputMulticastip VARCHAR(16),
	@InputMulticastIFace VARCHAR(16)
AS
BEGIN
IF EXISTS(SELECT Id FROM InputStream WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName)
	UPDATE InputStream SET
	InputName=@InputName,
	SdiAspectRatio=@SdiAspectRatio,
	SdiVideoMode=@SdiVideoMode,
	SdiAudioConf=@SdiAudioConf,
	ARate=@ARate,
	AudioChannels=@AudioChannels,
	ModifiedOn=CURRENT_TIMESTAMP,
	LocalIP=@LocalIP,
	LocalPort=@LocalPort,
	InputMulticast=@InputMulticast,
	InputMulticastip=@InputMulticastip,
	InputMulticastIFace=@InputMulticastIFace,
	Deleted=0
	WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName
ELSE
	INSERT INTO InputStream(
	HostId,
	ConfigFileName,
	InputName,
	SdiAspectRatio,
	SdiVideoMode,
	SdiAudioConf,
	ARate,
	AudioChannels,
	ModifiedOn,
	LocalIP,
	LocalPort,
	InputMulticast,
	InputMulticastip,
	InputMulticastIFace
	)
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
	@InputMulticastip,
	@InputMulticastIFace
	)
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
			SELECT @MaxIndex = Max([Index]) FROM MenuItems WHERE ParentId=(SELECT ParentId FROM MenuItems WHERE Id=@Id)
			SELECT @PrevId=Id, @PrevIndex=[Index] FROM MenuItems WHERE ParentId=(SELECT ParentId FROM MenuItems WHERE Id=@Id) AND [Index]=(SELECT [Index]-1 FROM MenuItems WHERE Id=@Id)
			UPDATE MenuItems
			SET [Index] = @MaxIndex + 1
			WHERE Id=@Id
			UPDATE MenuItems
			SET [Index] = [Index] + 1
			WHERE Id=@PrevId
			UPDATE MenuItems
			SET [Index] = @PrevIndex
			WHERE Id=@Id
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
			SELECT @MaxIndex = Max([Index]) FROM MenuItems WHERE ParentId=(SELECT ParentId FROM MenuItems WHERE Id=@Id)
			SELECT @NextId=Id, @NextIndex=[Index] FROM MenuItems WHERE ParentId=(SELECT ParentId FROM MenuItems WHERE Id=@Id) AND [Index]=(SELECT [Index]+1 FROM MenuItems WHERE Id=@Id)
			UPDATE MenuItems
			SET [Index] = @MaxIndex + 1
			WHERE Id=@Id
			UPDATE MenuItems
			SET [Index] = [Index] - 1
			WHERE Id=@NextId
			UPDATE MenuItems
			SET [Index] = @NextIndex
			WHERE Id=@Id
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
	IF @ParentId IS NOT NULL AND @ParentId NOT IN (SELECT Id FROM MenuItems WHERE ParentId IS NULL OR ParentId='EF40FD3A-F889-4DC9-86E4-BC41413A87C0')
		SELECT 2 AS Successful	-- Invalid ParentId
	ELSE IF @ImageId IS NOT NULL AND @ImageId NOT IN (SELECT Id FROM Images)
		SELECT 3 AS Successful	-- Invalid ImageId
	ELSE IF @PageId IS NOT NULL AND @PageId NOT IN (SELECT Id FROM Page)
		SELECT 4 AS Successful	-- Invalid PageId
	ELSE IF EXISTS(SELECT * FROM MenuItems WHERE Id<>@Id AND Name=@Name)
		SELECT 5 AS Successful	-- Duplicated Name
	ELSE IF EXISTS(SELECT * FROM MenuItems WHERE Id=@Id)
	BEGIN
		UPDATE MenuItems SET
			Name = @Name,
			ParentId = @ParentId,
			Title = @Title,
			ToolTip = @ToolTip,
			ImageId = @ImageId,
			PageId = @PageId
		WHERE Id=@Id
		SELECT 1 AS Successful	-- Update successful
	END
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DECLARE @Index INT
				SELECT @Index=MAX([Index])+1 FROM MenuItems WHERE ParentId IS NULL AND @ParentId IS NULL OR ParentId=@ParentId
				IF @Index IS NULL
					SET @Index=0
				INSERT MenuItems(Id, Name, ParentId, Title, [Index], ToolTip, ImageId, PageId) VALUES(@Id, @Name, @ParentId, @Title, @Index, @ToolTip, @ImageId, @PageId)
				INSERT INTO RoleObjectScope(ObjectId, RoleId)VALUES(@Id, '212B9E56-6AD4-4612-B294-309E000DC4F6')
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
	SELECT Id, Name, ParentId, Title, [Index], ToolTip, ImageId, PageId FROM MenuItems
	WHERE ParentId IS NULL OR ParentId='EF40FD3A-F889-4DC9-86E4-BC41413A87C0' ORDER BY ParentId, [Index]
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
	IF EXISTS(SELECT * FROM MenuItems WHERE ParentId=@Id)
		SELECT 1 AS Successful
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DECLARE @ParentId UNIQUEIDENTIFIER
				DECLARE @Index INT
				SELECT @ParentId=ParentId, @Index=[Index] FROM MenuItems WHERE Id=@Id

				DELETE MenuItems WHERE Id=@Id
				UPDATE MenuItems SET [Index]=[Index]-1 WHERE (ParentId IS NULL AND @ParentId IS NULL OR ParentId=@ParentId) AND [Index]>@Index
				DELETE RoleObjectScope WHERE ObjectId=@Id
				
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
	IF EXISTS(SELECT ImageId FROM Button WHERE ImageId=@Id)
		SELECT 1 AS Successful
	ELSE IF EXISTS(SELECT ImageId FROM Page WHERE ImageId=@Id)
		SELECT 2 AS Successful
	ELSE IF EXISTS(SELECT ImageId FROM MenuItems WHERE ImageId=@Id)
		SELECT 3 AS Successful
	ELSE
	BEGIN
		DELETE [Images] WHERE Id=@Id
		SELECT 0 AS Successful
	END
END
GO
/****** Object:  StoredProcedure [dbo].[PleServerStream_InsertUpdate_HostId_ConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PleServerStream_InsertUpdate_HostId_ConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100),
	@StreamName VARCHAR(40),
	@PleServerIndex VARCHAR(8),
	@StreamEnabled BIT,
	@DestinationIP VARCHAR(16),
	@DestinationPort INT,
	@OutputMulticast BIT,
	@OutputMulticastIP VARCHAR(16),
	@OutputMulticastIFace VARCHAR(16),
	@MultiIPAddress VARCHAR(16)
AS
BEGIN
IF EXISTS(SELECT Id FROM PleServerStream WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName)
	UPDATE PleServerStream SET
	StreamName=@StreamName,
	PleServerIndex=@PleServerIndex,
	StreamEnabled=@StreamEnabled,
	DestinationIP=@DestinationIP,
	DestinationPort=@DestinationPort,
	ModifiedOn=CURRENT_TIMESTAMP,
	OutputMulticast=@OutputMulticast,
	OutputMulticastIP=@OutputMulticastIP,
	OutputMulticastIFace=@OutputMulticastIFace,
	MultiIPAddress=@MultiIPAddress,
	Deleted=0
	WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName
ELSE
	INSERT INTO PleServerStream(
	HostId,
	ConfigFileName,
	StreamName,
	PleServerIndex,
	StreamEnabled,
	DestinationIP,
	DestinationPort,
	ModifiedOn,
	OutputMulticast,
	OutputMulticastIP,
	OutputMulticastIFace,
	MultiIPAddress
	)
	VALUES(
	@HostId,
	@ConfigFileName,
	@StreamName,
	@PleServerIndex,
	@StreamEnabled,
	@DestinationIP,
	@DestinationPort,
	CURRENT_TIMESTAMP,
	@OutputMulticast,
	@OutputMulticastIP,
	@OutputMulticastIFace,
	@MultiIPAddress
	)
END
GO
/****** Object:  StoredProcedure [dbo].[PleServerStream_GetListByHostIdPleConfigFileName]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PleServerStream_GetListByHostIdPleConfigFileName]
	@HostId UNIQUEIDENTIFIER,
	@ConfigFileName VARCHAR(100)
AS
BEGIN
	SELECT [Id]
		  ,[HostId]
		  ,[ConfigFileName]
		  ,[StreamName]
		  ,[PleServerIndex]
		  ,[StreamEnabled]
		  ,[DestinationIP]
		  ,[DestinationPort]
		  ,[ModifiedOn]
		  ,[OutputMulticast]
		  ,[OutputMulticastIP]
		  ,[OutputMulticastIFace]
		  ,[MultiIPAddress]
	FROM [PleServerStream]
	WHERE HostId=@HostId AND ConfigFileName LIKE REPLACE(@ConfigFileName, '-config', '') + '_stream_%' AND Deleted=0
	ORDER BY ConfigFileName
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
	IF @PageId IS NULL OR @PageId NOT IN (SELECT Id FROM Page)
		SELECT 1 AS Successful
	ELSE IF @ButtonId IS NULL OR @ButtonId NOT IN (SELECT Id FROM Button)
		SELECT 2 AS Successful
	ELSE
	BEGIN
		UPDATE PageButton SET PageId=@PageId, ButtonId=@ButtonId, ToolTip=@ToolTip, RedirectPageId=@RedirectPageId WHERE Id=@Id
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
	SELECT @PageId=PageId, @ForGridUse=ForGridUse, @Index=[Index] FROM PageButton WHERE Id=@Id
	DECLARE @MaxIndexPlusOne INT
	SELECT @MaxIndexPlusOne = MAX([Index]) + 1 FROM PageButton WHERE PageId=@PageId
	IF @ForGridUse=0 AND @Up=1
	BEGIN	--up
		BEGIN TRY
			BEGIN TRANSACTION
				DECLARE @PrevId UNIQUEIDENTIFIER
				SELECT @PrevId=Id FROM PageButton WHERE PageId=@PageId AND ForGridUse=@ForGridUse AND [Index]=@Index-1
				UPDATE PageButton SET [Index]=@MaxIndexPlusOne WHERE Id=@Id
				UPDATE PageButton SET [Index]=[Index]+1 WHERE Id=@PrevId
				UPDATE PageButton SET [Index]=@Index-1 WHERE Id=@Id
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
	ELSE IF @ForGridUse=0 AND @Up=0
	BEGIN	--down
		BEGIN TRY
			BEGIN TRANSACTION
				DECLARE @NextId UNIQUEIDENTIFIER
				SELECT @NextId=Id FROM PageButton WHERE PageId=@PageId AND ForGridUse=@ForGridUse AND [Index]=@Index+1
				UPDATE PageButton SET [Index]=@MaxIndexPlusOne WHERE Id=@Id
				UPDATE PageButton SET [Index]=[Index]-1 WHERE Id=@NextId
				UPDATE PageButton SET [Index]=@Index+1 WHERE Id=@Id
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
	ELSE IF @ForGridUse=1
		SELECT 1 AS Successful
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
	@RedirectPageId UNIQUEIDENTIFIER=NULL,
	@ForGridUse BIT=0
AS
BEGIN
	IF @PageId IS NULL OR @PageId NOT IN (SELECT Id FROM Page)
		SELECT 1 AS Successful
	ELSE IF @ButtonId IS NULL OR @ButtonId NOT IN (SELECT Id FROM Button)
		SELECT 2 AS Successful
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DECLARE @Id UNIQUEIDENTIFIER
				DECLARE @Index INT
				SET @Id = NEWID()
				SELECT @Index=MAX([Index])+1 FROM PageButton WHERE PageId=@PageId AND ForGridUse=@ForGridUse
				IF @Index IS NULL
					SET @Index=0
				INSERT INTO PageButton(Id, PageId, ButtonId, [Index], ToolTip, RedirectPageId, ForGridUse) VALUES(@Id, @PageId, @ButtonId, @Index, @ToolTip, @RedirectPageId, @ForGridUse)
				IF @ForGridUse=0
					INSERT INTO RoleObjectScope(ObjectId, RoleId)
					SELECT @Id AS ObjectId, Id AS RoleId FROM Role WHERE CompanyId=(SELECT Id FROM Company WHERE IsMaster=1) AND Type=0 -- VALUES(@Id, '212B9E56-6AD4-4612-B294-309E000DC4F6')
				SELECT 0 AS Successful
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
				SELECT -2 AS Successful
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
	DECLARE @PageUrl VARCHAR(100)
	SELECT @PageUrl=Url FROM Page WHERE Id=(SELECT PageId FROM PageButton WHERE Id=@GridButtonId)
	SELECT Id,
	Name,
	Value
	FROM Scope 
	WHERE (((SELECT Id FROM Company WHERE IsMaster=1)=(SELECT CompanyId FROM [User] WHERE Id=@UserId)) OR Value<>(SELECT MAX(Value) FROM Scope))
	AND (Value<>1 OR (@PageUrl='Monitor.aspx') OR (@PageUrl='Scheduling.aspx'))
	ORDER BY Value
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
	SELECT Id, Name, CompanyId, Type FROM Role
	WHERE EXISTS(SELECT Name FROM Company WHERE Id=(SELECT CompanyId FROM [User] WHERE Id=@UserId) AND IsMaster=1)
	OR CompanyId=(SELECT CompanyId FROM [User] WHERE Id=@UserId)
	ORDER BY CompanyId, Type
END
GO
/****** Object:  StoredProcedure [dbo].[Role_GetListByObjectIdUserId]    Script Date: 09/07/2017 14:00:15 ******/
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
	IF @In=1
		SELECT Id, Name, CompanyId, Type FROM Role
		WHERE Id IN (SELECT RoleId FROM RoleObjectScope WHERE ObjectId=@ObjectId)
		AND ((SELECT Id FROM Company WHERE IsMaster=1)=(SELECT CompanyId FROM [User] WHERE Id=@UserId) OR CompanyId=(SELECT CompanyId FROM [User] WHERE Id=@UserId))
		AND Id NOT IN (SELECT Id FROM [Role] WHERE CompanyId=(SELECT Id FROM Company WHERE IsMaster=1) AND Type=0)
		-- Host System Administrators can't be removed, not showing
		ORDER BY CompanyId, Type
	ELSE
		SELECT Id, Name, CompanyId, Type FROM Role
		WHERE Id NOT IN (SELECT RoleId FROM RoleObjectScope WHERE ObjectId=@ObjectId)
		AND ((SELECT Id FROM Company WHERE IsMaster=1)=(SELECT CompanyId FROM [User] WHERE Id=@UserId) OR CompanyId=(SELECT CompanyId FROM [User] WHERE Id=@UserId))
		ORDER BY CompanyId, Type
END
GO
/****** Object:  StoredProcedure [dbo].[Company_DeleteById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Company_DeleteById]
	@Id	UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT CompanyId FROM [Host] WHERE CompanyId=@Id)
		SELECT 1 AS Successful
	ELSE IF EXISTS(SELECT CompanyId FROM [User] WHERE CompanyId=@Id)
		SELECT 2 AS Successful
	ELSE IF EXISTS(SELECT Name FROM Company WHERE Id=@Id AND IsMaster=1)
		SELECT 3 AS Successful
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DELETE Role WHERE CompanyId=@Id
				DELETE Company WHERE Id=@Id
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
/****** Object:  StoredProcedure [dbo].[Event_GetListByHostId_IntervalSecond]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_GetListByHostId_IntervalSecond]
	@HostId UNIQUEIDENTIFIER,
	@IntervalSecond INT
AS
BEGIN



SELECT [Id]								-- 0
      ,[Name]							-- 1
      ,[CompanyId]						-- 2
      ,[SourceDeviceId]					-- 3
      ,[DestinationDeviceId]			-- 4
      ,[StartTime]						-- 5
      ,[EndTime]						-- 6
      ,[CreatorId]						-- 7
      ,[CreatedOn]						-- 9
      ,[VideoProfileId]					--10
      ,[ParentId]						--11
      ,[RTT]							--12
      ,[PleClientStreamConfigId]		--13
      ,[PleServerStreamId]				--14
      ,PleServerConfigId				--15
      ,InputStreamId					--16
      ,OutputStreamId					--17
      ,DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond	--18
      ,CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond		--19
      ,SourceAcknowledgement				--20
      ,DestinationAcknowledgement			--21
      ,[StatusId]						--22
      ,VBitRate							--23
      ,AudioChannels					--24
      ,OwnerId							--25
      ,ActualStarted					--26
      ,ActualEnded						--27
      ,[ClosedCaption]					--28
      ,[SerialNumber]					--29
      ,[Tx]								--30
      ,[Rx]								--31
FROM [Event]
WHERE ([PleClientStreamConfigId] IN (SELECT Id FROM [PleClientStreamConfig] WHERE HostId=@HostId)
	OR [PleServerStreamId] IN (SELECT Id FROM [PleServerStream] WHERE HostId=@HostId))
AND (DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime)<@IntervalSecond AND (DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime)>-3600 OR EndTime IS NULL) )
AND [Status] < 4 OR [Status]=9-- UnStarted:0, Starting: 1, Started: 2, Stopping, 3
ORDER BY [StartTime], [EndTime]

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
SELECT [Id]								-- 0
      ,[Name]							-- 1
      ,[CompanyId]						-- 2
      ,[SourceDeviceId]					-- 3
      ,[DestinationDeviceId]			-- 4
      ,[StartTime]						-- 5
      ,[EndTime]						-- 6
      ,[CreatorId]						-- 7
      ,[CreatedOn]						-- 9
      ,[VideoProfileId]					--10
      ,[ParentId]						--11
      ,[RTT]							--12
      ,[PleClientStreamConfigId]		--13
      ,[PleServerStreamId]				--14
      ,PleServerConfigId				--15
      ,InputStreamId					--16
      ,OutputStreamId					--17
      ,DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond	--18
      ,CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond		--19
      ,SourceAcknowledgement			--20
      ,DestinationAcknowledgement		--21
      ,[StatusId]						--22
      ,VBitRate							--23
      ,AudioChannels					--24
      ,OwnerId							--25
      ,ActualStarted					--26
      ,ActualEnded						--27
      ,[ClosedCaption]					--28
      ,[SerialNumber]					--29
      ,[Tx]								--30
      ,[Rx]								--31
      ,CAST(0 AS BIT) AS AllDay
FROM [Event]
WHERE (PleClientStreamConfigId=@DeviceId OR PleServerConfigId=@DeviceId)
--AND ActualEnded IS NULL 
AND (Cancelled=0 OR Status<>6)
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
	UPDATE [Event]
	SET Tx = @Tx
 WHERE Id = @Id
END
GO
/****** Object:  StoredProcedure [dbo].[Event_UpdateStatusById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_UpdateStatusById]
	   @Id UNIQUEIDENTIFIER,
       @Status INT
AS
BEGIN
	UPDATE [Event]
	SET [Status] = @Status
	WHERE Id = @Id
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
	UPDATE [Event]
	SET Rx = @Rx
 WHERE Id = @Id
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
       @Cancelled BIT,
       @CreatedOn DATETIME,
       @VideoProfileId UNIQUEIDENTIFIER,
       @RTT INT,
       @PleClientStreamConfigId UNIQUEIDENTIFIER,
       @PleServerStreamId UNIQUEIDENTIFIER,
       @PleServerConfigId UNIQUEIDENTIFIER,
       @InputStreamId UNIQUEIDENTIFIER,
       @OutputStreamId UNIQUEIDENTIFIER,
       @SourceAcknowledgement INT,
       @DestinationAcknowledgement INT,
       @Status INT,
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
	UPDATE [Event]
	SET [Name] = @Name
      ,[CompanyId] = @CompanyId
      ,[SourceDeviceId] = @SourceDeviceId
      ,[DestinationDeviceId] = @DestinationDeviceId
      ,[StartTime] = @StartTime
      ,[EndTime] = @EndTime
      ,[CreatorId] = @CreatorId
      ,[CreatedOn] = @CreatedOn
      ,[VideoProfileId] = @VideoProfileId
      ,[RTT] = @RTT
      ,[PleClientStreamConfigId] = @PleClientStreamConfigId
      ,[PleServerStreamId] = @PleServerStreamId
      ,[PleServerConfigId] = @PleServerConfigId
      ,[InputStreamId] = @InputStreamId
      ,[OutputStreamId] = @OutputStreamId
      ,[SourceAcknowledgement] = @SourceAcknowledgement
      ,[DestinationAcknowledgement] = @DestinationAcknowledgement
      ,[StatusId] = @Status
      ,VBitRate = @VBitRate
      ,AudioChannels = @AudioChannels
      ,OwnerId = @OwnerId
      ,ActualStarted = @ActualStarted
      ,ActualEnded = @ActualEnded
 WHERE Id = @Id
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
	DECLARE @Id UNIQUEIDENTIFIER
	SELECT @Id=Id FROM InputStream WHERE HostId=@HostId AND ConfigFileName=@ConfigFileName
	IF @Id IS NOT NULL
	BEGIN
		IF EXISTS(SELECT Id FROM [Event] WHERE InputStreamId=@Id)
			UPDATE InputStream SET Deleted=1 WHERE Id=@Id
		ELSE
			DELETE InputStream WHERE Id=@Id
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
		SELECT Id, Name, ParentId, Title, [Index], ToolTip, ImageId, PageId
		FROM MenuItems
		WHERE Id IN(SELECT ObjectId FROM RoleObjectScope WHERE RoleId IN(SELECT RoleId FROM UserRole WHERE UserId=@UserId)) AND (ParentId IS NULL)
		ORDER BY [Index]
	ELSE
		SELECT Id, Name, ParentId, Title, [Index], ToolTip, ImageId, PageId
		FROM MenuItems
		WHERE Id IN(SELECT ObjectId FROM RoleObjectScope WHERE RoleId IN(SELECT RoleId FROM UserRole WHERE UserId=@UserId)) AND (ParentId=@ParentId)
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
SELECT [Id]
      ,[Name]
      ,[BrowserTitle]
      ,[PageTitle]
      ,[Url]
      ,[AvailableOnDashboard]
      ,[ImageId]
      ,(SELECT Url FROM Images WHERE Id=Page.ImageId) AS ImageUrl
FROM [Page]
WHERE Id IN(SELECT ObjectId FROM RoleObjectScope WHERE RoleId IN(SELECT RoleId FROM UserRole WHERE UserId=@UserId))
AND [AvailableOnDashboard]=1
OR Url='Dashboard.aspx'
ORDER BY Url
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
SELECT [Id]
      ,[Name]
      ,[BrowserTitle]
      ,[PageTitle]
      ,[Url]
      ,[AvailableOnDashboard]
      ,[ImageId]
      ,(SELECT Url FROM Images WHERE Id=Page.ImageId) AS ImageUrl
FROM [Page]
WHERE Id IN(SELECT ObjectId FROM RoleObjectScope WHERE RoleId IN(SELECT RoleId FROM UserRole WHERE UserId=@UserId))
AND Id NOT IN (SELECT ObjectId FROM UserDashboardItem WHERE UserId=@UserId)
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
	@RoleId UNIQUEIDENTIFIER
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM [Role] WHERE Id=@RoleId AND [Type]=0) OR (SELECT COUNT(*) FROM UserRole WHERE RoleId=@RoleId)>1
		DELETE UserRole WHERE UserId=@UserId AND RoleId=@RoleId
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
			DELETE RoleObjectScope WHERE RoleId=@Id
			DELETE RolePermissionScopeEntity WHERE RoleId=@Id
			DELETE UserRole WHERE RoleId=@Id
			DELETE Role WHERE Id=@Id
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
GO
/****** Object:  StoredProcedure [dbo].[Role_AddUser]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Role_AddUser]
	@UserId	UNIQUEIDENTIFIER,
	@RoleId UNIQUEIDENTIFIER
AS
BEGIN
	INSERT INTO UserRole(UserId, RoleId)VALUES(@UserId, @RoleId)
END
GO
/****** Object:  StoredProcedure [dbo].[PleClientStreamConfig_GetListWithHostNameByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PleClientStreamConfig_GetListWithHostNameByUserId]
	@UserId UNIQUEIDENTIFIER,
	@Type INT = 0
	-- 0: for create event
	-- 1: for grid filter
AS
BEGIN
	SELECT Id, (SELECT Name FROM Host WHERE Id=PleClientStreamConfig.HostId)+': '+InputName AS Name
	FROM PleClientStreamConfig
	WHERE (HostId IN (SELECT Id FROM [Host] WHERE CompanyId = (SELECT CompanyId FROM [User] WHERE Id=@UserId))
	OR (SELECT Id FROM Company WHERE IsMaster=1) = (SELECT CompanyId FROM [User] WHERE Id=@UserId)
	OR Id IN (SELECT PleClientStreamConfigId FROM [Event] WHERE CompanyId = (SELECT CompanyId FROM [User] WHERE Id=@UserId)) AND @Type=1
	OR Id IN (SELECT DeviceId FROM DeviceSharedToCompany WHERE CompanyId = (SELECT CompanyId FROM [User] WHERE Id=@UserId)) AND @Type=2
	) 
	AND Deleted=0
	ORDER BY Name
END
GO
/****** Object:  StoredProcedure [dbo].[PleServerConfig_GetListWithHostNameByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PleServerConfig_GetListWithHostNameByUserId]
	@UserId UNIQUEIDENTIFIER,
	@Type INT = 0
	-- 0: for create event
	-- 1: for grid filter
AS
BEGIN
	SELECT Id, (SELECT Name FROM Host WHERE Id=PleServerConfig.HostId)+': '+InputName AS Name
	FROM PleServerConfig
	WHERE (HostId IN (SELECT Id FROM [Host] WHERE CompanyId = (SELECT CompanyId FROM [User] WHERE Id=@UserId))
	OR (SELECT Id FROM Company WHERE IsMaster=1) = (SELECT CompanyId FROM [User] WHERE Id=@UserId)
	OR Id IN (SELECT PleServerConfigId FROM [Event] WHERE CompanyId = (SELECT CompanyId FROM [User] WHERE Id=@UserId)) AND @Type=1
	OR Id IN (SELECT DeviceId FROM DeviceSharedToCompany WHERE CompanyId = (SELECT CompanyId FROM [User] WHERE Id=@UserId)) AND @Type=2
	)
	AND Deleted=0
	ORDER BY Name
END
GO
/****** Object:  StoredProcedure [dbo].[User_GetListByRoleId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[User_GetListByRoleId]
	@RoleId UNIQUEIDENTIFIER,
	@In BIT = 1
AS
BEGIN
	IF @In=1
		SELECT [Id]
		  ,[Name]
		  ,[Password]
		  ,[PersonId]
		  ,[CompanyId]
		  ,[Registered]
		  ,[PageId]
		  ,[DateFormatId]
		FROM [User]
		WHERE Id IN 
		(
			SELECT UserId FROM UserRole WHERE RoleId=@RoleId
		)
		AND CompanyId=(SELECT CompanyId FROM [Role] WHERE Id=@RoleId)
		ORDER BY Name
	ELSE
		SELECT [Id]
		  ,[Name]
		  ,[Password]
		  ,[PersonId]
		  ,[CompanyId]
		  ,[Registered]
		  ,[PageId]
		  ,[DateFormatId]
		FROM [User]
		WHERE Id NOT IN 
		(
			SELECT UserId FROM UserRole WHERE RoleId=@RoleId
		)
		AND CompanyId=(SELECT CompanyId FROM [Role] WHERE Id=@RoleId)
		ORDER BY Name
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
	IF EXISTS(SELECT * FROM [Event] WHERE CreatorId=@Id OR OwnerId=@Id)
		SELECT 1 AS Success
	ELSE IF EXISTS(SELECT * FROM EventHostory WHERE UserId=@Id)
		SELECT 2 AS Success
	ELSE IF EXISTS(SELECT * FROM HostHistory WHERE UserId=@Id)
		SELECT 3 AS Success
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DECLARE @PersonId UNIQUEIDENTIFIER
				SELECT @PersonId=PersonId FROM [User] WHERE Id=@Id
				DELETE UserRole WHERE UserId=@Id
				DELETE UserSetting WHERE UserId=@Id
				DELETE UserDashboardItem WHERE UserId=@Id
				DELETE [User] WHERE Id=@Id
				DELETE Phone WHERE PersonId=@PersonId
				DELETE [Address] WHERE Id=(SELECT AddressId FROM Person WHERE Id=@PersonId)
				DELETE Person WHERE Id=@PersonId
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
	IF @In=1
		SELECT Id, Name, CompanyId, Type FROM Role
		WHERE Id IN (SELECT RoleId FROM UserRole WHERE UserId=@UserId)
		AND CompanyId=(SELECT CompanyId FROM [User] WHERE Id=@UserId)
		AND Type<>1
		ORDER BY Name
	ELSE
		SELECT Id, Name, CompanyId, Type FROM Role
		WHERE Id NOT IN (SELECT RoleId FROM UserRole WHERE UserId=@UserId)
		AND CompanyId=(SELECT CompanyId FROM [User] WHERE Id=@UserId)
		AND Type<>1
		ORDER BY Name
END
GO
/****** Object:  StoredProcedure [dbo].[UserPerson_IsertUpdate]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserPerson_IsertUpdate]
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
	@Prifix VARCHAR(50),
	@Suffix VARCHAR(50),
	@Email VARCHAR(250),
	@AddressId UNIQUEIDENTIFIER = NULL
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM [User] WHERE Id=@Id)
	BEGIN
		BEGIN TRY
			INSERT INTO Person(Id, FirstName, LastName, MiddleName, Prifix, Suffix, Email, AddressId)
			VALUES(@PersonId, @FirstName, @LastName, @MiddleName, @Prifix, @Suffix, @Email, @AddressId)
			INSERT INTO [User](Id, Name, [Password], PersonId, CompanyId, Registered, PageId, DateFormatId, [Enabled], EventNotifications)
			VALUES(@Id, @Name, @Password, @PersonId, @CompanyId, GETDATE(), @PageId, @DateFormatId, @Enabled, @EventNotifications)
			INSERT UserRole(UserId, RoleId)
			SELECT @Id AS UserId, Id AS RoleId FROM [Role] WHERE CompanyId=@CompanyId AND Name='Everyone'
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
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				UPDATE [User]
				SET Name = @Name,
				[Password] = @Password,
				PageId = @PageId,
				DateFormatId = @DateFormatId,
				[Enabled] = @Enabled,
				EventNotifications = @EventNotifications
				WHERE Id = @Id
				
				UPDATE Person
				SET FirstName = @FirstName,
				LastName = @LastName,
				MiddleName = @MiddleName,
				Prifix = @Prifix,
				Suffix = @Suffix,
				Email = @Email,
				AddressId = @AddressId
				WHERE Id = @PersonId
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
/****** Object:  StoredProcedure [dbo].[UserDashboardItem_UpdateById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserDashboardItem_UpdateById]
	@Id UNIQUEIDENTIFIER,
	@ObjectId UNIQUEIDENTIFIER
AS
BEGIN
	UPDATE [UserDashboardItem] SET ObjectId=@ObjectId WHERE Id=@Id
END
GO
/****** Object:  StoredProcedure [dbo].[UserDashboardItem_MoveUpDownById]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserDashboardItem_MoveUpDownById]
	@Id UNIQUEIDENTIFIER,
	@UpDown INT --0: up; 1: down
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			DECLARE @MaxIndex INT
			DECLARE @Index INT
			DECLARE @NeiborId UNIQUEIDENTIFIER
			DECLARE @UserId UNIQUEIDENTIFIER
			SELECT @UserId=UserId, @Index=[Index] FROM [UserDashboardItem] WHERE Id=@Id 
			SELECT @MaxIndex=MAX([Index]) + 1 FROM [UserDashboardItem] WHERE UserId=@UserId
			UPDATE [UserDashboardItem] SET [Index]=@MaxIndex WHERE Id=@Id

			IF @UpDown=0 --up
			BEGIN
				UPDATE [UserDashboardItem] SET [Index]=@Index FROM [UserDashboardItem] WHERE UserId=@UserId AND [Index]=@Index-1
				UPDATE [UserDashboardItem] SET [Index]=@Index-1 WHERE Id=@Id
			END
			ELSE -- down
			BEGIN
				UPDATE [UserDashboardItem] SET [Index]=@Index FROM [UserDashboardItem] WHERE UserId=@UserId AND [Index]=@Index+1
				UPDATE [UserDashboardItem] SET [Index]=@Index+1 WHERE Id=@Id
			END
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
/****** Object:  StoredProcedure [dbo].[UserDashboardItem_Insert]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserDashboardItem_Insert]
	@UserId UNIQUEIDENTIFIER,
	@ObjectId UNIQUEIDENTIFIER
AS
BEGIN
	IF EXISTS(SELECT * FROM [UserDashboardItem] WHERE UserId=@UserId AND ObjectId=@ObjectId)
		SELECT 1 AS Successful
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DECLARE @Index INT
				IF EXISTS(SELECT * FROM [UserDashboardItem] WHERE UserId=@UserId)
					SELECT @Index=MAX([Index]) + 1 FROM [UserDashboardItem] WHERE UserId=@UserId
				ELSE
					SET @Index = 0

				INSERT [UserDashboardItem](Id, UserId, ObjectId, [Index]) VALUES(NEWID(), @UserId, @ObjectId, @Index)
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
/****** Object:  StoredProcedure [dbo].[UserDashboardItem_GetListByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UserDashboardItem_GetListByUserId]
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT [UserDashboardItem].[Id]
		  ,[UserDashboardItem].[UserId]
		  ,[UserDashboardItem].[ObjectId]
		  ,[UserDashboardItem].[Index]
		  ,Page.ImageId
		  ,Page.Url AS NavigateURL
		  ,Page.Name
		  ,Images.Url AS ImageUrl
		  ,(SELECT MIN([MinDashboardItem].[Index]) FROM [UserDashboardItem] [MinDashboardItem] WHERE [MinDashboardItem].UserId = [UserDashboardItem].UserId) AS [MinIndex]
		  ,(SELECT MAX([MinDashboardItem].[Index]) FROM [UserDashboardItem] [MinDashboardItem] WHERE [MinDashboardItem].UserId = [UserDashboardItem].UserId) AS [MaxIndex]
	FROM [UserDashboardItem]
	LEFT JOIN Page INNER JOIN Images ON Images.Id=Page.ImageId ON Page.Id = [UserDashboardItem].[ObjectId]
	WHERE UserId=@UserId
	AND Page.[AvailableOnDashboard]=1
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
			SELECT @UserId=UserId, @Index=[Index] FROM [UserDashboardItem] WHERE Id=@Id
			DELETE [UserDashboardItem] WHERE Id=@Id
			UPDATE [UserDashboardItem] SET [Index]=[Index]-1 WHERE UserId=@UserId AND [Index]>@Index
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
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id FROM Page WHERE Url=@PageName
	DECLARE @PageButtonId UNIQUEIDENTIFIER
	SELECT @PageButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name=@ButtonName) AND ForGridUse=1
	SELECT dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @PageButtonId) AS ButtonScope
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
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id FROM Page WHERE Url='Users.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	DECLARE @RolesButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Delete') AND ForGridUse=1
	SELECT @RolesButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Roles') AND ForGridUse=1
	SELECT [User].Id
	, [User].Name AS UserName
	, [User].CompanyId
	, [User].Registered
	, [User].Enabled
	, [User].DateFormatId
	, [User].Enabled
	, [User].EventNotifications
	, View_Person_FullName_Email.Name
	, View_Person_FullName_Email.Email
	, View_Person_FullName_Email.PhoneCountryId
	, View_Person_FullName_Email.AreaCode
	, View_Person_FullName_Email.Number
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @RolesButtonId) AS RolesButton
	FROM [User]
	INNER JOIN View_Person_FullName_Email ON View_Person_FullName_Email.Id=[User].PersonId
	WHERE CompanyId = (SELECT CompanyId FROM [User] WHERE Id=@UserId) 
	OR (SELECT Id FROM Company WHERE IsMaster=1) = (SELECT CompanyId FROM [User] WHERE Id=@UserId)
	ORDER BY CompanyId, UserName, Registered
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
	DECLARE @ButtonPageId UNIQUEIDENTIFIER
	SELECT @ButtonPageId=Id FROM Page WHERE Url='SystemSettings.aspx'
	DECLARE @AddButtonId UNIQUEIDENTIFIER
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	SELECT @AddButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Add') AND ForGridUse=1
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Delete') AND ForGridUse=1
	SELECT Id, Name, INTValue, StringValue 
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @AddButtonId) AS AddButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
	FROM Configuration ORDER BY Name
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
	DECLARE @ButtonPageId UNIQUEIDENTIFIER
	SELECT @ButtonPageId=Id FROM Page WHERE Url='GridButtonRoles.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT Id, Name, CompanyId, Type,
	CASE WHEN EXISTS(SELECT * FROM RoleObjectScope WHERE RoleId=Role.Id AND RoleObjectScope.ObjectId=@GridButtonId)
		THEN (SELECT TOP 1 Scope.Id FROM Scope INNER JOIN RoleObjectScope ON RoleObjectScope.ScopeId=Scope.Id WHERE RoleObjectScope.RoleId=Role.Id AND RoleObjectScope.ObjectId=@GridButtonId ORDER BY Scope.Value)
		ELSE (SELECT Id FROM Scope WHERE Value=0) END AS ScopeId
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
	FROM Role
	WHERE (SELECT Id FROM Company WHERE IsMaster=1)=(SELECT CompanyId FROM [User] WHERE Id=@UserId) OR CompanyId=(SELECT CompanyId FROM [User] WHERE Id=@UserId)
	ORDER BY CompanyId, Type
END
GO
/****** Object:  StoredProcedure [dbo].[PageButton_GetListByPageIdUserIdPageGrid]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PageButton_GetListByPageIdUserIdPageGrid]
	@PageId UNIQUEIDENTIFIER,
	@UserId UNIQUEIDENTIFIER,
	@PageGrid INT = 2	--2: all; 1:Grid Button only; o: Page Button only
AS
BEGIN
	DECLARE @ButtonPageId UNIQUEIDENTIFIER
	SELECT @ButtonPageId=Id FROM Page WHERE Url='PageButtons.aspx'
	DECLARE @AddButtonId UNIQUEIDENTIFIER
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	DECLARE @PageButtonRolesButtonId UNIQUEIDENTIFIER
	DECLARE @MoveDownButtonId UNIQUEIDENTIFIER
	DECLARE @MoveUpButtonId UNIQUEIDENTIFIER
	DECLARE @NewGridButtonId UNIQUEIDENTIFIER
	DECLARE @GridEditButtonId UNIQUEIDENTIFIER
	DECLARE @GridDeleteButtonId UNIQUEIDENTIFIER
	DECLARE @GridButtonRolesButtonId UNIQUEIDENTIFIER
	SELECT @AddButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Add') AND ForGridUse=1
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Delete') AND ForGridUse=1
	SELECT @PageButtonRolesButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='PageButtonRoles') AND ForGridUse=1
	SELECT @MoveDownButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Move Down') AND ForGridUse=1
	SELECT @MoveUpButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Move Up') AND ForGridUse=1
	SELECT @NewGridButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='NewGridButton') AND ForGridUse=1
	SELECT @GridEditButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='GridEdit') AND ForGridUse=1
	SELECT @GridDeleteButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='GridDelete') AND ForGridUse=1
	SELECT @GridButtonRolesButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Grid Button Roles') AND ForGridUse=1
	SELECT Id, 
	PageId, 
	ButtonId, 
	[Index], 
	ToolTip, 
	CASE WHEN (SELECT IsHome FROM Button WHERE Id=PageButton.ButtonId)=1 THEN (SELECT PageId FROM [User] WHERE Id=@UserId) ELSE RedirectPageId END AS RedirectPageId
	, ForGridUse 
	,(SELECT MIN([Index]) FROM [PageButton] WHERE PageId=@PageId AND ForGridUse=0) AS [MinIndex]
	,(SELECT MAX([Index]) FROM [PageButton] WHERE PageId=@PageId AND ForGridUse=0) AS [MaxIndex]
	,(SELECT Images.Url FROM Images INNER JOIN Button ON Button.ImageId=Images.Id WHERE Button.Id=PageButton.ButtonId) AS ImageUrl
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @AddButtonId) AS AddButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @PageButtonRolesButtonId) AS PageButtonRolesButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @MoveDownButtonId) AS MoveDownButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @MoveUpButtonId) AS MoveUpButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @NewGridButtonId) AS NewGridButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @GridEditButtonId) AS GridEditButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @GridDeleteButtonId) AS GridDeleteButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @GridButtonRolesButtonId) AS GridButtonRolesButton
	FROM PageButton 
	WHERE (Id IN(SELECT ObjectId FROM RoleObjectScope WHERE RoleId IN(SELECT RoleId FROM UserRole WHERE UserId=@UserId)) OR ForGridUse=1) AND PageId=@PageId 
	AND (@PageGrid=2 OR @PageGrid=0 AND ForGridUse=0 OR @PageGrid=1 AND ForGridUse=1)
	ORDER BY ForGridUse, [Index]
END
GO
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
	IF EXISTS(SELECT * FROM Page WHERE Id<>@Id AND Name=@Name)
		SELECT 2 AS Successful
	ELSE IF @ImageId IS NOT NULL AND @ImageId NOT IN (SELECT Id FROM Images)
		SELECT 3 AS Successful	-- Invalid ImageId
	ELSE
	BEGIN
		BEGIN TRY
			IF EXISTS(SELECT * FROM Page WHERE Id=@Id) --UPDATE
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
					SELECT Id FROM UserDashboardItem WHERE ObjectId=@Id
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
				SELECT 1 AS Successful	-- Update successful
			END
			ELSE
			BEGIN
					INSERT INTO Page(Id, Name, BrowserTitle, PageTitle, Url, AvailableOnDashboard, ImageId)
					VALUES(@Id, @Name, @BrowserTitle, @PageTitle, @Url, @AvailableOnDashboard, @ImageId)
					INSERT INTO RoleObjectScope(ObjectId, RoleId)VALUES(@Id, '212B9E56-6AD4-4612-B294-309E000DC4F6')
					SELECT 0 AS Successful
			END
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
	SELECT @PageId=Id FROM Page WHERE Url='Pages.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	DECLARE @RolesButtonId UNIQUEIDENTIFIER
	DECLARE @PageButtonsButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Delete') AND ForGridUse=1
	SELECT @RolesButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Roles') AND ForGridUse=1
	SELECT @PageButtonsButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='PageButtons') AND ForGridUse=1
	SELECT [Id]
		  ,[Name]
		  ,[BrowserTitle]
		  ,[PageTitle]
		  ,[Url]
		  ,[AvailableOnDashboard]
		  ,[ImageId]
		  ,(SELECT Url FROM Images WHERE Id=Page.ImageId) AS ImageUrl
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @RolesButtonId) AS RolesButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @PageButtonsButtonId) AS PageButtonsButton
	FROM [Page]
	WHERE Id IN(SELECT ObjectId FROM RoleObjectScope WHERE RoleId IN(SELECT RoleId FROM UserRole WHERE UserId=@UserId))
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
	IF EXISTS(SELECT * FROM MenuItems WHERE PageId=@Id)
		SELECT 1 AS Successful
	ELSE IF EXISTS(SELECT * FROM [User] WHERE PageId=@Id)
		SELECT 2 AS Successful
	--ELSE IF EXISTS(SELECT * FROM Grid WHERE PageId=@Id)
	--	SELECT 3 AS Successful
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
				DELETE RoleObjectScope WHERE ObjectId IN (SELECT Id FROM PageButton WHERE PageId=@Id)
				DELETE PageButton WHERE PageId=@Id OR RedirectPageId=@Id
				DELETE Grid WHERE PageId=@Id
				DELETE RoleObjectScope WHERE ObjectId=Id
					DECLARE @UserDashboardItemId UNIQUEIDENTIFIER
					DECLARE UserDashboardItem_Cursor CURSOR FOR
					SELECT Id FROM UserDashboardItem WHERE ObjectId=@Id
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

				SELECT 0 AS Successful

			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
					CLOSE UserDashboardItem_Cursor
					DEALLOCATE UserDashboardItem_Cursor
				ROLLBACK TRANSACTION
				SELECT -2 AS Successful
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
	SELECT @PageId=Id FROM Page WHERE Url='MenuItems.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	DECLARE @RolesButtonId UNIQUEIDENTIFIER
	DECLARE @MoveDownButtonId UNIQUEIDENTIFIER
	DECLARE @MoveUpButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Delete') AND ForGridUse=1
	SELECT @RolesButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Roles') AND ForGridUse=1
	SELECT @MoveDownButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Move Down') AND ForGridUse=1
	SELECT @MoveUpButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Move Up') AND ForGridUse=1
	SELECT Id, Name, ParentId, Title, [Index], ToolTip, ImageId, PageId,
			(SELECT MIN([MinMenuItem].[Index]) FROM [MenuItems] [MinMenuItem] WHERE [MinMenuItem].[ParentId] = [MenuItems].[ParentId]) AS [MinIndex],
			(SELECT MAX([MaxMenuItem].[Index]) FROM [MenuItems] [MaxMenuItem] WHERE [MaxMenuItem].[ParentId] = [MenuItems].[ParentId]) AS [MaxIndex],
			(SELECT COUNT(*) FROM [MenuItems] [Children] WHERE [Children].[ParentId] = [MenuItems].[Id]) AS [Children],
			(CASE
				WHEN [MenuItems].[ParentId] IN (SELECT [RootItem].[Id] FROM [MenuItems] [RootItem] WHERE UPPER(LTRIM(RTRIM([RootItem].[Name]))) = 'ROOT') THEN
					([MenuItems].[Index] * 1000)
				ELSE
					(((SELECT [ParentItem].[Index] FROM [MenuItems] [ParentItem] WHERE [ParentItem].[Id] = [MenuItems].[ParentId]) * 1000) + [MenuItems].[Index] + 1)
				END) AS [SortIndex],
		(SELECT Url FROM Images WHERE Id=MenuItems.ImageId) AS ImageUrl
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @RolesButtonId) AS RolesButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @MoveDownButtonId) AS MoveDownButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @MoveUpButtonId) AS MoveUpButton
	FROM MenuItems
	WHERE Id IN(SELECT ObjectId FROM RoleObjectScope WHERE RoleId IN(SELECT RoleId FROM UserRole WHERE UserId=@UserId)) AND (ParentId IS NOT NULL) 
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
	SELECT @PageId=Id FROM Page WHERE Url='Host.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @ToolButtonId UNIQUEIDENTIFIER
	DECLARE @APIButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @ToolButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Tool Destination') AND ForGridUse=1
	SELECT @APIButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='API') AND ForGridUse=1
	SELECT [Id]
      ,[Name]
      ,[SerialNumber]
      ,[CompanyId]
      ,[LicenseKey]
      ,[IPAddress]
      ,[MacAddress]
      ,[Version]
      ,TunnelIP
      ,[ApiPort]
      ,[ApiPassword]
      ,[LanIPAddress]
      ,[LastCheckin]
      ,CASE WHEN DATEDIFF(minute, LastCheckin, CURRENT_TIMESTAMP)>20 THEN 'Red' WHEN DATEDIFF(minute, LastCheckin, CURRENT_TIMESTAMP)>5 AND DATEDIFF(minute, LastCheckin, CURRENT_TIMESTAMP)<=20 THEN 'Yellow' ELSE 'Green' END AS [Status]
      ,CASE WHEN IPAddress IS NULL THEN '' ELSE IPAddress END + '|' + CASE WHEN TunnelIP IS NULL THEN '' ELSE TunnelIP END AS WebGuiAddresses
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @ToolButtonId) AS ToolButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @APIButtonId) AS APIButton
	FROM [Host]
	WHERE ([CompanyId] = (SELECT CompanyId FROM [User] WHERE Id=@UserId) OR (SELECT Id FROM Company WHERE IsMaster=1)=(SELECT CompanyId FROM [User] WHERE Id=@UserId))
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
	SELECT @PageId=Id FROM Page WHERE Url='Images.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Delete') AND ForGridUse=1
	SELECT [Id]								-- 0
		  ,[Name]							-- 1
		  ,[Url]						-- 2
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
	FROM [Images]
	WHERE ((SELECT Id FROM Company WHERE IsMaster=1)=(SELECT CompanyId FROM [User] WHERE Id=@UserId))
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
		  ,[EventId]
		  ,[UserId]
		  ,[ModifiedOn]
		  ,[EventActionId]
		  ,ClosedCaption
		  ,Name
		  ,StartTime
		  ,EndTime
		  ,OwnerId
		  ,VideoProfileId
		  ,VBitRate
		  ,AudioChannels
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
       @PleClientStreamConfigId UNIQUEIDENTIFIER,
       @PleServerStreamId UNIQUEIDENTIFIER,
       @PleServerConfigId UNIQUEIDENTIFIER,
       @InputStreamId UNIQUEIDENTIFIER,
       @OutputStreamId UNIQUEIDENTIFIER,
       @SourceAcknowledgement INT,
       @DestinationAcknowledgement INT,
       @Status INT,
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

	IF EXISTS
	(
		SELECT [Name] FROM [Event] 
		WHERE (PleClientStreamConfigId=@PleClientStreamConfigId OR PleServerConfigId=@PleServerConfigId) AND [Cancelled]=0 AND 
			(
				@StartTime>=[StartTime] AND (@StartTime<=[EndTime] OR ([EndTime] IS NULL AND ActualEnded IS NULL)) OR
				@EndTime>[StartTime] AND (@EndTime<=[EndTime] OR [EndTime] IS NULL AND ActualEnded IS NULL) OR
				@StartTime<=[StartTime] AND (@EndTime>=[EndTime] OR @EndTime IS NULL) OR
				([EndTime] IS NULL OR @StartTime<=[EndTime]) AND @EndTime IS NULL
			)
	)
		SELECT CAST(0 AS BIT) AS Successful
	ELSE
	BEGIN
		BEGIN TRY
			BEGIN TRANSACTION
			DECLARE @EventActionId UNIQUEIDENTIFIER
			SELECT @EventActionId=Id FROM EventAction WHERE [Name]='Schedule'
			INSERT INTO [Event](
				   [Id]
				   ,[Name]
				   ,[CompanyId]
				   ,[SourceDeviceId]
				   ,[DestinationDeviceId]
				   ,[StartTime]
				   ,[EndTime]
				   ,[CreatorId]
				   ,[Cancelled]
				   ,[CreatedOn]
				   ,[VideoProfileId]
				   ,[ParentId]
				   ,[RTT]
				   ,[PleClientStreamConfigId]
				   ,[PleServerStreamId]
				   ,[PleServerConfigId]
				   ,[InputStreamId]
				   ,[OutputStreamId]
				   ,[SourceAcknowledgement]
				   ,[DestinationAcknowledgement]
				   ,[Status]
				   ,VBitRate
				   ,AudioChannels
				   ,OwnerId,
				   ActualStarted,
				   ActualEnded,
				   ClosedCaption,
				   Tx,
				   Rx
			   )
			 VALUES
			 (
				   @Id,
				   @Name,
				   @CompanyId,
				   @SourceDeviceId,
				   @DestinationDeviceId,
				   @StartTime,
				   @EndTime,
				   @CreatorId,
				   @Cancelled,
				   @CreatedOn,
				   @VideoProfileId,
				   @ParentId,
				   @RTT,
				   @PleClientStreamConfigId,
				   @PleServerStreamId,
				   @PleServerConfigId,
				   @InputStreamId,
				   @OutputStreamId,
				   @SourceAcknowledgement,
				   @DestinationAcknowledgement,
				   @Status,
				   @VBitRate,
				   @AudioChannels,
				   @OwnerId,
				   @ActualStarted,
				   @ActualEnded,
				   @ClosedCaption,
				   @Tx,
				   @Rx
				)
				INSERT INTO EventHistory
				(
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
					[AudioChannels]
				)
				VALUES
				(
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
					@AudioChannels
				)
			SELECT CAST(1 AS BIT) AS Successful
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			IF @@TRANCOUNT > 0
			BEGIN
				ROLLBACK TRANSACTION
				SELECT CAST(0 AS BIT) AS Successful
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
			
			UPDATE [Event] 
			SET [Status]=(SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Goodnighting') 
			WHERE Id=@EventId
			
			INSERT INTO EventHistory
			(
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
				[AudioChannels]
			)
			SELECT NEWID() AS Id,
				Id AS EventId,
				@UserId,
				GETDATE() AS ModifiedOn,
				(SELECT Id FROM EventAction WHERE [Name]='Goodnight') AS EventActionId,
				[ClosedCaption],
				[Name],
				[StartTime],
				GETDATE() AS [EndTime],
				[OwnerId],
				[VideoProfileId],
				[VBitRate],
				[AudioChannels]
			FROM [Event] WHERE Id=@EventId
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
				
			DECLARE @PleClientStreamConfigId UNIQUEIDENTIFIER
			DECLARE @PleServerConfigId UNIQUEIDENTIFIER
			SELECT @PleClientStreamConfigId=PleClientStreamConfigId,
				@PleServerConfigId=PleServerConfigId
				FROM [Event] WHERE Id=@EventId
			IF EXISTS
			(
				SELECT [Name] FROM [Event] 
				WHERE (PleClientStreamConfigId=@PleClientStreamConfigId OR PleServerConfigId=@PleServerConfigId) AND Id<>@EventId AND [Cancelled]=0 AND 
					(
						@StartTime>=[StartTime] AND (@StartTime<=[EndTime] OR ([EndTime] IS NULL AND ActualEnded IS NULL)) OR
						@EndTime>[StartTime] AND (@EndTime<=[EndTime] OR [EndTime] IS NULL AND ActualEnded IS NULL) OR
						@StartTime<=[StartTime] AND (@EndTime>=[EndTime] OR @EndTime IS NULL) OR
						([EndTime] IS NULL OR @StartTime<=[EndTime]) AND @EndTime IS NULL
					)
			)
				SELECT 1 AS Successful
			ELSE
			BEGIN
				UPDATE [Event]
				SET Name=@Name, 
				   StartTime=@StartTime,
				   EndTime=@EndTime,
				   VideoProfileId=@VideoProfileId,
				   VBitRate=@VBitRate,
				   AudioChannels=@AudioChannels,
				   OwnerId=@OwnerId
				WHERE Id=@EventId
				INSERT INTO EventHistory
				(
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
					[AudioChannels]
				)
				SELECT NEWID() AS Id,
					Id AS EventId,
					@UserId,
					GETDATE() AS ModifiedOn,
					(SELECT Id FROM EventAction WHERE [Name]='Update') AS EventActionId,
					[ClosedCaption],
					[Name],
					[StartTime],
					[EndTime],
					[OwnerId],
					[VideoProfileId],
					[VBitRate],
					[AudioChannels]
				FROM [Event] WHERE Id=@EventId
				SELECT 0 AS Successful
			END
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
/****** Object:  StoredProcedure [dbo].[Event_GetListByUserIdStatusPageUrl]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_GetListByUserIdStatusPageUrl]
	@UserId UNIQUEIDENTIFIER,
	@Status INT = 0,
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
	
	DECLARE @Status_Running INT = 1
	DECLARE @Status_Future INT = 2
	DECLARE @Status_Past INT = 3
	DECLARE @Status_Cancelled INT = 4
	DECLARE @Status_Cleared INT = 5
	
	DECLARE @All_Id INT
	DECLARE @Scheduled_Id INT
	DECLARE @Starting_Id INT
	DECLARE @Started_Id INT
	DECLARE @Stopping_Id INT
	DECLARE @Stopped_Id INT
	DECLARE @Goodnighting_Id INT
	DECLARE @Goodnighted_Id INT
	DECLARE @Clearing_Id INT
	DECLARE @Cleared_Id INT
	DECLARE @Cancelled_Id INT
	
	SELECT @All_Id=[Id]			FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'All'
	SELECT @Scheduled_Id=[Id]	FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Scheduled'
	SELECT @Starting_Id=Id		FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Starting'
	SELECT @Started_Id=Id		FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Started'
	SELECT @Stopping_Id=Id		FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Stopping'
	SELECT @Stopped_Id=Id		FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Stopped'
	SELECT @Goodnighting_Id=Id	FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Goodnighting'
	SELECT @Goodnighted_Id=Id	FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Goodnighted'
	SELECT @Clearing_Id=Id		FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Clearing'
	SELECT @Cleared_Id=Id		FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Cleared'
	SELECT @Cancelled_Id=Id		FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Cancelled'
	
	-- Index of the text to be shown in the "Status" field in every row
	DECLARE @Scheduling_Status_Running INT		= 0
	DECLARE @Scheduling_Status_Future INT		= 1
	DECLARE @Scheduling_Status_Past INT			= 2
	DECLARE @Scheduling_Status_Cancelled INT	= 3
	DECLARE @Scheduling_Status_Cleared INT		= 4
	
	-- End

	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id FROM Page WHERE Url=@PageUrl
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @CancelButtonId UNIQUEIDENTIFIER
	DECLARE @GoodnightButtonId UNIQUEIDENTIFIER
	DECLARE @ExtendButtonId UNIQUEIDENTIFIER
	DECLARE @ConnectionButtonId UNIQUEIDENTIFIER
	DECLARE @VideoButtonId UNIQUEIDENTIFIER
	DECLARE @ClearButtonId UNIQUEIDENTIFIER
	DECLARE @RestartEncoderButtonId UNIQUEIDENTIFIER
	DECLARE @ToolSourceButtonId UNIQUEIDENTIFIER
	DECLARE @ToolDestinationButtonId UNIQUEIDENTIFIER
	DECLARE @LogButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @CancelButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Cancel') AND ForGridUse=1
	SELECT @GoodnightButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Goodnight') AND ForGridUse=1
	SELECT @ExtendButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Extend') AND ForGridUse=1
	SELECT @ConnectionButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Connection') AND ForGridUse=1
	SELECT @VideoButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Video') AND ForGridUse=1
	SELECT @ClearButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Clear') AND ForGridUse=1
	SELECT @RestartEncoderButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Restart Encoder') AND ForGridUse=1
	SELECT @ToolSourceButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Tool Source') AND ForGridUse=1
	SELECT @ToolDestinationButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Tool Destination') AND ForGridUse=1
	SELECT @LogButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Log') AND ForGridUse=1
	DECLARE @CompanyId UNIQUEIDENTIFIER
	SELECT @CompanyId=CompanyId FROM [User] WHERE Id=@UserId
SELECT [Event].[Id]								-- 0
      ,[Event].[Name]							-- 1
      ,[Event].[CompanyId]						-- 2
      ,[SourceDeviceId]					-- 3
      ,[DestinationDeviceId]			-- 4
      ,[StartTime]						-- 5
      ,[EndTime]						-- 6
      ,[CreatorId]						-- 7
      ,[Cancelled]						-- 8
      ,[CreatedOn]						-- 9
      ,[VideoProfileId]					--10
      ,[ParentId]						--11
      ,[RTT]							--12
      ,[PleClientStreamConfigId]		--13
      ,[PleServerStreamId]				--14
      ,PleServerConfigId				--15
      ,InputStreamId					--16
      ,OutputStreamId					--17
      ,DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond	--18
      ,CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond		--19
      ,SourceAcknowledgement				--20
      ,DestinationAcknowledgement			--21
      ,[Status]							--22
      ,VBitRate							--23
      ,AudioChannels					--24
      ,OwnerId							--25
      ,ActualStarted					--26
      ,ActualEnded						--27
      ,[ClosedCaption]					--28
      ,[Event].[SerialNumber]					--29
      ,[Tx]								--30
      ,[Rx]								--31
      
      --,CASE  WHEN [Status]=1 OR [Status]=3 OR [Status]=9 THEN 'Yellow' WHEN [Status]=2 THEN 'Green' ELSE 'Red' END AS TrafficLight
      ,CASE  WHEN [Status]=@Starting_Id THEN 'Yellow' 
			WHEN [Status]= @Started_Id 	THEN 'Green' 
			ELSE 'Red' 
			END AS TrafficLight

      ,CASE WHEN EndTime IS NULL AND ActualEnded IS NULL 
				THEN '&#x221e;' --???????????????????
				ELSE CASE WHEN ActualEnded IS NULL 
							THEN CONVERT(VARCHAR(15), DATEDIFF(minute, CURRENT_TIMESTAMP, EndTime)) 
							ELSE '0' 
				END 
			END AS Remaining
      ,HostSource.IPAddress AS SourceIp
      ,HostSource.TunnelIP AS SourceVpn
      ,HostDestination.IPAddress AS DestinationIP
      ,HostDestination.TunnelIP AS DestinationVpn
      ,PleServerStream.ConfigFileName AS DestinationConfigFileName		-- for log use
      ,CASE WHEN ActualEnded IS NOT NULL AND ActualStarted IS NOT NULL THEN DATEDIFF(minute, ActualStarted, ActualEnded) ELSE NULL END AS Duration
  --    ,CASE WHEN [Status]<>6 AND [Cancelled]<>1 AND ActualStarted IS NOT NULL AND DATEDIFF(SECOND, CURRENT_TIMESTAMP, ActualStarted)<0 AND (ActualEnded IS NULL OR DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime)>0) OR [Status]=2 THEN 0 -- running
		--	WHEN [Status]<>6 AND [Cancelled]<>1 AND DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime)>0 OR [Status]=0 THEN 1 -- future
		--	WHEN [Status]<> AND [Cancelled]<>1 AND ActualEnded IS NOT NULL AND DATEDIFF(SECOND, CURRENT_TIMESTAMP, ActualEnded)<0 OR [Status]=4 OR [Status]=5 OR [Status]=9 THEN 2 -- past
		--	WHEN [Status]=6 [Cancelled]=1 THEN 3 -- cancelled
		--	WHEN [Status]=8 THEN 4
		--END AS SchedulingStatus
		
		-- Used in the Scheduling view
      ,CASE WHEN [Status] IN (@Starting_Id, @Started_Id, @Stopping_Id)	THEN @Scheduling_Status_Running		-- running
			WHEN [Status]=@Scheduled_Id									THEN @Scheduling_Status_Future		-- future
			WHEN [Status] IN (@Goodnighted_Id, @Stopped_Id)				THEN @Scheduling_Status_Past		-- past
			WHEN [Cancelled]=1 OR [Status] = @Cancelled_Id				THEN @Scheduling_Status_Cancelled	-- cancelled
			WHEN [Status]=@Cleared_Id 									THEN @Scheduling_Status_Cleared		-- cleared
		END AS SchedulingStatus

		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @CancelButtonId) AS CancelButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @GoodnightButtonId) AS GoodnightButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @ExtendButtonId) AS ExtendButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @ConnectionButtonId) AS ConnectionButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @VideoButtonId) AS VideoButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @ClearButtonId) AS ClearButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @RestartEncoderButtonId) AS RestartEncoderButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @ToolSourceButtonId) AS ToolSourceButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @ToolDestinationButtonId) AS ToolDestinationButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @LogButtonId) AS LogButton
		,DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), StartTime) AS StartTimeUTC
		,DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), EndTime) AS EndTimeUTC
		,DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), ActualStarted) AS ActualStartedUTC
		,DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), ActualEnded) AS ActualEndedUTC
FROM [Event]
INNER JOIN PleClientStreamConfig INNER JOIN Host HostSource ON HostSource.Id=PleClientStreamConfig.HostId ON PleClientStreamConfig.Id=[Event].PleClientStreamConfigId
INNER JOIN PleServerStream INNER JOIN Host HostDestination ON HostDestination.Id=PleServerStream.HostId ON PleServerStream.Id=[Event].PleServerStreamId
WHERE 
(
	[Event].[CompanyId] = @CompanyId OR 
	(SELECT Id FROM Company WHERE IsMaster=1)=@CompanyId OR 
	HostSource.[CompanyId] = @CompanyId OR 
	HostDestination.[CompanyId] = @CompanyId
)
AND 
(
	--(@Status = 0) OR -- all
	--(@Status = 1 AND ([Status]<>6 AND [Cancelled]<>1 AND ActualStarted IS NOT NULL AND DATEDIFF(SECOND, CURRENT_TIMESTAMP, ActualStarted)<0 AND (ActualEnded IS NULL OR DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime)>0) OR [Status]=2)) OR -- running
	--(@Status = 2 AND ([Status]<>6 AND [Cancelled]<>1 AND DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime)>0 OR [Status]=0)) OR -- future
	--(@Status = 3 AND ([Status]<>6 AND [Cancelled]<>1 AND ActualEnded IS NOT NULL AND DATEDIFF(SECOND, CURRENT_TIMESTAMP, ActualEnded)<0 OR [Status]=4 OR [Status]=5 OR [Status]=9)) OR -- past
	--(@Status = 4 AND ([Status]=6 OR [Cancelled]=1)) -- cancelled
	
	(@Status = @All_Id) 
	OR (@Status = @Status_Running	AND [Status] IN (@Starting_Id, @Started_Id, @Stopping_Id))	-- running
	OR (@Status = @Status_Future	AND [Status] = @Scheduled_Id)								-- future
	OR (@Status = @Status_Past		AND [Status] IN (@Goodnighted_Id, @Stopped_Id))				-- past
	OR (@Status = @Status_Cancelled AND ([Cancelled]=1 OR  [Status] = @Cancelled_Id))			-- cancelled
	OR (@Status = @Status_Cleared	AND [Status] = @Cleared_Id)									-- cleared
)

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
			DECLARE @PleClientStreamConfigId UNIQUEIDENTIFIER
			DECLARE @PleServerConfigId UNIQUEIDENTIFIER
			SELECT @StartTime=EndTime, @EndTime=DATEADD(minute,
				@Timespan, EndTime),
				@PleClientStreamConfigId=PleClientStreamConfigId,
				@PleServerConfigId=PleServerConfigId
				FROM [Event] WHERE Id=@EventId
			IF EXISTS
			(
				SELECT [Name] FROM [Event] 
				WHERE (PleClientStreamConfigId=@PleClientStreamConfigId OR PleServerConfigId=@PleServerConfigId) AND Id<>@EventId AND [Cancelled]=0 AND
					(
						@StartTime>=[StartTime] AND (@StartTime<=[EndTime] OR ([EndTime] IS NULL AND ActualEnded IS NULL)) OR
						@EndTime>[StartTime] AND (@EndTime<=[EndTime] OR [EndTime] IS NULL AND ActualEnded IS NULL) OR
						@StartTime<=[StartTime] AND (@EndTime>=[EndTime] OR @EndTime IS NULL) OR
						([EndTime] IS NULL OR @StartTime<=[EndTime]) AND @EndTime IS NULL
					)
			)
				SELECT 1 AS Successful
			ELSE
			BEGIN
				UPDATE [Event] SET EndTime=@EndTime WHERE Id=@EventId
				INSERT INTO EventHistory
				(
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
					[AudioChannels]
				)
				SELECT NEWID() AS Id,
					Id AS EventId,
					@UserId,
					GETDATE() AS ModifiedOn,
					(SELECT Id FROM EventAction WHERE [Name]='Extend') AS EventActionId,
					[ClosedCaption],
					[Name],
					[StartTime],
					@EndTime AS [EndTime],
					[OwnerId],
					[VideoProfileId],
					[VBitRate],
					[AudioChannels]
				FROM [Event] WHERE Id=@EventId
				SELECT 0 AS Successful
			END
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
/****** Object:  StoredProcedure [dbo].[Event_ClearByUserId]    Script Date: 09/07/2017 14:00:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Event_ClearByUserId]
	@EventId UNIQUEIDENTIFIER,
	@UserId UNIQUEIDENTIFIER
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE [Event] SET [Status]=8 WHERE Id=@EventId
			INSERT INTO EventHistory
			(
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
				[AudioChannels]
			)
			SELECT NEWID() AS Id,
				Id AS EventId,
				@UserId,
				GETDATE() AS ModifiedOn,
				(SELECT Id FROM EventAction WHERE [Name]='Clear') AS EventActionId,
				[ClosedCaption],
				[Name],
				[StartTime],
				[EndTime],
				[OwnerId],
				[VideoProfileId],
				[VBitRate],
				[AudioChannels]
			FROM [Event] WHERE Id=@EventId
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
			UPDATE [Event] SET [Status]=6, Cancelled=1 WHERE Id=@EventId
			INSERT INTO EventHistory
			(
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
				[AudioChannels]
			)
			SELECT NEWID() AS Id,
				Id AS EventId,
				@UserId,
				GETDATE() AS ModifiedOn,
				(SELECT Id FROM EventAction WHERE [Name]='Cancel') AS EventActionId,
				[ClosedCaption],
				[Name],
				[StartTime],
				GETDATE() AS [EndTime],
				[OwnerId],
				[VideoProfileId],
				[VBitRate],
				[AudioChannels]
			FROM [Event] WHERE Id=@EventId
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
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id FROM Page WHERE Url='Host.aspx'
	DECLARE @CalendarButtonId UNIQUEIDENTIFIER
	DECLARE @PermissionsButtonId UNIQUEIDENTIFIER
	SELECT @CalendarButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Calendar') AND ForGridUse=1
	SELECT @PermissionsButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Device Permissions') AND ForGridUse=1
	SELECT Id, Name, HostId, ConfigFileName, Type,
	CASE Type WHEN 'Encoder INTernal' THEN 0 WHEN 'Encoder External' THEN 1 WHEN 'Decoder INTernal' THEN 2 WHEN 'Decoder External' THEN 3 END AS SortOrder
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @CalendarButtonId) AS CalendarButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @PermissionsButtonId) AS PermissionsButton
		,(SELECT CompanyId FROM [Host] WHERE Id=View_HostDevice.HostId) AS CompanyId
		,CAST(Id AS VARCHAR(40)) + '|' + (SELECT Name FROM Host WHERE Id=@HostId) + ': ' + Name AS IdName
	FROM View_HostDevice
	WHERE HostId=@HostId
	ORDER BY SortOrder, Name
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
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id FROM Page WHERE Url='Companies.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Delete') AND ForGridUse=1
	SELECT
		View_Company.*, 
		dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton,
		dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
	FROM View_Company
	WHERE Enabled=1
	AND EXISTS(SELECT Name FROM Company WHERE Id=(SELECT CompanyId FROM [User] WHERE Id=@UserId) AND IsMaster=1)
	OR Id=(SELECT CompanyId FROM [User] WHERE Id=@UserId)
	ORDER BY View_Company.[Name]
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
	DECLARE @PageId UNIQUEIDENTIFIER
	SELECT @PageId=Id FROM Page WHERE Url='Buttons.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id FROM PageButton WHERE PageId=@PageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Delete') AND ForGridUse=1
	SELECT Id, Name, ImageId, IsHome, (SELECT Url FROM Images WHERE Id=Button.ImageId) AS ImageUrl
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
		,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
	FROM Button
	WHERE (SELECT Id FROM Company WHERE IsMaster=1)=(SELECT CompanyId FROM [User] WHERE Id=@UserId)
	ORDER BY Name
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
	DECLARE @ButtonPageId UNIQUEIDENTIFIER
	SELECT @ButtonPageId=Id FROM Page WHERE Url='Brands.aspx'
	DECLARE @EditSubButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteSubButtonId UNIQUEIDENTIFIER
	SELECT @EditSubButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='EditSub') AND ForGridUse=1
	SELECT @DeleteSubButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='DeleteSub') AND ForGridUse=1
	SELECT [Id]
      ,[BrandId]
      ,[Url]
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditSubButtonId) AS EditButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteSubButtonId) AS DeleteButton
	FROM BrandUrl WHERE BrandId=@BrandId
	ORDER BY Url
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
	DECLARE @ButtonPageId UNIQUEIDENTIFIER
	SELECT @ButtonPageId=Id FROM Page WHERE Url='Brands.aspx'
	DECLARE @EditButtonId UNIQUEIDENTIFIER
	DECLARE @DeleteButtonId UNIQUEIDENTIFIER
	SELECT @EditButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Edit') AND ForGridUse=1
	SELECT @DeleteButtonId=Id FROM PageButton WHERE PageId=@ButtonPageId AND ButtonId=(SELECT Id FROM Button WHERE Name='Delete') AND ForGridUse=1
	SELECT Id
	  , [Name]
	  , LoginBannerImageId
	  , LogINTagImageId
	  , PortalImageId
	  , FaviconImageId
      ,[FooterCaption]
      ,[Default]
      ,(SELECT Url FROM Images WHERE Id=Brand.LoginBannerImageId) AS LoginBannerURL
      ,(SELECT Url FROM Images WHERE Id=Brand.LogINTagImageId) AS LogINTagURL
      ,(SELECT Url FROM Images WHERE Id=Brand.PortalImageId) AS PortalImageURL
      ,(SELECT Url FROM Images WHERE Id=Brand.FaviconImageId) AS FaviconURL
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @EditButtonId) AS EditButton
	,dbo.Function_MaxScopeValue_ByUserIdObjectId(@UserId, @DeleteButtonId) AS DeleteButton
	FROM Brand WHERE Id IN 
	(
		SELECT ObjectId
		FROM RoleObjectScope
		WHERE RoleId IN (SELECT RoleId FROM UserRole WHERE UserId=@UserId)
	)
	ORDER BY Name
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
-- Description:			Changes the Event.Status to Stopping when Event.EndTime <= now and wasw Started
-- =============================================
CREATE PROCEDURE [dbo].[Event_Scheduled_Stop] 
AS
BEGIN
	DECLARE	@Started_Id INT;
	DECLARE	@Stopping_Id INT;
	
	SET @Started_Id = (SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Started');
	SET @Stopping_Id = (SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Stopping');
	
	-- Updates the events that were started by the DeviceCaster
	UPDATE [Scheduler].[dbo].[Event]
		SET [StatusId] = @Stopping_Id						
			,[SourceAcknowledgement] = 0
			,[DestinationAcknowledgement] = 0
		WHERE [EndTime] <= CURRENT_TIMESTAMP AND [StatusId] = @Started_Id
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
	DECLARE	@Scheduled_Id INT;
	DECLARE	@Starting_Id INT;
	DECLARE @In_Advance_Period_Minute INT;
	SET @In_Advance_Period_Minute = 1; -- this value is subject to possible modification
	
	
	SET @Scheduled_Id = (SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Scheduled');
	SET @Starting_Id = (SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Starting');
	
	-- Update the events that are due wiht in one minute
	UPDATE [Scheduler].[dbo].[Event]
	SET [StatusId] = @Starting_Id
		,[SourceAcknowledgement] = 0
		,[DestinationAcknowledgement] = 0					
	WHERE [StartTime] <= DATEADD(MINUTE, @In_Advance_Period_Minute, CURRENT_TIMESTAMP) AND [StatusId] = @Scheduled_Id

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
	DECLARE	@Starting_Id INT;
	DECLARE	@Stopping_Id INT;
	DECLARE @Goodnighting_Id INT;
	DECLARE	@Clearing_Id INT;
	DECLARE @Grace_period_Minute INT;
	SET @Grace_period_Minute = 5; -- this value is subject to possible modification
	
	SET @Starting_Id =		(SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Starting');
	SET @Stopping_Id =		(SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Stopping');
	SET @Goodnighting_Id =	(SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Goodnighting');
	SET @Clearing_Id =		(SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Clearing');
	
	-- Flag only the events that keep "ing" for 5 min after the ending time
	UPDATE [Scheduler].[dbo].[Event]
	SET [StatusId] = @Clearing_Id	
			,[SourceAcknowledgement] = 0
			,[DestinationAcknowledgement] = 0					
	WHERE @Grace_period_Minute < DATEDIFF(MINUTE, [EndTime], CURRENT_TIMESTAMP) AND [StatusId] IN (@Stopping_Id, @Starting_Id, @Goodnighting_Id)
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
	DECLARE	@Stopping_Id INT;
	DECLARE @Goodnighting_Id INT;
	SET @Stopping_Id =		(SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Stopping');
	SET @Goodnighting_Id =	(SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Goodnighting');
	

SELECT [Id]							-- 0
      ,[Name]							-- 1
      ,[CompanyId]						-- 2
      ,[SourceDeviceId]					-- 3
      ,[DestinationDeviceId]			-- 4
      ,[StartTime]						-- 5
      ,[EndTime]						-- 6
      ,[CreatorId]						-- 7
      ,[CreatedOn]						-- 9
      ,[VideoProfileId]					--10
      ,[ParentId]						--11
      ,[RTT]							--12
      ,[PleClientStreamConfigId]		--13
      ,[PleServerStreamId]				--14
      ,[PleServerConfigId]				--15
      ,[InputStreamId]					--16
      ,[OutputStreamId]					--17
      ,DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond	--18
      ,CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond		--19
      ,[SourceAcknowledgement]			--20
      ,[DestinationAcknowledgement]		--21
      ,[StatusId]						--22
      ,[VBitRate]						--23
      ,[AudioChannels]					--24
      ,[OwnerId]						--25
      ,[ActualStarted]					--26
      ,[ActualEnded]					--27
      ,[ClosedCaption]					--28
      ,[SerialNumber]					--29
      ,[Tx]								--30
      ,[Rx]								--31
FROM [Event]
WHERE	([PleClientStreamConfigId]	IN (SELECT Id FROM [PleClientStreamConfig]	WHERE HostId=@HostId)
	OR	[PleServerStreamId]			IN (SELECT Id FROM [PleServerStream]		WHERE HostId=@HostId))
	AND ([StatusId]=@Stopping_Id OR [StatusId]=@Goodnighting_Id)
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
	
	DECLARE	@Starting_Id INT;
	SET @Starting_Id = (SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Starting');


	SELECT [Id]							-- 0
      ,[Name]							-- 1
      ,[CompanyId]						-- 2
      ,[SourceDeviceId]					-- 3
      ,[DestinationDeviceId]			-- 4
      ,[StartTime]						-- 5
      ,[EndTime]						-- 6
      ,[CreatorId]						-- 7
      ,[CreatedOn]						-- 9
      ,[VideoProfileId]					--10
      ,[ParentId]						--11
      ,[RTT]							--12
      ,[PleClientStreamConfigId]		--13
      ,[PleServerStreamId]				--14
      ,[PleServerConfigId]				--15
      ,[InputStreamId]					--16
      ,[OutputStreamId]					--17
      ,DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond	--18
      ,CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond		--19
      ,[SourceAcknowledgement]			--20
      ,[DestinationAcknowledgement]		--21
      ,[StatusId]						--22
      ,[VBitRate]						--23
      ,[AudioChannels]					--24
      ,[OwnerId]						--25
      ,[ActualStarted]					--26
      ,[ActualEnded]					--27
      ,[ClosedCaption]					--28
      ,[SerialNumber]					--29
      ,[Tx]								--30
      ,[Rx]								--31
FROM [Event]
WHERE	([PleClientStreamConfigId]	IN (SELECT Id FROM [PleClientStreamConfig]	WHERE HostId=@HostId)
	OR	[PleServerStreamId]			IN (SELECT Id FROM [PleServerStream]		WHERE HostId=@HostId))
	AND [StatusId]= @Starting_Id
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

	DECLARE	@Started_Id INT;
	DECLARE	@Stopping_Id INT;
	SET @Started_Id = (SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Started');
	SET @Stopping_Id = (SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Stopping');


	SELECT [Id]							-- 0
      ,[Name]							-- 1
      ,[CompanyId]						-- 2
      ,[SourceDeviceId]					-- 3
      ,[DestinationDeviceId]			-- 4
      ,[StartTime]						-- 5
      ,[EndTime]						-- 6
      ,[CreatorId]						-- 7
      ,[CreatedOn]						-- 9
      ,[VideoProfileId]					--10
      ,[ParentId]						--11
      ,[RTT]							--12
      ,[PleClientStreamConfigId]		--13
      ,[PleServerStreamId]				--14
      ,[PleServerConfigId]				--15
      ,[InputStreamId]					--16
      ,[OutputStreamId]					--17
      ,DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond	--18
      ,CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond		--19
      ,[SourceAcknowledgement]			--20
      ,[DestinationAcknowledgement]		--21
      ,[StatusId]						--22
      ,[VBitRate]						--23
      ,[AudioChannels]					--24
      ,[OwnerId]						--25
      ,[ActualStarted]					--26
      ,[ActualEnded]					--27
      ,[ClosedCaption]					--28
      ,[SerialNumber]					--29
      ,[Tx]								--30
      ,[Rx]								--31
FROM [Event]
WHERE	([PleClientStreamConfigId]	IN (SELECT Id FROM [PleClientStreamConfig]	WHERE HostId=@HostId)
	OR	 [PleServerStreamId]		IN (SELECT Id FROM [PleServerStream]		WHERE HostId=@HostId))
	AND [StatusId]=@Started_Id AND ([EndTime] IS NULL OR [EndTime]>CURRENT_TIMESTAMP)
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

	DECLARE @Clearing_Id INT;
	SET @Clearing_Id =		(SELECT [Id] FROM [Scheduler].[dbo].[Status] WHERE [Name] = 'Clearing');
	

	SELECT [Id]							-- 0
      ,[Name]							-- 1
      ,[CompanyId]						-- 2
      ,[SourceDeviceId]					-- 3
      ,[DestinationDeviceId]			-- 4
      ,[StartTime]						-- 5
      ,[EndTime]						-- 6
      ,[CreatorId]						-- 7
      ,[CreatedOn]						-- 9
      ,[VideoProfileId]					--10
      ,[ParentId]						--11
      ,[RTT]							--12
      ,[PleClientStreamConfigId]		--13
      ,[PleServerStreamId]				--14
      ,[PleServerConfigId]				--15
      ,[InputStreamId]					--16
      ,[OutputStreamId]					--17
      ,DATEDIFF(SECOND, CURRENT_TIMESTAMP, StartTime) AS StartTimeDiffSecond	--18
      ,CASE WHEN EndTime IS NULL THEN 1 ELSE DATEDIFF(SECOND, CURRENT_TIMESTAMP, EndTime) END AS EndTimeDiffSecond		--19
      ,[SourceAcknowledgement]			--20
      ,[DestinationAcknowledgement]		--21
      ,[StatusId]						--22
      ,[VBitRate]						--23
      ,[AudioChannels]					--24
      ,[OwnerId]						--25
      ,[ActualStarted]					--26
      ,[ActualEnded]					--27
      ,[ClosedCaption]					--28
      ,[SerialNumber]					--29
      ,[Tx]								--30
      ,[Rx]								--31
FROM [Event]
WHERE	([PleClientStreamConfigId]	IN (SELECT Id FROM [PleClientStreamConfig]	WHERE HostId=@HostId)
	OR	 [PleServerStreamId]		IN (SELECT Id FROM [PleServerStream]		WHERE HostId=@HostId))
	AND [StatusId]=@Clearing_Id
ORDER BY [StartTime]

    
END
GO

