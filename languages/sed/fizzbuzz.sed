# FizzBuzz in sed. Input is the numbers 1..100, one per line (see run.sh).
# GNU step addresses (first~step) give us the 3-, 5- and 15-cycles directly.
15~15 s/.*/FizzBuzz/
3~3   s/^[0-9]*$/Fizz/
5~5   s/^[0-9]*$/Buzz/
