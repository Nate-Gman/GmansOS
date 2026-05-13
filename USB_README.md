# GMan OS - USB Flash Drive Contents

This USB drive contains the standalone **GMan OS BIOS Flash Utility**.

## Files

| File | Purpose |
|------|---------|
| `SmartWatchOS.py` | The monolithic OS + BIOS flasher + Installer + all tests |
| `FLASH_BIOS.bat` | Windows launcher - double-click to flash BIOS |
| `FLASH_BIOS.sh` | Linux/macOS launcher - run in terminal |
| `GMAN_USB_BOOT` | Marker file - when present, auto-launches BIOS flasher |
| `USB_README.md` | This file |

> Note: every file above (and every test) is embedded inside SmartWatchOS.py.
> If any file is missing, run `python SmartWatchOS.py --extract-files` to
> rebuild the folder from the bundle.

## How to Launch the BIOS Flash Utility

You have **three options** to enter BIOS flash mode (any one works):

### 1. Double-click `FLASH_BIOS.bat` (Windows)
The easiest method. Runs the flasher immediately.

### 2. Run from command line
```
python SmartWatchOS.py --bios-flash
```
or
```
python SmartWatchOS.py -b
```

### 3. Auto-launch via USB marker
If the file `GMAN_USB_BOOT` exists next to `SmartWatchOS.py`, the flasher
will automatically run instead of the normal OS whenever the script is
executed.

## What the Flasher Does

The utility walks through **9 detailed stages**:
1. **Pre-Flight Safety Checks** -- power, USB lock, write-protect jumper
2. **Current BIOS Backup** -- saves your existing BIOS to a recovery image
3. **Image Integrity Verification** -- SHA-256 + quantum signature check
4. **Hardware Compatibility Scan** -- matches image to chip + architecture
5. **Flashing BIOS Sectors** -- writes the new firmware
6. **Post-Flash Verification** -- read-back compare + checksum
7. **Quantum Security Injection** -- installs quantum-resistant boot signatures
8. **Bootloader Registration** -- registers GMan OS bootloader with UEFI NVRAM
9. **Finalization** -- sets first-boot flags and creates install marker

Each stage has its own progress bar, status indicator, and live log entries.
A full memory-map visualization shows which flash sectors are written.

## Hardware Tier Selection

Choose from 5 hardware tiers (1945-present) - each tier scales the image
size, duration, and flash steps:
- **MODERN / QUANTUM** (2015+) - 8 MB UEFI + Quantum Security
- **LEGACY BIOS** (1995-2014) - 2 MB Pentium/Core 2 class
- **VINTAGE IBM-PC** (1981-1994) - 512 KB 8088/8086 real-mode
- **TRANSISTOR ERA** (1960-1980) - 64 KB minicomputer/mainframe
- **VACUUM TUBE** (pre-1960) - 4 KB ENIAC-class minimal glue logic

## Safety

- **DRY RUN is ON by default** -- nothing is actually written unless you toggle it off.
- Hit **ESC** or click **EMERGENCY ABORT** at any time to halt safely.
- Your original BIOS is backed up in stage 2 before any writes happen.

## Other Standalone Modes

- `--install` -- Full OS Installer (auto-discovers all 110+ apps)
- `--run-tests` -- Run every embedded test in subprocess
- `--run-test <name>` -- Run a single test
- `--extract-files [dir]` -- Rebuild this folder from the bundle

## Requirements

- Python 3.8+ with pygame installed (`pip install pygame`)
- A USB port
- Stable power (battery >50% if laptop)
