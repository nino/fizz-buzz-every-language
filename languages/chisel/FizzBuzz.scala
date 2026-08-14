// FizzBuzz in Chisel: a hardware generator that emits the label for a
// counter value, plus a plain-Scala elaboration-time printout.
import chisel3._
import chisel3.util._

class FizzBuzz extends Module {
  val io = IO(new Bundle {
    val n    = Input(UInt(8.W))
    val fizz = Output(Bool())
    val buzz = Output(Bool())
  })

  io.fizz := io.n % 3.U === 0.U
  io.buzz := io.n % 5.U === 0.U
}

object FizzBuzzApp extends App {
  for (i <- 1 to 100) {
    println((i % 3, i % 5) match {
      case (0, 0) => "FizzBuzz"
      case (0, _) => "Fizz"
      case (_, 0) => "Buzz"
      case _      => i.toString
    })
  }
}
