: fizz? ( n -- flag ) 3 mod 0= ;
: buzz? ( n -- flag ) 5 mod 0= ;

: fizzbuzz ( n -- )
  dup fizz? over buzz? and if ." FizzBuzz" drop
  else dup fizz? if ." Fizz" drop
  else dup buzz? if ." Buzz" drop
  else . -1 spaces
  then then then cr ;

: main ( -- ) 101 1 do i fizzbuzz loop ;

main
bye
