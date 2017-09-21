USE [SchedulerProduction]
GO
-- Country   *******************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedCountry.sql

-- State   *******************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedState.sql

-- Image  *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedImage.sql

-- Address *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedAddress.sql

-- RoleType  *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedRoleType.sql

-- DCLINC Company  *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedCompany.sql

-- Status  *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedEventStatus.sql

-- Scope  *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedScope.sql

-- Configuration  *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedConfiguration.sql

-- DateFormat  *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedDateFormat.sql

-- DateFormat  *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedButton.sql

-- EventAction  *********************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedEventAction.sql

-- Page  ****************************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedPage.sql

-- Grid  ****************************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedGrid.sql

-- Monitor Status  ****************************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedMonitorStatus.sql

-- Role Company  ****************************************************************************************************************************
:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedRoleCompany.sql

-- Video profile  ****************************************************************************************************************************
--:r C:\Users\Harry\Desktop\Ron\NewSchedulerScripts\MigrationScripts\Seed\SeedVideoProfile.sql NO need



/*
-- Entity  *********************************************************************************************************************
IF NOT EXISTS (SELECT * FROM [Scheduler].[dbo].[Entity])
	INSERT INTO [Scheduler].[dbo].[Entity]
           ([Id]
           ,[Name])
     VALUES
			(NEWID(), 'Event'),
			(NEWID(), ''),
			(NEWID(), ''),
			(NEWID(), '')

*/



GO

