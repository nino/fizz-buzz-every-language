-- FizzBuzz in Curry (functional-logic; the pure-functional subset here
-- reads almost exactly like Haskell).
fizzbuzz :: Int -> String
fizzbuzz n
  | n `mod` 15 == 0 = "FizzBuzz"
  | n `mod` 3 == 0  = "Fizz"
  | n `mod` 5 == 0  = "Buzz"
  | otherwise       = show n

main :: IO ()
main = mapM_ (putStrLn . fizzbuzz) [1 .. 100]
