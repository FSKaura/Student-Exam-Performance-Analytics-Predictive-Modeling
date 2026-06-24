/*
=============================================================
Database Creation and schemas
=============================================================
Script Purpose:
    This script creates a new SQL Server database named 'students_results'. 
    If the database already exists, it is dropped to ensure a clean setup. 
    The script then creates three Shemas: 'academic_result', 'student_performance', and 'education_analytics'.
    
WARNING:
    Running this script will drop the entire 'students_results' database if it exists, 
    permanently deleting all data within it. Proceed with caution and ensure you 
    have proper backups before executing this script.
*/


USE MASTER;  -- Go use master first if nothing is created
GO 
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'students_results') --If the database name exists go and check
ALTER DATABASE students_results SET SINGLE_USER WITH ROLLBACK IMMEDIATE --
GO
DROP DATABASE students_results; -- If exists drop it database students_results
GO
CREATE DATABASE students_results; -- Create database 
GO
USE students_results; -- Then go head and use it
GO
CREATE SCHEMA academic_result; -- we are Creating schema with names
GO
CREATE SCHEMA student_performance;
GO
CREATE SCHEMA education_analytics;
