# FizzBuzz for x86-64 Linux, GNU as syntax, raw syscalls (no libc).
        .section .rodata
sfizzbuzz:  .ascii "FizzBuzz\n"
        .set    sfizzbuzz_len, 9
sfizz:      .ascii "Fizz\n"
        .set    sfizz_len, 5
sbuzz:      .ascii "Buzz\n"
        .set    sbuzz_len, 5

        .bss
        .lcomm  numbuf, 16

        .text
        .globl  _start
_start:
        movq    $1, %r12                # i = 1
.Lloop:
        cmpq    $100, %r12
        jg      .Ldone

        movq    %r12, %rax              # i % 15
        xorq    %rdx, %rdx
        movq    $15, %rcx
        divq    %rcx
        testq   %rdx, %rdx
        jz      .Lfizzbuzz

        movq    %r12, %rax              # i % 3
        xorq    %rdx, %rdx
        movq    $3, %rcx
        divq    %rcx
        testq   %rdx, %rdx
        jz      .Lfizz

        movq    %r12, %rax              # i % 5
        xorq    %rdx, %rdx
        movq    $5, %rcx
        divq    %rcx
        testq   %rdx, %rdx
        jz      .Lbuzz

.Lnumber:                               # itoa into numbuf, backwards
        leaq    numbuf(%rip), %rbx
        addq    $15, %rbx
        movb    $10, (%rbx)             # trailing newline
        movq    %r12, %rax
.Lconv:
        xorq    %rdx, %rdx
        movq    $10, %rcx
        divq    %rcx
        addb    $48, %dl
        decq    %rbx
        movb    %dl, (%rbx)
        testq   %rax, %rax
        jnz     .Lconv
        leaq    numbuf(%rip), %rdx
        addq    $16, %rdx
        subq    %rbx, %rdx              # rdx = length
        movq    %rbx, %rsi
        jmp     .Lwrite

.Lfizzbuzz:
        leaq    sfizzbuzz(%rip), %rsi
        movq    $sfizzbuzz_len, %rdx
        jmp     .Lwrite
.Lfizz:
        leaq    sfizz(%rip), %rsi
        movq    $sfizz_len, %rdx
        jmp     .Lwrite
.Lbuzz:
        leaq    sbuzz(%rip), %rsi
        movq    $sbuzz_len, %rdx

.Lwrite:
        movq    $1, %rax                # sys_write
        movq    $1, %rdi                # fd = stdout
        syscall
        incq    %r12
        jmp     .Lloop

.Ldone:
        movq    $60, %rax               # sys_exit
        xorq    %rdi, %rdi
        syscall
