IF NOT EXISTS (SELECT * FROM [dbo].[RoleType])
	INSERT INTO [dbo].[RoleType]
           ([Id]
           ,[Name])
     VALUES
           (NEWID(), 'System Administrators'),
           (NEWID(), 'Everyone'),
           (NEWID(), 'User defined')

GO