# FizzBuzz in Nushell.
# The `else` has to sit on the same line as the closing brace: a newline ends
# the block and the dangling `else` is a parse error.
1..100 | each { |i|
  if ($i mod 15) == 0 { "FizzBuzz" } else if ($i mod 3) == 0 { "Fizz" } else if ($i mod 5) == 0 { "Buzz" } else { $i | into string }
} | str join "\n" | print
