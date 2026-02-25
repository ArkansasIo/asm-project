; Simulated BIOS routine for NES ROM
	.include "constants.inc"

	.segment "CODE"


BIOS:
	SEI
	CLD
	LDX #$40
	STX $4017
	LDX #$FF
	TXS
	INX
	STX $2000
	STX $2001
	STX $4010

	; Wait for PPU to stabilize
	LDY #$00
vblankwait1:
	BIT $2002
	BPL vblankwait1
vblankwait2:
	BIT $2002
	BPL vblankwait2

	; Show splash screen first
	JSR SplashScreen

	; Then show boot screen
	JSR BootScreen

	; After boot, jump to BIOS menu
	JMP BIOS_Menu

; --- Splash Screen Routine ---
SplashScreen:
	; Set background color (green)
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006
	LDA #$29        ; Green
	STA $2007

	; (Placeholder) Delay for splash
	LDY #$FF
SplashScreen_delay:
	LDX #$FF
SplashScreen_delay_inner:
	DEX
	BNE SplashScreen_delay_inner
	DEY
	BNE SplashScreen_delay
	RTS

; --- Boot Screen Routine ---
BootScreen:
	; Set background color (red)
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006
	LDA #BG_COLOR_RED
	STA $2007

	; (Placeholder) Write 'BOOT' text to nametable (top left)
	; Normally you'd DMA tile data, here we just delay
	LDY #$FF
BootScreen_delay:
	LDX #$FF
BootScreen_delay_inner:
	DEX
	BNE BootScreen_delay_inner
	DEY
	BNE BootScreen_delay
	RTS

; --- BIOS Menu Routine (placeholder) ---
BIOS_Menu:
	; Draw menu (placeholder: just delay, normally would write to nametable)
	JSR DrawMenu

	; Menu loop
MenuLoop:
	JSR ReadController
	LDA menu_selection
	CMP #0
	BEQ Menu_StartGame
	CMP #1
	BEQ Menu_CMOS
	CMP #2
	BEQ Menu_Editor
	JMP MenuLoop

; --- Draw Menu Routine (placeholder) ---
DrawMenu:
	; (Would normally write menu text to nametable)
	; For now, just delay
	LDY #$7F
DrawMenu_delay:
	LDX #$FF
DrawMenu_delay_inner:
	DEX
	BNE DrawMenu_delay_inner
	DEY
	BNE DrawMenu_delay
	RTS

; --- Read Controller and update menu_selection (very basic, placeholder) ---
ReadController:
	; (In real NES, poll $4016/$4017 for input)
	; Here, just increment menu_selection for demo
	INC menu_selection
	JSR Sound_PlayMenuSelect ; Play menu select sound
	LDA menu_selection
	CMP #3
	BCC rc_done
	LDA #0
	STA menu_selection
rc_done:
	RTS

; --- Menu Selection Variables ---
	.segment "ZEROPAGE"
menu_selection: .res 1, 0

; --- Menu Actions ---
Menu_StartGame:
	JMP RESET_MAIN
Menu_CMOS:
	JMP CMOS_Menu
Menu_Editor:
	JMP Editor_Menu

; --- CMOS Menu Stub ---
CMOS_Menu:
	; Set background color (yellow) for CMOS screen
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006
	LDA #$27        ; Yellow
	STA $2007

	; (Placeholder) Simulate showing CMOS RAM values
	LDY #$7F
CMOS_delay:
	LDX #$FF
CMOS_delay_inner:
	DEX
	BNE CMOS_delay_inner
	DEY
	BNE CMOS_delay

	; Return to BIOS menu
	JMP BIOS_Menu

; --- Editor Menu Stub ---
Editor_Menu:
	; Set background color (blue-gray) for editor screen
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006
	LDA #$11        ; Blue-gray
	STA $2007

	; Editor loop: allow increment/decrement of CMOS RAM value
EditorLoop:
	JSR Editor_DrawValue
	JSR Editor_HandleInput
	JMP EditorLoop

; --- Editor: Draw Value (placeholder, just delay) ---
Editor_DrawValue:
	; Would normally draw value to screen
	LDY #$1F
EditorDraw_delay:
	LDX #$FF
EditorDraw_delay_inner:
	DEX
	BNE EditorDraw_delay_inner
	DEY
	BNE EditorDraw_delay
	RTS

; --- Editor: Handle Input (simulate increment/decrement) ---
Editor_HandleInput:
	; For demo, alternate increment/decrement CMOS_RAM_ADDR
	LDA editor_toggle
	EOR #$01
	STA editor_toggle
	BEQ EditorInc
EditorDec:
	LDA CMOS_RAM_ADDR
	SEC
	SBC #1
	STA CMOS_RAM_ADDR
	RTS
EditorInc:
	LDA CMOS_RAM_ADDR
	CLC
	ADC #1
	STA CMOS_RAM_ADDR
	RTS

	.segment "ZEROPAGE"
editor_toggle: .res 1, 0
