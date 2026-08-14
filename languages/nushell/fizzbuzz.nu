# FizzBuzz in Nushell.
#
# Two things to know. The `else` has to sit on the same line as the closing
# brace -- a newline ends the block and the dangling `else` is a parse error.
# And `str join` followed by a single `print` emits no trailing newline, so
# the last line would not terminate; printing per iteration avoids that.
for i in 1..100 {
  print (if ($i mod 15) == 0 { "FizzBuzz" } else if ($i mod 3) == 0 { "Fizz" } else if ($i mod 5) == 0 { "Buzz" } else { $i | into string })
}
