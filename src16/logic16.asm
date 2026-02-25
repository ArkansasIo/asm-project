; SNES 16-bit Logic Functions (Game/Editor)
.segment "CODE"

; Example: Increment a value in CMOS RAM
IncCMOS16:
	LDX #0
	LDA CMOS_RAM16, X
	CLC
	ADC #1
	STA CMOS_RAM16, X
	RTS

; Example: Decrement a value in CMOS RAM
DecCMOS16:
	LDX #0
	LDA CMOS_RAM16, X
	SEC
	SBC #1
	STA CMOS_RAM16, X
	RTS

; Add more game/editor logic routines here
