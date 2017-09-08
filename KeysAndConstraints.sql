-- These scripts add the primary and foreign key to the tables

ALTER TABLE [Scheduler].[dbo].[Country]
	ADD CONSTRAINT PK_Country PRIMARY KEY (Id)
	
ALTER TABLE [Scheduler].[dbo].[State]
	ADD CONSTRAINT PK_State				PRIMARY KEY (Id),
		CONSTRAINT FK_State_Country		FOREIGN KEY (CountryId)	REFERENCES [Scheduler].[dbo].[Country]	(Id)

ALTER TABLE [Scheduler].[dbo].[Address]
	ADD CONSTRAINT PK_Address			PRIMARY KEY (Id),
		CONSTRAINT FK_Address_Country	FOREIGN KEY (CountryId)	REFERENCES [Scheduler].[dbo].[Country]	(Id),
		CONSTRAINT FK_Address_State		FOREIGN KEY (StateId)	REFERENCES [Scheduler].[dbo].[State]	(Id)
		
ALTER TABLE [Scheduler].[dbo].[Image]
	ADD CONSTRAINT PK_Image PRIMARY KEY (Id)

ALTER TABLE [Scheduler].[dbo].[Brand]
	ADD CONSTRAINT PK_Brand						PRIMARY KEY (Id),
		CONSTRAINT FK_Brand_Images_Favicon		FOREIGN KEY (FaviconImageId)	REFERENCES [Scheduler].[dbo].[Image]	(Id),
		CONSTRAINT FK_Brand_Images_LoginBanner	FOREIGN KEY (LoginBannerImageId) REFERENCES [Scheduler].[dbo].[Image]	(Id),
		CONSTRAINT FK_Brand_Images_LoginTag		FOREIGN KEY (LoginTagImageId)	REFERENCES [Scheduler].[dbo].[Image]	(Id),
		CONSTRAINT FK_Brand_Images_Portal		FOREIGN KEY (PortalImageId)		REFERENCES [Scheduler].[dbo].[Image]	(Id)
	
ALTER TABLE [Scheduler].[dbo].[BrandUrl]
	ADD CONSTRAINT PK_BrandUrl			PRIMARY KEY (Id),
		CONSTRAINT FK_BrandUrl_Brand	FOREIGN KEY (BrandId)	REFERENCES [Scheduler].[dbo].[Brand]	(Id)

ALTER TABLE [Scheduler].[dbo].[Button]
	ADD CONSTRAINT PK_Button		PRIMARY KEY (Id),
		CONSTRAINT FK_Button_Image	FOREIGN KEY (ImageId)	REFERENCES [Scheduler].[dbo].[Image]	(Id)
	
ALTER TABLE [Scheduler].[dbo].[Company]
	ADD CONSTRAINT PK_Company PRIMARY KEY (Id)

ALTER TABLE [Scheduler].[dbo].[CompanyType]
	ADD CONSTRAINT PK_CompanyType PRIMARY KEY (Id)
	
ALTER TABLE [Scheduler].[dbo].[Configuration]
	ADD CONSTRAINT PK_Configuration PRIMARY KEY (Id)

ALTER TABLE [Scheduler].[dbo].[DateFormat]
	ADD CONSTRAINT PK_DateFormat PRIMARY KEY (Id)
	
ALTER TABLE [Scheduler].[dbo].[Host]
	ADD CONSTRAINT PK_Host			PRIMARY KEY (Id),
		CONSTRAINT FK_Host_Company	FOREIGN KEY (CompanyId)	REFERENCES [Scheduler].[dbo].[Company] (Id)

ALTER TABLE [Scheduler].[dbo].[Device]
	ADD CONSTRAINT PK_Device		PRIMARY KEY (Id),
		CONSTRAINT FK_Device_Host	FOREIGN KEY (HostId)	REFERENCES [Scheduler].[dbo].[Host]	(Id)

ALTER TABLE [Scheduler].[dbo].[DeviceSharedToCompany]
	ADD CONSTRAINT PK_DeviceSharedToCompany			    PRIMARY KEY (DeviceId, CompanyId),
		CONSTRAINT FK_DeviceSharedToCompany_Device		FOREIGN KEY (DeviceId)	REFERENCES [Scheduler].[dbo].[Device]	(Id),
		CONSTRAINT FK_DeviceSharedToCompany_Company		FOREIGN KEY (CompanyId)	REFERENCES [Scheduler].[dbo].[Company]	(Id)
		
ALTER TABLE [Scheduler].[dbo].[Entity]
	ADD CONSTRAINT PK_Entity PRIMARY KEY (Id)
	
