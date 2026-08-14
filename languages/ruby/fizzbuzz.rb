(1..100).each do |i|
  puts if i % 15 == 0 then 'FizzBuzz'
       elsif i % 3 == 0 then 'Fizz'
       elsif i % 5 == 0 then 'Buzz'
       else i
       end
end
