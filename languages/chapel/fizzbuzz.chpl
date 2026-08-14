for i in 1..100 {
  if i % 15 == 0 then
    writeln("FizzBuzz");
  else if i % 3 == 0 then
    writeln("Fizz");
  else if i % 5 == 0 then
    writeln("Buzz");
  else
    writeln(i);
}
