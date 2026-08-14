#!/usr/bin/env python3
"""Assemble languages/ed/fizzbuzz.ed.

ed is a line editor: no variables, no arithmetic, no loops. The only thing it
can do is address lines and substitute. So FizzBuzz becomes a pure text
transformation -- run.sh fills the buffer with 1..100 and this script
overwrites each line that needs a word.

Because there is no loop, every address has to be written out. That is the
honest shape of the program, not a shortcut around it.
"""
from pathlib import Path


def build() -> str:
    lines = [
        "# FizzBuzz in ed, the standard text editor.",
        "# The buffer starts as the numbers 1..100 (run.sh pipes them in).",
        "# ed has no arithmetic and no loops, so each multiple is addressed",
        "# directly: one substitution per line that needs a word.",
    ]
    for n in range(1, 101):
        word = "Fizz" * (n % 3 == 0) + "Buzz" * (n % 5 == 0)
        if word:
            lines.append(f"{n}s/.*/{word}/")
    lines += [
        ",p",   # print the whole buffer
        "Q",    # quit without writing the file back
    ]
    return "\n".join(lines) + "\n"


def main() -> None:
    out = Path(__file__).resolve().parent.parent / "languages" / "ed" / "fizzbuzz.ed"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(build())
    print(f"wrote {out}")


if __name__ == "__main__":
    main()
