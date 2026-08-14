# FizzBuzz in Uiua.
# 
# Nothing branches. Each n is turned into an index and the index picks a
# branch of the switch function:
# 
#   0 = neither   -> the number, formatted by °⋕
#   1 = Fizz      -> divisible by 3
#   2 = Buzz      -> divisible by 5
#   3 = FizzBuzz  -> both
# 
# The index is (3 divides n) + 2 x (5 divides n), so the combined case falls
# out of the arithmetic rather than needing a test of its own.
# 
# ⟜∘ keeps a copy of n underneath, because the switch consumes the index but
# the number branch still needs the number.

Fizz  ← =0◿3
Buzz  ← =0◿5
Index ← +⊃Fizz(×2 Buzz)
Label ← ⨬(°⋕|"Fizz"|"Buzz"|"FizzBuzz")

≡(&p Label Index ⟜∘) +1⇡100
