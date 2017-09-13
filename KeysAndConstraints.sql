-- These scripts add the primary and foreign key to the tables

ALTER TABLE [dbo].[Country]
	ADD CONSTRAINT PK_Country PRIMARY KEY (Id)
	
ALTER TABLE [dbo].[State]
	ADD CONSTRAINT PK_State				PRIMARY KEY (Id),
		CONSTRAINT FK_State_Country		FOREIGN KEY (CountryId)	REFERENCES [dbo].[Country]	(Id)

ALTER TABLE [dbo].[Address]
	ADD CONSTRAINT PK_Address			PRIMARY KEY (Id),
		CONSTRAINT FK_Address_Country	FOREIGN KEY (CountryId)	REFERENCES [dbo].[Country]	(Id),
		CONSTRAINT FK_Address_State		FOREIGN KEY (StateId)	REFERENCES [dbo].[State]	(Id)
		
ALTER TABLE [dbo].[Image]
	ADD CONSTRAINT PK_Image PRIMARY KEY (Id)

ALTER TABLE [dbo].[Brand]
	ADD CONSTRAINT PK_Brand						PRIMARY KEY (Id),
		CONSTRAINT FK_Brand_Images_Favicon		FOREIGN KEY (FaviconImageId)	REFERENCES [dbo].[Image]	(Id),
		CONSTRAINT FK_Brand_Images_LoginBanner	FOREIGN KEY (LoginBannerImageId) REFERENCES [dbo].[Image]	(Id),
		CONSTRAINT FK_Brand_Images_LoginTag		FOREIGN KEY (LoginTagImageId)	REFERENCES [dbo].[Image]	(Id),
		CONSTRAINT FK_Brand_Images_Portal		FOREIGN KEY (PortalImageId)		REFERENCES [dbo].[Image]	(Id)
	
ALTER TABLE [dbo].[BrandUrl]
	ADD CONSTRAINT PK_BrandUrl			PRIMARY KEY (Id),
		CONSTRAINT FK_BrandUrl_Brand	FOREIGN KEY (BrandId)	REFERENCES [dbo].[Brand]	(Id)

ALTER TABLE [dbo].[Button]
	ADD CONSTRAINT PK_Button		PRIMARY KEY (Id),
		CONSTRAINT FK_Button_Image	FOREIGN KEY (ImageId)	REFERENCES [dbo].[Image]	(Id)
	
ALTER TABLE [dbo].[Company]
	ADD CONSTRAINT PK_Company PRIMARY KEY (Id)

ALTER TABLE [dbo].[CompanyType]
	ADD CONSTRAINT PK_CompanyType PRIMARY KEY (Id)
	
ALTER TABLE [dbo].[Configuration]
	ADD CONSTRAINT PK_Configuration PRIMARY KEY (Id)

ALTER TABLE [dbo].[DateFormat]
	ADD CONSTRAINT PK_DateFormat PRIMARY KEY (Id)
	
ALTER TABLE [dbo].[Host]
	ADD CONSTRAINT PK_Host			PRIMARY KEY (Id),
		CONSTRAINT FK_Host_Company	FOREIGN KEY (CompanyId)	REFERENCES [dbo].[Company] (Id)

ALTER TABLE [dbo].[Device]
	ADD CONSTRAINT PK_Device		PRIMARY KEY (Id),
		CONSTRAINT FK_Device_Host	FOREIGN KEY (HostId)	REFERENCES [dbo].[Host]	(Id)

ALTER TABLE [dbo].[DeviceSharedToCompany]
	ADD CONSTRAINT PK_DeviceSharedToCompany			    PRIMARY KEY (DeviceId, CompanyId),
		CONSTRAINT FK_DeviceSharedToCompany_Device		FOREIGN KEY (DeviceId)	REFERENCES [dbo].[Device]	(Id),
		CONSTRAINT FK_DeviceSharedToCompany_Company		FOREIGN KEY (CompanyId)	REFERENCES [dbo].[Company]	(Id)
		
ALTER TABLE [dbo].[Entity]
	ADD CONSTRAINT PK_Entity PRIMARY KEY (Id)
	
ALTER TABLE [dbo].[Status]
	ADD CONSTRAINT PK_Status PRIMARY KEY (Id)
	
ALTER TABLE [dbo].[InputStream]
	ADD CONSTRAINT PK_InputStream		PRIMARY KEY (Id),
		CONSTRAINT FK_InputStream_Host	FOREIGN KEY (HostId)	REFERENCES [dbo].[Host]	(Id)

ALTER TABLE [dbo].[OutputStream]
	ADD CONSTRAINT PK_OutputStream			PRIMARY KEY (Id),
		CONSTRAINT FK_OutputStream_Host		FOREIGN KEY (HostId)	REFERENCES [dbo].[Host]	(Id)

