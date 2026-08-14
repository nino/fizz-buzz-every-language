const std = @import("std");

pub fn main() !void {
    const out = std.io.getStdOut().writer();
    var i: u32 = 1;
    while (i <= 100) : (i += 1) {
        if (i % 15 == 0) {
            try out.print("FizzBuzz\n", .{});
        } else if (i % 3 == 0) {
            try out.print("Fizz\n", .{});
        } else if (i % 5 == 0) {
            try out.print("Buzz\n", .{});
        } else {
            try out.print("{d}\n", .{i});
        }
    }
}
