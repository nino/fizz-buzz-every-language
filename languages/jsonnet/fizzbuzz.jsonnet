local fizzbuzz(n) =
  if n % 15 == 0 then 'FizzBuzz'
  else if n % 3 == 0 then 'Fizz'
  else if n % 5 == 0 then 'Buzz'
  else std.toString(n);

std.join('\n', [fizzbuzz(i) for i in std.range(1, 100)])
