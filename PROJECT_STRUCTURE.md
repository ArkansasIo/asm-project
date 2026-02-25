# NES Emulator Project Structure

## Folders
- src/: C++ NES emulator source code
- src16/: SNES (16-bit) ASM source code
- docs/: Documentation and design docs

## NES Emulator (src/)
- main.cpp: Emulator entry point
- cpu.h/cpu.cpp: 6502 CPU emulation
- ppu.h/ppu.cpp: PPU (graphics) emulation
- apu.h/apu.cpp: APU (audio) emulation
- memory.h/memory.cpp: Memory/ROM loader
- input.h/input.cpp: Controller input

## SNES ASM (src16/)
- main16.asm, bios16.asm, etc.: SNES 65816 ASM modules

## Build
- Use a C++ compiler (g++, clang++, MSVC) for src/
- Use ca65/ld65 for src16/

## TODO
- Implement all NES subsystems in src/
- Expand SNES ASM modules in src16/
