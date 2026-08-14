#!/usr/bin/env zsh

for i in {1..100}; do
  if   (( i % 15 == 0 )); then print "FizzBuzz"
  elif (( i % 3 == 0 ));  then print "Fizz"
  elif (( i % 5 == 0 ));  then print "Buzz"
  else                         print $i
  fi
done
