(for [i (range 1 101)]
  (print (cond (= 0 (% i 15)) "FizzBuzz"
               (= 0 (% i 3))  "Fizz"
               (= 0 (% i 5))  "Buzz"
               True           i)))
