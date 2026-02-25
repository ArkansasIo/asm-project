# Tilemap and Map Data Format

## Tilemap Structure
- How tilemaps are stored in ASM (arrays, banks)
- Map scrolling and windowing
- Attribute tables and color assignment

## Editing
- Using the in-ROM or external map editor
- Export/import workflow for maps

## Example
```asm
; Example tilemap data
TileMap:
    .byte $01, $02, $03, $04, $05, $06, $07, $08
```
