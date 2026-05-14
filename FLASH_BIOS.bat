@echo off
REM ============================================================
REM Gman'sOS 1.0 - BIOS Flash Utility Launcher (Windows)
REM
REM Place this on a USB drive alongside SmartWatchOS.py.
REM Double-click to launch the staged BIOS flasher.
REM
REM Related launch modes (run from cmd / powershell):
REM   python SmartWatchOS.py --usb-boot    (unified Flash + Install + Live wizard)
REM   python SmartWatchOS.py --install     (OS installer only)
REM   python SmartWatchOS.py               (boot the OS)
REM   python SmartWatchOS.py --run-tests   (run every embedded test)
REM
REM See USB_README.md for the full reference.
REM ============================================================

setlocal
cd /d "%~dp0"

echo ============================================================
echo GMAN'SOS 1.0 - BIOS FLASH UTILITY
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
echo.
echo TIP: Drop a file named 'GMAN_USB_BOOT' next to SmartWatchOS.py to
echo      auto-launch the unified USB Boot Wizard on next run.
pause
endlocal
