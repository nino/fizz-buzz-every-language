⍝ FizzBuzz in GNU APL
∇FizzBuzz
  ⎕IO←1
  :FOR i :IN ⍳100
    :IF 0=15|i
      ⎕←'FizzBuzz'
    :ELSEIF 0=3|i
      ⎕←'Fizz'
    :ELSEIF 0=5|i
      ⎕←'Buzz'
    :ELSE
      ⎕←⍕i
    :ENDIF
  :ENDFOR
∇

FizzBuzz
)OFF
