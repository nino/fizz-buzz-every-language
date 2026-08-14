@echo off
setlocal enabledelayedexpansion
for /l %%i in (1,1,100) do (
    set /a m15=%%i %% 15
    set /a m3=%%i %% 3
    set /a m5=%%i %% 5
    if !m15! equ 0 (
        echo FizzBuzz
    ) else if !m3! equ 0 (
        echo Fizz
    ) else if !m5! equ 0 (
        echo Buzz
    ) else (
        echo %%i
    )
)
