IF NOT EXISTS (SELECT * FROM .[dbo].[Scope])
	INSERT INTO .[dbo].[Scope]
           ([Id]
           ,[Name]
           ,[Value])
     VALUES
           (NEWID(), 'None'		, 0),
           (NEWID(), 'Owner'	, 1),
           (NEWID(), 'Company'	, 2),
           (NEWID(), 'All'		, 10)
GO