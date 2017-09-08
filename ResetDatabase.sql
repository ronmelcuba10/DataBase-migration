-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- ||																									  ||
-- ||	This query deletes all the database and restore with some values, it should be used with care	  ||
-- ||																								      ||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

-- Clears te database   ************************************************************************************
-- repeat until the database is clean
:r E:\SQL\SchedulerProduction\MigrationScripts\ClearWholeDataBase.sql

-- Creates the database   **********************************************************************************
:r E:\SQL\SchedulerProduction\MigrationScripts\Creation.sql

-- Creates all the keys and constraints  *******************************************************************
:r E:\SQL\SchedulerProduction\MigrationScripts\KeysAndConstraints.sql

-- Seeds the database  *************************************************************************************
:r E:\SQL\SchedulerProduction\MigrationScripts\Seed\Seed.sql

