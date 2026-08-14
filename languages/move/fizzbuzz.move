module fizzbuzz::fizzbuzz {
    use std::string::{Self, String};
    use std::vector;

    public fun fizzbuzz(n: u64): String {
        if (n % 15 == 0) { string::utf8(b"FizzBuzz") }
        else if (n % 3 == 0) { string::utf8(b"Fizz") }
        else if (n % 5 == 0) { string::utf8(b"Buzz") }
        else { to_string(n) }
    }

    public fun all(): vector<String> {
        let out = vector::empty<String>();
        let i = 1;
        while (i <= 100) {
            vector::push_back(&mut out, fizzbuzz(i));
            i = i + 1;
        };
        out
    }

    fun to_string(value: u64): String {
        if (value == 0) { return string::utf8(b"0") };
        let buffer = vector::empty<u8>();
        let v = value;
        while (v != 0) {
            vector::push_back(&mut buffer, ((48 + v % 10) as u8));
            v = v / 10;
        };
        vector::reverse(&mut buffer);
        string::utf8(buffer)
    }
}
