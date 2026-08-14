ed has no arithmetic and no loops -- it is a line editor driven by addresses.
The FizzBuzz here works the way you would do it by hand: `seq` produces the
buffer, then three global substitutions rewrite every 3rd, 5th and 15th line.

`ed` cannot express "every Nth line" directly either, so run.sh builds the
address list. The interesting part is that the whole thing is still a text
transformation with no variables at all.
