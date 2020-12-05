@echo off
title Set the PowerShell Execution Policy
color 0e
mode 1000
cls
goto Pre

:Pre
echo Note: If you are seeing this the second time, after already giving administrator permissions, this is normal.
echo In such a case, please enter y and you will be directed to the correct place.
echo =============================================================================================================
echo =============================================================================================================
echo Administrator permissions are needed to change the PowerShell Execution Level.
echo Allow?
set /p "choice=(Y/N)?..."
if /i "%choice%" == "Y" (
    goto RunAdmin
) else if /i "%choice%" == "N" (
    echo You have chosen to not give administrator permissions to the windows command prompt.
	echo As a result, you will not be able to change the PowerShell execution level.
	echo Command prompt will close in 15 seconds...
	timeout 15
	exit
) else (
	echo Your input is not one of the choices. 
	echo Please try again...
	pause
	cls
	goto Pre
)

:RunAdmin
echo =======================================
echo Running administrator Command Prompt...
echo =======================================

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
echo.
echo ******************************************
echo  Invoking UAC for Privilege Escalation...
echo ******************************************
echo.
echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
echo args = "ELEV " >> "%vbsGetPrivileges%"
echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
echo Next >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /b

:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)
cls
goto Start

:Start
echo Which execution level do you want to set on PowerShell?
echo Choose one of the following:
echo Restricted = RT
echo AllSigned = AS
echo RemoteSigned = RS (recommended)
echo Unrestricted = UR
echo Bypass = BY (not recommended)
SET /P "choice=Your choice?..."
IF /I "%choice%" == "RT" (
    goto RT
) else IF /I "%choice%" == "AS" (
    goto AS
) else IF /I "%choice%" == "RS" (
    goto RS
) else IF /I "%choice%" == "UR" (
    goto UR
) else IF /I "%choice%" == "BY" (
    goto BY
) else (
    ECHO "%choice%" is not a valid choice. Please type one of the given two letter shorthands for the execution level(capitalization doesn't matter).
	PAUSE
	CLS
	goto Start
)

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
