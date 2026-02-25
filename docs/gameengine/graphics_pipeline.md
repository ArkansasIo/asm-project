# 8BitStudio Graphics Pipeline

## Overview
Describes the flow of graphics data from ASM code to the screen, including tile/sprite management, VRAM updates, and rendering order.

## Steps
1. Tile and sprite data definition (in ASM)
2. Loading graphics into VRAM
3. PPU register setup
4. Sprite DMA and OAM updates
5. Rendering loop and VBlank timing

## Optimization
- Minimizing VRAM writes
- Efficient sprite sorting
- Palette management
- ASM macros for graphics routines
