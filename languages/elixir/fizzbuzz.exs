Enum.each(1..100, fn i ->
  IO.puts(
    cond do
      rem(i, 15) == 0 -> "FizzBuzz"
      rem(i, 3) == 0 -> "Fizz"
      rem(i, 5) == 0 -> "Buzz"
      true -> i
    end
  )
end)
