DECLARE @UnitedStatesId UNIQUEIDENTIFIER = (SELECT [ID]									-- United States
												FROM [dbo].[Country] 
												WHERE [Name] = 'United States')


IF NOT EXISTS (SELECT [ID] FROM [dbo].[Address] WHERE [Address1] = '14050 W State Road 84')
	INSERT INTO [dbo].[Address]
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
           , (SELECT [ID] FROM [dbo].[State] WHERE [Name] = 'Florida')
           , NULL
           , '33324'
           , @UnitedStatesId)
GO