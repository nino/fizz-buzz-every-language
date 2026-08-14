1 to: 100 do: [ :i |
    | line |
    line := (i \\ 15 = 0)
        ifTrue: [ 'FizzBuzz' ]
        ifFalse: [ (i \\ 3 = 0)
            ifTrue: [ 'Fizz' ]
            ifFalse: [ (i \\ 5 = 0)
                ifTrue: [ 'Buzz' ]
                ifFalse: [ i printString ] ] ].
    Transcript showCr: line ]
