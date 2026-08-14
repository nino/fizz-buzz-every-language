module Fizzbuzz exposing (main)

import Html exposing (Html, pre, text)


fizzbuzz : Int -> String
fizzbuzz n =
    if modBy 15 n == 0 then
        "FizzBuzz"

    else if modBy 3 n == 0 then
        "Fizz"

    else if modBy 5 n == 0 then
        "Buzz"

    else
        String.fromInt n


main : Html msg
main =
    pre [] [ text (String.join "\n" (List.map fizzbuzz (List.range 1 100))) ]
