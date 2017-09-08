IF NOT EXISTS (SELECT * FROM [Scheduler].[dbo].[DateFormat])
	INSERT INTO [Scheduler].[dbo].[DateFormat]
           ([Id]
           ,[Name]
           ,[IsDefault])
     VALUES
			(NEWID(), 'MM/dd/yy',	NULL),
			(NEWID(), 'dd/MM/yy',	NULL),
			(NEWID(), 'dd/MM/yyyy',	NULL),
			(NEWID(), 'MM/dd/yyyy',	1)
GO