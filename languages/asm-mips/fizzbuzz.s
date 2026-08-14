# FizzBuzz for MIPS32 (MARS/SPIM system calls).
        .data
sfizzbuzz:  .asciiz "FizzBuzz\n"
sfizz:      .asciiz "Fizz\n"
sbuzz:      .asciiz "Buzz\n"
newline:    .asciiz "\n"

        .text
        .globl  main
main:
        li      $s0, 1                  # i = 1
loop:
        li      $t0, 100
        bgt     $s0, $t0, done

        li      $t1, 15                 # i % 15
        div     $s0, $t1
        mfhi    $t2
        beqz    $t2, do_fizzbuzz

        li      $t1, 3                  # i % 3
        div     $s0, $t1
        mfhi    $t2
        beqz    $t2, do_fizz

        li      $t1, 5                  # i % 5
        div     $s0, $t1
        mfhi    $t2
        beqz    $t2, do_buzz

        li      $v0, 1                  # print_int
        move    $a0, $s0
        syscall
        j       print_newline

do_fizzbuzz:
        li      $v0, 4                  # print_string
        la      $a0, sfizzbuzz
        syscall
        j       next
do_fizz:
        li      $v0, 4
        la      $a0, sfizz
        syscall
        j       next
do_buzz:
        li      $v0, 4
        la      $a0, sbuzz
        syscall
        j       next

print_newline:
        li      $v0, 4
        la      $a0, newline
        syscall

next:
        addi    $s0, $s0, 1
        j       loop

done:
        li      $v0, 10                 # exit
        syscall
