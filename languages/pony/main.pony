actor Main
  new create(env: Env) =>
    var i: U32 = 1
    while i <= 100 do
      let line =
        if (i % 15) == 0 then "FizzBuzz"
        elseif (i % 3) == 0 then "Fizz"
        elseif (i % 5) == 0 then "Buzz"
        else i.string()
        end
      env.out.print(line)
      i = i + 1
    end
