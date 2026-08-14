;;; fizzbuzz.el --- FizzBuzz in Emacs Lisp  -*- lexical-binding: t; -*-
(let ((i 1))
  (while (<= i 100)
    (princ (cond ((zerop (mod i 15)) "FizzBuzz")
                 ((zerop (mod i 3))  "Fizz")
                 ((zerop (mod i 5))  "Buzz")
                 (t (number-to-string i))))
    (terpri)
    (setq i (1+ i))))