ALTER TABLE [Scheduler].[dbo].[Status]
	ADD CONSTRAINT PK_Status PRIMARY KEY (Id)
	
ALTER TABLE [Scheduler].[dbo].[InputStream]
	ADD CONSTRAINT PK_InputStream		PRIMARY KEY (Id),
		CONSTRAINT FK_InputStream_Host	FOREIGN KEY (HostId)	REFERENCES [Scheduler].[dbo].[Host]	(Id)

ALTER TABLE [Scheduler].[dbo].[OutputStream]
	ADD CONSTRAINT PK_OutputStream			PRIMARY KEY (Id),
		CONSTRAINT FK_OutputStream_Host		FOREIGN KEY (HostId)	REFERENCES [Scheduler].[dbo].[Host]	(Id)

ALTER TABLE [Scheduler].[dbo].[PleClientStreamConfig]
	ADD CONSTRAINT PK_PleClienStreamConfig		PRIMARY KEY (Id),
		CONSTRAINT FK_PleClienStreamConfig_Host	FOREIGN KEY (HostId)	REFERENCES [Scheduler].[dbo].[Host]	(Id)

ALTER TABLE [Scheduler].[dbo].[PleServerConfig]
	ADD CONSTRAINT PK_PleServerConfig		PRIMARY KEY (Id),
		CONSTRAINT FK_PleServerConfig_Host	FOREIGN KEY (HostId)	REFERENCES [Scheduler].[dbo].[Host]	(Id)

ALTER TABLE [Scheduler].[dbo].[PleServerStream]
	ADD CONSTRAINT PK_PleServerStream		PRIMARY KEY (Id),
		CONSTRAINT FK_PleServerStream_Host	FOREIGN KEY (HostId)	REFERENCES [Scheduler].[dbo].[Host]	(Id)
		
ALTER TABLE [Scheduler].[dbo].[Page]
	ADD CONSTRAINT PK_Page			PRIMARY KEY (Id),
		CONSTRAINT FK_Page_Image	FOREIGN KEY (ImageId)	REFERENCES [Scheduler].[dbo].[Image]	(Id)
		
ALTER TABLE [Scheduler].[dbo].[Person]
	ADD CONSTRAINT PK_Person			PRIMARY KEY (Id),
		CONSTRAINT FK_Person_Address	FOREIGN KEY (AddressId)	REFERENCES [Scheduler].[dbo].[Address]	(Id)

ALTER TABLE [Scheduler].[dbo].[User]
	ADD CONSTRAINT PK_User				PRIMARY KEY (Id),
		CONSTRAINT FK_User_Company		FOREIGN KEY (CompanyId)	REFERENCES [Scheduler].[dbo].[Company]	(Id),
		CONSTRAINT FK_User_DateFormat	FOREIGN KEY (DateFormatId)	REFERENCES [Scheduler].[dbo].[DateFormat]	(Id),
		CONSTRAINT FK_User_Page			FOREIGN KEY (PageId)	REFERENCES [Scheduler].[dbo].[Page]	(Id),
		CONSTRAINT FK_User_Person		FOREIGN KEY (PersonId)	REFERENCES [Scheduler].[dbo].[Person]	(Id)

ALTER TABLE [Scheduler].[dbo].[VideoProfile]
	ADD CONSTRAINT PK_VideoProfile	PRIMARY KEY (Id)

ALTER TABLE [Scheduler].[dbo].[Event]
	ADD CONSTRAINT PK_Event							PRIMARY KEY (Id),
		CONSTRAINT FK_Event_Company					FOREIGN KEY (CompanyId)	REFERENCES [Scheduler].[dbo].[Company]	(Id),
		CONSTRAINT FK_Event_SourceDevice			FOREIGN KEY (SourceDeviceId)	REFERENCES [Scheduler].[dbo].[Device]	(Id),
		CONSTRAINT FK_Event_DestinationDevice		FOREIGN KEY (DestinationDeviceId)	REFERENCES [Scheduler].[dbo].[Device]	(Id),
		CONSTRAINT FK_Event_Status					FOREIGN KEY (StatusId)	REFERENCES [Scheduler].[dbo].[Status]	(Id),
		CONSTRAINT FK_Event_InputStream				FOREIGN KEY (InputStreamId)	REFERENCES [Scheduler].[dbo].[InputStream]	(Id),
		CONSTRAINT FK_Event_OutputStream			FOREIGN KEY (OutputStreamId)	REFERENCES [Scheduler].[dbo].[OutputStream]	(Id),
		CONSTRAINT FK_Event_PleClientStreamConfig	FOREIGN KEY (PleClientStreamConfigId)	REFERENCES [Scheduler].[dbo].[PleClientStreamConfig]	(Id),
		CONSTRAINT FK_Event_PleServerConfig			FOREIGN KEY (PleServerConfigId)	REFERENCES [Scheduler].[dbo].[PleServerConfig]	(Id),
		CONSTRAINT FK_Event_PleServerStream			FOREIGN KEY (PleServerStreamId)	REFERENCES [Scheduler].[dbo].[PleServerStream]	(Id),
		CONSTRAINT FK_Event_Creator					FOREIGN KEY (CreatorId)	REFERENCES [Scheduler].[dbo].[User]	(Id),
		CONSTRAINT FK_Event_Owner					FOREIGN KEY (OwnerId)	REFERENCES [Scheduler].[dbo].[User]	(Id),
		CONSTRAINT FK_Event_VideoProfile			FOREIGN KEY (VideoProfileId)	REFERENCES [Scheduler].[dbo].[VideoProfile]	(Id)
	
