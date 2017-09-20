IF NOT EXISTS (SELECT [Id] FROM [dbo].[Company] WHERE [Name] = 'DCL Inc')
	INSERT INTO [dbo].[Company]
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
			   ('83418BD4-CD7A-46D2-A676-E577462978DC' -- keep the DeviceCaster's hard coded ID 
			   , 'DCL Inc'
			   , (SELECT [ID] FROM [dbo].[Address] WHERE [Address1] = '14050 W State Road 84')
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