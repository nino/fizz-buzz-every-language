-- FizzBuzz in Dhall. Dhall is total and has no modulo, so `mod` is built
-- from integer division: n - d * (n / d).
let List/map = https://prelude.dhall-lang.org/List/map
let Natural/enumerate = https://prelude.dhall-lang.org/Natural/enumerate
let Text/concatSep = https://prelude.dhall-lang.org/Text/concatSep

let mod =
      \(n : Natural) ->
      \(d : Natural) ->
        Natural/subtract (d * (n / d)) n

let classify =
      \(n : Natural) ->
        if        Natural/isZero (mod n 15)
        then      "FizzBuzz"
        else if   Natural/isZero (mod n 3)
        then      "Fizz"
        else if   Natural/isZero (mod n 5)
        then      "Buzz"
        else      Natural/show n

in  Text/concatSep
      "\n"
      ( List/map
          Natural
          Text
          (\(i : Natural) -> classify (i + 1))
          (Natural/enumerate 100)
      )
