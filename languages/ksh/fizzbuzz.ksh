#!/usr/bin/env ksh

integer i
for ((i = 1; i <= 100; i++)); do
    if   (( i % 15 == 0 )); then print "FizzBuzz"
    elif (( i % 3 == 0 ));  then print "Fizz"
    elif (( i % 5 == 0 ));  then print "Buzz"
    else                         print $i
    fi
done
