import gleam/int
import gleam/io
import gleam/list

fn fizzbuzz(n: Int) -> String {
  case n % 3, n % 5 {
    0, 0 -> "FizzBuzz"
    0, _ -> "Fizz"
    _, 0 -> "Buzz"
    _, _ -> int.to_string(n)
  }
}

pub fn main() {
  list.range(1, 100)
  |> list.each(fn(i) { io.println(fizzbuzz(i)) })
}
