/*
    ***CREATE DATABASE AND SCHEMAS***
	DATABASE : Data_Warehouse
	SCHEMAS : first(Loading the data from the source), 
	          second(Data Cleaning and Data Wrangling), 
			  third(Business-Ready Data)
*/

USE master;
DROP DATABASE IF EXISTS Data_Warehouse;
CREATE DATABASE Data_Warehouse;

USE Data_Warehouse;
GO
CREATE SCHEMA first;

GO
CREATE SCHEMA second;

GO
CREATE SCHEMA third;
GO



