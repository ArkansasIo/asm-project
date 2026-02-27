; 8BitStudio ROM Data Types and Structs (Assembly style)
	.include "constants.inc"

; CMOS RAM struct
.struct CMOS_RAM_STRUCT
	byte0 .byte
	byte1 .byte
	byte2 .byte
	byte3 .byte
	byte4 .byte
	byte5 .byte
	byte6 .byte
	byte7 .byte
.endstruct

; ROM struct (level data)
.struct ROM_STRUCT
	tile0 .byte
	tile1 .byte
	tile2 .byte
	tile3 .byte
	tile4 .byte
	tile5 .byte
	tile6 .byte
	tile7 .byte
.endstruct

; BIOS struct
.struct BIOS_STRUCT
	setting0 .byte
	setting1 .byte
	setting2 .byte
	setting3 .byte
.endstruct

; Console struct
.struct CONSOLE_STRUCT
	info0 .byte
	info1 .byte
	info2 .byte
	info3 .byte
.endstruct
