module fizzbuzz

import StdEnv

fizzbuzz :: Int -> String
fizzbuzz n
  | n rem 15 == 0 = "FizzBuzz"
  | n rem 3 == 0  = "Fizz"
  | n rem 5 == 0  = "Buzz"
  | otherwise     = toString n

Start :: *World -> *World
Start world = foldl (\w s = snd (fclose (fwrites (s +++ "\n") (snd (stdio w)))))
                    world [fizzbuzz n \\ n <- [1 .. 100]]
