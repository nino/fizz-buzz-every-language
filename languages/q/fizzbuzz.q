/ FizzBuzz in q (kdb+)
fizzbuzz:{[n] $[0=n mod 15; "FizzBuzz"; 0=n mod 3; "Fizz"; 0=n mod 5; "Buzz"; string n]}
-1 each fizzbuzz each 1+til 100;
exit 0
