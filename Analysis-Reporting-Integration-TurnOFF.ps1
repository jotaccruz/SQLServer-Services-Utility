#This script is to disable Extra Services installed within SQL Server
#Analysis Services
#Reporting Services
#Integration Services
#Disabling SQL Server Logins used by these services to connect to.
#Requirements: dbatools has to be installed using "https://dbatools.io/"

#Author: Juan Carlos Cruz#

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

