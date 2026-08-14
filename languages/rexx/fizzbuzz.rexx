/* FizzBuzz in REXX */
do i = 1 to 100
   select
      when i // 15 = 0 then say 'FizzBuzz'
      when i // 3 = 0 then say 'Fizz'
      when i // 5 = 0 then say 'Buzz'
      otherwise say i
   end
end
