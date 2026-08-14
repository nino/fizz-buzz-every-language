#!/usr/bin/env bqn
# FizzBuzz in BQN.
#
# Replicate (/) does the branching without any conditional: a scalar 0 on the
# left drops the whole string, a scalar 1 keeps it. So "Fizz" survives only
# when 3 divides n, and the two results are joined. FizzBuzz needs no special
# case -- it is simply both halves surviving at once.

FizzBuzz ← {
  s ← ((0 = 3 | 𝕩) / "Fizz") ∾ ((0 = 5 | 𝕩) / "Buzz")
  0 < ≠s ? s ; •Repr 𝕩
}

•Out¨ FizzBuzz¨ 1 + ↕100
