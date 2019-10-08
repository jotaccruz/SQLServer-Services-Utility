#To disable extra services installed within SQL Server
#Analysis Services
#Reporting Services
#Integration Services
#Disabling SQL Server Logins used by these services to connect to.
#Requirements: 
#Run PS as Administrator
#Grant to connect to SQL Server using Windows Authentication and sysadmin fixed server role
#ReportServer-Login-Disable.sql script

#Author: Juan Carlos Cruz#

#Settings Variables
#Directory where is located ReportServer-Login-Disable.sql
$Location=""

#Get current status#
#Analysis
Get-Service |?{$_ -match 'OLAPService'} | select -property name,DisplayName,starttype,status | ft -aut
#Reporting
Get-Service |?{$_ -match 'ReportServer'} | select -property name,DisplayName,starttype,status | ft -aut
#Integration
Get-Service |?{$_ -match 'MsDts'} | select -property name,DisplayName,starttype,status | ft -aut

# Disabling Services#
#Analysis
Get-Service | ?{$_ -match 'OLAPService'} | select -property name | Stop-Service -passthru | Set-Service -startmode disabled
#Reporting
Get-Service | ?{$_ -match 'ReportServer'} | select -property name | Stop-Service -passthru | Set-Service -startmode disabled
#Integration
Get-Service | ?{$_ -match 'MsDts'} | select -property name | Stop-Service -passthru | Set-Service -startmode disabled

#Get Final Status#
#Analysis
Get-Service |?{$_ -match 'OLAPService'} | select -property name,DisplayName,starttype,status | ft -aut
#Reporting
Get-Service |?{$_ -match 'ReportServer'} | select -property name,DisplayName,starttype,status | ft -aut
#Integration
Get-Service |?{$_ -match 'MsDts'} | select -property name,DisplayName,starttype,status | ft -aut

#Disabling Reporting Services Login
Set-Location $Location
sqlcmd.exe -i ReportServer-Login-Disable.sql
