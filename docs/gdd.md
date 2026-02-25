# 8BitStudio Game Design Document (GDD)

## Game/ROM Overview
A demonstration 8BitStudio ROM with BIOS, splash, menus, CMOS RAM, and an in-ROM editor. Designed for educational and homebrew purposes.

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
- Written in 6502 assembly for 8BitStudio
- Modular source files in src/
- CMOS RAM simulated in zero page

## Credits
- Project by [Stephen]  https://github.com/ArkansasIo
- Powered by open-source tools
