; Dragon Warrior Clone - Sound

.segment "RODATA"
DW_Music:
    ; Boot/title pattern.
    .byte $48,$50,$58,$60,$68,$70,$78,$80,$00
    ; Field pattern.
    .byte $40,$44,$48,$4C,$50,$54,$58,$5C,$00

DW_SFX:
    ; Hit/confirm/noise placeholders.
    .byte $F0,$E0,$D0,$C0,$00
    .byte $80,$90,$A0,$B0,$00

.segment "CODE"
DW_SoundInit:
    RTS

DW_SoundBoot:
    RTS

DW_SoundMenuMove:
    RTS

DW_SoundMenuConfirm:
    RTS

DW_SoundBattleHit:
    RTS
