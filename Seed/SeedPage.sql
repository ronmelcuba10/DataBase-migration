IF NOT EXISTS (SELECT * FROM [dbo].[Page])
BEGIN
	-- variable initialization
	DECLARE @ApplianceImageId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Host 128x128.png')
	DECLARE @BrandDetail UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Tag 128x128.png')
	DECLARE @BrandsId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Tag 128x128.png')
	DECLARE @ButtonEditId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Buttons 128x128.png')
	DECLARE @ButtonsId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Buttons 128x128.png')
	DECLARE @ChangePasswordId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Permissions 128x128.png')
	DECLARE @CompanyEditId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Customers 128x128.png')
	DECLARE @CompaniesId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Customers 128x128.png')
	DECLARE @DashboardId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Dashboard 128x128.png')
	DECLARE @DeviceCalendarrId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Calendar 128x128.png')
	DECLARE @DeviceSharingId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'DIGICASTER Device Permissions 128x128.png')
	DECLARE @EventEditId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Appointment 128x128.png')
	DECLARE @SchedulingId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Appointment 128x128.png')
	DECLARE @GridButtonRolesId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Grid Buttons Permissions 128x128.png')
	DECLARE @HostId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Host 128x128.png')
	DECLARE @ImageEditId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Edit 128x128.png'),16),
	DECLARE @ImagesId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Pictures 128x128.png'),16),
	DECLARE @LogonIdLogon UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Abacus 128x128.png'),16),
	DECLARE @LogouotId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Accounts 256x256.png'),16),
	DECLARE @RolesUsersId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 128x128.png'),16),
	DECLARE @MenuItemRolesId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu Permissions 128x128.png'),16),
	DECLARE @MenuItemsId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu 128x128.png'),16),
	DECLARE @MenuItemEditId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu 128x128.png'),16),
	DECLARE @MonitorId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Monitor 128x128.png'),16),
	DECLARE @PageButtonRolesId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Buttons Permissions 128x128.png'),16),
	DECLARE @PageButtonsId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Buttons 128x128.png'),16),
	DECLARE @PageRolesId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Permissions 128x128.png'),16),
	DECLARE @PageEditId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Edit 128x128.png'),16),
	DECLARE @PagesId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Web Pages 128x128.png'),16),
	DECLARE @RolesId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Roles 128x128.png'),16),
	DECLARE @RoleEditId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 128x128.png'),16),
	DECLARE @SystemSettingsId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Settings 128x128.png'),16),
	DECLARE @UserEditId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'User 128x128.png'),16),
	DECLARE @UsersId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 128x128.png'),16),
	DECLARE @UserProfileId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Profile 128x128.png'),16),
	DECLARE @UserRolesId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Roles 128x128.png'),16)



















	--


	INSERT INTO [dbo].[Page]
        ([Id]
        ,[Name]
        ,[BrowserTitle]
        ,[PageTitle]
        ,[Url]
        ,[AvailableOnDashboard]
        ,[ImageId]
		,[Size])
   VALUES
		(NEWID(), 'Appliances', 'Appliances', 'Appliance Management', 'Appliances.aspx',	1, @ApplianceImageId, 16),
		(NEWID(), 'Brand Details', 'Brand Details', 'Brand Details', 'BrandEdit.aspx',		0, @BrandDetail,16),
		(NEWID(), 'Brands', 'Brands', 'Brand Mnagement', 'Brands.aspx', 1, ,16),
		(NEWID(), 'Button Edit', 'Button Edit', 'Button Edit', 'ButtonEdit.aspx', 0, ,16),
		(NEWID(), 'Button Management', 'Buttons', 'Button Managerment', 'Buttons.aspx', 1, ,16),
		(NEWID(), 'Change Password', 'Change Password', 'Change Password', 'ChangePassword.aspx', 0, ,16),
		(NEWID(), 'Customer Details', 'Customer Details', 'Customer Details', 'CompanyEdit.aspx', 0, ,16),
		(NEWID(), 'Customers', 'Customers', 'Customer Management', 'Companies.aspx', 0, ,16),
		(NEWID(), 'Dashboard', 'Dashboard', 'Dashboard', 'Dashboard.aspx', 1, ,16),
		(NEWID(), 'Device Calendar', 'Device Calendar', 'Device Calendar', 'DeviceCalendar.aspx', NULL, ,16),
		(NEWID(), 'Device Permissions', 'Device Permissions', 'Device Permissions', 'DeviceSharing.aspx', 0, ,16),
		(NEWID(), 'Event Details', 'Event Details', 'Event Details', 'EventEdit.aspx', 0, ,16),
		(NEWID(), 'Event Scheduling', 'Events', 'Event Scheduling', 'Scheduling.aspx', 1, ,16),
		(NEWID(), 'Grid Button Permission', 'Grid Button Permissions', 'Grid Button Permission', 'GridButtonRoles.aspx', 0, ,16),
		(NEWID(), 'Host Management', 'Hosts', 'Host Management', 'Host.aspx', 1, ,16),
		(NEWID(), 'Image Edit', 'Image Edit', 'Image Edit', 'ImageEdit.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Edit 128x128.png'),16),
		(NEWID(), 'Images', 'Images', 'Image Management', 'Images.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Pictures 128x128.png'),16),
		(NEWID(), 'Logon', 'Logon', 'Logon', 'Logon.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Abacus 128x128.png'),16),
		(NEWID(), 'Logouot', 'Logouot', 'Logouot', 'Logout.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Accounts 256x256.png'),16),
		(NEWID(), 'Manage Role''s Users', 'Role''s Users', 'Manage Role''s Users', 'RoleUsers.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 128x128.png'),16),
		(NEWID(), 'Menu Item Permissions', 'Menu Item Permissions', 'Menu Item Permissions', 'MenuItemRoles.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu Permissions 128x128.png'),16),
		(NEWID(), 'Menu Items', 'Menu Items', 'Menu Item Management', 'MenuItems.aspx', 1, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu 128x128.png'),16),
		(NEWID(), 'MenuItemEdit', 'MenuI tem Edit', 'MenuI tem Edit', 'MenuItemEdit.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Menu 128x128.png'),16),
		(NEWID(), 'Monitor', 'Monitor', 'Event Monitoring', 'Monitor.aspx', 1, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Monitor 128x128.png'),16),
		(NEWID(), 'Page Button Permission ', 'Page Button Permissions', 'Page Button Permission', 'PageButtonRoles.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Buttons Permissions 128x128.png'),16),
		(NEWID(), 'Page Buttons', 'Page Buttons', 'Page Buttons', 'PageButtons.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Buttons 128x128.png'),16),
		(NEWID(), 'Page Permissions', 'Page Permissions', 'Page Permissions', 'PageRoles.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Permissions 128x128.png'),16),
		(NEWID(), 'PageEdit', 'PageEdit', 'PageEdit', 'PageEdit.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Edit 128x128.png'),16),
		(NEWID(), 'Pages', 'Pages', 'Page Management', 'Pages.aspx', 1, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Web Pages 128x128.png'),16),
		(NEWID(), 'Role Management', 'Roles', 'Role Management', 'Roles.aspx', 1, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Roles 128x128.png'),16),
		(NEWID(), 'Role''s User Management', 'Role''s Users', 'Role''s User Management', 'RoleEdit.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 128x128.png'),16),
		(NEWID(), 'System Settings', 'System Settings', 'System Settings', 'SystemSettings.aspx', 1, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Settings 128x128.png'),16),
		(NEWID(), 'User Details', 'User Details', 'User Details', 'UserEdit.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'User 128x128.png'),16),
		(NEWID(), 'User Management', 'Users', 'User Management', 'Users.aspx', 1, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Groups 128x128.png'),16),
		(NEWID(), 'User Profile', 'User Profile', 'User Profile', 'UserProfile.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Profile 128x128.png'),16),
		(NEWID(), 'User''s Roles', 'User''s Roles', 'Manage User''s Roles', 'UserRoles.aspx', 0, (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Roles 128x128.png'),16)
END
GO