ALTER TABLE [dbo].[PleClientStreamConfig]
	ADD CONSTRAINT PK_PLEClienStreamConfig		PRIMARY KEY (Id),
		CONSTRAINT FK_PLEClienStreamConfig_Host	FOREIGN KEY (HostId)	REFERENCES [dbo].[Host]	(Id)

ALTER TABLE [dbo].[PLEServerConfig]
	ADD CONSTRAINT PK_PLEServerConfig		PRIMARY KEY (Id),
		CONSTRAINT FK_PLEServerConfig_Host	FOREIGN KEY (HostId)	REFERENCES [dbo].[Host]	(Id)

ALTER TABLE [dbo].[PLEServerStream]
	ADD CONSTRAINT PK_PLEServerStream		PRIMARY KEY (Id),
		CONSTRAINT FK_PLEServerStream_Host	FOREIGN KEY (HostId)	REFERENCES [dbo].[Host]	(Id)
		
ALTER TABLE [dbo].[Page]
	ADD CONSTRAINT PK_Page			PRIMARY KEY (Id),
		CONSTRAINT FK_Page_Image	FOREIGN KEY (ImageId)	REFERENCES [dbo].[Image]	(Id)
		
ALTER TABLE [dbo].[Person]
	ADD CONSTRAINT PK_Person			PRIMARY KEY (Id),
		CONSTRAINT FK_Person_Address	FOREIGN KEY (AddressId)	REFERENCES [dbo].[Address]	(Id)

ALTER TABLE [dbo].[User]
	ADD CONSTRAINT PK_User				PRIMARY KEY (Id),
		CONSTRAINT FK_User_Company		FOREIGN KEY (CompanyId)	REFERENCES [dbo].[Company]	(Id),
		CONSTRAINT FK_User_DateFormat	FOREIGN KEY (DateFormatId)	REFERENCES [dbo].[DateFormat]	(Id),
		CONSTRAINT FK_User_Page			FOREIGN KEY (PageId)	REFERENCES [dbo].[Page]	(Id),
		CONSTRAINT FK_User_Person		FOREIGN KEY (PersonId)	REFERENCES [dbo].[Person]	(Id)

ALTER TABLE [dbo].[VideoProfile]
	ADD CONSTRAINT PK_VideoProfile	PRIMARY KEY (Id)

ALTER TABLE [dbo].[Event]
	ADD CONSTRAINT PK_Event							PRIMARY KEY (Id),
		CONSTRAINT FK_Event_Company					FOREIGN KEY (CompanyId)	REFERENCES [dbo].[Company]	(Id),
		CONSTRAINT FK_Event_SourceDevice			FOREIGN KEY (SourceDeviceId)	REFERENCES [dbo].[Device]	(Id),
		CONSTRAINT FK_Event_DestinationDevice		FOREIGN KEY (DestinationDeviceId)	REFERENCES [dbo].[Device]	(Id),
		CONSTRAINT FK_Event_Status					FOREIGN KEY (StatusId)	REFERENCES [dbo].[Status]	(Id),
		CONSTRAINT FK_Event_InputStream				FOREIGN KEY (InputStreamId)	REFERENCES [dbo].[InputStream]	(Id),
		CONSTRAINT FK_Event_OutputStream			FOREIGN KEY (OutputStreamId)	REFERENCES [dbo].[OutputStream]	(Id),
		CONSTRAINT FK_Event_PLEClientStreamConfig	FOREIGN KEY (PLEClientStreamConfigId)	REFERENCES [dbo].[PLEClientStreamConfig]	(Id),
		CONSTRAINT FK_Event_PLEServerConfig			FOREIGN KEY (PLEServerConfigId)	REFERENCES [dbo].[PLEServerConfig]	(Id),
		CONSTRAINT FK_Event_PLEServerStream			FOREIGN KEY (PLEServerStreamId)	REFERENCES [dbo].[PLEServerStream]	(Id),
		CONSTRAINT FK_Event_Creator					FOREIGN KEY (CreatorId)	REFERENCES [dbo].[User]	(Id),
		CONSTRAINT FK_Event_Owner					FOREIGN KEY (OwnerId)	REFERENCES [dbo].[User]	(Id),
		CONSTRAINT FK_Event_VideoProfile			FOREIGN KEY (VideoProfileId)	REFERENCES [dbo].[VideoProfile]	(Id)
	
ALTER TABLE [dbo].[EventAction]
	ADD CONSTRAINT PK_EventAction PRIMARY KEY (Id)
	
