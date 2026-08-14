**FREE
// FizzBuzz in ILE RPG (free-form).
dcl-s i   int(10);
dcl-s msg char(10);

for i = 1 to 100;
  select;
    when %rem(i : 15) = 0;
      msg = 'FizzBuzz';
    when %rem(i : 3) = 0;
      msg = 'Fizz';
    when %rem(i : 5) = 0;
      msg = 'Buzz';
    other;
      msg = %char(i);
  endsl;
  dsply %trim(msg);
endfor;

*inlr = *on;
