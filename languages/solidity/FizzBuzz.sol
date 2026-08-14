// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FizzBuzz {
    function fizzbuzz(uint256 n) public pure returns (string memory) {
        if (n % 15 == 0) return "FizzBuzz";
        if (n % 3 == 0) return "Fizz";
        if (n % 5 == 0) return "Buzz";
        return toString(n);
    }

    function all() public pure returns (string[100] memory out) {
        for (uint256 i = 1; i <= 100; i++) {
            out[i - 1] = fizzbuzz(i);
        }
    }

    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) return "0";
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
