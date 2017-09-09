IF NOT EXISTS (SELECT [ID] FROM [dbo].[MonitorStatus])
	INSERT INTO [dbo].[MonitorStatus]
           ([Id],
		   [Name])
     VALUES
			(NEWID(), 'All'),
			(NEWID(), 'Running'),
			(NEWID(), 'Future'),
			(NEWID(), 'Past'),
			(NEWID(), 'Cancelled'),
			(NEWID(), 'Cleared')
GO
