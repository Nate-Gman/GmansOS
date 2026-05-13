#!/usr/bin/env bash
# ============================================================
# GMan OS - BIOS Flash Utility Launcher (Linux/macOS)
# Place this on a USB drive alongside SmartWatchOS.py and the
# GMAN_USB_BOOT marker file. Run to launch the flasher.
# ============================================================

set -e
cd "$(dirname "$0")"

echo "============================================================"
echo "GMAN OS - BIOS FLASH UTILITY"
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
