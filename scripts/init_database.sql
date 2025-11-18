/*
============================================
Create Database and Schemas
============================================
Script Purpose:
	This scripts creates a new database named 'DataWareHouse' after checking if it already exists.
	If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
	within the database:'bronze','silver','gold'

Warning:
	Running this script will drop the entire 'DataWareHouse' database if it exists.
	All data in the database will be permanently deleted. proceed with caution
	and ensure you have proper backups before running the script.
*/

USE Master;
GO

--Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.database WHERE name = 'DataWareHouse')
BEGIN
	ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DatawareHouse

CREATE DATABASE DataWareHouse;

USE DataWareHouse;

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
