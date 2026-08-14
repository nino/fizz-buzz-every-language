NB. FizzBuzz in J
fizzbuzz =: 3 : 0
  if. 0 = 15 | y do. 'FizzBuzz'
  elseif. 0 = 3 | y do. 'Fizz'
  elseif. 0 = 5 | y do. 'Buzz'
  elseif. do. ": y
  end.
)

main =: 3 : 0
  for_i. >: i. 100 do.
    echo fizzbuzz i
  end.
  i. 0 0
)

main ''
exit ''
