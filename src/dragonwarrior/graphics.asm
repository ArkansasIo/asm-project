; Dragon Warrior Clone - Graphics

.segment "RODATA"
DW_Tiles:
    ; Placeholder CHR/tile metadata.
    .byte $00,$01,$02,$03,$04,$05,$06,$07

DW_Sprites:
    ; Placeholder sprite IDs.
    .byte $10,$11,$12,$13

.segment "CODE"
DW_GfxInit:
    ; Real implementation should upload palettes/tiles during VBlank.
    RTS

DW_DrawFrame:
    ; Frame-level draw dispatch placeholder.
    JSR DW_DrawHUD
    JSR DW_DrawMenus
    RTS

DW_DrawHUD:
    ; Status bar draw placeholder (HP/MP/Gold/Level).
    RTS

DW_DrawMenus:
    ; Command/battle menu draw placeholder.
    RTS
