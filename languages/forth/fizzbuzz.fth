: fizz? ( n -- flag ) 3 mod 0= ;
: buzz? ( n -- flag ) 5 mod 0= ;

\ Print n with no trailing space (unlike `.`).
: .n ( n -- ) 0 <# #s #> type ;

: fizzbuzz ( n -- )
  dup fizz? over buzz? and if ." FizzBuzz" drop
  else dup fizz? if ." Fizz" drop
  else dup buzz? if ." Buzz" drop
  else .n
  then then then cr ;

: main ( -- ) 101 1 do i fizzbuzz loop ;

main
bye