ALTER TABLE [Scheduler].[dbo].[EventAction]
	ADD CONSTRAINT PK_EventAction PRIMARY KEY (Id)
	
ALTER TABLE [Scheduler].[dbo].[EventHistory]
	ADD CONSTRAINT PK_EventHistory					PRIMARY KEY (Id),
		CONSTRAINT FK_EventHistory_Event			FOREIGN KEY (EventId)	REFERENCES [Scheduler].[dbo].[Event]	(Id),
		CONSTRAINT FK_EventHistory_EventAction		FOREIGN KEY (EventActionId)	REFERENCES [Scheduler].[dbo].[EventAction]	(Id),
		CONSTRAINT FK_EventHistory_User				FOREIGN KEY (UserId)	REFERENCES [Scheduler].[dbo].[User]	(Id),
		CONSTRAINT FK_EventHistory_Owner		FOREIGN KEY (OwnerId)	REFERENCES [Scheduler].[dbo].[User]	(Id),
		CONSTRAINT FK_EventHistory_VideoProfile		FOREIGN KEY (VideoProfileId)	REFERENCES [Scheduler].[dbo].[VideoProfile]	(Id)

ALTER TABLE [Scheduler].[dbo].[Grid]
	ADD CONSTRAINT PK_Grid			PRIMARY KEY (Id),
		CONSTRAINT FK_Grid_Page		FOREIGN KEY (PageId)	REFERENCES [Scheduler].[dbo].[Page]	(Id)
		
ALTER TABLE [Scheduler].[dbo].[HostHistory]
	ADD CONSTRAINT PK_HostHistory		PRIMARY KEY (Id),
		CONSTRAINT FK_HostHistory_Host	FOREIGN KEY (HostId)	REFERENCES [Scheduler].[dbo].[Host]	(Id),
		CONSTRAINT FK_HostHistory_User	FOREIGN KEY (UserId)	REFERENCES [Scheduler].[dbo].[User]	(Id)

ALTER TABLE [Scheduler].[dbo].[MenuItem]
	ADD CONSTRAINT PK_MenuItem			PRIMARY KEY (Id),
		CONSTRAINT FK_MenuItem_Image	FOREIGN KEY (ImageId)	REFERENCES [Scheduler].[dbo].[Image]	(Id),
		CONSTRAINT FK_MenuItem_Parent	FOREIGN KEY (ParentId)	REFERENCES [Scheduler].[dbo].[MenuItem]	(Id),
		CONSTRAINT FK_MenuItem_Page		FOREIGN KEY (PageId)	REFERENCES [Scheduler].[dbo].[Page]	(Id)
		
ALTER TABLE [Scheduler].[dbo].[PageButton]
	ADD CONSTRAINT PK_PageButton				PRIMARY KEY (Id),
		CONSTRAINT FK_PageButton_Button			FOREIGN KEY (ButtonId)	REFERENCES [Scheduler].[dbo].[Button]	(Id),
		CONSTRAINT FK_PageButton_Page			FOREIGN KEY (PageId)	REFERENCES [Scheduler].[dbo].[Page]	(Id),
		CONSTRAINT FK_PageButton_RedirectPage	FOREIGN KEY (RedirectPageId)	REFERENCES [Scheduler].[dbo].[Page]	(Id)
		
ALTER TABLE [Scheduler].[dbo].[Permission]
	ADD CONSTRAINT PK_Permission PRIMARY KEY (Id)
	
