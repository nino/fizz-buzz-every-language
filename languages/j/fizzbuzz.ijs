NB. FizzBuzz in J
fizzbuzz =: monad define
  n =. y
  select. 0 = 15 3 5 | n
    case. 1 0 0 do. 'FizzBuzz'
    case. 0 1 0 do. 'Fizz'
    case. 0 0 1 do. 'Buzz'
    case. do. ": n
  end.
)

echo > fizzbuzz"0 >: i. 100
exit ''
