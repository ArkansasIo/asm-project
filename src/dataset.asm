; 8BitStudio ROM Data Structures and Types
	.include "constants.inc"

; CMOS RAM dataset (8 bytes for demo)
CMOS_RAM_DATASET:
	.res 8, 0

; ROM dataset (level data, 16 bytes for demo)
ROM_DATASET:
	.byte $00, $01, $02, $03, $04, $05, $06, $07
	.byte $08, $09, $0A, $0B, $0C, $0D, $0E, $0F

; BIOS dataset (settings, 4 bytes for demo)
BIOS_DATASET:
	.res 4, 0

; NES Console dataset (system info, 4 bytes for demo)
CONSOLE_DATASET:
	.byte $10, $20, $30, $40
