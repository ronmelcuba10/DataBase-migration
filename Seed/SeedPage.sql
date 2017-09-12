IF NOT EXISTS (SELECT * FROM [dbo].[Page])
BEGIN
	-- variable initialization
	DECLARE @ApplianceImageId UNIQUEIDENTIFIER =	(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Host 128x128.png')
	DECLARE @BrandDetail UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Tag 128x128.png')
	DECLARE @BrandsId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Tag 128x128.png')
	DECLARE @ButtonEditId UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Buttons 128x128.png')
	DECLARE @ButtonsId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Buttons 128x128.png')
	DECLARE @ChangePasswordId UNIQUEIDENTIFIER =	(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Permissions 128x128.png')
	DECLARE @CompanyEditId UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Customers 128x128.png')
	DECLARE @CompaniesId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Customers 128x128.png')
	DECLARE @DashboardId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Dashboard 128x128.png')
	DECLARE @DeviceCalendarrId UNIQUEIDENTIFIER =	(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Calendar 128x128.png')
	DECLARE @DeviceSharingId UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'DIGICASTER Device Permissions 128x128.png')
	DECLARE @EventEditId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Appointment 128x128.png')
	DECLARE @SchedulingId UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Appointment 128x128.png')
	DECLARE @GridButtonRolesId UNIQUEIDENTIFIER =	(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Grid Buttons Permissions 128x128.png')
	DECLARE @HostId UNIQUEIDENTIFIER =				(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Host 128x128.png')
	DECLARE @ImageEditId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Edit 128x128.png')
	DECLARE @ImagesId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Pictures 128x128.png')
	DECLARE @LogonIdLogon UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Abacus 128x128.png')
	DECLARE @LogouotId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Accounts 256x256.png')
	DECLARE @RolesUsersId UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 128x128.png')
	DECLARE @MenuItemRolesId UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu Permissions 128x128.png')
	DECLARE @MenuItemsId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu 128x128.png')
	DECLARE @MenuItemEditId UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu 128x128.png')
	DECLARE @MonitorId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Monitor 128x128.png')
	DECLARE @PageButtonRolesId UNIQUEIDENTIFIER =	(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Buttons Permissions 128x128.png')
	DECLARE @PageButtonsId UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Buttons 128x128.png')
	DECLARE @PageRolesId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Permissions 128x128.png')
	DECLARE @PageEditId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Edit 128x128.png')
	DECLARE @PagesId UNIQUEIDENTIFIER =				(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Web Pages 128x128.png')
	DECLARE @RolesId UNIQUEIDENTIFIER =				(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Roles 128x128.png')
	DECLARE @RoleEditId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 128x128.png')
	DECLARE @SystemSettingsId UNIQUEIDENTIFIER =	(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Settings 128x128.png')
	DECLARE @UserEditId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'User 128x128.png')
	DECLARE @UsersId UNIQUEIDENTIFIER =				(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 128x128.png')
	DECLARE @UserProfileId UNIQUEIDENTIFIER =		(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Profile 128x128.png')
	DECLARE @UserRolesId UNIQUEIDENTIFIER =			(SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Roles 128x128.png')

	--


	INSERT INTO [dbo].[Page]
        ([Id],		[Name],						[BrowserTitle],				[PageTitle],				[Url],			[AvailableOnDashboard],	[ImageId],			[Size])
   VALUES
		(NEWID(), 'Appliances',					'Appliances',				'Appliance Management',		'Appliances.aspx',		1,				@ApplianceImageId,	128),
		(NEWID(), 'Brand Details',				'Brand Details',			'Brand Details',			'BrandEdit.aspx',		0,				@BrandDetail,		128),
		(NEWID(), 'Brands',						'Brands',					'Brand Mnagement',			'Brands.aspx',			1,				@BrandsId,			128),
		(NEWID(), 'Button Edit',				'Button Edit',				'Button Edit',				'ButtonEdit.aspx',		0,				@ButtonEditId,		128),
		(NEWID(), 'Button Management',			'Buttons',					'Button Managerment',		'Buttons.aspx',			1,				@ButtonsId,			128),
		(NEWID(), 'Change Password',			'Change Password',			'Change Password',			'ChangePassword.aspx',	0,				@ChangePasswordId,	128),
		(NEWID(), 'Customer Details',			'Customer Details',			'Customer Details',			'CompanyEdit.aspx',		0,				@CompanyEditId,		128),
		(NEWID(), 'Customers',					'Customers',				'Customer Management',		'Companies.aspx',		0,				@CompaniesId,		128),
		(NEWID(), 'Dashboard',					'Dashboard',				'Dashboard',				'Dashboard.aspx',		1,				@DashboardId,		128),
		(NEWID(), 'Device Calendar',			'Device Calendar',			'Device Calendar',			'DeviceCalendar.aspx',	NULL,			@DeviceCalendarrId,	128),
		(NEWID(), 'Device Permissions',			'Device Permissions',		'Device Permissions',		'DeviceSharing.aspx',	0,				@DeviceSharingId,	128),
		(NEWID(), 'Event Details',				'Event Details',			'Event Details',			'EventEdit.aspx',		0,				@EventEditId,		128),
		(NEWID(), 'Event Scheduling',			'Events',					'Event Scheduling',			'Scheduling.aspx',		1,				@SchedulingId,		128),
		(NEWID(), 'Grid Button Permission',		'Grid Button Permissions',  'Grid Button Permission',	'GridButtonRoles.aspx', 0,				@GridButtonRolesId,	128),
		(NEWID(), 'Host Management',			'Hosts',					'Host Management',			'Host.aspx',			1,				@HostId,			128),
		(NEWID(), 'Image Edit',					'Image Edit',				'Image Edit',				'ImageEdit.aspx',		0,				@ImageEditId,		128),
		(NEWID(), 'Images',						'Images',					'Image Management',			'Images.aspx',			0,				@ImagesId,			128),
		(NEWID(), 'Logon',						'Logon',					'Logon',					'Logon.aspx',			0,				@LogonIdLogon,		128),
		(NEWID(), 'Logouot',					'Logouot',					'Logouot',					'Logout.aspx',			0,				@LogouotId,			128),
		(NEWID(), 'Manage Role''s Users',		'Role''s Users',			'Manage Role''s Users',		'RoleUsers.aspx',		0,				@RolesUsersId,		128),
		(NEWID(), 'Menu Item Permissions',		'Menu Item Permissions',	'Menu Item Permissions',	'MenuItemRoles.aspx',	0,				@MenuItemRolesId,	128),
		(NEWID(), 'Menu Items',					'Menu Items',				'Menu Item Management',		'MenuItems.aspx',		1,				@MenuItemsId,		128),
		(NEWID(), 'MenuItemEdit',				'MenuI tem Edit',			'MenuI tem Edit',			'MenuItemEdit.aspx',	0,				@MenuItemEditId,	128),
		(NEWID(), 'Monitor',					'Monitor',					'Event Monitoring',			'Monitor.aspx',			1,				@MonitorId,			128),
		(NEWID(), 'Page Button Permission ',	'Page Button Permissions',	'Page Button Permission',	'PageButtonRoles.aspx', 0,				@PageButtonRolesId,	128),
		(NEWID(), 'Page Buttons',				'Page Buttons',				'Page Buttons',				'PageButtons.aspx',		0,				@PageButtonsId,		128),
		(NEWID(), 'Page Permissions',			'Page Permissions',			'Page Permissions',			'PageRoles.aspx',		0,				@PageRolesId,		128),
		(NEWID(), 'PageEdit',					'PageEdit',					'PageEdit',					'PageEdit.aspx',		0,				@PageEditId,		128),
		(NEWID(), 'Pages',						'Pages',					'Page Management',			'Pages.aspx',			1,				@PagesId,			128),
		(NEWID(), 'Role Management',			'Roles',					'Role Management',			'Roles.aspx',			1,				@RolesId,			128),
		(NEWID(), 'Role''s User Management',	'Role''s Users',			'Role''s User Management',	'RoleEdit.aspx',		0,				@RolesId,			128),
		(NEWID(), 'System Settings',			'System Settings',			'System Settings',			'SystemSettings.aspx',	1,				@SystemSettingsId,	128),
		(NEWID(), 'User Details',				'User Details',				'User Details',				'UserEdit.aspx',		0,				@UserEditId,		128),
		(NEWID(), 'User Management',			'Users',					'User Management',			'Users.aspx',			1,				@UsersId,			128),
		(NEWID(), 'User Profile',				'User Profile',				'User Profile',				'UserProfile.aspx',		0,				@UserProfileId,		128),
		(NEWID(), 'User''s Roles',				'User''s Roles',			'Manage User''s Roles',		'UserRoles.aspx',		0,				@UserRolesId,		128)
END
GO

