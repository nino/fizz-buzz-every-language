#include "share/atspre_staload.hats"

fun fizzbuzz (n: int): void =
  if n % 15 = 0 then println! ("FizzBuzz")
  else if n % 3 = 0 then println! ("Fizz")
  else if n % 5 = 0 then println! ("Buzz")
  else println! (n)

implement main0 () = let
  fun loop (i: int): void =
    if i <= 100 then (fizzbuzz (i); loop (i + 1))
in
  loop (1)
end
