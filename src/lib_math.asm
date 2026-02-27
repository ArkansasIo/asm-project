; Math library for 8BitStudio (6502 ASM)
; Add, subtract, multiply, divide, etc.
Math_Add:
	; A = A + X
	TXA
	CLC
	ADC Math_MulResult
	RTS

Math_Sub:
	; A = A - X
	TXA
	SEC
	SBC Math_MulResult
	RTS

Math_Mul:
	; Multiply A * X (8-bit, naive)
	LDY #0
	STY Math_MulResult
	CPX #0
	BEQ Math_MulDone
Math_MulLoop:
	CLC
	ADC Math_MulResult
	STA Math_MulResult
	DEX
	BNE Math_MulLoop
Math_MulDone:
	LDA Math_MulResult
	RTS
Math_MulResult: .res 1, 0

Math_Div:
	; TODO: Implement division
	RTS