ALTER TABLE [dbo].[EventHistory]
	ADD CONSTRAINT PK_EventHistory					PRIMARY KEY (Id),
		CONSTRAINT FK_EventHistory_Event			FOREIGN KEY (EventId)	REFERENCES [dbo].[Event]	(Id),
		CONSTRAINT FK_EventHistory_EventAction		FOREIGN KEY (EventActionId)	REFERENCES [dbo].[EventAction]	(Id),
		CONSTRAINT FK_EventHistory_User				FOREIGN KEY (UserId)	REFERENCES [dbo].[User]	(Id),
		CONSTRAINT FK_EventHistory_Owner		FOREIGN KEY (OwnerId)	REFERENCES [dbo].[User]	(Id),
		CONSTRAINT FK_EventHistory_VideoProfile		FOREIGN KEY (VideoProfileId)	REFERENCES [dbo].[VideoProfile]	(Id)

ALTER TABLE [dbo].[Grid]
	ADD CONSTRAINT PK_Grid			PRIMARY KEY (Id),
		CONSTRAINT FK_Grid_Page		FOREIGN KEY (PageId)	REFERENCES [dbo].[Page]	(Id)
		
ALTER TABLE [dbo].[HostHistory]
	ADD CONSTRAINT PK_HostHistory		PRIMARY KEY (Id),
		CONSTRAINT FK_HostHistory_Host	FOREIGN KEY (HostId)	REFERENCES [dbo].[Host]	(Id),
		CONSTRAINT FK_HostHistory_User	FOREIGN KEY (UserId)	REFERENCES [dbo].[User]	(Id)

ALTER TABLE [dbo].[MenuItem]
	ADD CONSTRAINT PK_MenuItem			PRIMARY KEY (Id),
		CONSTRAINT FK_MenuItem_Image	FOREIGN KEY (ImageId)	REFERENCES [dbo].[Image]	(Id),
		CONSTRAINT FK_MenuItem_Parent	FOREIGN KEY (ParentId)	REFERENCES [dbo].[MenuItem]	(Id),
		CONSTRAINT FK_MenuItem_Page		FOREIGN KEY (PageId)	REFERENCES [dbo].[Page]	(Id)
		
ALTER TABLE [dbo].[PageButton]
	ADD CONSTRAINT PK_PageButton				PRIMARY KEY (Id),
		CONSTRAINT FK_PageButton_Button			FOREIGN KEY (ButtonId)	REFERENCES [dbo].[Button]	(Id),
		CONSTRAINT FK_PageButton_Page			FOREIGN KEY (PageId)	REFERENCES [dbo].[Page]	(Id),
		CONSTRAINT FK_PageButton_RedirectPage	FOREIGN KEY (RedirectPageId)	REFERENCES [dbo].[Page]	(Id)
		
ALTER TABLE [dbo].[Permission]
	ADD CONSTRAINT PK_Permission PRIMARY KEY (Id)
	
ALTER TABLE [dbo].[Phone]
	ADD CONSTRAINT PK_Phone				PRIMARY KEY (Id),
		CONSTRAINT FK_Phone_Country		FOREIGN KEY (CountryId)	REFERENCES [dbo].[Country]	(Id),
		CONSTRAINT FK_Phone_Person		FOREIGN KEY (PersonId)	REFERENCES [dbo].[Person]	(Id),
		CONSTRAINT FK_Phone_Company		FOREIGN KEY (CompanyId)	REFERENCES [dbo].[Company]	(Id)
		
ALTER TABLE [dbo].[RoleType]
	ADD CONSTRAINT PK_RoleType PRIMARY KEY (Id)

ALTER TABLE [dbo].[RoleCompany]
	ADD CONSTRAINT PK_Role			PRIMARY KEY (Id),
		CONSTRAINT FK_Role_Company	FOREIGN KEY (CompanyId)	REFERENCES [dbo].[Company]	(Id),
		CONSTRAINT FK_Role_RoleType	FOREIGN KEY (RoleTypeId)REFERENCES [dbo].[RoleType]	(Id)

ALTER TABLE [dbo].[Scope]
	ADD CONSTRAINT PK_Scope			PRIMARY KEY (Id)
	
ALTER TABLE [dbo].[BrandRoleScope]
	ADD CONSTRAINT PK_BrandRoleScope			PRIMARY KEY (Id),
		CONSTRAINT FK_BrandRoleScope_Role		FOREIGN KEY (RoleCompanyId)	REFERENCES [dbo].[RoleCompany]	(Id),
		CONSTRAINT FK_BrandRoleScope_Scope		FOREIGN KEY (ScopeId)		REFERENCES [dbo].[Scope]	(Id),
		CONSTRAINT FK_BrandRoleScope_MenuItem	FOREIGN KEY (BrandId)		REFERENCES [dbo].[Scope]	(Id)
	
