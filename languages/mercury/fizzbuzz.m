:- module fizzbuzz.
:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module int, list, string.

:- func fizzbuzz(int) = string.
fizzbuzz(N) =
    ( if N mod 15 = 0 then "FizzBuzz"
      else if N mod 3 = 0 then "Fizz"
      else if N mod 5 = 0 then "Buzz"
      else string.from_int(N)
    ).

main(!IO) :-
    list.foldl(
        (pred(N::in, !.IO::di, !:IO::uo) is det :-
            io.write_string(fizzbuzz(N) ++ "\n", !IO)),
        1 `..` 100, !IO).
