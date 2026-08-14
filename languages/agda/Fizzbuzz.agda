module Fizzbuzz where

open import Agda.Builtin.Nat using (Nat; zero; suc; _==_; mod-helper)
open import Agda.Builtin.Bool using (Bool; true; false)
open import Agda.Builtin.String using (String)
open import Agda.Builtin.IO using (IO)
open import Agda.Builtin.Unit using (⊤; tt)

postulate
  putStrLn : String → IO ⊤
  _>>=_    : {A B : Set} → IO A → (A → IO B) → IO B
  return   : {A : Set} → A → IO A
  showNat  : Nat → String

{-# FOREIGN GHC import qualified Data.Text as T #-}
{-# FOREIGN GHC import qualified Data.Text.IO as TIO #-}
{-# COMPILE GHC putStrLn = TIO.putStrLn #-}
{-# COMPILE GHC _>>=_ = \_ _ -> (>>=) #-}
{-# COMPILE GHC return = \_ -> return #-}
{-# COMPILE GHC showNat = \n -> T.pack (show n) #-}

_>>_ : {A B : Set} → IO A → IO B → IO B
m >> k = m >>= λ _ → k

-- Agda.Builtin.Nat exposes division only via mod-helper.
_%_ : Nat → Nat → Nat
n % zero    = n
n % (suc k) = mod-helper 0 k n k

if_then_else_ : {A : Set} → Bool → A → A → A
if true  then t else _ = t
if false then _ else f = f

fizzbuzz : Nat → String
fizzbuzz n =
  if (n % 15) == 0 then "FizzBuzz"
  else if (n % 3) == 0 then "Fizz"
  else if (n % 5) == 0 then "Buzz"
  else showNat n

-- `fuel` decreases structurally, which is what makes this pass the
-- termination checker; `n` is the value we are printing.
loop : Nat → Nat → IO ⊤
loop zero        _ = return tt
loop (suc fuel)  n = putStrLn (fizzbuzz n) >> loop fuel (suc n)

main : IO ⊤
main = loop 100 1
