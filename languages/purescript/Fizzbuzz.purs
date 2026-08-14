module Main where

import Prelude

import Data.Array ((..))
import Data.Foldable (for_)
import Effect (Effect)
import Effect.Console (log)

fizzbuzz :: Int -> String
fizzbuzz n
  | mod n 15 == 0 = "FizzBuzz"
  | mod n 3 == 0 = "Fizz"
  | mod n 5 == 0 = "Buzz"
  | otherwise = show n

main :: Effect Unit
main = for_ (1 .. 100) (log <<< fizzbuzz)
