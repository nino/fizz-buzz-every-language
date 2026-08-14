MODULE fizzbuzz;

FROM STextIO IMPORT WriteString, WriteLn;
FROM SWholeIO IMPORT WriteCard;

VAR i: CARDINAL;

BEGIN
  FOR i := 1 TO 100 DO
    IF i MOD 15 = 0 THEN
      WriteString("FizzBuzz"); WriteLn;
    ELSIF i MOD 3 = 0 THEN
      WriteString("Fizz"); WriteLn;
    ELSIF i MOD 5 = 0 THEN
      WriteString("Buzz"); WriteLn;
    ELSE
      WriteCard(i, 0); WriteLn;
    END;
  END;
END fizzbuzz.
