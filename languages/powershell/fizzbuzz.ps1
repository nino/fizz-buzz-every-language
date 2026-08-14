1..100 | ForEach-Object {
    if ($_ % 15 -eq 0)    { 'FizzBuzz' }
    elseif ($_ % 3 -eq 0) { 'Fizz' }
    elseif ($_ % 5 -eq 0) { 'Buzz' }
    else                  { $_ }
}
