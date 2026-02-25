# NES Clone Game Design Document (GDD)

## Game/ROM Overview
A demonstration NES ROM with BIOS, splash, menus, CMOS RAM, and an in-ROM editor. Designed for educational and homebrew purposes.

## Features
- Splash screen
- Boot screen
- BIOS menu and submenus
- CMOS RAM screen (view/edit persistent data)
- In-ROM editor/tool (level/sprite editor, WIP)

## Controls
- D-pad: Navigate menus
- A: Select
- B: Back

## 16-bit Version (Planned)
A future version will target a 16-bit platform (e.g., SNES), using 65816 assembly and expanded features.

## Technical Notes
- Written in 6502 assembly for NES
- Modular source files in src/
- CMOS RAM simulated in zero page

## Credits
- Project by [Your Name]
- Powered by open-source tools
