; CMOS RAM routines for NES ROM
	.include "constants.inc"

	.segment "ZEROPAGE"
CMOS_RAM:
	.res 8, 0 ; 8 bytes of CMOS RAM
