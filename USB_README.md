# Gman'sOS — USB Flash Drive Contents

This USB drive carries **Gman'sOS 1.0**: a single-file monolith containing the
full OS, the BIOS flasher, the OS installer, and the unified USB Boot Wizard.

## Files

| File | Purpose |
|------|---------|
| `SmartWatchOS.py` | Monolith: OS + BIOS flasher + Installer + USB Wizard + all tests |
| `FLASH_BIOS.bat` | Windows launcher — double-click to flash BIOS |
| `FLASH_BIOS.sh` | Linux/macOS launcher — run in terminal to flash BIOS |
| `GMAN_USB_BOOT` | Marker file — when present, auto-launches the **USB Boot Wizard** |
| `USB_README.md` | This file |

> Every file above (and every embedded test) lives inside `SmartWatchOS.py`.
> If any file is missing, run `python SmartWatchOS.py --extract-files`
> to rebuild the folder from the bundle.

## Launch Modes

### Unified USB Boot Wizard (recommended on USB drop)
Drop `GMAN_USB_BOOT` next to `SmartWatchOS.py` — the wizard appears with a
4-card menu:

- **Flash BIOS only** — runs the staged flasher (see below)
- **Install OS only** — runs the OS installer (auto-discovers 144+ apps)
- **Flash + Install** — does both back-to-back
- **Live Mode** — boots the OS in-place without writing anything

Or invoke directly:
```
python SmartWatchOS.py --usb-boot
python SmartWatchOS.py --usb
python SmartWatchOS.py -u
```

### BIOS Flasher (direct, no wizard)
Skips the menu and goes straight into the flash UI.
```
python SmartWatchOS.py --bios-flash
python SmartWatchOS.py --flash
python SmartWatchOS.py -b
```
Or double-click `FLASH_BIOS.bat` (Windows) / run `./FLASH_BIOS.sh` (Linux/macOS).

### OS Installer (direct, no wizard)
Auto-discovers every app + state in the bundle and installs them.
```
python SmartWatchOS.py --install
python SmartWatchOS.py --installer
python SmartWatchOS.py -i
```

### Run / Boot the OS
```
python SmartWatchOS.py
```

### Tests + Tools
```
python SmartWatchOS.py --run-tests              # run every embedded test
python SmartWatchOS.py --run-test <name>        # run one embedded test
python SmartWatchOS.py --extract-files [dir]    # rebuild this folder
```

### Environment-variable triggers (alternative to flags)
- `GMAN_BIOS_FLASH=1` — force BIOS flash mode
- `GMAN_INSTALL=1` — force installer mode
- `GMAN_USB_WIZARD=1` — force USB Boot Wizard mode

## What the BIOS Flasher Does

The utility walks through **9 detailed stages**:
1. **Pre-Flight Safety Checks** — power, USB lock, write-protect jumper
2. **Current BIOS Backup** — saves your existing BIOS to a recovery image
3. **Image Integrity Verification** — SHA-256 + quantum signature check
4. **Hardware Compatibility Scan** — matches image to chip + architecture
5. **Flashing BIOS Sectors** — writes the new firmware
6. **Post-Flash Verification** — read-back compare + checksum
7. **Quantum Security Injection** — installs quantum-resistant boot signatures
8. **Bootloader Registration** — registers Gman'sOS with UEFI NVRAM
9. **Finalization** — sets first-boot flags and creates install marker

Each stage has its own progress bar, status indicator, and live log entries.
A full memory-map visualization shows which flash sectors are written.

## Hardware Tier Selection

5 hardware tiers (1945-present) — each tier scales image size, duration, and
flash steps:
- **MODERN / QUANTUM** (2015+) — 8 MB UEFI + Quantum Security
- **LEGACY BIOS** (1995-2014) — 2 MB Pentium / Core 2 class
- **VINTAGE IBM-PC** (1981-1994) — 512 KB 8088/8086 real-mode
- **TRANSISTOR ERA** (1960-1980) — 64 KB minicomputer/mainframe
- **VACUUM TUBE** (pre-1960) — 4 KB ENIAC-class minimal glue logic

## Safety

- **DRY RUN is ON by default** — nothing is actually written unless you toggle it off.
- Hit **ESC** or click **EMERGENCY ABORT** at any time to halt safely.
- Your original BIOS is backed up in stage 2 before any writes happen.
- The USB Boot Wizard (the GMAN_USB_BOOT default) requires explicit user
  confirmation before flashing — it never auto-flashes without consent.

## What's in the OS

Gman'sOS 1.0 ships with **144 apps** + a fully wired desktop environment:

**Foundation systems (Cycle 1)**
- Universal `ActionRegistry` — every action exposed by name
- Command Palette (`Ctrl+K`) — fuzzy-search every action in the OS
- `ActivityLog` event bus + Timeline app
- `AIAssistant` chat — natural-language action dispatcher
- `WorkspaceManager` — 4 virtual desktops (`Ctrl+1..4`, `Ctrl+←/→`)
- `NotificationCenter` — categorized, filterable, DND-aware

**Polish + integration (Cycle 2)**
- `HotkeyManager` + Settings panel (conflict detection)
- `SnapshotManager` — capture / restore / auto-snapshot
- `FocusModeManager` — Off / Work / Sleep / Game presets
- `PermissionsCenter` — per-app capability matrix with audit log
- `SecureClipboard` — TTL + sensitivity tags + auto-sweep

**Right-click + rules + a11y (Cycle 3)**
- `ContextMenuSystem` — right-click on desktop / window title bar
- Auto-save snapshots on key events + snapshot GC
- Always-on-top toggle per window
- `NotificationRulesEngine` — per-app rules, quiet hours, snooze
  (critical-severity always bypasses)
- `AccessibilityManager` — 8 font scales (0.75x..2.0x), reduced motion,
  high contrast, large cursor

## Hotkeys (in-OS)

| Key | Action |
|-----|--------|
| `Ctrl+K` | Open Command Palette |
| `Ctrl+1`..`Ctrl+4` | Switch to workspace 1..4 |
| `Ctrl+←` / `Ctrl+→` | Previous / next workspace |
| Right-click | Context menu (desktop or window title bar) |
| `F1` | Show / hide help overlay |
| `F11` | Toggle fullscreen emulator mode |
| `ESC` | Close menus / dismiss overlays |

## Requirements

- Python 3.8+ with pygame installed (`pip install pygame`)
- A USB port
- Stable power (battery >50% if laptop)

## Verification

The bundle ships with self-contained test suites runnable via
`--run-tests` or individually via `--run-test <name>`:
`test_all_apps`, `test_app_launch`, `test_main_loop`, `test_ui_layouts`,
`test_smartwatch_mode`, `test_display_profiles`, `test_autodiscovery`,
`test_bios_standalone`, `test_installer_standalone`.
