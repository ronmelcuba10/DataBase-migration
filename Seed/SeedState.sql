
DECLARE @UnitedStatesId UNIQUEIDENTIFIER = (SELECT [ID] 
												FROM [dbo].[Country] 
												WHERE [Name] = 'United States')
										

IF NOT EXISTS (SELECT * FROM [Scheduler].[dbo].[State])
	INSERT INTO [Scheduler].[dbo].[State]
			   ([Id]
			   ,[CountryId]
			   ,[PostalCode]
			   ,[Name])
		 VALUES
				( NEWID(), @UnitedStatesId, 'AL', 'Alabama'),
				( NEWID(), @UnitedStatesId, 'AK', 'Alaska'),
				( NEWID(), @UnitedStatesId, 'AS', 'American Samoa'),
				( NEWID(), @UnitedStatesId, 'AZ', 'Arizona'),
				( NEWID(), @UnitedStatesId, 'AR', 'Arkansas'),
				( NEWID(), @UnitedStatesId, 'CA', 'California'),
				( NEWID(), @UnitedStatesId, 'CO', 'Colorado'),
				( NEWID(), @UnitedStatesId, 'CT', 'Connecticut'),
				( NEWID(), @UnitedStatesId, 'DE', 'Delaware'),
				( NEWID(), @UnitedStatesId, 'DC', 'District of Columbia'),
				( NEWID(), @UnitedStatesId, 'FM', 'Federated States of Micronesia'),
				( NEWID(), @UnitedStatesId, 'FL', 'Florida'),
				( NEWID(), @UnitedStatesId, 'GA', 'Georgia'),
				( NEWID(), @UnitedStatesId, 'GU', 'Guam'),
				( NEWID(), @UnitedStatesId, 'HI', 'Hawaii'),
				( NEWID(), @UnitedStatesId, 'ID', 'Idaho'),
				( NEWID(), @UnitedStatesId, 'IL', 'Illinois'),
				( NEWID(), @UnitedStatesId, 'IN', 'Indiana'),
				( NEWID(), @UnitedStatesId, 'IA', 'Iowa'),
				( NEWID(), @UnitedStatesId, 'KS', 'Kansas'),
				( NEWID(), @UnitedStatesId, 'KY', 'Kentucky'),
				( NEWID(), @UnitedStatesId, 'LA', 'Louisiana'),
				( NEWID(), @UnitedStatesId, 'ME', 'Maine'),
				( NEWID(), @UnitedStatesId, 'MH', 'Marshall Islands'),
				( NEWID(), @UnitedStatesId, 'MD', 'Maryland'),
				( NEWID(), @UnitedStatesId, 'MA', 'Massachusetts'),
				( NEWID(), @UnitedStatesId, 'MI', 'Michigan'),
				( NEWID(), @UnitedStatesId, 'MN', 'Minnesota'),
				( NEWID(), @UnitedStatesId, 'MS', 'Mississippi'),
				( NEWID(), @UnitedStatesId, 'MO', 'Missouri'),
				( NEWID(), @UnitedStatesId, 'MT', 'Montana'),
				( NEWID(), @UnitedStatesId, 'NE', 'Nebraska'),
				( NEWID(), @UnitedStatesId, 'NV', 'Nevada'),
				( NEWID(), @UnitedStatesId, 'NH', 'New Hampshire'),
				( NEWID(), @UnitedStatesId, 'NJ', 'New Jersey'),
				( NEWID(), @UnitedStatesId, 'NM', 'New Mexico'),
				( NEWID(), @UnitedStatesId, 'NY', 'New York'),
				( NEWID(), @UnitedStatesId, 'NC', 'North Carolina'),
				( NEWID(), @UnitedStatesId, 'ND', 'North Dakota'),
				( NEWID(), @UnitedStatesId, 'MP', 'Northern Mariana Islands'),
				( NEWID(), @UnitedStatesId, 'OH', 'Ohio'),
				( NEWID(), @UnitedStatesId, 'OK', 'Oklahoma'),
				( NEWID(), @UnitedStatesId, 'OR', 'Oregon'),
				( NEWID(), @UnitedStatesId, 'PW', 'Palau'),
				( NEWID(), @UnitedStatesId, 'PA', 'Pennsylvania'),
				( NEWID(), @UnitedStatesId, 'PR', 'Puerto Rico'),
				( NEWID(), @UnitedStatesId, 'RI', 'Rhode Island'),
				( NEWID(), @UnitedStatesId, 'SC', 'South Carolina'),
				( NEWID(), @UnitedStatesId, 'SD', 'South Dakota'),
				( NEWID(), @UnitedStatesId, 'TN', 'Tennessee'),
				( NEWID(), @UnitedStatesId, 'TX', 'Texas'),
				( NEWID(), @UnitedStatesId, 'UT', 'Utah'),
				( NEWID(), @UnitedStatesId, 'VT', 'Vermont'),
				( NEWID(), @UnitedStatesId, 'VI', 'Virgin Islands'),
				( NEWID(), @UnitedStatesId, 'VA', 'Virginia'),
				( NEWID(), @UnitedStatesId, 'WA', 'Washington'),
				( NEWID(), @UnitedStatesId, 'WV', 'West Virginia'),
				( NEWID(), @UnitedStatesId, 'WI', 'Wisconsin'),
				( NEWID(), @UnitedStatesId, 'WY', 'Wyoming')

GO