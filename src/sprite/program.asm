; sprite
; Displays a sprite that can be controlled with a controller
.INCLUDE "../lib/registers.asm"
.INCLUDE "../lib/settings.asm"
.INCLUDE "../lib/values.asm"
.INCLUDE "header.asm"

.BANK 0
.ORG 0

.SECTION "Main"

Reset:
    clc
    xce

    rep #$08

    .INCLUDE "../lib/initialize.asm"

; Create color palette

    sep #$20

    lda #$81    ; Palette 8, color 1 (white)
    sta CGADD
    lda #$FF
    sta CGDATA
    lda #$7F
    sta CGDATA

; Create a sprite

    stz OBSEL   ; Sprite size is 8x8 or 16x16, sprite character segment 0

    stz OAMADDH     ; Select table 1
    stz OAMADDL
    
    ; Sprite 0
    lda #(SCREEN_W / 2 - 8)
    sta OAMDATA     ; x
    lda #(SCREEN_H / 2 - 8)
    sta OAMDATA     ; y
    lda #$02
    sta OAMDATA     ; Character 2
    stz OAMDATA     ; Palette 0, priority 0, no flip

    stz OAMADDL
    lda #$01        ; Select table 2
    sta OAMADDH
    lda #%00000010
    sta OAMDATA     ; Size large (see OBSEL)

; Create a character

    lda #$00    ; Increment address after writing VMDATAL
    sta VMAIN

    ; Sprite character segment 0
    ; Character 2 (@4bpp)
    lda #$20
    sta VMADD

    ; Character 2
    lda #%10000000
    sta VMDATAL
    lda #%11000000
    sta VMDATAL
    lda #%10100000
    sta VMDATAL
    lda #%10010000
    sta VMDATAL
    lda #%10001000
    sta VMDATAL
    lda #%10000100
    sta VMDATAL
    lda #%10000010
    sta VMDATAL
    lda #%10000001
    sta VMDATAL

    ; Skip to character 3 (@4bpp)
    lda #$30
    sta VMADD

    ; Character 3
    lda #%00000000
    sta VMDATAL
    lda #%00000000
    sta VMDATAL
    lda #%00000000
    sta VMDATAL
    lda #%00000000
    sta VMDATAL
    lda #%00000000
    sta VMDATAL
    lda #%00000000
    sta VMDATAL
    lda #%00000000
    sta VMDATAL
    lda #%00000000
    sta VMDATAL

    rep #$20

    ; Skip to character 18 (@4bpp)
    lda #$0120
    sta VMADD

    ; Character 18
    lda #%10000000
    sta VMDATAL
    lda #%10000000
    sta VMDATAL
    lda #%10000000
    sta VMDATAL
    lda #%10000000
    sta VMDATAL
    lda #%10000000
    sta VMDATAL
    lda #%10000000
    sta VMDATAL
    lda #%10000000
    sta VMDATAL
    lda #%11111111
    sta VMDATAL

    ; Skip to character 19 (@4bpp)
    lda #$0130
    sta VMADD

    ; Character 19
    lda #%10000000
    sta VMDATAL
    lda #%01000000
    sta VMDATAL
    lda #%00100000
    sta VMDATAL
    lda #%00010000
    sta VMDATAL
    lda #%00001000
    sta VMDATAL
    lda #%00000100
    sta VMDATAL
    lda #%00000010
    sta VMDATAL
    lda #%11111111
    sta VMDATAL

; Enable background layer, screen

    sep #$20

    lda #%00010000  ; Enable BG1
    sta TM

    lda #$0F
    sta INIDISP

    lda #NMITIMEN_NMIENABLE
    sta NMITIMEN

-   wai
    jmp -

VBlank:
    rti

.ENDS
