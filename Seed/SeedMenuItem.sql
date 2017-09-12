IF NOT EXISTS (SELECT * FROM .[dbo].[MenuItem])
BEGIN
	-- initializing variables

	-- Variables indented to show parent relationship
	DECLARE @RootMenuItemId UNIQUEIDENTIFIER = NEWID();

		DECLARE @MainMenuMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @DashboardMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @CustomersMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @HostsMenuItemId UNIQUEIDENTIFIER = NEWID();
			
		DECLARE @EventsMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @MonitorMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @ScheduleMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @AlertsMenuItemId UNIQUEIDENTIFIER = NEWID();
			
		DECLARE @SecurityMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @RolesMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @UsersMenuItemId UNIQUEIDENTIFIER = NEWID();
			
		DECLARE @AdministrationMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @SettingsMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @PagesMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @ButtonsMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @ImagesMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @MenuItemsMenuItemId UNIQUEIDENTIFIER = NEWID();
			DECLARE @BrandsMenuItemId UNIQUEIDENTIFIER = NEWID();
		
		DECLARE @ReportsMenuItemId UNIQUEIDENTIFIER = NEWID();


	-- ImageId variables
	DECLARE @RootImageId UNIQUEIDENTIFIER = NULL;
		DECLARE @MainMenuImageId UNIQUEIDENTIFIER = NULL;
			DECLARE @DashboardImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Dashboard 16x16.png');
			DECLARE @CustomersImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Customers 16x16.png');
			DECLARE @HostsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Host 16x16.png');

		DECLARE @EventsImageId UNIQUEIDENTIFIER = NULL;
			DECLARE @MonitorImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Monitor 16x16.png');
			DECLARE @ScheduleImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Appointment 16x16.png');
			DECLARE @AlertsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Alert Yellow 16x16.png');

		DECLARE @SecurityImageId UNIQUEIDENTIFIER = NULL;
			DECLARE @RolesImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Roles 16x16.png');
			DECLARE @UsersImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 16x16.png');

		DECLARE @AdministrationImageId UNIQUEIDENTIFIER = NULL;
			DECLARE @SettingsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
			DECLARE @PagesImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = '');
			DECLARE @ButtonsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Buttons 16x16.png');
			DECLARE @MenuItemImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu 16x16.png');
			DECLARE @ImagesImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Pictures 16x16.png');
			DECLARE @BrandsImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Tag 16x16.png');
	
		DECLARE @ReportsImageId UNIQUEIDENTIFIER = NULL;




	-- PageId variables
	DECLARE @RootPageId UNIQUEIDENTIFIER = NULL;

		DECLARE @MainMenuPageId UNIQUEIDENTIFIER = NULL;
			DECLARE @DashboardPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Dashboard');
			DECLARE @CustomersPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Customers');
			DECLARE @HostsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Host Management');

		DECLARE @EventsPageId UNIQUEIDENTIFIER = NULL;
			DECLARE @MonitorPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Monitor');
			DECLARE @SchedulePageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Event Scheduling');
			DECLARE @AlertsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Event Scheduling');
	
		DECLARE @SecurityPageId UNIQUEIDENTIFIER = NULL;
			DECLARE @RolesPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Role Management');
			DECLARE @UsersPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'User Management');
			
		DECLARE @AdministrationPageId UNIQUEIDENTIFIER = NULL;
			DECLARE @SettingsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'System Settings');
			DECLARE @PagesPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Pages');
			DECLARE @ButtonsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Button Management');
			DECLARE @MenuItemPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Menu Items');
			DECLARE @ImagesPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Images');
			DECLARE @BrandsPageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Page] WHERE [Name] = 'Brands');

		DECLARE @ReportsPageId UNIQUEIDENTIFIER = NULL;

	
	-- seeding section
	INSERT INTO .[dbo].[MenuItem]
			   ([Id],						[Name],				[ParentId],					[Title],		[Index], [ToolTip],							[ImageId],				[Size],[PageId])
		 VALUES
				(@RootMenuItemId,			'Root',				'NULL',						'Root Menu',		0, 'NULL',								NULL,					NULL,	NULL),

				(@MainMenuMenuItemId,		'Main Menu',		@RootMenuItemId,			'Main Menu',		1, 'Main Menu',							NULL,					NULL,	NULL),	
				(@DashboardMenuItemId,		'Dashboard',		@MainMenuMenuItemId,		'Dashboard',		1, 'Dashboard',							@DashboardImageId,		16,		@DashboardPageId),
				(@HostsMenuItemId,			'Hosts',			@MainMenuMenuItemId,		'Hosts',			3, 'Manage Hosts',						@HostsImageId,			16,		@HostsPageId),
				(@CustomersMenuItemId,		'Customers',		@MainMenuMenuItemId,		'Customers',		2, 'Manage Customer Information',		@CustomersImageId,		16,		@CustomersPageId),

				(@EventsMenuItemId,			'Events',			@RootMenuItemId,			'Events',			2, 'Events',							NULL,					NULL,	NULL),
				(@MonitorMenuItemId,		'Monitor',			@EventsMenuItemId,			'Monitor',			3, 'Manage Event',						@MonitorImageId,		16,		@MonitorPageId),
				(@AlertsMenuItemId,			'Alerts',			@EventsMenuItemId,			'Alerts',			5, 'Event Alerts',						@AlertsImageId,			16,		@AlertsPageId),
				(@ScheduleMenuItemId,		'Schedule',			@EventsMenuItemId,			'Schedule',			4, 'Manage Event Schedule',				@ScheduleImageId,		16,		@SchedulePageId ),

				(@AdministrationMenuItemId, 'Administration',	@RootMenuItemId,			'Administration',	3, 'Administration',					NULL,					NULL,	NULL),
				(@MenuItemsMenuItemId,		'Menu Items',		@AdministrationMenuItemId,	'Menu Items',		1, 'Manage Menu Items and Permissions', @MenuItemImageId,		16,		@MenuItemPageId),
				(@PagesMenuItemId,			'Pages',			@AdministrationMenuItemId,	'Pages',			2, 'Manage Page Information',			@PagesImageId,			16,		@PagesPageId),
				(@ButtonsMenuItemId,		'Buttons',			@AdministrationMenuItemId,	'Buttons',			3, 'Buttons',							@ButtonsImageId,		16,		@ButtonsPageId),
				(@ImagesMenuItemId,			'Images',			@AdministrationMenuItemId,	'Images',			4, 'Manage Images',						@ImagesImageId,			16,		@ImagesPageId),
				(@BrandsMenuItemId,			'Brands',			@AdministrationMenuItemId,	'Brands',			5, 'NULL',								@BrandsImageId,			16,		@BrandsPageId),
				(@SettingsMenuItemId,		'Settings',			@AdministrationMenuItemId,	'System Settings',	6, 'Manage System Settings',			@SettingsImageId,		16,		@SettingsPageId),

				(@SecurityMenuItemId,		'Security',			@RootMenuItemId,			'Security',			4, 'Manage System Security',			NULL,					NULL,	NULL),
				(@UsersMenuItemId,			'Users',			@SecurityMenuItemId,		'Users',			1, 'Manage Users',						@UsersImageId,			16,		@UsersPageId),
				(@RolesMenuItemId,			'Roles',			@SecurityMenuItemId,		'Roles',			2, 'Manage Roles',						@RolesImageId,			16,		@RolesPageId),

				(@ReportsMenuItemId,		'Reports',			@RootMenuItemId,			'Reports',			5, 'Reports',							NULL,					NULL,	NULL)

END


GO

