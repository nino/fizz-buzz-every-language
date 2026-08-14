module Fizzbuzz where

open import Agda.Builtin.Nat using (Nat; _+_; mod-helper)
open import Agda.Builtin.String using (String)
open import Agda.Builtin.IO using (IO)
open import Agda.Builtin.Unit using (⊤)
open import Agda.Builtin.List using (List; []; _∷_)

postulate
  putStrLn : String → IO ⊤
  _>>_     : IO ⊤ → IO ⊤ → IO ⊤
  showNat  : Nat → String

{-# FOREIGN GHC import qualified Data.Text.IO as T #-}
{-# COMPILE GHC putStrLn = T.putStrLn #-}
{-# COMPILE GHC _>>_ = \x y -> x >> y #-}
{-# COMPILE GHC showNat = \n -> Data.Text.pack (show n) #-}

_%_ : Nat → Nat → Nat
n % (Agda.Builtin.Nat.suc m) = mod-helper 0 m n m
n % zero = n

fizzbuzz : Nat → String
fizzbuzz n with n % 15 | n % 3 | n % 5
... | 0 | _ | _ = "FizzBuzz"
... | _ | 0 | _ = "Fizz"
... | _ | _ | 0 = "Buzz"
... | _ | _ | _ = showNat n

count : Nat → List Nat
count zero = []
count (Agda.Builtin.Nat.suc n) = count n Agda.Builtin.List.++ (Agda.Builtin.Nat.suc n ∷ [])

main : IO ⊤
main = go 1 where
  go : Nat → IO ⊤
  go n = putStrLn (fizzbuzz n)
