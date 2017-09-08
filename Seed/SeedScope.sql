IF NOT EXISTS (SELECT * FROM [Scheduler].[dbo].[Scope])
	INSERT INTO [Scheduler].[dbo].[Scope]
           ([Id]
           ,[Name]
           ,[Value])
     VALUES
           (NEWID(), 'None'		, 0),
           (NEWID(), 'Owner'	, 1),
           (NEWID(), 'Company'	, 2),
           (NEWID(), 'All'		, 10)
GO