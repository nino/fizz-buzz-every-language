#!/usr/bin/env python3
"""Translate an Ook! program back into Brainfuck, printed on stdout."""
import re
import sys
from pathlib import Path

MAPPING = {
    "Ook. Ook?": ">",
    "Ook? Ook.": "<",
    "Ook. Ook.": "+",
    "Ook! Ook!": "-",
    "Ook! Ook.": ".",
    "Ook. Ook!": ",",
    "Ook! Ook?": "[",
    "Ook? Ook!": "]",
}


def main() -> int:
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} program.ook", file=sys.stderr)
        return 2

    text = Path(sys.argv[1]).read_text()
    tokens = re.findall(r"Ook[.?!]", text)
    if len(tokens) % 2:
        print("odd number of Ook tokens", file=sys.stderr)
        return 2

    out = []
    for i in range(0, len(tokens), 2):
        pair = f"{tokens[i]} {tokens[i + 1]}"
        if pair not in MAPPING:
            print(f"unknown Ook pair: {pair}", file=sys.stderr)
            return 2
        out.append(MAPPING[pair])

    sys.stdout.write("".join(out))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
