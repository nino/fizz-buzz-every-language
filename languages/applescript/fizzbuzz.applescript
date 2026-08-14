-- FizzBuzz in AppleScript
repeat with i from 1 to 100
    if i mod 15 = 0 then
        log "FizzBuzz"
    else if i mod 3 = 0 then
        log "Fizz"
    else if i mod 5 = 0 then
        log "Buzz"
    else
        log (i as text)
    end if
end repeat
