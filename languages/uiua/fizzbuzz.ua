# FizzBuzz in Uiua.
#
# Rather than branching, each n is turned into an index and the index selects
# a branch of the switch function ⨬:
#
#   0 = neither  -> the number itself
#   1 = Fizz     -> divisible by 3
#   2 = Buzz     -> divisible by 5
#   3 = FizzBuzz -> both
#
# The index is (3 divides n) + 2 × (5 divides n), so the "both" case falls out
# of the arithmetic instead of needing its own test.

Fizz? ← =0◿3
Buzz? ← =0◿5
Index ← +⊃Fizz?(×2 Buzz?)
Label ← ⨬(°⋕|"Fizz"|"Buzz"|"FizzBuzz")

&p⊂∵(Label Index.) +1⇡100
