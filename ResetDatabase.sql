-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||																									  ||
-- ||	This query deletes all the database and restore with some values, it should be used with care	  ||
-- ||																								      ||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

-- Clears the database   ***********************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\ClearWholeDataBase.sql

-- Creates the database   **********************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Creation.sql

-- Creates all the keys and constraints  *******************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\KeysAndConstraints.sql

-- Seeds the tables  ***************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\Seed.sql

-- Creates the function   **********************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\userdefined\userdefined.sql

-- Creates the stored Procedures   *************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\StoredProcedures\sp.sql

-- Creates the views   *************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Views\views.sql

