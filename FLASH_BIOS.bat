@echo off
REM ============================================================
REM GMan OS - BIOS Flash Utility Launcher
REM Place this on a USB drive alongside SmartWatchOS.py and the
REM GMAN_USB_BOOT marker file. Double-click to launch the flasher.
REM ============================================================

setlocal
cd /d "%~dp0"

echo ============================================================
echo GMAN OS - BIOS FLASH UTILITY
echo Standalone USB Boot Mode
echo ============================================================
echo.
echo Detecting Python...

where python >nul 2>&1
if %errorlevel% equ 0 (
    python SmartWatchOS.py --bios-flash
    goto :end
)

where py >nul 2>&1
if %errorlevel% equ 0 (
    py SmartWatchOS.py --bios-flash
    goto :end
)

echo ERROR: Python is not installed or not in PATH.
echo Please install Python 3.8+ from https://python.org
pause
exit /b 1

:end
echo.
echo Flash utility exited.
pause
endlocal
