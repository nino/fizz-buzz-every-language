# FizzBuzz in Janet
(loop [i :range [1 101]]
  (print (cond
           (zero? (% i 15)) "FizzBuzz"
           (zero? (% i 3))  "Fizz"
           (zero? (% i 5))  "Buzz"
           (string i))))
