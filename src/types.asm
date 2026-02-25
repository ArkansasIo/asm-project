; 8BitStudio ROM Data Types and Structs (Assembly style)
	.include "constants.inc"

; CMOS RAM struct
.struct CMOS_RAM_STRUCT
	byte0 .byte 0
	byte1 .byte 0
	byte2 .byte 0
	byte3 .byte 0
	byte4 .byte 0
	byte5 .byte 0
	byte6 .byte 0
	byte7 .byte 0
.endstruct

; ROM struct (level data)
.struct ROM_STRUCT
	tile0 .byte 0
	tile1 .byte 0
	tile2 .byte 0
	tile3 .byte 0
	tile4 .byte 0
	tile5 .byte 0
	tile6 .byte 0
	tile7 .byte 0
.endstruct

; BIOS struct
.struct BIOS_STRUCT
	setting0 .byte 0
	setting1 .byte 0
	setting2 .byte 0
	setting3 .byte 0
.endstruct

; Console struct
.struct CONSOLE_STRUCT
	info0 .byte 0
	info1 .byte 0
	info2 .byte 0
	info3 .byte 0
.endstruct
