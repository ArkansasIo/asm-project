; Main game logic for NES ROM
	.include "constants.inc"

	.segment "CODE"
RESET_MAIN:
	; Set background color (blue)
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006
	LDA #BG_COLOR_BLUE
	STA $2007

	; Enable rendering
	LDA #%10001000
	STA $2000
	LDA #%00011110
	STA $2001

	; CMOS RAM demo
	LDA #$42
	STA CMOS_RAM_ADDR
	LDA CMOS_RAM_ADDR

Forever:
	JMP Forever
