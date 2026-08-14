\\ FizzBuzz in PARI/GP
{
  for(i = 1, 100,
    if(i % 15 == 0, print("FizzBuzz"),
      if(i % 3 == 0, print("Fizz"),
        if(i % 5 == 0, print("Buzz"),
          print(i)))))
}
quit()
