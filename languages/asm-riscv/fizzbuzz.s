# FizzBuzz for RISC-V (RV64) Linux, raw syscalls (no libc).
        .section .rodata
sfizzbuzz:  .ascii "FizzBuzz\n"
        .equ    sfizzbuzz_len, 9
sfizz:      .ascii "Fizz\n"
        .equ    sfizz_len, 5
sbuzz:      .ascii "Buzz\n"
        .equ    sbuzz_len, 5

        .bss
        .align  3
numbuf: .skip   16

        .text
        .globl  _start
_start:
        li      s0, 1                   # i = 1
loop:
        li      t0, 100
        bgt     s0, t0, done

        li      t1, 15                  # i % 15
        rem     t2, s0, t1
        beqz    t2, do_fizzbuzz

        li      t1, 3                   # i % 3
        rem     t2, s0, t1
        beqz    t2, do_fizz

        li      t1, 5                   # i % 5
        rem     t2, s0, t1
        beqz    t2, do_buzz

number:                                 # itoa backwards into numbuf
        la      s1, numbuf
        addi    s1, s1, 15
        li      t0, 10
        sb      t0, 0(s1)               # trailing newline
        mv      t3, s0
        li      t4, 10
conv:
        rem     t5, t3, t4
        addi    t5, t5, 48
        addi    s1, s1, -1
        sb      t5, 0(s1)
        div     t3, t3, t4
        bnez    t3, conv
        la      a2, numbuf
        addi    a2, a2, 16
        sub     a2, a2, s1              # length
        mv      a1, s1
        j       write

do_fizzbuzz:
        la      a1, sfizzbuzz
        li      a2, sfizzbuzz_len
        j       write
do_fizz:
        la      a1, sfizz
        li      a2, sfizz_len
        j       write
do_buzz:
        la      a1, sbuzz
        li      a2, sbuzz_len

write:
        li      a0, 1                   # fd = stdout
        li      a7, 64                  # __NR_write
        ecall
        addi    s0, s0, 1
        j       loop

done:
        li      a0, 0
        li      a7, 93                  # __NR_exit
        ecall
