// FizzBuzz in SystemVerilog. Simulation-only module.
module fizzbuzz;
    initial begin
        for (int i = 1; i <= 100; i++) begin
            unique case (1'b1)
                (i % 15 == 0): $display("FizzBuzz");
                (i % 3 == 0):  $display("Fizz");
                (i % 5 == 0):  $display("Buzz");
                default:       $display("%0d", i);
            endcase
        end
        $finish;
    end
endmodule
