@echo off
title Set the PowerShell Execution Policy
color 0e
mode con: cols=150 lines=30
cls

:: ========================================
:: Check for admin and elevate if needed
:: ========================================
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' goto :Start

:: Request elevation
echo =============================================================================================================
echo Administrator permissions are needed to change the PowerShell Execution Level.
echo =============================================================================================================
set /p "choice=Allow? (Y/N): "
if /i not "%choice%" == "Y" (
    echo.
    echo You have chosen to not give administrator permissions.
    echo Command prompt will close in 10 seconds...
    timeout /t 10
    exit /b
)

echo.
echo Requesting administrator privileges...
powershell -Command "Start-Process '%~f0' -Verb RunAs"
exit /b

:: ========================================
:: Main menu (runs after elevation)
:: ========================================
:Start
cls
echo =============================================================================================================
echo PowerShell Execution Policy Modifier
echo =============================================================================================================
echo.
echo Choose an execution level:
echo.
echo   [RT] Restricted                 --^> Will not allow any powershell scripts to run.  Only individual commands may be run.
echo   [AS] AllSigned                  --^> Will allow signed powershell scripts to run.
echo   [RS] RemoteSigned (RECOMMENDED) --^> Allows unsigned local script and signed remote powershell scripts to run.
echo   [UR] Unrestricted               --^> Will allow unsigned powershell scripts to run.  Warns before running downloaded scripts.
echo   [BY] Bypass (NOT RECOMMENDED)   --^> Nothing is blocked and there are no warnings or prompts.
echo   [Q]  Quit                       --^> Exit without changes
echo.
echo =============================================================================================================
set /p "choice=Your choice: "

:: Convert to uppercase and validate
set "choice=%choice:~0,2%"
if /i "%choice%" == "RT" goto :SetPolicy
if /i "%choice%" == "AS" goto :SetPolicy
if /i "%choice%" == "RS" goto :SetPolicy
if /i "%choice%" == "UR" goto :SetPolicy
if /i "%choice%" == "BY" goto :SetPolicy
if /i "%choice%" == "Q"  goto :Quit

:: Invalid input
echo.
echo ERROR: "%choice%" is not a valid choice.
pause
goto :Start

:: ========================================
:: Set policy based on choice
:: ========================================
:SetPolicy
:: Map shorthand to full policy name
if /i "%choice%" == "RT" set "policy=Restricted"
if /i "%choice%" == "AS" set "policy=AllSigned"
if /i "%choice%" == "RS" set "policy=RemoteSigned"
if /i "%choice%" == "UR" set "policy=Unrestricted"
if /i "%choice%" == "BY" set "policy=Bypass"

echo.
echo Setting execution policy to %policy%...
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy %policy% -Force"

:: Verify it worked
echo.
echo =============================================================================================================
echo SUCCESS! PowerShell Execution Policy is now set to:
powershell -Command "Get-ExecutionPolicy"
echo =============================================================================================================
echo.
echo Window will close in 10 seconds...
timeout /t 10
exit /b

:Quit
echo.
echo Exiting without changes...
timeout /t 2
exit /b