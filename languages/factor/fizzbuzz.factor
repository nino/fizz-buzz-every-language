! FizzBuzz in Factor
USING: io kernel math math.functions math.parser math.ranges sequences ;
IN: fizzbuzz

: fizzbuzz ( n -- str )
    dup 15 mod 0 = [ drop "FizzBuzz" ] [
        dup 3 mod 0 = [ drop "Fizz" ] [
            dup 5 mod 0 = [ drop "Buzz" ] [ number>string ] if
        ] if
    ] if ;

: main ( -- ) 100 [1,b] [ fizzbuzz print ] each ;

MAIN: main
