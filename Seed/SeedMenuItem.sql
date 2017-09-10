IF NOT EXISTS (SELECT * FROM .[dbo].[MenuItem])
BEGIN
	-- initializing variables

	-- MenuitemsId variables
	DECLARE @RootMenuItemId UNIQUEIDENTIFIER = NEWID();
		DECLARE @MainMenuMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @DashboardMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @CustomersdMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @HostsMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @BrandsMenuItemId UNIQUEIDENTIFIER = NEWID();

		DECLARE @EventsMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @MonitorMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @ScheduleMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @AlertsMenuItemId UNIQUEIDENTIFIER = NEWID();

		DECLARE @SecurityMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @RolesMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @UsersMenuItemId UNIQUEIDENTIFIER = NEWID();

		DECLARE @SettingsMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @PagesMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @ButtonsMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @ImagesMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @MenuItemsMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @AdministrationMenuItemId UNIQUEIDENTIFIER = NEWID();

		DECLARE @ReportsMenuItemId UNIQUEIDENTIFIER = NEWID();


	-- ImageId variables
	DECLARE @RootImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @MainMenuImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @DashboardImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @CustomersdImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @HostsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @BrandsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @EventsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @MonitorImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @ScheduleImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @AlertsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @SecurityImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @RolesImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @UsersImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @SettingsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @PagesImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @ButtonsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @MenuItemImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @ImagesImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @AdministrationImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
	DECLARE @ReportsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');

	-- PageId variables
	DECLARE @RootPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @MainMenuPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @DashboardPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @CustomersdPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @HostsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @BrandsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @EventsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @MonitorPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @SchedulePageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @AlertsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @SecurityPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @RolesPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @UsersPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @SettingsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @PagesPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @ButtonsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @PagesPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @PagesPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @AdministrationPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');
	DECLARE @ReportsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = '');






/*	
Alert Yellow 16x16.png
Appointment 16x16.png
Buttons 16x16.png
Customers 16x16.png
Dashboard 16x16.png
Groups 16x16.png
Host 16x16.png
Menu 16x16.png
Monitor 16x16.png
Pictures 16x16.png
Roles 16x16.png
Settings 16x16.png
Tag 16x16.png
Web Pages 16x16.png
*/

	
	INSERT INTO .[dbo].[MenuItem]
			   ([Id] ,						[Name] ,			[ParentId] ,			[Title] ,	  [Index] ,[ToolTip] ,[ImageId] ,[PageId])
		 VALUES
				(@RootMenuItemId,			'Root',				'NULL',					'Root Menu',		0, 'NULL',								,),
				(@UsersMenuItemId,			'Users',			@SecurityMenuItemId,	'Users',			1, 'Manage Users',						,),
				(@MainMenuMenuItemId,		'Main Menu',		@RootMenuItemId,		'Main Menu',		1, 'Main Menu',							,),
				(@DashboardMenuItemId,		'Dashboard',		@MainMenuMenuItemId,	'Dashboard',		1, 'Dashboard',							,),
				(@MenuItemsMenuItemId,		'Menu Items',		@SettingsMenuItemId,	'Menu Items',		1, 'Manage Menu Items and Permissions', ,),
				(@CustomersdMenuItemId,		'Customers',		@MainMenuMenuItemId,	'Customers',		2, 'Manage Customer Information',		,),
				(@EventsMenuItemId,			'Events',			@RootMenuItemId,		'Events',			2, 'Events',							,),
				(@PagesMenuItemId,			'Pages',			@SettingsMenuItemId,	'Pages',			2, 'Manage Page Information',			,),
				(@RolesMenuItemI,			'Roles',			@SecurityMenuItemId,	'Roles',			2, 'Manage Roles',						,),
				(@HostsMenuItemId,			'Hosts',			@MainMenuMenuItemId,	'Hosts',			3, 'Manage Hosts',						,),
				(@ButtonsMenuItemId,		'Buttons',			@SettingsMenuItemId,	'Buttons',			3, 'Buttons',							,),
				(@AdministrationMenuItemId, 'Administration',	@SettingsMenuItemId,	'Administration',	3, 'Administration',					,),
				(@MonitorMenuItemId,		'Monitor',			@EventsMenuItemId,		'Monitor',			3, 'Manage Event',						,),
				(@SecurityMenuItemId,		'Security',			@RootMenuItemId,		'Security',			4, 'Manage System Security',			,),
				(@ScheduleMenuItemId,		'Schedule',			@EventsMenuItemId,		'Schedule',			4, 'Manage Event Schedule',				,),
				(@ImagesMenuItemId,			'Images',			@SettingsMenuItemId,	'Images',			4, 'Manage Images',						,),
				(@BrandsMenuItemId,			'Brands',			@MainMenuMenuItemId,	'Brands',			5, 'NULL',								,),
				(@ReportsMenuItemId,		'Reports',			@RootMenuItemId,		'Reports',			5, 'Reports',							,),
				(@AlertsMenuItemId,			'Alerts',			@EventsMenuItemId,		'Alerts',			5, 'Event Alerts',						,),
				(@SettingsMenuItemId,		'Settings',			@RootMenuItemId,		'System Settings',	6, 'Manage System Settings',			,)

END


GO

