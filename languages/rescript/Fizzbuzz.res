// FizzBuzz in ReScript
let fizzbuzz = n =>
  if mod(n, 15) == 0 {
    "FizzBuzz"
  } else if mod(n, 3) == 0 {
    "Fizz"
  } else if mod(n, 5) == 0 {
    "Buzz"
  } else {
    Belt.Int.toString(n)
  }

for i in 1 to 100 {
  Js.log(fizzbuzz(i))
}
