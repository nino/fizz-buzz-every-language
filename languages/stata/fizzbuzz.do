forvalues i = 1/100 {
    if mod(`i', 15) == 0 {
        display "FizzBuzz"
    }
    else if mod(`i', 3) == 0 {
        display "Fizz"
    }
    else if mod(`i', 5) == 0 {
        display "Buzz"
    }
    else {
        display `i'
    }
}
