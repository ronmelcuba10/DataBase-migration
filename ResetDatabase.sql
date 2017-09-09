-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||																									  ||
-- ||	This query deletes all the database and restore with some values, it should be used with care	  ||
-- ||																								      ||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

-- Clears te database   ************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\ClearWholeDataBase.sql

-- Creates the database   **********************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Creation.sql

-- Creates all the keys and constraints  *******************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\KeysAndConstraints.sql

-- Seeds the database  *************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\Seed\Seed.sql

-- Stored Procedures   *************************************************************************************
:r F:\SQL\SchedulerProduction\MigrationScripts\StoredProcedures\sp.sql

