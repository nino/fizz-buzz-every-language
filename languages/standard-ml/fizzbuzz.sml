fun fizzbuzz n =
  if n mod 15 = 0 then "FizzBuzz"
  else if n mod 3 = 0 then "Fizz"
  else if n mod 5 = 0 then "Buzz"
  else Int.toString n

fun loop i =
  if i > 100 then ()
  else (print (fizzbuzz i ^ "\n"); loop (i + 1))

val () = loop 1
