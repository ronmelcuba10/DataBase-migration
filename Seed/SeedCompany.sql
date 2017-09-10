IF NOT EXISTS (SELECT [Id] FROM [dbo].[Company] WHERE [Name] = 'DCL Inc')
	INSERT INTO [dbo].[Company]
			   ([Id]
			   ,[Name]
			   ,[AddressId]
			   ,[Website]
			   ,[IsMaster]
			   ,[Contact]
			   ,[Email]
			   ,[AccountingEmail]
			   ,[AccountingNotifications]
			   ,[EventEmail]
			   ,[EventNotifications]
			   ,[Enabled])
		 VALUES
			   (NEWID()
			   , 'DCL Inc'
			   , (SELECT [ID] FROM [dbo].[Address] WHERE [Address1] = '14050 W State Road 84')
			   , 'http://dclinc.net'
			   , 1
			   , 'Robert Mendes'
			   , 'mendes@dclinc.net'
			   , NULL
			   , 0
			   , NULL
			   , 0
			   , 1)


/*
Uncomment After finishing the seeding on tables RoleObjectScope and RoleCompany

-- Updating table RoleCompany
DECLARE @SystemAdministrators VARCHAR(50) = 'SystemAdministrators'
DECLARE @Everyone VARCHAR(50) = 'Everyone'
DECLARE @SystemAdministratorRoleId UNIQUEIDENTIFIER = (SELECT [Id] FROM [RoleType] WHERE [Name] = 'System Administrators')
DECLARE @EveryoneId UNIQUEIDENTIFIER = (SELECT [Id] FROM [RoleType] WHERE [Name] = 'Everyone')
INSERT INTO [RoleCompany](Id, Name, CompanyId, TypeId) VALUES(NEWID(), 'System Administrators', @CompanyId, @SystemAdministratorRoleId)
DECLARE @RoleCompanyId UNIQUEIDENTIFIER = NEWID()
INSERT INTO [RoleCompany](Id, Name, CompanyId, TypeId) VALUES(@RoleCompanyId, 'Everyone', @CompanyId, @EveryoneId)

-- Updating RoleObjectScope
INSERT INTO [RoleObjectScope]
	(ObjectId
	,RoleCompanyId)
SELECT 
	Id AS ObjectId,						
	@RoleCompanyId AS RoleCompanyId		
FROM [MenuItems] WHERE ParentId IS NULL
*/

GO