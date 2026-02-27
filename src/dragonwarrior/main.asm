; Dragon Warrior Clone - Main Game Logic

.segment "CODE"

DW_Main:
    JSR DW_BootScreen
    JSR DW_Init
    JSR DW_TitleScreen
DW_MainLoop:
    JSR DW_Tick
    JMP DW_MainLoop

DW_BootScreen:
    LDA #29
    STA DW_MessageId
    JSR DW_SoundBoot
    RTS

DW_Init:
    JSR DW_DataInit
    JSR DW_GfxInit
    JSR DW_SoundInit
    RTS

DW_TitleScreen:
    ; Placeholder title flow. START confirms begin.
    LDA #30
    STA DW_MessageId
@waitStart:
    JSR DW_InputPoll
    LDA DW_InputPressed
    AND #DW_BTN_START
    BEQ @waitStart
    LDA #31
    STA DW_MessageId
    RTS

DW_Tick:
    JSR DW_InputPoll
    JSR DW_MenuLoop
    LDA DW_BattleActive
    BNE @battle
    JSR DW_MapLoop
    JMP @draw
@battle:
    JSR DW_BattleLoop
@draw:
    JSR DW_DrawFrame
    RTS

DW_InputPoll:
    ; NES controller 1 read from $4016.
    LDA #$01
    STA $4016
    LDA #$00
    STA $4016

    LDX #8
    LDA #0
    STA DW_InputHeld
@readLoop:
    LDA $4016
    AND #1
    ROR A
    ROL DW_InputHeld
    DEX
    BNE @readLoop

    ; pressed = held & (~prev)
    LDA DW_InputPrev
    EOR #$FF
    AND DW_InputHeld
    STA DW_InputPressed

    LDA DW_InputHeld
    STA DW_InputPrev
    RTS
