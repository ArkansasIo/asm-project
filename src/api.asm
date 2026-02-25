; NES ROM API: Exposed routines for game/editor
	.include "constants.inc"

; API: Set background color
API_SetBGColor:
	; Input: A = color index
	STA $2006
	LDA #$00
	STA $2006
	STA $2007
	RTS

; API: Print character to screen (placeholder)
API_PrintChar:
	; Input: A = ASCII/charset index
	; TODO: Write char to nametable
	RTS

; API: Play sound effect (placeholder)
API_PlaySFX:
	; Input: A = SFX index
	; TODO: Write to APU registers
	RTS
