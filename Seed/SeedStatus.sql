IF NOT EXISTS (SELECT * FROM [Scheduler].[dbo].[Status])
	INSERT INTO [Scheduler].[dbo].[Status]
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