ALTER TABLE [Scheduler].[dbo].[Phone]
	ADD CONSTRAINT PK_Phone				PRIMARY KEY (Id),
		CONSTRAINT FK_Phone_Country		FOREIGN KEY (CountryId)	REFERENCES [Scheduler].[dbo].[Country]	(Id),
		CONSTRAINT FK_Phone_Person		FOREIGN KEY (PersonId)	REFERENCES [Scheduler].[dbo].[Person]	(Id),
		CONSTRAINT FK_Phone_Company		FOREIGN KEY (CompanyId)	REFERENCES [Scheduler].[dbo].[Company]	(Id)
		
ALTER TABLE [Scheduler].[dbo].[RoleType]
	ADD CONSTRAINT PK_RoleType PRIMARY KEY (Id)

ALTER TABLE [Scheduler].[dbo].[Role]
	ADD CONSTRAINT PK_Role			PRIMARY KEY (Id),
		CONSTRAINT FK_Role_Company	FOREIGN KEY (CompanyId)	REFERENCES [Scheduler].[dbo].[Company]	(Id),
		CONSTRAINT FK_Role_Type		FOREIGN KEY (TypeId)	REFERENCES [Scheduler].[dbo].[RoleType]	(Id)

ALTER TABLE [Scheduler].[dbo].[Scope]
	ADD CONSTRAINT PK_Scope			PRIMARY KEY (Id)

ALTER TABLE [Scheduler].[dbo].[RoleObjectScope]
	ADD CONSTRAINT PK_RoleObjectScope			PRIMARY KEY (Id),
		CONSTRAINT FK_RoleObjectScope_Role		FOREIGN KEY (RoleId)	REFERENCES [Scheduler].[dbo].[Role]	(Id),
		CONSTRAINT FK_RoleObjectScope_Scope		FOREIGN KEY (ScopeId)	REFERENCES [Scheduler].[dbo].[Scope]	(Id)

ALTER TABLE [Scheduler].[dbo].[RolePermissionScopeEntity]
	ADD CONSTRAINT PK_RolePermissionScopeEntity				PRIMARY KEY (EntityId, PermissionId, RoleId, ScopeId),
		CONSTRAINT FK_RolePermissionScopeEntity_Entity		FOREIGN KEY (EntityId)	REFERENCES [Scheduler].[dbo].[Entity]	(Id),
		CONSTRAINT FK_RolePermissionScopeEntity_Permission	FOREIGN KEY (PermissionId)	REFERENCES [Scheduler].[dbo].[Permission]	(Id),
		CONSTRAINT FK_RolePermissionScopeEntity_Role		FOREIGN KEY (RoleId)	REFERENCES [Scheduler].[dbo].[Role]	(Id),
		CONSTRAINT FK_RolePermissionScopeEntity_Scope		FOREIGN KEY (ScopeId)	REFERENCES [Scheduler].[dbo].[Scope]	(Id)

ALTER TABLE [Scheduler].[dbo].[UserDashBoardItem]
	ADD CONSTRAINT PK_UserDashBoardItem	PRIMARY KEY (Id),
		CONSTRAINT FK_UserDashBoardItem_User	FOREIGN KEY (UserId)	REFERENCES [Scheduler].[dbo].[User]	(Id)

ALTER TABLE [Scheduler].[dbo].[UserHistory]
	ADD CONSTRAINT PK_UserHistory	PRIMARY KEY (Id),
		CONSTRAINT FK_UserHistory_User	FOREIGN KEY (UserId)	REFERENCES [Scheduler].[dbo].[User]	(Id)

ALTER TABLE [Scheduler].[dbo].[UserRole]
	ADD CONSTRAINT PK_UserRole		PRIMARY KEY (RoleId, UserId),
		CONSTRAINT FK_UserRole_Role	FOREIGN KEY (RoleId)	REFERENCES [Scheduler].[dbo].[Role]	(Id),
		CONSTRAINT FK_UserRole_User	FOREIGN KEY (UserId)	REFERENCES [Scheduler].[dbo].[User]	(Id)

ALTER TABLE [Scheduler].[dbo].[UserSetting]
	ADD CONSTRAINT PK_UserSetting				PRIMARY KEY (Id),
		CONSTRAINT FK_UserSetting_User			FOREIGN KEY (UserId)	REFERENCES [Scheduler].[dbo].[User]	(Id),
		CONSTRAINT FK_UserSetting_VideoProfile	FOREIGN KEY (VideoProfileId)	REFERENCES [Scheduler].[dbo].[VideoProfile]	(Id)



