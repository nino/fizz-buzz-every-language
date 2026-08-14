for i in 1 .. 100 do
    match i % 3, i % 5 with
    | 0, 0 -> printfn "FizzBuzz"
    | 0, _ -> printfn "Fizz"
    | _, 0 -> printfn "Buzz"
    | _    -> printfn "%d" i
