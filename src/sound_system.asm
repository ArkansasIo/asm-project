; 8BitStudio Sound and Audio System (6502 ASM)
	.include "constants.inc"

; Play a simple square wave tone on channel 1
Sound_PlayTone:
	LDA #$80        ; Enable channel 1, duty cycle
	STA $4000
	LDA #$FF        ; Max volume
	STA $4001
	LDA #$0F        ; Low byte of period
	STA $4002
	LDA #$07        ; High byte of period
	STA $4003
	RTS

; Stop all sound
Sound_StopAll:
	LDA #$00
	STA $4000
	STA $4001
	STA $4002
	STA $4003
	STA $4004
	STA $4005
	STA $4006
	STA $4007
	STA $4008
	STA $4009
	STA $400A
	STA $400B
	STA $400C
	STA $400D
	STA $400E
	STA $400F
	RTS

; Play a simple noise effect (channel 4)
Sound_PlayNoise:
	LDA #$30        ; Enable noise, volume
	STA $400C
	LDA #$0F        ; Noise period
	STA $400E
	LDA #$00        ; Length counter
	STA $400F
	RTS

; Play a 'jump' sound effect (short high-pitched tone)
Sound_PlayJump:
	LDA #$80
	STA $4000
	LDA #$FF
	STA $4001
	LDA #$05
	STA $4002
	LDA #$06
	STA $4003
	RTS

; Play a 'coin' sound effect (short mid-pitched tone)
Sound_PlayCoin:
	LDA #$80
	STA $4000
	LDA #$FF
	STA $4001
	LDA #$20
	STA $4002
	LDA #$07
	STA $4003
	RTS

; Play a 'menu select' beep (short low-pitched tone)
Sound_PlayMenuSelect:
	LDA #$80
	STA $4000
	LDA #$FF
	STA $4001
	LDA #$80
	STA $4002
	LDA #$08
	STA $4003
	RTS

; TODO: Add music playback and more advanced sound routines
