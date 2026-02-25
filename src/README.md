# 8BitStudio Emulator src/ Folder Organization

- main.cpp: Emulator entry point
- cpu.h / cpu.cpp: 6502 CPU emulation
- ppu.h / ppu.cpp: PPU (graphics) emulation
- apu.h / apu.cpp: APU (audio) emulation
- memory.h / memory.cpp: Memory/ROM loader
- input.h / input.cpp: Controller input

## How to Expand
- Add more .h/.cpp files for mappers, debugging, or UI as needed
- Keep each 8BitStudio subsystem in its own pair of files
- Use a build system (CMake, Makefile, or IDE project) for easy compilation

## Example Build (g++)
g++ main.cpp cpu.cpp ppu.cpp apu.cpp memory.cpp input.cpp -o 8bitstudioemu

---

Keep all C++ source and header files for the 8BitStudio emulator in src/ for clarity and maintainability.
