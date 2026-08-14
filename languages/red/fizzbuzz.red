Red [
    Title: "FizzBuzz"
]

repeat i 100 [
    print case [
        zero? i % 15 ["FizzBuzz"]
        zero? i % 3  ["Fizz"]
        zero? i % 5  ["Buzz"]
        true         [i]
    ]
]
