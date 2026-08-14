// FizzBuzz for AArch64 Linux, GNU as syntax, raw syscalls (no libc).
        .section .rodata
sfizzbuzz:  .ascii "FizzBuzz\n"
        .set    sfizzbuzz_len, 9
sfizz:      .ascii "Fizz\n"
        .set    sfizz_len, 5
sbuzz:      .ascii "Buzz\n"
        .set    sbuzz_len, 5

        .bss
        .align  3
numbuf: .skip   16

        .text
        .globl  _start
_start:
        mov     x19, #1                 // i = 1
loop:
        cmp     x19, #100
        b.gt    done

        mov     x20, #15                // i % 15
        udiv    x21, x19, x20
        msub    x21, x21, x20, x19
        cbz     x21, do_fizzbuzz

        mov     x20, #3                 // i % 3
        udiv    x21, x19, x20
        msub    x21, x21, x20, x19
        cbz     x21, do_fizz

        mov     x20, #5                 // i % 5
        udiv    x21, x19, x20
        msub    x21, x21, x20, x19
        cbz     x21, do_buzz

number:                                 // itoa backwards into numbuf
        adrp    x22, numbuf
        add     x22, x22, :lo12:numbuf
        add     x22, x22, #15
        mov     w23, #10
        strb    w23, [x22]              // trailing newline
        mov     x24, x19
        mov     x25, #10
conv:
        udiv    x26, x24, x25
        msub    x27, x26, x25, x24      // digit = x24 - x26*10
        add     w27, w27, #48
        sub     x22, x22, #1
        strb    w27, [x22]
        mov     x24, x26
        cbnz    x24, conv
        adrp    x2, numbuf
        add     x2, x2, :lo12:numbuf
        add     x2, x2, #16
        sub     x2, x2, x22             // length
        mov     x1, x22
        b       write

do_fizzbuzz:
        adrp    x1, sfizzbuzz
        add     x1, x1, :lo12:sfizzbuzz
        mov     x2, #sfizzbuzz_len
        b       write
do_fizz:
        adrp    x1, sfizz
        add     x1, x1, :lo12:sfizz
        mov     x2, #sfizz_len
        b       write
do_buzz:
        adrp    x1, sbuzz
        add     x1, x1, :lo12:sbuzz
        mov     x2, #sbuzz_len

write:
        mov     x0, #1                  // fd = stdout
        mov     x8, #64                 // __NR_write
        svc     #0
        add     x19, x19, #1
        b       loop

done:
        mov     x0, #0
        mov     x8, #93                 // __NR_exit
        svc     #0
