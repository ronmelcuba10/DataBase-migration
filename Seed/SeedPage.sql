IF NOT EXISTS (SELECT * FROM [Scheduler].[dbo].[Page])
	INSERT INTO [Scheduler].[dbo].[Page]
           ([Id]
           ,[Name]
           ,[BrowserTitle]
           ,[PageTitle]
           ,[Url]
           ,[AvailableOnDashboard]
           ,[ImageId])
     VALUES
			(NEWID(), 'Appliances', 'Appliances', 'Appliance Management', 'Appliances.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Host 128x128.png')),
			(NEWID(), 'Brand Details', 'Brand Details', 'Brand Details', 'BrandEdit.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Tag 128x128.png')),
			(NEWID(), 'Brands', 'Brands', 'Brand Mnagement', 'Brands.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Tag 128x128.png')),
			(NEWID(), 'Button Edit', 'Button Edit', 'Button Edit', 'ButtonEdit.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Buttons 128x128.png')),
			(NEWID(), 'Button Management', 'Buttons', 'Button Managerment', 'Buttons.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Buttons 128x128.png')),
			(NEWID(), 'Change Password', 'Change Password', 'Change Password', 'ChangePassword.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Permissions 128x128.png')),
			(NEWID(), 'Customer Details', 'Customer Details', 'Customer Details', 'CompanyEdit.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Customers 128x128.png')),
			(NEWID(), 'Customers', 'Customers', 'Customer Management', 'Companies.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Customers 128x128.png')),
			(NEWID(), 'Dashboard', 'Dashboard', 'Dashboard', 'Dashboard.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Dashboard 128x128.png')),
			(NEWID(), 'Device Calendar', 'Device Calendar', 'Device Calendar', 'DeviceCalendar.aspx', NULL, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Calendar 128x128.png')),
			(NEWID(), 'Device Permissions', 'Device Permissions', 'Device Permissions', 'DeviceSharing.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'DIGICASTER Device Permissions 128x128.png')),
			(NEWID(), 'Event Details', 'Event Details', 'Event Details', 'EventEdit.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Appointment 128x128.png')),
			(NEWID(), 'Event Scheduling', 'Events', 'Event Scheduling', 'Scheduling.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Appointment 128x128.png')),
			(NEWID(), 'Grid Button Permission', 'Grid Button Permissions', 'Grid Button Permission', 'GridButtonRoles.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Grid Buttons Permissions 128x128.png')),
			(NEWID(), 'Host Management', 'Hosts', 'Host Management', 'Host.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Host 128x128.png')),
			(NEWID(), 'Image Edit', 'Image Edit', 'Image Edit', 'ImageEdit.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Edit 128x128.png')),
			(NEWID(), 'Images', 'Images', 'Image Management', 'Images.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Pictures 128x128.png')),
			(NEWID(), 'Logon', 'Logon', 'Logon', 'Logon.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Abacus 128x128.png')),
			(NEWID(), 'Logouot', 'Logouot', 'Logouot', 'Logout.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Accounts 256x256.png')),
			(NEWID(), 'Manage Role''s Users', 'Role''s Users', 'Manage Role''s Users', 'RoleUsers.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Groups 128x128.png')),
			(NEWID(), 'Menu Item Permissions', 'Menu Item Permissions', 'Menu Item Permissions', 'MenuItemRoles.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Menu Permissions 128x128.png')),
			(NEWID(), 'Menu Items', 'Menu Items', 'Menu Item Management', 'MenuItems.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Menu 128x128.png')),
			(NEWID(), 'MenuItemEdit', 'MenuI tem Edit', 'MenuI tem Edit', 'MenuItemEdit.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Menu 128x128.png')),
			(NEWID(), 'Monitor', 'Monitor', 'Event Monitoring', 'Monitor.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Monitor 128x128.png')),
			(NEWID(), 'Page Button Permission ', 'Page Button Permissions', 'Page Button Permission', 'PageButtonRoles.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Page Buttons Permissions 128x128.png')),
			(NEWID(), 'Page Buttons', 'Page Buttons', 'Page Buttons', 'PageButtons.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Page Buttons 128x128.png')),
			(NEWID(), 'Page Permissions', 'Page Permissions', 'Page Permissions', 'PageRoles.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Page Permissions 128x128.png')),
			(NEWID(), 'PageEdit', 'PageEdit', 'PageEdit', 'PageEdit.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Edit 128x128.png')),
			(NEWID(), 'Pages', 'Pages', 'Page Management', 'Pages.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Web Pages 128x128.png')),
			(NEWID(), 'Role Management', 'Roles', 'Role Management', 'Roles.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Roles 128x128.png')),
			(NEWID(), 'Role''s User Management', 'Role''s Users', 'Role''s User Management', 'RoleEdit.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Groups 128x128.png')),
			(NEWID(), 'System Settings', 'System Settings', 'System Settings', 'SystemSettings.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Settings 128x128.png')),
			(NEWID(), 'User Details', 'User Details', 'User Details', 'UserEdit.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'User 128x128.png')),
			(NEWID(), 'User Management', 'Users', 'User Management', 'Users.aspx', 1, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Groups 128x128.png')),
			(NEWID(), 'User Profile', 'User Profile', 'User Profile', 'UserProfile.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Profile 128x128.png')),
			(NEWID(), 'User''s Roles', 'User''s Roles', 'Manage User''s Roles', 'UserRoles.aspx', 0, (SELECT [Id] FROM [Scheduler].[dbo].[Image] WHERE [Name] = 'Roles 128x128.png'))
GO

