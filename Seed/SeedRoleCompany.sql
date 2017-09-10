IF NOT EXISTS (SELECT [Id] FROM [dbo].[RoleCompany])
	BEGIN
		-- get the IDs and the variables that conatain the names
		DECLARE @SystemAdministrators VARCHAR(50) = 'System Administrators'
		DECLARE @Everyone VARCHAR(50) = 'Everyone'
		DECLARE @SystemAdministratorRoleId UNIQUEIDENTIFIER = (SELECT [Id] FROM [RoleType] WHERE [Name] = @SystemAdministrators)
		DECLARE @EveryoneId UNIQUEIDENTIFIER = (SELECT [Id] FROM [RoleType] WHERE [Name] = @Everyone)
		DECLARE @CompanyId UNIQUEIDENTIFIER = (SELECT [Id] FROM [Company] WHERE [Name] = 'DCL Inc') -- Starts with DCL

		-- IDs and names are used in the RoleCompany table
		-- Every company starts with the roles: 'SystemAdministrators' and 'Everyone'
		INSERT INTO [RoleCompany]([Id], [Name], [CompanyId], [TypeId]) VALUES(NEWID(), @SystemAdministrators,	@CompanyId, @SystemAdministratorRoleId)
		INSERT INTO [RoleCompany]([Id], [Name], [CompanyId], [TypeId]) VALUES(NEWID(), @Everyone,				@CompanyId, @EveryoneId)
	END

