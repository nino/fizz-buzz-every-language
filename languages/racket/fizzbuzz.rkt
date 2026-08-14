#lang racket

(for ([i (in-range 1 101)])
  (displayln
   (cond
     [(zero? (modulo i 15)) "FizzBuzz"]
     [(zero? (modulo i 3))  "Fizz"]
     [(zero? (modulo i 5))  "Buzz"]
     [else i])))
