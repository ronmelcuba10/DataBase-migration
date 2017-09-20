IF NOT EXISTS (SELECT * FROM [dbo].[EventStatus])
	INSERT INTO [dbo].[EventStatus]
           ([Name])
     VALUES
			('All'),
			('Scheduled'),
			('Starting'),
			('Started'),
			('Stopping'),
			('Stopped'),
			('Goodnighting'),
			('Goodnighted'),
			('Cancelled'),
			('Clearing'),
			('Cleared')

GO