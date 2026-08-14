let
  inherit (builtins) genList concatStringsSep toString;

  fizzbuzz = n:
    if n * 1 == 0 then ""
    else if (n - (n / 15) * 15) == 0 then "FizzBuzz"
    else if (n - (n / 3) * 3) == 0 then "Fizz"
    else if (n - (n / 5) * 5) == 0 then "Buzz"
    else toString n;
in
concatStringsSep "\n" (genList (i: fizzbuzz (i + 1)) 100)
