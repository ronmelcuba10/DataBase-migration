DECLARE @UnitedStatesId UNIQUEIDENTIFIER = (SELECT [ID]									-- United States
												FROM [Scheduler].[dbo].[Country] 
												WHERE [Name] = 'United States')


IF NOT EXISTS (SELECT [ID] FROM [Scheduler].[dbo].[Address] WHERE [Address1] = '14050 W State Road 84')
	INSERT INTO [Scheduler].[dbo].[Address]
           ([Id]
           ,[Address1]
           ,[Address2]
           ,[City]
           ,[StateId]
           ,[StateProvince]
           ,[Zip]
           ,[CountryId])
     VALUES
           ( NEWID()
           , '14050 W State Road 84'
           , NULL
           , 'Davie'
           , (SELECT [ID] FROM [Scheduler].[dbo].[State] WHERE [Name] = 'Florida')
           , NULL
           , '33324'
           , @UnitedStatesId)
GO