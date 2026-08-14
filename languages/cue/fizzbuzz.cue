package fizzbuzz

import (
	"list"
	"strconv"
)

#fizzbuzz: {
	n: int
	out: [
		if mod(n, 15) == 0 {"FizzBuzz"},
		if mod(n, 3) == 0 {"Fizz"},
		if mod(n, 5) == 0 {"Buzz"},
		strconv.FormatInt(n, 10),
	][0]
}

result: [for i in list.Range(1, 101, 1) {(#fizzbuzz & {n: i}).out}]
