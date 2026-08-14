% FizzBuzz in MiniZinc. There is nothing to search for here -- the model is
% fully determined -- so the work happens in the output item.
int: n = 100;

function string: fizzbuzz(int: i) =
  if i mod 15 == 0 then "FizzBuzz"
  elseif i mod 3 == 0 then "Fizz"
  elseif i mod 5 == 0 then "Buzz"
  else show(i)
  endif;

solve satisfy;

output [ fizzbuzz(i) ++ "\n" | i in 1..n ];
