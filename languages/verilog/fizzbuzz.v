// FizzBuzz in Verilog. Simulation-only module.
module fizzbuzz;
    integer i;

    initial begin
        for (i = 1; i <= 100; i = i + 1) begin
            if (i % 15 == 0)
                $display("FizzBuzz");
            else if (i % 3 == 0)
                $display("Fizz");
            else if (i % 5 == 0)
                $display("Buzz");
            else
                $display("%0d", i);
        end
        $finish;
    end
endmodule
