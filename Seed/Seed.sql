
-- Country   *******************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedCountry.sql

-- State   *******************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedState.sql

-- Image  *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedImage.sql

-- Address *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedAddress.sql

-- RoleType  *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedRoleType.sql

-- DCLINC Company  *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedCompany.sql

-- Status  *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedStatus.sql

-- Scope  *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedScope.sql

-- Configuration  *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedConfiguration.sql

-- DateFormat  *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedDateFormat.sql

-- DateFormat  *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedButton.sql

-- EventAction  *********************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedEventAction.sql

-- Page  ****************************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedPage.sql

-- Grid  ****************************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedGrid.sql

-- Monitor Status  ****************************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedMonitorStatus.sql

-- Role Company  ****************************************************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\SeedRoleCompany.sql



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

