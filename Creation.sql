-- These scripts create the tables

CREATE TABLE [dbo].[Address] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Address1]					VARCHAR(100)		NOT NULL,
	[Address2]					VARCHAR(50),
	[City]						VARCHAR(50),
	[StateId]					UNIQUEIDENTIFIER,
	[StateProvince]				VARCHAR(50),
	[Zip]						VARCHAR(50),
	[CountryId]					UNIQUEIDENTIFIER
);


CREATE TABLE [dbo].[Brand] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[LoginBannerImageId]		UNIQUEIDENTIFIER	NOT NULL,
	[LoginTagImageId]			UNIQUEIDENTIFIER	NOT NULL,
	[PortalImageId]				UNIQUEIDENTIFIER	NOT NULL,
	[FaviconImageId]			UNIQUEIDENTIFIER	NOT NULL,
	[FooterCaption]				VARCHAR(100),
	[IsDefault]					BIT
);


CREATE TABLE [dbo].[BrandUrl] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[BrandId]					UNIQUEIDENTIFIER	NOT NULL,
	[Url]						VARCHAR(100)		NOT NULL,
);


CREATE TABLE [dbo].[Button] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[ImageId]					UNIQUEIDENTIFIER	NOT NULL,
	[Size]						INT					NOT NULL,
	[IsHome]					BIT					NOT NULL
);


CREATE TABLE [dbo].[Company] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[AddressId]					UNIQUEIDENTIFIER,
	[Website]					VARCHAR(100),
	[IsMaster]					BIT					NOT NULL,
	[Contact]					VARCHAR(50),
	[Email]						VARCHAR(100),
	[AccountingEmail]			VARCHAR(100),
	[AccountingNotifications]	BIT					NOT NULL,
	[EventEmail]				VARCHAR(100),
	[EventNotifications]		BIT					NOT NULL,
	[Enabled]					BIT					NOT NULL
);


CREATE TABLE [dbo].[CompanyType] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Type]						VARCHAR(50)			NOT NULL,
);


CREATE TABLE [dbo].[Configuration] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[IntValue]					INT,
	[StringValue]				VARCHAR(50),
);


CREATE TABLE [dbo].[Country] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[Code]						VARCHAR(10)			NOT NULL,
	[Order]						INT	IDENTITY(1,1)	NOT NULL,
);


CREATE TABLE [dbo].[DateFormat] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(10)			NOT NULL,
	[IsDefault]					BIT,
);


CREATE TABLE [dbo].[Device] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50),
	[HostId]					UNIQUEIDENTIFIER,
	[DeviceType]				INT,
	[Rx]						INT,
	[Tx]						INT
);


CREATE TABLE [dbo].[DeviceSharedToCompany] (
	[DeviceId]					UNIQUEIDENTIFIER	NOT NULL,
	[CompanyId]					UNIQUEIDENTIFIER	NOT NULL,
);


CREATE TABLE [dbo].[Entity] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
);


CREATE TABLE [dbo].[Event] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[CompanyId]					UNIQUEIDENTIFIER	NOT NULL,
	[SourceDeviceId]			UNIQUEIDENTIFIER,
	[DestinationDeviceId]		UNIQUEIDENTIFIER,
	[StartTime]					DATETIME			NOT NULL,
	[ActualStarted]				DATETIME,
	[EndTime]					DATETIME,
	[ActualEnded]				DATETIME,
	[OwnerId]					UNIQUEIDENTIFIER,
	[CreatorId]					UNIQUEIDENTIFIER	NOT NULL,
	[CreatedOn]					DATETIME			NOT NULL,
	[VideoProfileId]			UNIQUEIDENTIFIER	NOT NULL,
	[ParentId]					UNIQUEIDENTIFIER,
	[PleClientStreamConfigId]	UNIQUEIDENTIFIER,
	[PleServerStreamId]			UNIQUEIDENTIFIER,
	[PleServerConfigId]			UNIQUEIDENTIFIER,
	[InputStreamId]				UNIQUEIDENTIFIER,
	[OutputStreamId]			UNIQUEIDENTIFIER,
	[SourceAcknowledgement]		INT					NOT NULL,
	[DestinationAcknowledgement]INT					NOT NULL,
	[StatusId]					INT					NOT NULL,
	[Vbitrate]					VARCHAR(50)			NOT NULL,
	[Audiochannels]				VARCHAR(50)			NOT NULL,
	[ClosedCaption]				BIT					NOT NULL,
	[SerialNumber]				INT					NOT NULL,
	[RTT]						INT,
	[Tx]						INT					NOT NULL,
	[Rx]						INT					NOT NULL
);



