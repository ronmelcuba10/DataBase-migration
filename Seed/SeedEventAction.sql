IF NOT EXISTS (SELECT * FROM [dbo].[EventAction])
	INSERT INTO [dbo].[EventAction]
           ([Id]
           ,[Name])
     VALUES
           ( NEWID(),'Cancel'),
           ( NEWID(),'Extend'),
           ( NEWID(),'Schedule'),
           ( NEWID(),'Goodnight'),
           ( NEWID(),'Update')
GO

