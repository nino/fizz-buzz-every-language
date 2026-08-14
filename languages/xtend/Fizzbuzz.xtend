// FizzBuzz in Xtend
class Fizzbuzz {
    def static void main(String[] args) {
        for (i : 1 .. 100) {
            println(
                switch it : i {
                    case i % 15 == 0: "FizzBuzz"
                    case i % 3 == 0: "Fizz"
                    case i % 5 == 0: "Buzz"
                    default: i.toString
                }
            )
        }
    }
}
