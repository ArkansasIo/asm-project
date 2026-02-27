; 8BitStudio ROM UI/GUI routines
	.include "constants.inc"

; Game Boy-style GUI demo screen (4 green shades, simple windows).
UI_ShowGameBoyGUI:
	JSR UI_WaitVBlank

	LDA #$00
	STA $2000
	STA $2001

	JSR UI_LoadGuiTiles
	JSR UI_LoadGuiPalette
	JSR UI_ClearNametable
	JSR UI_DrawTopBar
	JSR UI_DrawMainWindow
	JSR UI_DrawBottomPanel
	JSR UI_InitGuiState
	JSR UI_DrawCursorIndicator

	LDA #%10001000
	STA $2000
	LDA #%00011110
	STA $2001
	RTS

UI_RunGameBoyGUI:
	JSR UI_ShowGameBoyGUI
@loop:
	JSR UI_WaitVBlank
	JSR UI_PollInput
	JSR UI_HandleInput
	JMP @loop

UI_WaitVBlank:
	BIT $2002
@wait:
	BIT $2002
	BPL @wait
	RTS

UI_LoadGuiTiles:
	LDA $2002
	LDA #$00
	STA $2006
	LDA #$00
	STA $2006

	LDX #$00
@tileLoop:
	LDA UI_GuiTiles, X
	STA $2007
	INX
	CPX #$30
	BNE @tileLoop
	RTS

UI_LoadGuiPalette:
	LDA $2002
	LDA #$3F
	STA $2006
	LDA #$00
	STA $2006

	LDX #$00
@palLoop:
	LDA UI_GuiPalette, X
	STA $2007
	INX
	CPX #$10
	BNE @palLoop
	RTS

UI_ClearNametable:
	LDA $2002
	LDA #$20
	STA $2006
	LDA #$00
	STA $2006

	LDA #$00
	LDX #$00
@clearOuter:
	LDY #$00
@clearInner:
	STA $2007
	INY
	BNE @clearInner
	INX
	CPX #$04
	BNE @clearOuter

	LDA #$20
	LDX #$00
@attrLoop:
	STA $2007
	INX
	CPX #$40
	BNE @attrLoop
	RTS

UI_DrawTopBar:
	LDA $2002
	LDA #$20
	STA $2006
	LDA #$00
	STA $2006

	LDA #$01
	LDX #$60
@loop:
	STA $2007
	DEX
	BNE @loop
	RTS

UI_DrawMainWindow:
	LDA #$24
	STA UI_TmpHigh
	LDA #$20
	STA UI_TmpLow
	LDA #$02
	STA UI_TmpTile
	LDA #$06
	STA UI_TmpRows
	LDA #$1C
	STA UI_TmpCols
	JSR UI_FillRect
	RTS

UI_DrawBottomPanel:
	LDA #$26
	STA UI_TmpHigh
	LDA #$80
	STA UI_TmpLow
	LDA #$03
	STA UI_TmpTile
	LDA #$04
	STA UI_TmpRows
	LDA #$20
	STA UI_TmpCols
	JSR UI_FillRect
	RTS

UI_InitGuiState:
	LDA #$01
	STA UI_MainTile
	LDA #$00
	STA UI_CursorIndex
	STA UI_SelectedIndex
	STA UI_InputPrev
	STA UI_InputHeld
	STA UI_InputPressed
	RTS

UI_PollInput:
	LDA #$01
	STA $4016
	LDA #$00
	STA $4016

	LDX #8
	LDA #0
	STA UI_InputHeld
@readLoop:
	LDA $4016
	AND #1
	ROR A
	ROL UI_InputHeld
	DEX
	BNE @readLoop

	LDA UI_InputPrev
	EOR #$FF
	AND UI_InputHeld
	STA UI_InputPressed

	LDA UI_InputHeld
	STA UI_InputPrev
	RTS

UI_HandleInput:
	LDA UI_InputPressed
	AND #DW_BTN_LEFT
	BEQ @checkRight
	LDA UI_CursorIndex
	BEQ @checkRight
	DEC UI_CursorIndex
@checkRight:
	LDA UI_InputPressed
	AND #DW_BTN_RIGHT
	BEQ @checkA
	LDA UI_CursorIndex
	CMP #2
	BCS @checkA
	INC UI_CursorIndex
