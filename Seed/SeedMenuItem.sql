IF NOT EXISTS (SELECT * FROM .[dbo].[MenuItem])
BEGIN
	DECLARE @RootId UNIQUEIDENTIFIER = NEWID();
	DECLARE @AdministrationId UNIQUEIDENTIFIER = NEWID();
	DECLARE @SecurityId UNIQUEIDENTIFIER = NEWID();
	DECLARE @MainMenuId UNIQUEIDENTIFIER = NEWID();
	DECLARE @EventsId UNIQUEIDENTIFIER = NEWID();
	
	DECLARE @AppointmentId UNIQUEIDENTIFIER = NEWID();
	DECLARE @Id UNIQUEIDENTIFIER = NEWID();
	DECLARE @SecurityId UNIQUEIDENTIFIER = NEWID();
	DECLARE @MainMenuId UNIQUEIDENTIFIER = NEWID();
	DECLARE @EventsId UNIQUEIDENTIFIER = NEWID();
	
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

	
	INSERT INTO .[dbo].[MenuItem]
			   ([Id] ,[Name] ,[ParentId] ,[Title] ,[Index] ,[ToolTip] ,[ImageId] ,[PageId])
		 VALUES
				(@RootId, 'Root', 'NULL', 'Root Menu', '0', 'NULL', ,),
				(NEWID(), 'Users', , 'Users', 1, 'Manage Users', ,),
				(NEWID(), 'Main Menu', , 'Main Menu', 1, 'Main Menu', ,),
				(NEWID(), 'Dashboard', , 'Dashboard', 1, 'Dashboard', ,),
				(NEWID(), 'Menu Items', , 'Menu Items', 1, 'Manage Menu Items and Permissions', ,),
				(NEWID(), 'Customers', , 'Customers', 2, 'Manage Customer Information', ,),
				(NEWID(), 'Events', , 'Events', 2, 'Events', ,),
				(NEWID(), 'Pages', , 'Pages', 2, 'Manage Page Information', ,),
				(NEWID(), 'Roles', , 'Roles', 2, 'Manage Roles', ,),
				(NEWID(), 'Hosts', , 'Hosts', 3, 'Manage Hosts', ,),
				(NEWID(), 'Buttons', , 'Buttons', 3, 'Buttons', ,),
				(NEWID(), 'Administration', , 'Administration', 3, 'Administration', ,),
				(NEWID(), 'Monitor', , 'Monitor', 3, 'Manage Event', ,),
				(NEWID(), 'Security', , 'Security', 4, 'Manage System Security', ,),
				(NEWID(), 'Schedule', , 'Schedule', 4, 'Manage Event Schedule', ,),
				(NEWID(), 'Images', , 'Images', 4, 'Manage Images', ,),
				(NEWID(), 'Brands', , 'Brands', 5, 'NULL', ,),
				(NEWID(), 'Reports', , 'Reports', 5, 'Reports', ,),
				(NEWID(), 'Alerts', , 'Alerts', 5, 'Event Alerts', ,),
				(NEWID(), 'Settings', , 'System Settings', 6, 'Manage System Settings,,)

END



GO

