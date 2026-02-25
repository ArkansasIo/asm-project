# 8BitStudio Project Systems

This folder contains build scripts, run scripts, and system integration files for the 8BitStudio project.

- build_all.bat: Builds the 8BitStudio ROM from all modules using ca65/ld65.
- run.bat: Runs the built ROM in FCEUX emulator.
- 8bitstudio.cfg: Linker configuration for ld65.
- src/: All source code modules.

## Requirements
- cc65 toolchain (ca65, ld65)
- FCEUX 8BitStudio emulator

## Usage
1. Run build_all.bat to build the ROM.
2. Run run.bat to launch the ROM in the emulator.
