; Editor Integration for NES Console and Game
.segment "EDITOR_INTEGRATION"

Editor_ConsoleLink:
    ; Link editor to NES console build
    JSR Console_Init
    RTS

Editor_GameLink:
    ; Link editor to game ROM
    JSR DW_Main
    RTS

Editor_GraphicsLink:
    ; Link editor to graphics system
    JSR Editor_InitGraphics
    RTS

Editor_SoundLink:
    ; Link editor to sound system
    JSR Editor_AddSound
    RTS
