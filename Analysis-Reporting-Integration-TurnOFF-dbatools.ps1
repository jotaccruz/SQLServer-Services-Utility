#To disable extra services installed within SQL Server
#Analysis Services
#Reporting Services
#Integration Services
#Disabling SQL Server Logins used by these services to connect to.
#Requirements: 
#dbatools PS Module "https://dbatools.io/"
#Run PS as Administrator
#Grant to connect to SQL Server using Windows Authentication and sysadmin fixed server role
#ReportServer-Login-Disable.sql script

#Author: Juan Carlos Cruz#

#Settings Variables
#Directory where is located ReportServer-Login-Disable.sql
$Location=""

#Get current status#
#Analysis, Reporting, Integration
Get-DbaService -Type SSAS,SSRS,SSIS

# Disabling Services#
#Analysis
Get-DbaService -Type SSAS,SSRS,SSIS | select -property ServiceName | Stop-Service -passthru | Set-Service -startmode disabled

#Get Final Status#
#Analysis, Reporting, Integration
Get-DbaService -Type SSAS,SSRS,SSIS

#Disabling Reporting Services Login
Set-Location $Location
sqlcmd.exe -i ReportServer-Login-Disable.sql
