USE [Scheduler]
GO
/****** Object:  Table [dbo].[Entity]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Entity](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Entity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DateFormat]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DateFormat](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](10) NOT NULL,
	[IsDefault] [bit] NULL,
 CONSTRAINT [PK_DateFormat] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Country]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[Order] [int] NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Configuration]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Configuration](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[IntValue] [int] NULL,
	[StringValue] [varchar](50) NULL,
 CONSTRAINT [PK_Configuration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [AK_Configuration_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CompanyType]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CompanyType](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Type] [varchar](50) NOT NULL,
 CONSTRAINT [PK_CompanyType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Company]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Company](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[AddressId] [uniqueidentifier] NULL,
	[Website] [varchar](100) NULL,
	[IsMaster] [bit] NOT NULL,
	[Contact] [varchar](50) NULL,
	[Email] [varchar](100) NULL,
	[AccountingEmail] [varchar](100) NULL,
	[AccountingNotifications] [bit] NOT NULL,
	[EventEmail] [varchar](100) NULL,
	[EventNotifications] [bit] NOT NULL,
	[Enabled] [bit] NOT NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventAction]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventAction](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EventAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Images]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Images](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Url] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Images] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventStatus]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventStatus](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EventStatus] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Permission]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Permission](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ObjectiveId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Scope]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Scope](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Value] [int] NOT NULL,
 CONSTRAINT [PK_Scope] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VideoProfile]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VideoProfile](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Vcodec] [varchar](50) NOT NULL,
	[Sdivideomode] [varchar](50) NOT NULL,
	[Value] [varchar](50) NOT NULL,
 CONSTRAINT [PK_VideoProfile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[State]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State](
	[Id] [uniqueidentifier] NOT NULL,
	[CountryId] [uniqueidentifier] NULL,
	[Name] [varchar](50) NOT NULL,
	[Postalcode] [varchar](5) NULL,
 CONSTRAINT [PK_State] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[Type] [int] NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Page]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Page](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[BrowserTitle] [varchar](50) NULL,
	[PageTitle] [varchar](50) NULL,
	[Url] [varchar](100) NULL,
	[AvailableOnDashboard] [bit] NULL,
	[ImageId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Button]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Button](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ImageId] [uniqueidentifier] NOT NULL,
	[IsHome] [bit] NOT NULL,
 CONSTRAINT [PK_Button] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Brand]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Brand](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[LoginBannerImageId] [uniqueidentifier] NOT NULL,
	[LoginTagImageId] [uniqueidentifier] NOT NULL,
	[PortalImageId] [uniqueidentifier] NOT NULL,
	[FaviconImageId] [uniqueidentifier] NOT NULL,
	[FooterCaption] [varchar](100) NULL,
	[Default] [bit] NULL,
 CONSTRAINT [PK_Brand] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DeviceSharedToCompany]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeviceSharedToCompany](
	[DeviceId] [uniqueidentifier] NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_DeviceSharedToCompany] PRIMARY KEY CLUSTERED 
(
	[DeviceId] ASC,
	[CompanyId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Host]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Host](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[SerialNumber] [varchar](20) NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[Licensekey] [varchar](50) NULL,
	[IPAddress] [varchar](50) NULL,
	[MacAddress] [varchar](50) NULL,
	[Version] [varchar](50) NULL,
	[TunnelIp] [varchar](50) NULL,
	[Apiport] [varchar](50) NULL,
	[Apipassword] [varchar](50) NULL,
	[LanIPAddress] [varchar](50) NULL,
	[LastCheckin] [datetime] NULL,
 CONSTRAINT [PK_Host] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Grid]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Grid](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Tag] [varchar](50) NOT NULL,
	[PageId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Grid] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Device]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Device](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[HostId] [uniqueidentifier] NULL,
	[DeviceType] [int] NULL,
	[Tx] [int] NULL,
	[Rx] [int] NULL,
 CONSTRAINT [PK_Device] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Address]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Address](
	[Id] [uniqueidentifier] NOT NULL,
	[Address1] [varchar](100) NOT NULL,
	[Address2] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[StateId] [uniqueidentifier] NULL,
	[StateProvince] [varchar](50) NULL,
	[Zip] [varchar](50) NULL,
	[CountryId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BrandUrl]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BrandUrl](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[BrandId] [uniqueidentifier] NOT NULL,
	[Url] [varchar](100) NOT NULL,
 CONSTRAINT [PK_BrandUrl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OutputStream]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OutputStream](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[HostId] [uniqueidentifier] NOT NULL,
	[ConfigFilename] [varchar](100) NOT NULL,
	[Streamname] [varchar](40) NOT NULL,
	[Streamenabled] [bit] NOT NULL,
	[Outputformat] [varchar](32) NULL,
	[Vbitrate] [varchar](16) NULL,
	[Videotranscodemethod] [varchar](32) NULL,
	[Videooutputformat] [varchar](32) NULL,
	[Gopsize] [int] NULL,
	[Scalingmode] [varchar](32) NULL,
	[Frameratemode] [varchar](32) NULL,
	[Deinterlace] [varchar](8) NULL,
	[Tsratecontrol] [varchar](8) NULL,
	[Tsbitratemin] [varchar](16) NULL,
	[Tsbitratemax] [varchar](16) NULL,
	[Audiotranscodingtype] [varchar](32) NULL,
	[Abitrate] [varchar](16) NULL,
	[Arate] [varchar](16) NULL,
	[Audiochannels] [varchar](16) NULL,
	[Aprofile] [varchar](32) NULL,
	[Destinationip] [varchar](16) NULL,
	[Destinationport] [int] NULL,
	[Modified] [datetime] NULL,
	[Outputproto] [varchar](40) NULL,
	[Outputmulticast] [bit] NULL,
	[Outputmulticastiface] [varchar](16) NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_OutputStream] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MenuItems]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MenuItems](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[Title] [varchar](50) NOT NULL,
	[Index] [int] NOT NULL,
	[ToolTip] [varchar](100) NULL,
	[ImageId] [uniqueidentifier] NULL,
	[PageId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_MenuItems] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InputStream]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InputStream](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[HostId] [uniqueidentifier] NOT NULL,
	[ConfigFilename] [varchar](100) NOT NULL,
	[Inputname] [varchar](32) NULL,
	[Sdiaspectratio] [varchar](16) NULL,
	[Sdivideomode] [varchar](24) NULL,
	[Sdiaudioconf] [varchar](24) NULL,
	[Arate] [varchar](24) NULL,
	[Audiochannels] [int] NULL,
	[Modified] [datetime] NULL,
	[Localip] [varchar](16) NULL,
	[Localport] [int] NULL,
	[Inputmulticast] [bit] NULL,
	[Inputmulticastip] [varchar](16) NULL,
	[Inputmulticastiface] [varchar](12) NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_InputStream] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RolePermissionScopeEntity]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermissionScopeEntity](
	[RoleId] [uniqueidentifier] NOT NULL,
	[PermissionId] [uniqueidentifier] NOT NULL,
	[ScopeId] [uniqueidentifier] NOT NULL,
	[EntityId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_RolePermissionScopeEntity] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[PermissionId] ASC,
	[ScopeId] ASC,
	[EntityId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleObjectScope]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleObjectScope](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
	[ObjectId] [uniqueidentifier] NOT NULL,
	[ScopeId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_RoleObject] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PageButton]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PageButton](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[PageId] [uniqueidentifier] NOT NULL,
	[ButtonId] [uniqueidentifier] NOT NULL,
	[Index] [int] NOT NULL,
	[ToolTip] [varchar](100) NULL,
	[RedirectPageId] [uniqueidentifier] NULL,
	[ForGridUse] [bit] NOT NULL,
 CONSTRAINT [PK_PageButton_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [DF_PageButton_PageId_ButtonId] UNIQUE NONCLUSTERED 
(
	[PageId] ASC,
	[ButtonId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [DF_PageButton_PageId_Index_ForGridUse] UNIQUE NONCLUSTERED 
(
	[PageId] ASC,
	[Index] ASC,
	[ForGridUse] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PleserverStream]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PleserverStream](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[HostId] [uniqueidentifier] NOT NULL,
	[ConfigFilename] [varchar](100) NOT NULL,
	[Streamname] [varchar](40) NOT NULL,
	[Pleserverindex] [varchar](8) NULL,
	[Streamenabled] [bit] NOT NULL,
	[Destinationip] [varchar](16) NULL,
	[Destinationport] [int] NULL,
	[Modified] [datetime] NULL,
	[Outputmulticast] [bit] NULL,
	[Outputmulticastip] [varchar](16) NULL,
	[Outputmulticastiface] [varchar](16) NULL,
	[Multiipaddress] [varchar](16) NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_PleserverStream] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PleserverConfig]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PleserverConfig](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[HostId] [uniqueidentifier] NOT NULL,
	[ConfigFilename] [varchar](100) NOT NULL,
	[Inputname] [varchar](32) NULL,
	[Bindip] [varchar](16) NULL,
	[Port] [int] NULL,
	[Modified] [datetime] NULL,
	[Lanipaddress] [varchar](16) NULL,
	[Altipaddress] [varchar](16) NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_PleserverConfig] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PleclientStreamConfig]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PleclientStreamConfig](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[HostId] [uniqueidentifier] NOT NULL,
	[ConfigFilename] [varchar](100) NOT NULL,
	[Inputname] [varchar](32) NULL,
	[Startmode] [int] NULL,
	[Clientindex] [varchar](8) NULL,
	[Localport] [int] NULL,
	[Modified] [datetime] NULL,
	[Localip] [varchar](32) NULL,
	[Lanipaddress] [varchar](16) NULL,
	[Inputmulticast] [bit] NULL,
	[Inputmulticastip] [varchar](16) NULL,
	[Inputmulticastiface] [varchar](16) NULL,
	[Multiipaddress] [varchar](16) NULL,
	[Deleted] [bit] NOT NULL,
 CONSTRAINT [PK_PleclientStreamConfig] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Person]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Person](
	[Id] [uniqueidentifier] NOT NULL,
	[Firstname] [varchar](50) NULL,
	[Lastname] [varchar](50) NULL,
	[Middlename] [varchar](50) NULL,
	[Prifix] [varchar](50) NULL,
	[Suffix] [varchar](50) NULL,
	[Email] [varchar](250) NULL,
	[AddressId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Phone]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Phone](
	[Id] [uniqueidentifier] NOT NULL,
	[CountryId] [uniqueidentifier] NULL,
	[AreaCode] [varchar](5) NULL,
	[Number] [varchar](10) NULL,
	[Extension] [varchar](10) NULL,
	[PhoneType] [int] NOT NULL,
	[PersonId] [uniqueidentifier] NULL,
	[CompanyId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[PersonId] [uniqueidentifier] NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[Registered] [datetime] NOT NULL,
	[PageId] [uniqueidentifier] NULL,
	[DateFormatId] [uniqueidentifier] NOT NULL,
	[Enabled] [bit] NOT NULL,
	[EventNotifications] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserSetting]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserSetting](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[VideoProfileId] [uniqueidentifier] NULL,
	[VideoBitrate] [varchar](10) NULL,
 CONSTRAINT [PK_UserSetting] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserId] [uniqueidentifier] NOT NULL,
	[RoleId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserHistory]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[LoginTime] [datetime] NOT NULL,
	[LoginIP] [varchar](50) NULL,
 CONSTRAINT [PK_UserHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserDashboardItem]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDashboardItem](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ObjectId] [uniqueidentifier] NOT NULL,
	[Index] [int] NOT NULL,
 CONSTRAINT [PK_UserDashboardItem] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [DF_UserDashboardItem_Object_Id_Index] UNIQUE NONCLUSTERED 
(
	[ObjectId] ASC,
	[Index] ASC,
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [DF_UserDashboardItem_UserId_ObjectId] UNIQUE NONCLUSTERED 
(
	[UserId] ASC,
	[ObjectId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HostHistory]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HostHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[HostId] [uniqueidentifier] NOT NULL,
	[History] [varchar](200) NULL,
	[UserId] [uniqueidentifier] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
 CONSTRAINT [PK_HostHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Event]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Event](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[SourceDeviceId] [uniqueidentifier] NULL,
	[DestinationDeviceId] [uniqueidentifier] NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[CreaterId] [uniqueidentifier] NOT NULL,
	[Cancelled] [bit] NOT NULL,
	[Created] [datetime] NOT NULL,
	[VideoProfileId] [uniqueidentifier] NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[RTT] [int] NULL,
	[PleclientStreamConfigId] [uniqueidentifier] NULL,
	[PleserverStreamId] [uniqueidentifier] NULL,
	[PleserverConfigId] [uniqueidentifier] NULL,
	[InputStreamId] [uniqueidentifier] NULL,
	[OutputStreamId] [uniqueidentifier] NULL,
	[SourceAcknowledge] [int] NOT NULL,
	[Destinationcknowledge] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Vbitrate] [varchar](16) NOT NULL,
	[Audiochannels] [varchar](16) NOT NULL,
	[OwnerId] [uniqueidentifier] NOT NULL,
	[ActualStarted] [datetime] NULL,
	[ActualEnded] [datetime] NULL,
	[CloseCaption] [bit] NOT NULL,
	[SerialNumber] [int] IDENTITY(1,1) NOT NULL,
	[Tx] [int] NOT NULL,
	[Rx] [int] NOT NULL,
 CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EventHistory]    Script Date: 09/12/2017 11:20:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EventHistory](
	[Id] [uniqueidentifier] NOT NULL,
	[EventId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NULL,
	[Modified] [datetime] NOT NULL,
	[EventActionId] [uniqueidentifier] NULL,
	[CloseCaption] [bit] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NULL,
	[OwnerId] [uniqueidentifier] NOT NULL,
	[VideoProfileId] [uniqueidentifier] NOT NULL,
	[Vbitrate] [varchar](16) NOT NULL,
	[Audiochannels] [varchar](16) NOT NULL,
 CONSTRAINT [PK_EventHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF_Address_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Address] ADD  CONSTRAINT [DF_Address_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Brand_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Brand] ADD  CONSTRAINT [DF_Brand_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_BrandUrl_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[BrandUrl] ADD  CONSTRAINT [DF_BrandUrl_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Button_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Button] ADD  CONSTRAINT [DF_Button_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Button_IsHome]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Button] ADD  CONSTRAINT [DF_Button_IsHome]  DEFAULT ((0)) FOR [IsHome]
GO
/****** Object:  Default [DF_Company_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Company_IsMaster]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_IsMaster]  DEFAULT ((0)) FOR [IsMaster]
GO
/****** Object:  Default [DF_Company_AccountingNotifications]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_AccountingNotifications]  DEFAULT ((0)) FOR [AccountingNotifications]
GO
/****** Object:  Default [DF_Company_EventNotifications]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_EventNotifications]  DEFAULT ((0)) FOR [EventNotifications]
GO
/****** Object:  Default [DF_Company_Enabled]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Company] ADD  CONSTRAINT [DF_Company_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
/****** Object:  Default [DF_CompanyType_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[CompanyType] ADD  CONSTRAINT [DF_CompanyType_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Configuration_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Configuration] ADD  CONSTRAINT [DF_Configuration_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Country_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Country] ADD  CONSTRAINT [DF_Country_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_DateFormat_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[DateFormat] ADD  CONSTRAINT [DF_DateFormat_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Entity_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Entity] ADD  CONSTRAINT [DF_Entity_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Event_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Event_Cancelled]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_Cancelled]  DEFAULT ((0)) FOR [Cancelled]
GO
/****** Object:  Default [DF_Event_Created]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_Created]  DEFAULT (getdate()) FOR [Created]
GO
/****** Object:  Default [DF_Event_SourceAcknowledge]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_SourceAcknowledge]  DEFAULT ((-1)) FOR [SourceAcknowledge]
GO
/****** Object:  Default [DF_Event_Destinationcknowledge]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_Destinationcknowledge]  DEFAULT ((-1)) FOR [Destinationcknowledge]
GO
/****** Object:  Default [DF_Event_Status]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_Status]  DEFAULT ((0)) FOR [Status]
GO
/****** Object:  Default [DF_Event_CloseCaption]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_CloseCaption]  DEFAULT ((0)) FOR [CloseCaption]
GO
/****** Object:  Default [DF_Event_Tx]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_Tx]  DEFAULT ((0)) FOR [Tx]
GO
/****** Object:  Default [DF_Event_Rx]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event] ADD  CONSTRAINT [DF_Event_Rx]  DEFAULT ((0)) FOR [Rx]
GO
/****** Object:  Default [DF_EventAction_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[EventAction] ADD  CONSTRAINT [DF_EventAction_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_EventHistory_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[EventHistory] ADD  CONSTRAINT [DF_EventHistory_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_EventHistory_ModifiedOn]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[EventHistory] ADD  CONSTRAINT [DF_EventHistory_ModifiedOn]  DEFAULT (getdate()) FOR [Modified]
GO
/****** Object:  Default [DF_EventHistory_CloseCaption]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[EventHistory] ADD  CONSTRAINT [DF_EventHistory_CloseCaption]  DEFAULT ((0)) FOR [CloseCaption]
GO
/****** Object:  Default [DF_Grid_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Grid] ADD  CONSTRAINT [DF_Grid_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Host_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Host] ADD  CONSTRAINT [DF_Host_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_HostHistory_ModifiedOn]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[HostHistory] ADD  CONSTRAINT [DF_HostHistory_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
/****** Object:  Default [DF_Images_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Images] ADD  CONSTRAINT [DF_Images_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_InputStream_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[InputStream] ADD  CONSTRAINT [DF_InputStream_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_InputStream_Deleted]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[InputStream] ADD  CONSTRAINT [DF_InputStream_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_MenuItems_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[MenuItems] ADD  CONSTRAINT [DF_MenuItems_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_OutputStream_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[OutputStream] ADD  CONSTRAINT [DF_OutputStream_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_OutputStream_Deleted]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[OutputStream] ADD  CONSTRAINT [DF_OutputStream_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Page_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Page] ADD  CONSTRAINT [DF_Page_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_PageButton_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PageButton] ADD  CONSTRAINT [DF_PageButton_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_PageButton_ForGridUse]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PageButton] ADD  CONSTRAINT [DF_PageButton_ForGridUse]  DEFAULT ((0)) FOR [ForGridUse]
GO
/****** Object:  Default [DF_Permission_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Permission] ADD  CONSTRAINT [DF_Permission_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Person_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Person] ADD  CONSTRAINT [DF_Person_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Phone_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Phone] ADD  CONSTRAINT [DF_Phone_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Phone_PhoneType]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Phone] ADD  CONSTRAINT [DF_Phone_PhoneType]  DEFAULT ((0)) FOR [PhoneType]
GO
/****** Object:  Default [DF_PleclientStreamConfig_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PleclientStreamConfig] ADD  CONSTRAINT [DF_PleclientStreamConfig_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_PleclientStreamConfig_Deleted]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PleclientStreamConfig] ADD  CONSTRAINT [DF_PleclientStreamConfig_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_PleserverConfig_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PleserverConfig] ADD  CONSTRAINT [DF_PleserverConfig_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_PleserverConfig_Deleted]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PleserverConfig] ADD  CONSTRAINT [DF_PleserverConfig_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_PleserverStream_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PleserverStream] ADD  CONSTRAINT [DF_PleserverStream_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_PleserverStream_Deleted]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PleserverStream] ADD  CONSTRAINT [DF_PleserverStream_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  Default [DF_Role_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Role_RoleType]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_RoleType]  DEFAULT ((0)) FOR [Type]
GO
/****** Object:  Default [DF_RoleObject_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[RoleObjectScope] ADD  CONSTRAINT [DF_RoleObject_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Scope_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Scope] ADD  CONSTRAINT [DF_Scope_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Scope_Value]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Scope] ADD  CONSTRAINT [DF_Scope_Value]  DEFAULT ((0)) FOR [Value]
GO
/****** Object:  Default [DF_State_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[State] ADD  CONSTRAINT [DF_State_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_User_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_User_Registered]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Registered]  DEFAULT (getdate()) FOR [Registered]
GO
/****** Object:  Default [DF_User_Enabled]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_Enabled]  DEFAULT ((1)) FOR [Enabled]
GO
/****** Object:  Default [DF_User_EventNotifications]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_EventNotifications]  DEFAULT ((0)) FOR [EventNotifications]
GO
/****** Object:  Default [DF_UserDashboardItem_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserDashboardItem] ADD  CONSTRAINT [DF_UserDashboardItem_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_UserHistory_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserHistory] ADD  CONSTRAINT [DF_UserHistory_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_UserHistory_LoginTime]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserHistory] ADD  CONSTRAINT [DF_UserHistory_LoginTime]  DEFAULT (getdate()) FOR [LoginTime]
GO
/****** Object:  Default [DF_UserSetting_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserSetting] ADD  CONSTRAINT [DF_UserSetting_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_VideoProfile_Id]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[VideoProfile] ADD  CONSTRAINT [DF_VideoProfile_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  ForeignKey [FK_Address_Country]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_Country]
GO
/****** Object:  ForeignKey [FK_Address_State]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_State] FOREIGN KEY([StateId])
REFERENCES [dbo].[State] ([Id])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_State]
GO
/****** Object:  ForeignKey [FK_Brand_Images_Favicon]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Brand]  WITH CHECK ADD  CONSTRAINT [FK_Brand_Images_Favicon] FOREIGN KEY([FaviconImageId])
REFERENCES [dbo].[Images] ([Id])
GO
ALTER TABLE [dbo].[Brand] CHECK CONSTRAINT [FK_Brand_Images_Favicon]
GO
/****** Object:  ForeignKey [FK_Brand_Images_LoginBanner]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Brand]  WITH CHECK ADD  CONSTRAINT [FK_Brand_Images_LoginBanner] FOREIGN KEY([LoginBannerImageId])
REFERENCES [dbo].[Images] ([Id])
GO
ALTER TABLE [dbo].[Brand] CHECK CONSTRAINT [FK_Brand_Images_LoginBanner]
GO
/****** Object:  ForeignKey [FK_Brand_Images_LoginTag]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Brand]  WITH CHECK ADD  CONSTRAINT [FK_Brand_Images_LoginTag] FOREIGN KEY([LoginTagImageId])
REFERENCES [dbo].[Images] ([Id])
GO
ALTER TABLE [dbo].[Brand] CHECK CONSTRAINT [FK_Brand_Images_LoginTag]
GO
/****** Object:  ForeignKey [FK_Brand_Images_Portal]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Brand]  WITH CHECK ADD  CONSTRAINT [FK_Brand_Images_Portal] FOREIGN KEY([PortalImageId])
REFERENCES [dbo].[Images] ([Id])
GO
ALTER TABLE [dbo].[Brand] CHECK CONSTRAINT [FK_Brand_Images_Portal]
GO
/****** Object:  ForeignKey [FK_BrandUrl_Brand]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[BrandUrl]  WITH CHECK ADD  CONSTRAINT [FK_BrandUrl_Brand] FOREIGN KEY([BrandId])
REFERENCES [dbo].[Brand] ([Id])
GO
ALTER TABLE [dbo].[BrandUrl] CHECK CONSTRAINT [FK_BrandUrl_Brand]
GO
/****** Object:  ForeignKey [FK_Button_Images]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Button]  WITH CHECK ADD  CONSTRAINT [FK_Button_Images] FOREIGN KEY([ImageId])
REFERENCES [dbo].[Images] ([Id])
GO
ALTER TABLE [dbo].[Button] CHECK CONSTRAINT [FK_Button_Images]
GO
/****** Object:  ForeignKey [FK_Device_Host]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Device]  WITH CHECK ADD  CONSTRAINT [FK_Device_Host] FOREIGN KEY([HostId])
REFERENCES [dbo].[Host] ([Id])
GO
ALTER TABLE [dbo].[Device] CHECK CONSTRAINT [FK_Device_Host]
GO
/****** Object:  ForeignKey [FK_DeviceSharedToCompany_Company]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[DeviceSharedToCompany]  WITH CHECK ADD  CONSTRAINT [FK_DeviceSharedToCompany_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[DeviceSharedToCompany] CHECK CONSTRAINT [FK_DeviceSharedToCompany_Company]
GO
/****** Object:  ForeignKey [FK_Event_Company]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Company]
GO
/****** Object:  ForeignKey [FK_Event_DestinationDevice]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_DestinationDevice] FOREIGN KEY([DestinationDeviceId])
REFERENCES [dbo].[Device] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_DestinationDevice]
GO
/****** Object:  ForeignKey [FK_Event_Event]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Event] FOREIGN KEY([ParentId])
REFERENCES [dbo].[Event] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Event]
GO
/****** Object:  ForeignKey [FK_Event_Event1]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Event1] FOREIGN KEY([Id])
REFERENCES [dbo].[Event] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Event1]
GO
/****** Object:  ForeignKey [FK_Event_EventStatus]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_EventStatus] FOREIGN KEY([Status])
REFERENCES [dbo].[EventStatus] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_EventStatus]
GO
/****** Object:  ForeignKey [FK_Event_InputStream]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_InputStream] FOREIGN KEY([InputStreamId])
REFERENCES [dbo].[InputStream] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_InputStream]
GO
/****** Object:  ForeignKey [FK_Event_OutputStream]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_OutputStream] FOREIGN KEY([OutputStreamId])
REFERENCES [dbo].[OutputStream] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_OutputStream]
GO
/****** Object:  ForeignKey [FK_Event_PleclientStreamConfig]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_PleclientStreamConfig] FOREIGN KEY([PleclientStreamConfigId])
REFERENCES [dbo].[PleclientStreamConfig] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_PleclientStreamConfig]
GO
/****** Object:  ForeignKey [FK_Event_PleserverConfig]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_PleserverConfig] FOREIGN KEY([PleserverConfigId])
REFERENCES [dbo].[PleserverConfig] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_PleserverConfig]
GO
/****** Object:  ForeignKey [FK_Event_PleserverStream]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_PleserverStream] FOREIGN KEY([PleserverStreamId])
REFERENCES [dbo].[PleserverStream] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_PleserverStream]
GO
/****** Object:  ForeignKey [FK_Event_SourceDevice]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_SourceDevice] FOREIGN KEY([SourceDeviceId])
REFERENCES [dbo].[Device] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_SourceDevice]
GO
/****** Object:  ForeignKey [FK_Event_User_Creater]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_User_Creater] FOREIGN KEY([CreaterId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_User_Creater]
GO
/****** Object:  ForeignKey [FK_Event_User_Owner]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_User_Owner] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_User_Owner]
GO
/****** Object:  ForeignKey [FK_Event_VideoProfile]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_VideoProfile] FOREIGN KEY([VideoProfileId])
REFERENCES [dbo].[VideoProfile] ([Id])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_VideoProfile]
GO
/****** Object:  ForeignKey [FK_EventHistory_Event]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[EventHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventHistory_Event] FOREIGN KEY([EventId])
REFERENCES [dbo].[Event] ([Id])
GO
ALTER TABLE [dbo].[EventHistory] CHECK CONSTRAINT [FK_EventHistory_Event]
GO
/****** Object:  ForeignKey [FK_EventHistory_EventAction]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[EventHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventHistory_EventAction] FOREIGN KEY([EventActionId])
REFERENCES [dbo].[EventAction] ([Id])
GO
ALTER TABLE [dbo].[EventHistory] CHECK CONSTRAINT [FK_EventHistory_EventAction]
GO
/****** Object:  ForeignKey [FK_EventHistory_User]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[EventHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventHistory_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[EventHistory] CHECK CONSTRAINT [FK_EventHistory_User]
GO
/****** Object:  ForeignKey [FK_EventHistory_UserOwner]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[EventHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventHistory_UserOwner] FOREIGN KEY([OwnerId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[EventHistory] CHECK CONSTRAINT [FK_EventHistory_UserOwner]
GO
/****** Object:  ForeignKey [FK_EventHistory_VideoProfile]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[EventHistory]  WITH CHECK ADD  CONSTRAINT [FK_EventHistory_VideoProfile] FOREIGN KEY([VideoProfileId])
REFERENCES [dbo].[VideoProfile] ([Id])
GO
ALTER TABLE [dbo].[EventHistory] CHECK CONSTRAINT [FK_EventHistory_VideoProfile]
GO
/****** Object:  ForeignKey [FK_Grid_Page]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Grid]  WITH CHECK ADD  CONSTRAINT [FK_Grid_Page] FOREIGN KEY([PageId])
REFERENCES [dbo].[Page] ([Id])
GO
ALTER TABLE [dbo].[Grid] CHECK CONSTRAINT [FK_Grid_Page]
GO
/****** Object:  ForeignKey [FK_Host_Company]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Host]  WITH CHECK ADD  CONSTRAINT [FK_Host_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[Host] CHECK CONSTRAINT [FK_Host_Company]
GO
/****** Object:  ForeignKey [FK_HostHistory_HostHistory]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[HostHistory]  WITH CHECK ADD  CONSTRAINT [FK_HostHistory_HostHistory] FOREIGN KEY([HostId])
REFERENCES [dbo].[Host] ([Id])
GO
ALTER TABLE [dbo].[HostHistory] CHECK CONSTRAINT [FK_HostHistory_HostHistory]
GO
/****** Object:  ForeignKey [FK_HostHistory_User]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[HostHistory]  WITH CHECK ADD  CONSTRAINT [FK_HostHistory_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[HostHistory] CHECK CONSTRAINT [FK_HostHistory_User]
GO
/****** Object:  ForeignKey [FK_InputStream_Host]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[InputStream]  WITH CHECK ADD  CONSTRAINT [FK_InputStream_Host] FOREIGN KEY([HostId])
REFERENCES [dbo].[Host] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InputStream] CHECK CONSTRAINT [FK_InputStream_Host]
GO
/****** Object:  ForeignKey [FK_MenuItems_Images]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[MenuItems]  WITH CHECK ADD  CONSTRAINT [FK_MenuItems_Images] FOREIGN KEY([ImageId])
REFERENCES [dbo].[Images] ([Id])
GO
ALTER TABLE [dbo].[MenuItems] CHECK CONSTRAINT [FK_MenuItems_Images]
GO
/****** Object:  ForeignKey [FK_MenuItems_MenuItems]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[MenuItems]  WITH CHECK ADD  CONSTRAINT [FK_MenuItems_MenuItems] FOREIGN KEY([ParentId])
REFERENCES [dbo].[MenuItems] ([Id])
GO
ALTER TABLE [dbo].[MenuItems] CHECK CONSTRAINT [FK_MenuItems_MenuItems]
GO
/****** Object:  ForeignKey [FK_MenuItems_Page]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[MenuItems]  WITH CHECK ADD  CONSTRAINT [FK_MenuItems_Page] FOREIGN KEY([PageId])
REFERENCES [dbo].[Page] ([Id])
GO
ALTER TABLE [dbo].[MenuItems] CHECK CONSTRAINT [FK_MenuItems_Page]
GO
/****** Object:  ForeignKey [FK_OutputStream_Host]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[OutputStream]  WITH CHECK ADD  CONSTRAINT [FK_OutputStream_Host] FOREIGN KEY([HostId])
REFERENCES [dbo].[Host] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[OutputStream] CHECK CONSTRAINT [FK_OutputStream_Host]
GO
/****** Object:  ForeignKey [FK_Page_Images]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Page]  WITH CHECK ADD  CONSTRAINT [FK_Page_Images] FOREIGN KEY([ImageId])
REFERENCES [dbo].[Images] ([Id])
GO
ALTER TABLE [dbo].[Page] CHECK CONSTRAINT [FK_Page_Images]
GO
/****** Object:  ForeignKey [FK_PageButton_Button]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PageButton]  WITH CHECK ADD  CONSTRAINT [FK_PageButton_Button] FOREIGN KEY([ButtonId])
REFERENCES [dbo].[Button] ([Id])
GO
ALTER TABLE [dbo].[PageButton] CHECK CONSTRAINT [FK_PageButton_Button]
GO
/****** Object:  ForeignKey [FK_PageButton_Page]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PageButton]  WITH CHECK ADD  CONSTRAINT [FK_PageButton_Page] FOREIGN KEY([PageId])
REFERENCES [dbo].[Page] ([Id])
GO
ALTER TABLE [dbo].[PageButton] CHECK CONSTRAINT [FK_PageButton_Page]
GO
/****** Object:  ForeignKey [FK_PageButton_Page1]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PageButton]  WITH CHECK ADD  CONSTRAINT [FK_PageButton_Page1] FOREIGN KEY([RedirectPageId])
REFERENCES [dbo].[Page] ([Id])
GO
ALTER TABLE [dbo].[PageButton] CHECK CONSTRAINT [FK_PageButton_Page1]
GO
/****** Object:  ForeignKey [FK_Person_Address]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Person]  WITH CHECK ADD  CONSTRAINT [FK_Person_Address] FOREIGN KEY([AddressId])
REFERENCES [dbo].[Address] ([Id])
GO
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Address]
GO
/****** Object:  ForeignKey [FK_Phone_Company]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_Company]
GO
/****** Object:  ForeignKey [FK_Phone_Country]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_Country]
GO
/****** Object:  ForeignKey [FK_Phone_Person]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_Person]
GO
/****** Object:  ForeignKey [FK_PleclientStreamConfig_Host]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PleclientStreamConfig]  WITH CHECK ADD  CONSTRAINT [FK_PleclientStreamConfig_Host] FOREIGN KEY([HostId])
REFERENCES [dbo].[Host] ([Id])
GO
ALTER TABLE [dbo].[PleclientStreamConfig] CHECK CONSTRAINT [FK_PleclientStreamConfig_Host]
GO
/****** Object:  ForeignKey [FK_PleserverConfig_Host]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PleserverConfig]  WITH CHECK ADD  CONSTRAINT [FK_PleserverConfig_Host] FOREIGN KEY([HostId])
REFERENCES [dbo].[Host] ([Id])
GO
ALTER TABLE [dbo].[PleserverConfig] CHECK CONSTRAINT [FK_PleserverConfig_Host]
GO
/****** Object:  ForeignKey [FK_PleserverStream_Host]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[PleserverStream]  WITH CHECK ADD  CONSTRAINT [FK_PleserverStream_Host] FOREIGN KEY([HostId])
REFERENCES [dbo].[Host] ([Id])
GO
ALTER TABLE [dbo].[PleserverStream] CHECK CONSTRAINT [FK_PleserverStream_Host]
GO
/****** Object:  ForeignKey [FK_Role_Company]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[Role]  WITH CHECK ADD  CONSTRAINT [FK_Role_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[Role] CHECK CONSTRAINT [FK_Role_Company]
GO
/****** Object:  ForeignKey [FK_RoleObject_Role]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[RoleObjectScope]  WITH CHECK ADD  CONSTRAINT [FK_RoleObject_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[RoleObjectScope] CHECK CONSTRAINT [FK_RoleObject_Role]
GO
/****** Object:  ForeignKey [FK_RoleObject_Scope]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[RoleObjectScope]  WITH CHECK ADD  CONSTRAINT [FK_RoleObject_Scope] FOREIGN KEY([ScopeId])
REFERENCES [dbo].[Scope] ([Id])
GO
ALTER TABLE [dbo].[RoleObjectScope] CHECK CONSTRAINT [FK_RoleObject_Scope]
GO
/****** Object:  ForeignKey [FK_RolePermissionScopeEntity_Entity]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[RolePermissionScopeEntity]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissionScopeEntity_Entity] FOREIGN KEY([EntityId])
REFERENCES [dbo].[Entity] ([Id])
GO
ALTER TABLE [dbo].[RolePermissionScopeEntity] CHECK CONSTRAINT [FK_RolePermissionScopeEntity_Entity]
GO
/****** Object:  ForeignKey [FK_RolePermissionScopeEntity_Permission]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[RolePermissionScopeEntity]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissionScopeEntity_Permission] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[Permission] ([Id])
GO
ALTER TABLE [dbo].[RolePermissionScopeEntity] CHECK CONSTRAINT [FK_RolePermissionScopeEntity_Permission]
GO
/****** Object:  ForeignKey [FK_RolePermissionScopeEntity_Role]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[RolePermissionScopeEntity]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissionScopeEntity_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[RolePermissionScopeEntity] CHECK CONSTRAINT [FK_RolePermissionScopeEntity_Role]
GO
/****** Object:  ForeignKey [FK_RolePermissionScopeEntity_Scope]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[RolePermissionScopeEntity]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissionScopeEntity_Scope] FOREIGN KEY([ScopeId])
REFERENCES [dbo].[Scope] ([Id])
GO
ALTER TABLE [dbo].[RolePermissionScopeEntity] CHECK CONSTRAINT [FK_RolePermissionScopeEntity_Scope]
GO
/****** Object:  ForeignKey [FK_State_Country]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[State]  WITH CHECK ADD  CONSTRAINT [FK_State_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
GO
ALTER TABLE [dbo].[State] CHECK CONSTRAINT [FK_State_Country]
GO
/****** Object:  ForeignKey [FK_User_Company]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Company] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Company] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Company]
GO
/****** Object:  ForeignKey [FK_User_DateFormat]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_DateFormat] FOREIGN KEY([DateFormatId])
REFERENCES [dbo].[DateFormat] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_DateFormat]
GO
/****** Object:  ForeignKey [FK_User_Page]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Page] FOREIGN KEY([PageId])
REFERENCES [dbo].[Page] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Page]
GO
/****** Object:  ForeignKey [FK_User_Person]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Person]
GO
/****** Object:  ForeignKey [FK_UserDashboardItem_User]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserDashboardItem]  WITH CHECK ADD  CONSTRAINT [FK_UserDashboardItem_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserDashboardItem] CHECK CONSTRAINT [FK_UserDashboardItem_User]
GO
/****** Object:  ForeignKey [FK_UserHistory_User]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserHistory]  WITH CHECK ADD  CONSTRAINT [FK_UserHistory_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserHistory] CHECK CONSTRAINT [FK_UserHistory_User]
GO
/****** Object:  ForeignKey [FK_UserRole_Role]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
/****** Object:  ForeignKey [FK_UserRole_User]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_User]
GO
/****** Object:  ForeignKey [FK_UserSetting_User]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserSetting]  WITH CHECK ADD  CONSTRAINT [FK_UserSetting_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([Id])
GO
ALTER TABLE [dbo].[UserSetting] CHECK CONSTRAINT [FK_UserSetting_User]
GO
/****** Object:  ForeignKey [FK_UserSetting_VideoProfile]    Script Date: 09/12/2017 11:20:31 ******/
ALTER TABLE [dbo].[UserSetting]  WITH CHECK ADD  CONSTRAINT [FK_UserSetting_VideoProfile] FOREIGN KEY([VideoProfileId])
REFERENCES [dbo].[VideoProfile] ([Id])
GO
ALTER TABLE [dbo].[UserSetting] CHECK CONSTRAINT [FK_UserSetting_VideoProfile]
GO