@checkA:
	LDA UI_InputPressed
	AND #DW_BTN_A
	BEQ @checkB
	LDA UI_CursorIndex
	STA UI_SelectedIndex
	JSR UI_ApplySelection
@checkB:
	LDA UI_InputPressed
	AND #DW_BTN_B
	BEQ @draw
	LDA #0
	STA UI_SelectedIndex
	LDA #$01
	STA UI_MainTile
	JSR UI_DrawMainWindow
@draw:
	JSR UI_DrawCursorIndicator
	RTS

UI_ApplySelection:
	LDA UI_SelectedIndex
	BEQ @opt0
	CMP #1
	BEQ @opt1
	LDA #$03
	BNE @set
@opt0:
	LDA #$02
	BNE @set
@opt1:
	LDA #$01
@set:
	STA UI_MainTile

	LDA #$24
	STA UI_TmpHigh
	LDA #$20
	STA UI_TmpLow
	LDA UI_MainTile
	STA UI_TmpTile
	LDA #$06
	STA UI_TmpRows
	LDA #$1C
	STA UI_TmpCols
	JSR UI_FillRect
	RTS

UI_DrawCursorIndicator:
	LDA $2002

	LDA #$26
	STA $2006
	LDA #$C6
	STA $2006
	LDA #$00
	STA $2007

	LDA #$26
	STA $2006
	LDA #$CE
	STA $2006
	LDA #$00
	STA $2007

	LDA #$26
	STA $2006
	LDA #$D6
	STA $2006
	LDA #$00
	STA $2007

	LDA UI_CursorIndex
	BEQ @slot0
	CMP #1
	BEQ @slot1
	LDA #$D6
	BNE @write
@slot0:
	LDA #$C6
	BNE @write
@slot1:
	LDA #$CE
@write:
	STA UI_TmpLow
	LDA #$26
	STA $2006
	LDA UI_TmpLow
	STA $2006
	LDA #$01
	STA $2007
	RTS

; Inputs:
;   UI_TmpHigh:UI_TmpLow = nametable address
;   UI_TmpTile = tile id
;   UI_TmpRows = number of rows
;   UI_TmpCols = number of cols per row
UI_FillRect:
	LDY #$00
@rowLoop:
	LDA $2002
	LDA UI_TmpHigh
	STA $2006
	LDA UI_TmpLow
	STA $2006

	LDA UI_TmpTile
	LDX UI_TmpCols
@colLoop:
	STA $2007
	DEX
	BNE @colLoop

	CLC
	LDA UI_TmpLow
	ADC #$20
	STA UI_TmpLow
	LDA UI_TmpHigh
	ADC #$00
	STA UI_TmpHigh

	INY
	CPY UI_TmpRows
	BNE @rowLoop
	RTS

; Backward-compatible placeholders used by existing menu stubs.
UI_DrawMenuBox:
	RTS

UI_DrawButton:
	RTS

UI_DrawCursor:
	RTS

UI_ShowMessage:
	RTS

	.segment "RODATA"
UI_GuiPalette:
	.byte $0F, $2A, $19, $09
	.byte $0F, $2A, $19, $09
	.byte $0F, $2A, $19, $09
	.byte $0F, $2A, $19, $09

; Tile 0: blank
; Tile 1: solid fill
; Tile 2: checker
; Tile 3: horizontal stripe
UI_GuiTiles:
	.byte $00,$00,$00,$00,$00,$00,$00,$00, $00,$00,$00,$00,$00,$00,$00,$00
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF, $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $AA,$55,$AA,$55,$AA,$55,$AA,$55, $00,$00,$00,$00,$00,$00,$00,$00
	.byte $FF,$00,$FF,$00,$FF,$00,$FF,$00, $00,$00,$00,$00,$00,$00,$00,$00

	.segment "RAM"
UI_TmpHigh: .res 1
UI_TmpLow:  .res 1
UI_TmpTile: .res 1
UI_TmpRows: .res 1
UI_TmpCols: .res 1
UI_InputHeld: .res 1
UI_InputPressed: .res 1
UI_InputPrev: .res 1
UI_CursorIndex: .res 1
UI_SelectedIndex: .res 1
UI_MainTile: .res 1
