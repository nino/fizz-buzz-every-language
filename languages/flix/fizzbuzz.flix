// FizzBuzz in Flix
def fizzbuzz(n: Int32): String =
    if (Int32.remainder(n, 15) == 0) "FizzBuzz"
    else if (Int32.remainder(n, 3) == 0) "Fizz"
    else if (Int32.remainder(n, 5) == 0) "Buzz"
    else "${n}"

def main(): Unit \ IO =
    List.range(1, 101) |> List.forEach(i -> println(fizzbuzz(i)))
