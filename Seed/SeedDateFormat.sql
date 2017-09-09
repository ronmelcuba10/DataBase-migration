IF NOT EXISTS (SELECT * FROM [dbo].[DateFormat])
	INSERT INTO [dbo].[DateFormat]
           ([Id]
           ,[Name]
           ,[IsDefault])
     VALUES
			(NEWID(), 'MM/dd/yy',	NULL),
			(NEWID(), 'dd/MM/yy',	NULL),
			(NEWID(), 'dd/MM/yyyy',	NULL),
			(NEWID(), 'MM/dd/yyyy',	1)
GO