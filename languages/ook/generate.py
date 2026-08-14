#!/usr/bin/env python3
"""Transliterate the Brainfuck FizzBuzz into Ook!."""
from pathlib import Path

MAPPING = {
    ">": "Ook. Ook?",
    "<": "Ook? Ook.",
    "+": "Ook. Ook.",
    "-": "Ook! Ook!",
    ".": "Ook! Ook.",
    ",": "Ook. Ook!",
    "[": "Ook! Ook?",
    "]": "Ook? Ook!",
}

src = Path(__file__).parent.parent / "brainfuck" / "fizzbuzz.b"
code = "".join(c for c in src.read_text() if c in MAPPING)
tokens = [MAPPING[c] for c in code]

out = Path(__file__).parent / "fizzbuzz.ook"
lines = [" ".join(tokens[i : i + 6]) for i in range(0, len(tokens), 6)]
out.write_text("\n".join(lines) + "\n")
print(f"wrote {out} ({len(tokens)} instructions)")
