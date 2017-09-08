IF NOT EXISTS (SELECT * FROM [Scheduler].[dbo].[RoleType])
	INSERT INTO [Scheduler].[dbo].[RoleType]
           ([Id]
           ,[Name])
     VALUES
           (NEWID(), 'System Administrators'),
           (NEWID(), 'Everyone'),
           (NEWID(), 'User defined')

GO