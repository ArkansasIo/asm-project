; 8BitStudio NES Console System
.segment "CONSOLE"
ConsoleInit:
    ; Initialize hardware
    ; Set up memory, PPU, APU
    RTS
ConsoleLoop:
    ; Main console loop
    ; Poll input, update state
    RTS
