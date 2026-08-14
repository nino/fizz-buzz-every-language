// FizzBuzz in BCPL, the language C descends from.
GET "libhdr"

LET fizzbuzz(n) BE
$(  TEST n REM 15 = 0 THEN writes("FizzBuzz*N")
    ELSE TEST n REM 3 = 0 THEN writes("Fizz*N")
    ELSE TEST n REM 5 = 0 THEN writes("Buzz*N")
    ELSE writef("%N*N", n)
$)

LET start() = VALOF
$(  FOR i = 1 TO 100 DO fizzbuzz(i)
    RESULTIS 0
$)