CREATE TABLE [dbo].[EventAction] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
);


CREATE TABLE [dbo].[EventHistory] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[EventId]					UNIQUEIDENTIFIER	NOT NULL,
	[UserId]					UNIQUEIDENTIFIER,
	[ModifiedOn]				DATETIME			NOT NULL,
	[EventActionId]				UNIQUEIDENTIFIER,
	[ClosedCaption]				BIT					NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[StartTime]					DATETIME			NOT NULL,
	[EndTime]					DATETIME,
	[OwnerId]					UNIQUEIDENTIFIER	NOT NULL,
	[VideoProfileId]			UNIQUEIDENTIFIER	NOT NULL,
	[Vbitrate]					VARCHAR(50)			NOT NULL,
	[AudioChannels]				VARCHAR(50)			NOT NULL
);


CREATE TABLE [dbo].[Grid] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[Tag]						VARCHAR(50)			NOT NULL,
	[PageId]					UNIQUEIDENTIFIER	NOT NULL
);

CREATE TABLE [dbo].[Host] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[SerialNumber]				VARCHAR(20),
	[CompanyId]					UNIQUEIDENTIFIER	NOT NULL,
	[LicenseKey]				VARCHAR(50),
	[IPAddress]					VARCHAR(50),	
	[MacAddress]				VARCHAR(50),
	[Version]					VARCHAR(50),
	[TunnelIP]					VARCHAR(50),
	[ApiPort]					VARCHAR(50),
	[ApiPassword]				VARCHAR(50),
	[LanIPAddress]				VARCHAR(50),
	[LastCheckin]				DATETIME
);


CREATE TABLE [dbo].[HostHistory] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[HostId]					UNIQUEIDENTIFIER	NOT NULL,
	[History]					VARCHAR(200),
	[UserId]					UNIQUEIDENTIFIER	NOT NULL,
	[ModifiedOn]				DATETIME			NOT NULL,
);


CREATE TABLE [dbo].[Image] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[Url]						VARCHAR(100)		NOT NULL
);


CREATE TABLE [dbo].[InputStream] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[HostId]					UNIQUEIDENTIFIER	NOT NULL,
	[ConfigFileName]			VARCHAR(100)		NOT NULL,
	[InputName]					VARCHAR(32),
	[SdiAspectRatio]			VARCHAR(16),
	[SdiVideoMode]				VARCHAR(24),
	[SdiAudioConf]				VARCHAR(24),
	[Arate]						VARCHAR(24),
	[AudioChannels]				INT,
	[ModifiedOn]				DATETIME,
	[LocalIP]					VARCHAR(16),
	[LocalPort]					INT,
	[InputMulticast]			BIT,
	[InputMulticastIP]			VARCHAR(16),
	[InputMulticastIFace]		VARCHAR(12),
	[Deleted]					BIT					NOT NULL
);

CREATE TABLE [dbo].[MenuItem] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(32)			NOT NULL,
	[ParentId]					UNIQUEIDENTIFIER,
	[Title]						VARCHAR(50)			NOT NULL,
	[Index]						INT					NOT NULL,
	[ToolTip]					VARCHAR(100),
	[ImageId]					UNIQUEIDENTIFIER,
	[Size]						INT					NOT NULL,
	[PageId]					UNIQUEIDENTIFIER
);


CREATE TABLE [dbo].[MonitorStatus] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(32)			NOT NULL,
);


