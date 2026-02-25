; Minimal NES ROM in 6502 Assembly
; Fills the screen with a color (background)
; Assembles with NESASM, ca65, or similar

        .inesprg 1   ; 1x 16KB PRG ROM
        .ineschr 1   ; 1x 8KB CHR ROM
        .inesmap 0   ; Mapper 0 (NROM)
        .inesmir 1   ; Vertical mirroring


        .org $C000

; --- Simulated BIOS Routine ---
BIOS:
        SEI             ; Disable interrupts
        CLD             ; Clear decimal mode
        LDX #$40
        STX $4017       ; Disable APU frame IRQ
        LDX #$FF
        TXS             ; Set up stack
        INX
        STX $2000       ; Disable NMI
        STX $2001       ; Disable rendering
        STX $4010       ; Disable DMC IRQ

        ; Wait for PPU to stabilize
        LDY #$00
vblankwait1:
        BIT $2002
        BPL vblankwait1
vblankwait2:
        BIT $2002
        BPL vblankwait2

        ; BIOS visual: Set background color (red)
        LDA #$3F
        STA $2006
        LDA #$00
        STA $2006
        LDA #$16        ; Red
        STA $2007

        ; Short delay to show BIOS color
        LDY #$FF
BIOS_delay:
        LDX #$FF
BIOS_delay_inner:
        DEX
        BNE BIOS_delay_inner
        DEY
        BNE BIOS_delay

        JMP RESET_MAIN  ; Jump to main game code

; --- Main Game Code ---
RESET_MAIN:
        ; Set background color (blue)
        LDA #$3F
        STA $2006
        LDA #$00
        STA $2006
        LDA #$21        ; Blue
        STA $2007

        ; Enable rendering
        LDA #%10001000  ; Enable NMI, background
        STA $2000
        LDA #%00011110  ; Show background
        STA $2001

        ; CMOS RAM demo: Write and read value
        LDA #$42        ; Example value
        STA CMOS_RAM    ; Store to CMOS
        LDA CMOS_RAM    ; Read from CMOS (for demo)

Forever:
        JMP Forever


; --- CMOS RAM Section (simulated, in zero page) ---
        .org $0002
CMOS_RAM:
        .res 1          ; 1 byte CMOS RAM (expand as needed)

; --- NMI handler (required, but empty for now) ---
        .org $C100
NMI:
        RTI

; --- IRQ handler (not used) ---
IRQ:
        RTI


        .org $FFFA
        .dw NMI         ; NMI vector
        .dw BIOS        ; Reset vector (start at BIOS)
        .dw IRQ         ; IRQ/BRK vector

        .bank 1
        .org $0000
        .dsb $2000, $00 ; 8KB CHR ROM (blank)
