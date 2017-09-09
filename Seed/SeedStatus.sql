IF NOT EXISTS (SELECT * FROM [dbo].[Status])
	INSERT INTO [dbo].[Status]
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