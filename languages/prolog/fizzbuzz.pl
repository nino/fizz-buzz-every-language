:- initialization(main, main).

fizzbuzz(N, 'FizzBuzz') :- 0 is N mod 15, !.
fizzbuzz(N, 'Fizz')     :- 0 is N mod 3, !.
fizzbuzz(N, 'Buzz')     :- 0 is N mod 5, !.
fizzbuzz(N, N).

main(_) :-
    forall(between(1, 100, N),
           (fizzbuzz(N, S), format("~w~n", [S]))).
