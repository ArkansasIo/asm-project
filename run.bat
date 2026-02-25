@echo off
REM Run NES ROM in FCEUX emulator (must be installed and in PATH)
set ROM=src\main_ca65.nes
set EMU=fceux.exe

if not exist %EMU% (
    echo FCEUX emulator not found! Please install FCEUX and add it to your PATH.
    exit /b 1
)

%EMU% %ROM%
