% FizzBuzz as an Answer Set Program (clingo).
num(1..100).

label(N, "FizzBuzz") :- num(N), N \ 15 == 0.
label(N, "Fizz")     :- num(N), N \ 3 == 0, N \ 15 != 0.
label(N, "Buzz")     :- num(N), N \ 5 == 0, N \ 15 != 0.
label(N, N)          :- num(N), N \ 3 != 0, N \ 5 != 0.

#show label/2.
