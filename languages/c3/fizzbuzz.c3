module fizzbuzz;
import std::io;

fn void main()
{
    for (int i = 1; i <= 100; i++)
    {
        if (i % 15 == 0)     io::printn("FizzBuzz");
        else if (i % 3 == 0) io::printn("Fizz");
        else if (i % 5 == 0) io::printn("Buzz");
        else                 io::printfn("%d", i);
    }
}
