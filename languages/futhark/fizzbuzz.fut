-- FizzBuzz in Futhark. Returns a code per entry:
-- 0 = number itself, 1 = Fizz, 2 = Buzz, 3 = FizzBuzz.
def classify (n: i32): i32 =
  if n % 15 == 0 then 3
  else if n % 3 == 0 then 1
  else if n % 5 == 0 then 2
  else 0

def main: [100]i32 =
  map classify (map (+1) (map i32.i64 (iota 100)))
