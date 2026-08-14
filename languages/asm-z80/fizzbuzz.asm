; FizzBuzz for the Z80 (CP/M; BDOS function 9 = print string, 2 = print char).
BDOS    EQU 5
PRINTS  EQU 9
PRINTC  EQU 2

        ORG 100h

start:
        LD B, 1                 ; i = 1
loop:
        LD A, B
        CALL mod15
        JR NZ, try3
        LD DE, txt_fizzbuzz
        CALL puts
        JR next

try3:
        LD A, B
        CALL mod3
        JR NZ, try5
        LD DE, txt_fizz
        CALL puts
        JR next

try5:
        LD A, B
        CALL mod5
        JR NZ, plain
        LD DE, txt_buzz
        CALL puts
        JR next

plain:
        LD A, B
        CALL print_dec

next:
        LD E, 13
        CALL putc
        LD E, 10
        CALL putc
        INC B
        LD A, B
        CP 101
        JR NZ, loop
        RET

; --- A mod n, result in A, zero flag set if divisible ---
mod15:  LD C, 15
        JR modn
mod3:   LD C, 3
        JR modn
mod5:   LD C, 5
modn:
        SUB C
        JR NC, modn
        ADD A, C
        OR A
        RET

; --- print '$'-terminated string at DE ---
puts:
        LD C, PRINTS
        JP BDOS

; --- print char in E ---
putc:
        LD C, PRINTC
        JP BDOS

; --- print A (1..100) as decimal ---
print_dec:
        LD H, 0
        LD L, A
        LD C, 100
        CALL digit
        LD C, 10
        CALL digit
        LD A, L
        ADD A, '0'
        LD E, A
        JP putc

digit:
        LD B, 0
dloop:
        LD A, L
        SUB C
        JR C, ddone
        LD L, A
        INC B
        JR dloop
ddone:
        LD A, B
        OR A
        RET Z                   ; suppress leading zeros
        ADD A, '0'
        LD E, A
        PUSH BC
        CALL putc
        POP BC
        RET

txt_fizzbuzz: DB 'FizzBuzz$'
txt_fizz:     DB 'Fizz$'
txt_buzz:     DB 'Buzz$'
