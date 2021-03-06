USE [SchedulerProduction]
GO
/****** Object:  UserDefinedFunction [dbo].[Function_MaxScopeValue_ByUserIdObjectId]    Script Date: 09/12/2017 11:21:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Function_MaxScopeValue_ByUserIdGridButtonId](@UserId UNIQUEIDENTIFIER, @GridButtonId UNIQUEIDENTIFIER)  
RETURNS INT   
AS   
-- Returns the stock level for the product.  
BEGIN  
    DECLARE @ret INT = (SELECT MAX(Value) 
							FROM [Scope] 
							WHERE [Id] IN (SELECT [ScopeId] 
											FROM [dbo].[GridButtonRoleScope]
											WHERE [GridButtonId]=@GridButtonId 
												AND [RoleCompanyId] IN (SELECT [RoleCompanyId] FROM [UserRole] WHERE [UserId]=@UserId)
												AND [ScopeId] IS NOT NULL))
    IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret;  
END;
GO
/****** Object:  UserDefinedFunction [dbo].[GridButtonId_ByNamePageUrl]    Script Date: 09/21/2017 08:49:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ronny
-- Create date: 9-21-2017
-- Description:	Returns the Gridbutton Id from its name and page name
-- =============================================
CREATE FUNCTION [dbo].[GridButtonId_ByNamePageUrl](@PageUrl VARCHAR(100), @ButtonName VARCHAR(50))
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @PageId UNIQUEIDENTIFIER  = (SELECT [Id] FROM [dbo].[Page] WHERE [Url]=@PageUrl)
	DECLARE @ButtonId UNIQUEIDENTIFIER = (SELECT Id	FROM [dbo].[Button]	WHERE [Name]=@ButtonName)
	DECLARE @GridButtonId UNIQUEIDENTIFIER = (SELECT [Id] FROM [dbo].[GridButton] WHERE [PageId]=@PageId AND [ButtonId]=@ButtonId)
	RETURN @GridButtonId
END
GO
/****** Object:  UserDefinedFunction [dbo].[RoleType_AdministratorRoleID]    Script Date: 09/21/2017 10:15:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ronny
-- Create date: 9-21-2017
-- Description:	Returns 'Administrator' role type ID
-- =============================================
CREATE FUNCTION [dbo].RoleType_AdministratorRoleID ()
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
	RETURN (SELECT [Id] FROM [dbo].[RoleType] WHERE [Name] = 'System Administrators')
END
GO
/****** Object:  UserDefinedFunction [dbo].[EventStatus_byName]    Script Date: 09/21/2017 10:15:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ronny
-- Create date: 9-21-2017
-- Description:	Returns 'Administrator' role type ID
-- =============================================
CREATE FUNCTION [dbo].[EventStatus_byName](@EventStatusName VARCHAR(100))
RETURNS INT
AS
BEGIN
	RETURN (SELECT [Id] FROM [dbo].[EventStatus] WHERE [Name] = @EventStatusName)
END
GO