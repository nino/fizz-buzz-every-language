class
    FIZZBUZZ

create
    make

feature

    make
        local
            i: INTEGER
        do
            from i := 1 until i > 100 loop
                if i \\ 15 = 0 then
                    print ("FizzBuzz%N")
                elseif i \\ 3 = 0 then
                    print ("Fizz%N")
                elseif i \\ 5 = 0 then
                    print ("Buzz%N")
                else
                    print (i.out + "%N")
                end
                i := i + 1
            end
        end

end
