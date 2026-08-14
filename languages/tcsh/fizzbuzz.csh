#!/usr/bin/env tcsh

@ i = 1
while ($i <= 100)
    @ m15 = $i % 15
    @ m3 = $i % 3
    @ m5 = $i % 5
    if ($m15 == 0) then
        echo "FizzBuzz"
    else if ($m3 == 0) then
        echo "Fizz"
    else if ($m5 == 0) then
        echo "Buzz"
    else
        echo $i
    endif
    @ i++
end
