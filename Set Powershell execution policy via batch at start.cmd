@echo off
title Set the PowerShell Execution Policy
color 0a
mode 1000
cls
goto Precheck

:Precheck
echo Just a reminder that this script needs to be run as administrator.
echo If this script already is, then proceed on as normal. 
echo If not, please close the window and reopen with administrator permissions.
pause
goto Start

:Start
echo Which execution level do you want to set on PowerShell?
echo Choose one of the following:
echo Restricted --> RT
echo AllSigned --> AS
echo RemoteSigned --> RS (recommended)
echo Unrestricted --> UR
echo Bypass --> BY (not recommended)
set choice=
set /p choice=You choice?: 
if NOT '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='RT' goto RT
if '%choice%'=='rt' goto RT
if '%choice%'=='AS' goto AS
if '%choice%'=='as' goto AS
if '%choice%'=='RS' goto RS
if '%choice%'=='rs' goto RS
if '%choice%'=='UR' goto UR
if '%choice%'=='ur' goto UR
if '%choice%'=='BY' goto BY
if '%choice%'=='by' goto BY
echo "%choice%" is not a valid choice. Please type one of the given two letter shorthands for the execution level(capitalization doesn't matter).
pause
cls
goto Start

:RT
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Restricted -Force}"
echo Success, PowerShell Execution Policy set to
powershell -command "& {Get-ExecutionPolicy}"
echo cmd will now close in 10 seconds.
timeout 10
exit

:AS
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy AllSigned -Force}"
echo Success, PowerShell Execution Policy set to
powershell -command "& {Get-ExecutionPolicy}"
echo cmd will now close in 10 seconds.
timeout 10
exit

:RS
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force}"
echo Success, PowerShell Execution Policy set to
powershell -command "& {Get-ExecutionPolicy}"
echo cmd will now close in 10 seconds.
timeout 10
exit

:UR
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force}"
echo Success, PowerShell Execution Policy set to
powershell -command "& {Get-ExecutionPolicy}"
echo cmd will now close in 10 seconds.
timeout 10
exit

:BY
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Bypass -Force}"
echo Success, PowerShell Execution Policy set to
powershell -command "& {Get-ExecutionPolicy}"
echo cmd will now close in 10 seconds.
timeout 10
exit
