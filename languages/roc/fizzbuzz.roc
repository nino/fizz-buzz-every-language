app [main] { pf: platform "https://github.com/roc-lang/basic-cli/release/download/0.10.0/vNe6s9hWzoTZtFmNkvEICPErI9ptji_ySjicO6CkucY.tar.br" }

import pf.Stdout

fizzbuzz : U64 -> Str
fizzbuzz = \n ->
    when { three: n % 3, five: n % 5 } is
        { three: 0, five: 0 } -> "FizzBuzz"
        { three: 0 } -> "Fizz"
        { five: 0 } -> "Buzz"
        _ -> Num.toStr n

main =
    List.range { start: At 1, end: At 100 }
    |> List.map fizzbuzz
    |> Str.joinWith "\n"
    |> Stdout.line!
