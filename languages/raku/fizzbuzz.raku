for 1 .. 100 -> $i {
    say do given $i {
        when $_ %% 15 { 'FizzBuzz' }
        when $_ %% 3  { 'Fizz' }
        when $_ %% 5  { 'Buzz' }
        default       { $_ }
    }
}
