IF NOT EXISTS (SELECT * FROM [Scheduler].[dbo].[Grid])
	INSERT INTO [Scheduler].[dbo].[Grid]
           ([Id]
           ,[Name]
           ,[Tag]
           ,[PageId])
     VALUES
			(NEWID(), 'Brand Permissions', 'gvBrandPermissions', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Brands')),
			(NEWID(), 'Brands', 'gvBrands', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Brands')),
			(NEWID(), 'Customers', 'gvCustomers', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Customers')),
			(NEWID(), 'Dashboard Items', 'gvDashboardItems', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'User Profile')),
			(NEWID(), 'Font Images', 'gvFontImages', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Images')),
			(NEWID(), 'Menu Item Permissions', 'gvMenuItemPermissions', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Menu Items')),
			(NEWID(), 'Menu Items', 'gvMenuItems', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Menu Items')),
			(NEWID(), 'Monitor', 'gvMonitor', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Monitor')),
			(NEWID(), 'Page Button Permissions', 'gvPageButtonPermissions', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Page Buttons')),
			(NEWID(), 'Page Buttons', 'gvPageButtons', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Page Buttons')),
			(NEWID(), 'Page Permissions', 'gvPagePermissions', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Pages')),
			(NEWID(), 'Pages', 'gvPages', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Pages')),
			(NEWID(), 'Roles', 'gvRoles', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'Role Management')),
			(NEWID(), 'Users', 'gvUsers', (SELECT [Id] FROM [Scheduler].[dbo].[Page] WHERE [Name] = 'User Management'))
GO