CREATE TABLE [dbo].[OutputStream] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[HostId]					UNIQUEIDENTIFIER	NOT NULL,
	[ConfigFileName]			VARCHAR(100)		NOT NULL,
	[StreamName]				VARCHAR(40)			NOT NULL,
	[StreamEnabled]				BIT					NOT NULL,
	[OutputFormat]				VARCHAR(32),
	[VBitrate]					VARCHAR(16),
	[VideoTranscodeMethod]		VARCHAR(32),
	[VideoOutputFormat]			VARCHAR(32),
	[GopSize]					INT,	
	[ScalingMode]				VARCHAR(32),
	[FrameRateMode]				VARCHAR(32),
	[DeInterlace]				VARCHAR(8),
	[TsRateControl]				VARCHAR(8),
	[TsBitRateMin]				VARCHAR(16),
	[TsBitRateMax]				VARCHAR(16),
	[AudioTranscodingType]		VARCHAR(32),
	[ABitRate]					VARCHAR(16),
	[ARate]						VARCHAR(16),
	[AudioChannels]				VARCHAR(16),
	[AProfile]					VARCHAR(32),
	[DestinationIP]				VARCHAR(16),
	[DestinationPort]			INT,
	[ModifiedOn]				DATETIME,
	[OutputProto]				VARCHAR(40),
	[OutputMulticast]			BIT,
	[OutputMulticastIFace]		VARCHAR(16),
	[Deleted]					BIT					NOT NULL
);


CREATE TABLE [dbo].[Page] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[BrowserTitle]				VARCHAR(50)	,
	[PageTitle]					VARCHAR(50)	,
	[Url]						VARCHAR(100)	,
	[AvailableOnDashboard]		BIT	,
	[ImageId]					UNIQUEIDENTIFIER,
	[Size]						INT					NOT NULL
);


CREATE TABLE [dbo].[PageButton] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[PageId]					UNIQUEIDENTIFIER	NOT NULL,
	[ButtonId]					UNIQUEIDENTIFIER	NOT NULL,
	[Index]						INT					NOT NULL,
	[ToolTip]					VARCHAR(100),
	[RedirectPageId]			UNIQUEIDENTIFIER,
	[ForGridUse]				BIT					NOT NULL,	
);


CREATE TABLE [dbo].[Permission] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[ObjectiveId]				UNIQUEIDENTIFIER,
);


CREATE TABLE [dbo].[Person] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[FirstName]					VARCHAR(50),
	[LastName]					VARCHAR(50),
	[MiddleName]				VARCHAR(50),
	[Prifix]					VARCHAR(50),
	[Suffix]					VARCHAR(50),
	[Email]						VARCHAR(250),
	[AddressId]					UNIQUEIDENTIFIER,
);


CREATE TABLE [dbo].[Phone] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[CountryId]					UNIQUEIDENTIFIER,
	[AreaCode]					VARCHAR(5),
	[Number]					VARCHAR(10),
	[Extension]					VARCHAR(10),
	[PhoneType]					INT					NOT NULL,
	[PersonId]					UNIQUEIDENTIFIER,
	[CompanyId]					UNIQUEIDENTIFIER,
);


CREATE TABLE [dbo].[PleClientStreamConfig] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[HostId]					UNIQUEIDENTIFIER	NOT NULL,
	[ConfigFileName]			VARCHAR(100)		NOT NULL,
	[InputName]					VARCHAR(32),
	[StartMode]					INT,
	[ClientIndex]				VARCHAR(8),
	[LocalPort]					INT,
	[ModifiedOn]				DATETIME,
	[LocalIp]					VARCHAR(32),
	[LanIPAddress]				VARCHAR(16),
	[InputMulticast]			BIT,
	[InputMulticastIP]			VARCHAR(16),
	[InputMulticastIFace]		VARCHAR(16),
	[MultiIPaddress]			VARCHAR(16),
	[Deleted]					BIT					NOT NULL,
);

CREATE TABLE [dbo].[PleServerConfig] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[HostId]					UNIQUEIDENTIFIER	NOT NULL,
	[ConfigFileName]			VARCHAR(100)		NOT NULL,
	[InputName]					VARCHAR(32),
	[BindIP]					VARCHAR(16),
	[Port]						INT,
	[ModifiedOn]				DATETIME,
	[LanIPAddress]				VARCHAR(16),
	[AltIPAddress]				VARCHAR(16),
	[Deleted]					BIT					NOT NULL,
);



