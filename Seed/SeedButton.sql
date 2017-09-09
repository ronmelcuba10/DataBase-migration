
IF NOT EXISTS (SELECT * FROM [dbo].[Button])
	INSERT INTO [dbo].[Button]
           ([Id]
           ,[Name]
           ,[ImageId]
           ,[IsHome])
     VALUES
			(NEWID(), 'Save',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Save 32x32.png'),0),
			(NEWID(), 'Add',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Plus Green 32x32.png'),0),
			(NEWID(), 'Roles',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Roles 32x32.png'),0),
			(NEWID(), 'Goodnight',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Goodnight 32x32.png'),0),
			(NEWID(), 'NewGridButton',		 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Plus Green 32x32.png'),0),
			(NEWID(), 'Move Down',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Arrow Down Green 32x32.png'),0),
			(NEWID(), 'Log',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'DIGICASTER Device Log 32x32.png'),0),
			(NEWID(), 'Connection',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Connection 32x32.png'),0),
			(NEWID(), 'Video',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Video 32x32.png'),0),
			(NEWID(), 'Device Permissions',  (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'DIGICASTER Device Permissions 32x32.png'),0),
			(NEWID(), 'GridDelete',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Trash 32x32.png'),0),
			(NEWID(), 'Extend',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Extend 32x32.png'),0),
			(NEWID(), 'Clear',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Clear Event 32x32.png'),0),
			(NEWID(), 'PageButtons',		 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Buttons 32x32.png'),0),
			(NEWID(), 'API',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'API 32x32.png'),0),
			(NEWID(), 'DeleteSub',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Trash 32x32.png'),0),
			(NEWID(), 'Add Event',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Add Event 32x32.png'),0),
			(NEWID(), 'Home',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Home 32x32.png'),1),
			(NEWID(), 'Move Up',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Arrow Up Green 32x32.png'),0),
			(NEWID(), 'Delete',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Trash 32x32.png'),0),
			(NEWID(), 'Cancel',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Cancel 32x32.png'),0),
			(NEWID(), 'Edit',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Edit 32x32.png'),0),
			(NEWID(), 'GridEdit',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Edit 32x32.png'),0),
			(NEWID(), 'EditSub',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Edit 32x32.png'),0),
			(NEWID(), 'Calendar',			 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Calendar 32x32.png'),0),
			(NEWID(), 'Exit',				 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Exit 32x32.png'),0),
			(NEWID(), 'Restart Encoder',	 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Button Refresh 32x32.png'),0),
			(NEWID(), 'Grid Button Roles',	 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Grid Buttons Permissions 32x32.png'),0),
			(NEWID(), 'Add Recurring Event', (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Recurring Appointment 32x32.png'),0),
			(NEWID(), 'PageButtonRoles',	 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Page Buttons Permissions 32x32.png'),0),
			(NEWID(), 'Tool Destination',	 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Tools 32x32.png'),0),
			(NEWID(), 'Tool Source',		 (SELECT [Id] FROM [dbo].[Image] WHERE [Name] = 'Tools 32x32.png'),0)
			
Go
           

























GO


