@echo off
REM Setup script for scheduled auto-commit task
REM This creates a Windows Scheduled Task to run auto-commit.ps1 every 5 minutes

setlocal enabledelayedexpansion
cd /d "%~dp0"

echo Setting up auto-commit scheduled task...
echo.

REM Check if running as Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: This script must run as Administrator
    echo Please right-click and select "Run as Administrator"
    pause
    exit /b 1
)

REM Get the full path to the auto-commit script
set SCRIPT_PATH=%~dp0auto-commit.ps1
echo Script path: %SCRIPT_PATH%
echo.

REM Create scheduled task to run every 5 minutes
echo Creating scheduled task to run auto-commit every 5 minutes...
schtasks /create /tn "Kussco-Housing-AutoCommit" /tr "powershell -ExecutionPolicy Bypass -File \"%SCRIPT_PATH%\"" /sc minute /mo 5 /f

if %errorlevel% equ 0 (
    echo.
    echo SUCCESS: Scheduled task created!
    echo Task name: Kussco-Housing-AutoCommit
    echo Frequency: Every 5 minutes
    echo.
    echo To manage the task, use:
    echo   - View: schtasks /query /tn "Kussco-Housing-AutoCommit"
    echo   - Delete: schtasks /delete /tn "Kussco-Housing-AutoCommit" /f
    echo   - Run now: schtasks /run /tn "Kussco-Housing-AutoCommit"
) else (
    echo ERROR: Failed to create scheduled task
)

pause
