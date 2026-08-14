; FizzBuzz for the 6502 (Commodore 64 flavour; CHROUT = $FFD2).
; Assemble with ca65/acme; run in an emulator.

CHROUT  = $FFD2

        * = $0801
        ; BASIC stub: 10 SYS 2062
        .byte $0C, $08, $0A, $00, $9E, $32, $30, $36, $32, $00, $00, $00

        * = $080E
start:
        lda #1
        sta counter
        lda #0
        sta fizz3
        sta fizz5

loop:
        ; increment the 3- and 5-cycle counters
        inc fizz3
        inc fizz5

        lda fizz3
        cmp #3
        bne check5
        ; multiple of 3
        lda #0
        sta fizz3
        lda fizz5
        cmp #5
        bne only_fizz
        ; multiple of 15
        lda #0
        sta fizz5
        ldx #<txt_fizzbuzz
        ldy #>txt_fizzbuzz
        jsr print
        jmp next

only_fizz:
        ldx #<txt_fizz
        ldy #>txt_fizz
        jsr print
        jmp next

check5:
        lda fizz5
        cmp #5
        bne plain
        lda #0
        sta fizz5
        ldx #<txt_buzz
        ldy #>txt_buzz
        jsr print
        jmp next

plain:
        lda counter
        jsr print_decimal

next:
        lda #13                 ; carriage return
        jsr CHROUT
        inc counter
        lda counter
        cmp #101
        bne loop
        rts

; --- print a NUL-terminated string at (X = lo, Y = hi) ---
print:
        stx strptr
        sty strptr+1
        ldy #0
print_loop:
        lda (strptr),y
        beq print_done
        jsr CHROUT
        iny
        bne print_loop
print_done:
        rts

; --- print A as decimal (1..100) ---
print_decimal:
        ldx #0
        cmp #100
        bcc tens
        ; value is exactly 100
        lda #$31                ; '1'
        jsr CHROUT
        lda #$30                ; '0'
        jsr CHROUT
        lda #$30                ; '0'
        jsr CHROUT
        rts
tens:
        ldx #0
div10:
        cmp #10
        bcc units
        sbc #10
        inx
        jmp div10
units:
        pha
        txa
        beq skip_tens
        clc
        adc #$30
        jsr CHROUT
skip_tens:
        pla
        clc
        adc #$30
        jsr CHROUT
        rts

txt_fizzbuzz: .byte "FIZZBUZZ", 0
txt_fizz:     .byte "FIZZ", 0
txt_buzz:     .byte "BUZZ", 0

counter: .byte 0
fizz3:   .byte 0
fizz5:   .byte 0
strptr:  .word 0
