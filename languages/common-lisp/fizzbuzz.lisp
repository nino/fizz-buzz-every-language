(loop for i from 1 to 100
      do (format t "~a~%"
                 (cond ((zerop (mod i 15)) "FizzBuzz")
                       ((zerop (mod i 3))  "Fizz")
                       ((zerop (mod i 5))  "Buzz")
                       (t i))))
