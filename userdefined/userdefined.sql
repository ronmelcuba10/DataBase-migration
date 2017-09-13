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
    DECLARE @ret INT;  
    SELECT @ret=MAX(Value) FROM [Scope] WHERE [Id] IN
		(
			SELECT [ScopeId] FROM [PageButtonRoleScope]
			WHERE [PageButtonId]=@GridButtonId
			AND [RoleCompanyId] IN (SELECT [RoleCompanyId] FROM [UserRole] WHERE [UserId]=@UserId)
			AND [ScopeId] IS NOT NULL
		)
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret;  
END;
GO
