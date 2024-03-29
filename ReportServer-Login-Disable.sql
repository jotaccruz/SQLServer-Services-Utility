/*
Disabling SQL Server Logins used by Reporting services to connect to.

Requirement:
Privilege to connect to SQL Server using Windows Authentication and sysadmin fixed server role

#Author: Juan Carlos Cruz#
*/

USE [master]
GO

/*Reporting Services user current status*/
SELECT name Name,
CASE
WHEN is_disabled=1 
THEN 'DISABLED'
ELSE 'ENABLED' END LoginCurrentStatus
 FROM master.sys.server_principals
WHERE name = 'NT SERVICE\ReportServer'
GO

/*Revoking access to Reporting Services user*/
DENY CONNECT SQL TO [NT SERVICE\ReportServer]
GO
ALTER LOGIN [NT SERVICE\ReportServer] DISABLE
GO

/*Reporting Services user current status*/
SELECT name Name,
CASE
WHEN is_disabled=1 
THEN 'DISABLED'
ELSE 'ENABLED' END LoginCurrentStatus
 FROM master.sys.server_principals
WHERE name = 'NT SERVICE\ReportServer'