package main

import "core:fmt"

main :: proc() {
	for i in 1 ..= 100 {
		switch {
		case i % 15 == 0:
			fmt.println("FizzBuzz")
		case i % 3 == 0:
			fmt.println("Fizz")
		case i % 5 == 0:
			fmt.println("Buzz")
		case:
			fmt.println(i)
		}
	}
}
