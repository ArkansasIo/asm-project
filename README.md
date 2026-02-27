# 8BitStudio ReadMe

This is a homebrew 8BitStudio project, including:
- 8BitStudio ROM in 6502 assembly
- Simulated BIOS and CMOS RAM
- Splash/boot screens, BIOS menu, submenus
- CMOS RAM screen
- In-ROM editor/tool (work in progress)

## How to Build
1. Assemble the code in src/ using NESASM, ca65, or your preferred assembler.
2. Flash or run the resulting ROM in a 8BitStudio-compatible emulator.

### Linux (ca65 + ld65)
- Build ROM: `./build_8bit.sh`
- Run ROM in FCEUX: `./run_8bit.sh`

The build output is `src/main_ca65.nes`.

## 16-bit Version
A 16-bit version (targeting SNES or similar) will be added in the future.