ALTER TABLE [dbo].[MenuItemRoleScope]
	ADD CONSTRAINT PK_MenuItemRoleScope				PRIMARY KEY (Id),
		CONSTRAINT FK_MenuItemRoleScope_Role		FOREIGN KEY (RoleCompanyId)	REFERENCES [dbo].[RoleCompany]	(Id),
		CONSTRAINT FK_MenuItemRoleScope_Scope		FOREIGN KEY (ScopeId)		REFERENCES [dbo].[Scope]	(Id),
		CONSTRAINT FK_MenuItemRoleScope_MenuItem	FOREIGN KEY (MenuItemId)	REFERENCES [dbo].[Scope]	(Id)
	
ALTER TABLE [dbo].[PageButtonRoleScope]
	ADD CONSTRAINT PK_PageButtonRoleScope				PRIMARY KEY (Id),
		CONSTRAINT FK_PageButtonRoleScope_Role			FOREIGN KEY (RoleCompanyId)	REFERENCES [dbo].[RoleCompany]	(Id),
		CONSTRAINT FK_PageButtonRoleScope_Scope			FOREIGN KEY (ScopeId)		REFERENCES [dbo].[Scope]	(Id),
		CONSTRAINT FK_PageButtonRoleScope_PageButton	FOREIGN KEY (PageButtonId)	REFERENCES [dbo].[Scope]	(Id)

ALTER TABLE [dbo].[PageRoleScope]
	ADD CONSTRAINT PK_PageRoleScope			PRIMARY KEY (Id),
		CONSTRAINT FK_PageRoleScope_Role	FOREIGN KEY (RoleCompanyId)	REFERENCES [dbo].[RoleCompany]	(Id),
		CONSTRAINT FK_PageRoleScope_Scope	FOREIGN KEY (ScopeId)		REFERENCES [dbo].[Scope]	(Id),
		CONSTRAINT FK_PageRoleScope_Page	FOREIGN KEY (PageId)		REFERENCES [dbo].[Scope]	(Id)

-- remove in the future		
ALTER TABLE [dbo].[RoleObjectScope]
	ADD CONSTRAINT PK_RoleObjectScope			PRIMARY KEY (Id),
		CONSTRAINT FK_RoleObjectScope_Role		FOREIGN KEY (RoleCompanyId)	REFERENCES [dbo].[RoleCompany]	(Id),
		CONSTRAINT FK_RoleObjectScope_Scope		FOREIGN KEY (ScopeId)	REFERENCES [dbo].[Scope]	(Id)
		
ALTER TABLE [dbo].[RolePermissionScopeEntity]
	ADD CONSTRAINT PK_RolePermissionScopeEntity				PRIMARY KEY (EntityId, PermissionId, RoleCompanyId, ScopeId),
		CONSTRAINT FK_RolePermissionScopeEntity_Entity		FOREIGN KEY (EntityId)	REFERENCES [dbo].[Entity]	(Id),
		CONSTRAINT FK_RolePermissionScopeEntity_Permission	FOREIGN KEY (PermissionId)	REFERENCES [dbo].[Permission]	(Id),
		CONSTRAINT FK_RolePermissionScopeEntity_Role		FOREIGN KEY (RoleCompanyId)	REFERENCES [dbo].[RoleCompany]	(Id),
		CONSTRAINT FK_RolePermissionScopeEntity_Scope		FOREIGN KEY (ScopeId)	REFERENCES [dbo].[Scope]	(Id)

ALTER TABLE [dbo].[UserDashBoardPage]
	ADD CONSTRAINT PK_UserDashBoardPage			PRIMARY KEY (Id),
		CONSTRAINT FK_UserDashBoardPage_User	FOREIGN KEY (UserId)	REFERENCES [dbo].[User]	(Id),
		CONSTRAINT FK_UserDashBoardPage_Page	FOREIGN KEY (PageId)	REFERENCES [dbo].[Page]	(Id)

ALTER TABLE [dbo].[UserHistory]
	ADD CONSTRAINT PK_UserHistory	PRIMARY KEY (Id),
		CONSTRAINT FK_UserHistory_User	FOREIGN KEY (UserId)	REFERENCES [dbo].[User]	(Id)

ALTER TABLE [dbo].[UserRole]
	ADD CONSTRAINT PK_UserRole		PRIMARY KEY (RoleCompanyId, UserId),
		CONSTRAINT FK_UserRole_Role	FOREIGN KEY (RoleCompanyId)	REFERENCES [dbo].[RoleCompany]	(Id),
		CONSTRAINT FK_UserRole_User	FOREIGN KEY (UserId)	REFERENCES [dbo].[User]	(Id)

ALTER TABLE [dbo].[UserSetting]
	ADD CONSTRAINT PK_UserSetting				PRIMARY KEY (Id),
		CONSTRAINT FK_UserSetting_User			FOREIGN KEY (UserId)	REFERENCES [dbo].[User]	(Id),
		CONSTRAINT FK_UserSetting_VideoProfile	FOREIGN KEY (VideoProfileId)	REFERENCES [dbo].[VideoProfile]	(Id)



