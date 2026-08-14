#!/usr/bin/env python3
"""A Befunge-93 interpreter, used to run languages/befunge.

The playfield is a torus: the instruction pointer moves in one of four
directions and wraps at the edges. Cells outside a short line are spaces.
"""
import sys
from pathlib import Path

WIDTH, HEIGHT = 80, 25


def run(src: str) -> None:
    lines = src.split("\n")
    grid = [[" "] * WIDTH for _ in range(HEIGHT)]
    for y, line in enumerate(lines[:HEIGHT]):
        for x, ch in enumerate(line[:WIDTH]):
            grid[y][x] = ch

    stack: list[int] = []
    x = y = 0
    dx, dy = 1, 0
    stringmode = False

    def pop() -> int:
        return stack.pop() if stack else 0

    while True:
        c = grid[y][x]

        if stringmode:
            if c == '"':
                stringmode = False
            else:
                stack.append(ord(c))
        elif c.isdigit():
            stack.append(int(c))
        elif c == '"':
            stringmode = True
        elif c == ">":
            dx, dy = 1, 0
        elif c == "<":
            dx, dy = -1, 0
        elif c == "^":
            dx, dy = 0, -1
        elif c == "v":
            dx, dy = 0, 1
        elif c == "_":
            dx, dy = (1, 0) if pop() == 0 else (-1, 0)
        elif c == "|":
            dx, dy = (0, 1) if pop() == 0 else (0, -1)
        elif c == "#":
            x = (x + dx) % WIDTH
            y = (y + dy) % HEIGHT
        elif c == "+":
            b, a = pop(), pop()
            stack.append(a + b)
        elif c == "-":
            b, a = pop(), pop()
            stack.append(a - b)
        elif c == "*":
            b, a = pop(), pop()
            stack.append(a * b)
        elif c == "/":
            b, a = pop(), pop()
            stack.append(a // b if b else 0)
        elif c == "%":
            b, a = pop(), pop()
            stack.append(a % b if b else 0)
        elif c == "!":
            stack.append(1 if pop() == 0 else 0)
        elif c == "`":
            b, a = pop(), pop()
            stack.append(1 if a > b else 0)
        elif c == ":":
            v = pop()
            stack.extend((v, v))
        elif c == "\\":
            b, a = pop(), pop()
            stack.extend((b, a))
        elif c == "$":
            pop()
        elif c == ".":
            sys.stdout.write(f"{pop()} ")
        elif c == ",":
            sys.stdout.write(chr(pop()))
        elif c == "g":
            gy, gx = pop(), pop()
            stack.append(ord(grid[gy % HEIGHT][gx % WIDTH]))
        elif c == "p":
            gy, gx, v = pop(), pop(), pop()
            grid[gy % HEIGHT][gx % WIDTH] = chr(v)
        elif c == "@":
            break
        # space and anything else: no-op

        x = (x + dx) % WIDTH
        y = (y + dy) % HEIGHT

    sys.stdout.flush()


def main() -> int:
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} program.bf93", file=sys.stderr)
        return 2
    run(Path(sys.argv[1]).read_text())
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
