; Utility library for NES (6502 ASM)
; Delay, random, swap, etc.
Util_Delay:
	; Simple delay loop
	LDY #$FF
Util_DelayLoop:
	LDX #$FF
Util_DelayInner:
	DEX
	BNE Util_DelayInner
	DEY
	BNE Util_DelayLoop
	RTS

Util_Random:
	; TODO: Return pseudo-random value
	RTS

Util_Swap:
	; TODO: Swap two memory locations
	RTS
