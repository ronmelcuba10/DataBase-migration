IF NOT EXISTS (SELECT [ID] FROM [Scheduler].[dbo].[Company] WHERE [Name] = 'DCL Inc')
	INSERT INTO [Scheduler].[dbo].[Company]
			   ([Id]
			   ,[Name]
			   ,[AddressId]
			   ,[Website]
			   ,[IsMaster]
			   ,[Contact]
			   ,[Email]
			   ,[AccountingEmail]
			   ,[AccountingNotifications]
			   ,[EventEmail]
			   ,[EventNotifications]
			   ,[Enabled])
		 VALUES
			   (NEWID()
			   , 'DCL Inc'
			   , (SELECT [ID] FROM [Scheduler].[dbo].[Address] WHERE [Address1] = '14050 W State Road 84')
			   , 'http://dclinc.net'
			   , 1
			   , 'Robert Mendes'
			   , 'mendes@dclinc.net'
			   , NULL
			   , 0
			   , NULL
			   , 0
			   , 1)
		
GO