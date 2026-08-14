# FizzBuzz in GAP
for i in [1 .. 100] do
  if i mod 15 = 0 then
    Print("FizzBuzz\n");
  elif i mod 3 = 0 then
    Print("Fizz\n");
  elif i mod 5 = 0 then
    Print("Buzz\n");
  else
    Print(i, "\n");
  fi;
od;
QUIT;
