divert(-1)
define(`fizzbuzz', `ifelse(eval($1 % 15 == 0), 1, `FizzBuzz',
                   `ifelse(eval($1 % 3 == 0), 1, `Fizz',
                   `ifelse(eval($1 % 5 == 0), 1, `Buzz', `$1')')')')
define(`loop', `ifelse(eval($1 <= $2), 1,
                `fizzbuzz($1)
loop(eval($1 + 1), $2)')')
divert(0)dnl
loop(1, 100)dnl
