" FizzBuzz in Vim script.
" `vim -es` runs silently and discards :echo, so collect the lines and write
" them to stdout explicitly.
let s:lines = []
for s:i in range(1, 100)
  if s:i % 15 == 0
    call add(s:lines, 'FizzBuzz')
  elseif s:i % 3 == 0
    call add(s:lines, 'Fizz')
  elseif s:i % 5 == 0
    call add(s:lines, 'Buzz')
  else
    call add(s:lines, string(s:i))
  endif
endfor
call writefile(s:lines, '/dev/stdout')
