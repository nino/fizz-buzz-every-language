-- FizzBuzz in VHDL. Simulation-only testbench style entity.
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity fizzbuzz is
end entity fizzbuzz;

architecture sim of fizzbuzz is
begin
    process
        variable l : line;
    begin
        for i in 1 to 100 loop
            if i mod 15 = 0 then
                write(l, string'("FizzBuzz"));
            elsif i mod 3 = 0 then
                write(l, string'("Fizz"));
            elsif i mod 5 = 0 then
                write(l, string'("Buzz"));
            else
                write(l, i);
            end if;
            writeline(output, l);
        end loop;
        wait;
    end process;
end architecture sim;
