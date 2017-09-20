IF NOT EXISTS (SELECT * FROM [dbo].[MenuItemRoleScope])
	BEGIN
		DECLARE @CompanyId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[Company] WHERE [Name] = 'DCL Inc' ) 
		DECLARE @EveryoneRoleTypeId UNIQUEIDENTIFIER = (SELECT [Id] FROM [RoleType] WHERE [Name] = 'Everyone')
		DECLARE @RoleCompanyId UNIQUEIDENTIFIER = (SELECT [Id] FROM [RoleCompany] 
													WHERE [RoleTypeId] = @EveryoneRoleTypeId) AND [CompanyId] = @CompanyId
		
		-- Assigns the root menuitem to 'everyone' in the company
		INSERT INTO [MenuItemRoleScope]
			(MenuItemId
			,RoleCompanyId)
		SELECT 
			@MenuItemId AS MenuItemId,						
			@RoleCompanyId AS RoleCompanyId		
			FROM [dbo].[MenuItem] 
			WHERE ParentId IS NULL
	END
	