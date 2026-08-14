module Main

fizzbuzz : Nat -> String
fizzbuzz n =
  if modNat n 15 == 0 then "FizzBuzz"
  else if modNat n 3 == 0 then "Fizz"
  else if modNat n 5 == 0 then "Buzz"
  else show n

main : IO ()
main = traverse_ (putStrLn . fizzbuzz) [1 .. 100]