CREATE TABLE [dbo].[PleServerStream] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[HostId]					UNIQUEIDENTIFIER	NOT NULL,
	[ConfigFileName]			VARCHAR(100)		NOT NULL,
	[StreamName]				VARCHAR(40)			NOT NULL,
	[PleServerIndex]			VARCHAR(8),
	[StreamEnabled]				BIT					NOT NULL,
	[DestinationIP]				VARCHAR(16),
	[DestinationPort]			INT,
	[ModifiedOn]					DATETIME,
	[OutputMulticast]			BIT,
	[OutputMulticastIP]			VARCHAR(16),
	[OutputMulticastIFace]		VARCHAR(16),
	[MultiIPAddress]			VARCHAR(16),
	[Deleted]					BIT					NOT NULL,
);


CREATE TABLE [dbo].[RoleType] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
);

CREATE TABLE [dbo].[RoleCompany] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[CompanyId]					UNIQUEIDENTIFIER	NOT NULL,
	[TypeId]						UNIQUEIDENTIFIER	NOT NULL,
);


CREATE TABLE [dbo].[RoleObjectScope] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[RoleCompanyId]					UNIQUEIDENTIFIER	NOT NULL,
	[ObjectId]					UNIQUEIDENTIFIER	NOT NULL,
	[ScopeId]					UNIQUEIDENTIFIER,
);


CREATE TABLE [dbo].[RolePermissionScopeEntity] (
	[RoleCompanyId]					UNIQUEIDENTIFIER	NOT NULL,
	[PermissionId]				UNIQUEIDENTIFIER	NOT NULL,
	[ScopeId]					UNIQUEIDENTIFIER	NOT NULL,
	[EntityId]					UNIQUEIDENTIFIER	NOT NULL,
);


CREATE TABLE [dbo].[Scope] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[Value]						INT					NOT NULL,
);



CREATE TABLE [dbo].[State] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[CountryId]					UNIQUEIDENTIFIER,
	[Name]						VARCHAR(50)			NOT NULL,
	[PostalCode]				VARCHAR(5),
);

CREATE TABLE [dbo].[Status] (
	[Id]						INT	IDENTITY(1,1)	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
);

CREATE TABLE [dbo].[User] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[Password]					VARCHAR(50)			NOT NULL,
	[PersonId]					UNIQUEIDENTIFIER	NOT NULL,
	[CompanyId]					UNIQUEIDENTIFIER	NOT NULL,
	[Registered]				DATETIME			NOT NULL,
	[PageId]					UNIQUEIDENTIFIER,
	[DateFormatId]				UNIQUEIDENTIFIER	NOT NULL,
	[Enabled]					BIT					NOT NULL,
	[EventNotifications]		BIT					NOT NULL,
);



CREATE TABLE [dbo].[UserDashBoardItem] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[UserId]					UNIQUEIDENTIFIER	NOT NULL,
	[ObjectId]					UNIQUEIDENTIFIER	NOT NULL,
	[Index]						INT					NOT NULL,
);


CREATE TABLE [dbo].[UserHistory] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[UserId]					UNIQUEIDENTIFIER	NOT NULL,
	[LoginTime]					DATETIME			NOT NULL,
	[LoginIP]					VARCHAR(50),
);



CREATE TABLE [dbo].[UserRole] (
	[UserId]					UNIQUEIDENTIFIER	NOT NULL,
	[RoleCompanyId]				UNIQUEIDENTIFIER	NOT NULL,
);


CREATE TABLE [dbo].[UserSetting] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[UserId]					UNIQUEIDENTIFIER	NOT NULL,
	[VideoProfileId]			UNIQUEIDENTIFIER,
	[VideoBitrate]				VARCHAR(10),
);

CREATE TABLE [dbo].[VideoProfile] (
	[Id]						UNIQUEIDENTIFIER	NOT NULL,
	[Name]						VARCHAR(50)			NOT NULL,
	[VCodec]					VARCHAR(50)			NOT NULL,
	[SdiVideoMode]				VARCHAR(50)			NOT NULL,
	[Value]						VARCHAR(50)			NOT NULL,
);








