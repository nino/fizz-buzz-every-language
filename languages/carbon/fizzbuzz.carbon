package FizzBuzz api;

fn Main() -> i32 {
  var i: i32 = 1;
  while (i <= 100) {
    if (i % 15 == 0) {
      Print("FizzBuzz");
    } else if (i % 3 == 0) {
      Print("Fizz");
    } else if (i % 5 == 0) {
      Print("Buzz");
    } else {
      Print("{0}", i);
    }
    i = i + 1;
  }
  return 0;
}
