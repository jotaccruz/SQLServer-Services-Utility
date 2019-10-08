#To disable extra services installed within SQL Server
#Analysis Services
#Reporting Services
#Integration Services
#Disabling SQL Server Logins used by these services to connect to.
#Requirements: dbatools has to be installed using "https://dbatools.io/"

#Author: Juan Carlos Cruz#

#Get current status#
#Analysis, Reporting, Integration
Get-DbaService -Type SSAS,SSRS,SSIS

# Disabling Services#
#Analysis
Get-DbaService -Type SSAS,SSRS,SSIS | select -property ServiceName | Stop-Service -passthru | Set-Service -startmode disabled

#Get Final Status#
#Analysis, Reporting, Integration
Get-DbaService -Type SSAS,SSRS,SSIS

