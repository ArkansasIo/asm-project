# 8BitStudio FCEUX Clone - Full Emulator Details

## Overview
This project is a modular NES emulator inspired by FCEUX, written in C++. It is designed for debugging, development, and running 8BitStudio ROMs.

## Core Modules
- **CPU (6502):** Opcode decoding, registers, memory access, interrupt handling.
- **PPU:** VRAM, OAM, tile/sprite rendering, scanline and VBlank timing.
- **APU:** Audio channels, mixing, frame counter.
- **Memory:** ROM/RAM mapping, I/O registers, mirroring.
- **Input:** Controller polling, state management.

## Debugger Features
- Breakpoints, memory viewer, register inspector, trace log.
- Step/continue execution, watch variables.

## File Structure
- `main.cpp`: Emulator entry point, main loop.
- `cpu.cpp/h`: CPU implementation.
- `ppu.cpp/h`: PPU implementation.
- `apu.cpp/h`: APU implementation.
- `memory.cpp/h`: Memory management.
- `input.cpp/h`: Input handling.

## Build & Run
- Requires C++ compiler (g++ or cl.exe).
- Build: `g++ main.cpp cpu.cpp ppu.cpp apu.cpp memory.cpp input.cpp -o fceux_clone.exe`
- Run: `./fceux_clone.exe`

## Extending
- Add save state, movie recording, cheat system, GUI frontend.
- Integrate with 8BitStudio build scripts for seamless workflow.

## References
- FCEUX source: https://github.com/TASVideos/fceux
- NES docs: https://wiki.nesdev.org/

## TODO
- Implement full opcode set, PPU rendering, APU mixing.
- Add debugger UI and advanced features.
