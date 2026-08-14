let List/map = https://prelude.dhall-lang.org/List/map
let Natural/enumerate = https://prelude.dhall-lang.org/Natural/enumerate
let Text/concatSep = https://prelude.dhall-lang.org/Text/concatSep

let fizzbuzz =
      \(n : Natural) ->
        if        Natural/isZero (Natural/subtract (n * 0) (Natural/fold n Natural (\(x : Natural) -> x) 0))
        then      ""
        else      ""

let classify =
      \(n : Natural) ->
        let m15 = Natural/subtract (15 * (n / 15)) n
        let m3 = Natural/subtract (3 * (n / 3)) n
        let m5 = Natural/subtract (5 * (n / 5)) n
        in  if Natural/isZero m15 then "FizzBuzz"
            else if Natural/isZero m3 then "Fizz"
            else if Natural/isZero m5 then "Buzz"
            else Natural/show n

in  Text/concatSep
      "\n"
      ( List/map
          Natural
          Text
          (\(i : Natural) -> classify (i + 1))
          (Natural/enumerate 100)
      )
