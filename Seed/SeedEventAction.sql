IF NOT EXISTS (SELECT * FROM [Scheduler].[dbo].[EventAction])
	INSERT INTO [Scheduler].[dbo].[EventAction]
           ([Id]
           ,[Name])
     VALUES
           ( NEWID(),'Cancel'),
           ( NEWID(),'Extend'),
           ( NEWID(),'Schedule'),
           ( NEWID(),'Goodnight'),
           ( NEWID(),'Update')
GO

