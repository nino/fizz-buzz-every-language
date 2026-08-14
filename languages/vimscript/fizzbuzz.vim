" FizzBuzz in Vim script
for s:i in range(1, 100)
  if s:i % 15 == 0
    echo 'FizzBuzz'
  elseif s:i % 3 == 0
    echo 'Fizz'
  elseif s:i % 5 == 0
    echo 'Buzz'
  else
    echo s:i
  endif
endfor
