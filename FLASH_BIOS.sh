#!/usr/bin/env bash
# ============================================================
# Gman'sOS 1.0 - BIOS Flash Utility Launcher (Linux/macOS)
#
# Place this on a USB drive alongside SmartWatchOS.py.
# Run to launch the staged BIOS flasher.
#
# Related launch modes:
#   python3 SmartWatchOS.py --usb-boot    # unified Flash + Install + Live wizard
#   python3 SmartWatchOS.py --install     # OS installer only
#   python3 SmartWatchOS.py               # boot the OS
#   python3 SmartWatchOS.py --run-tests   # run every embedded test
#
# See USB_README.md for the full reference.
# ============================================================

set -e
cd "$(dirname "$0")"

echo "============================================================"
echo "GMAN'SOS 1.0 - BIOS FLASH UTILITY"
echo "Standalone USB Boot Mode"
echo "============================================================"
echo ""

PY=""
if command -v python3 >/dev/null 2>&1; then
    PY="python3"
elif command -v python >/dev/null 2>&1; then
    PY="python"
else
    echo "ERROR: Python is not installed. Install Python 3.8+ first."
    exit 1
fi

echo "Launching BIOS flash utility..."
"$PY" SmartWatchOS.py --bios-flash

echo ""
echo "Flash utility exited."
echo ""
echo "TIP: Drop a file named 'GMAN_USB_BOOT' next to SmartWatchOS.py to"
echo "     auto-launch the unified USB Boot Wizard on next run."
