;; FizzBuzz in Fennel, a Lisp that compiles to Lua.
(for [i 1 100]
  (print (if (= 0 (% i 15)) "FizzBuzz"
             (= 0 (% i 3))  "Fizz"
             (= 0 (% i 5))  "Buzz"
             (tostring i))))
