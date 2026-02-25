# NES/SNES Clone Project Structure

## Root
- README.md, info.md, README_DUML.md: Project documentation
- PROJECT_STRUCTURE.md: Project structure and organization
- builds.md, systems.md: Build/run documentation
- build_8bit.bat, build_16bit.bat, build_all.bat, run.bat: Build/run scripts

## src/
- main.cpp: NES emulator entry point (C++)
- cpu.h/cpu.cpp: 6502 CPU emulation
- ppu.h/ppu.cpp: PPU (graphics) emulation
- apu.h/apu.cpp: APU (audio) emulation
- memory.h/memory.cpp: Memory/ROM loader
- input.h/input.cpp: Controller input

## src/ (NES ASM)
- constants.inc, bios.asm, main.asm, cmos.asm, ppu.asm, input.asm, ...
- Modular ASM: game_engine.asm, sprite_tile.asm, collision.asm, editor_tools.asm, api.asm, ui.asm, menus, logos, datasets, types, libraries
- build_ca65.bat, nes.cfg: NES ASM build scripts/config

## src16/
- main16.asm, bios16.asm, ...: SNES (65816) ASM modules
- cmos16.asm, ppu16.asm, apu16.asm, input16.asm, editor16.asm, constants16.inc, dataset16.asm, logic16.asm
- menu_main16.asm, menu_sub16.asm, menu_editor16.asm, editor_tools16.asm, ide16.asm

## docs/
- gdd.md: Game Design Document

---

- Keep C++ emulator code in src/
- Keep NES ASM code in src/
- Keep SNES ASM code in src16/
- Keep documentation in docs/
- Use build scripts in root or src/
