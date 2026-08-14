// FizzBuzz in Koka
fun fizzbuzz(n : int) : string
  if n % 15 == 0 then "FizzBuzz"
  elif n % 3 == 0 then "Fizz"
  elif n % 5 == 0 then "Buzz"
  else n.show

fun main() : console ()
  list(1, 100).foreach fn(i)
    println(fizzbuzz(i))
