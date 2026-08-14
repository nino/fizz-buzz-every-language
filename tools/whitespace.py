#!/usr/bin/env python3
"""A Whitespace interpreter, used to run languages/whitespace.

Whitespace ignores every character except space, tab and linefeed, so the
program text is invisible. Instructions are grouped by an IMP prefix:

    [Space]      stack manipulation
    [Tab][Space] arithmetic
    [Tab][Tab]   heap access
    [Tab][LF]    I/O
    [LF]         flow control
"""
import sys
from pathlib import Path

S, T, L = " ", "\t", "\n"


class Parser:
    def __init__(self, src: str) -> None:
        self.src = [c for c in src if c in (S, T, L)]
        self.i = 0

    def eof(self) -> bool:
        return self.i >= len(self.src)

    def next(self) -> str:
        c = self.src[self.i]
        self.i += 1
        return c

    def number(self) -> int:
        sign = -1 if self.next() == T else 1
        bits = ""
        while True:
            c = self.next()
            if c == L:
                break
            bits += "1" if c == T else "0"
        return sign * (int(bits, 2) if bits else 0)

    def label(self) -> str:
        out = ""
        while True:
            c = self.next()
            if c == L:
                return out
            out += c


def parse(src: str) -> list[tuple]:
    p = Parser(src)
    prog: list[tuple] = []
    while not p.eof():
        imp = p.next()
        if imp == S:  # stack
            c = p.next()
            if c == S:
                prog.append(("push", p.number()))
            elif c == L:
                c2 = p.next()
                prog.append({S: ("dup",), T: ("swap",), L: ("drop",)}[c2])
            else:  # T: copy / slide
                c2 = p.next()
                prog.append(("copy" if c2 == S else "slide", p.number()))
        elif imp == L:  # flow
            c, c2 = p.next(), p.next()
            key = c + c2
            if key == S + S:
                prog.append(("mark", p.label()))
            elif key == S + T:
                prog.append(("call", p.label()))
            elif key == S + L:
                prog.append(("jmp", p.label()))
            elif key == T + S:
                prog.append(("jz", p.label()))
            elif key == T + T:
                prog.append(("jneg", p.label()))
            elif key == T + L:
                prog.append(("ret",))
            elif key == L + L:
                prog.append(("end",))
            else:
                raise SystemExit(f"bad flow instruction at {p.i}")
        elif imp == T:
            c = p.next()
            if c == S:  # arithmetic
                a, b = p.next(), p.next()
                ops = {
                    S + S: "add", S + T: "sub", S + L: "mul",
                    T + S: "div", T + T: "mod",
                }
                prog.append((ops[a + b],))
            elif c == T:  # heap
                prog.append(("store",) if p.next() == S else ("load",))
            else:  # T + L: I/O
                a, b = p.next(), p.next()
                ops = {
                    S + S: "outc", S + T: "outn",
                    T + S: "readc", T + T: "readn",
                }
                prog.append((ops[a + b],))
    return prog


def run(prog: list[tuple]) -> None:
    labels = {ins[1]: i for i, ins in enumerate(prog) if ins[0] == "mark"}
    stack: list[int] = []
    heap: dict[int, int] = {}
    calls: list[int] = []
    ip = 0

    while ip < len(prog):
        ins = prog[ip]
        op = ins[0]

        if op == "push":
            stack.append(ins[1])
        elif op == "dup":
            stack.append(stack[-1])
        elif op == "swap":
            stack[-1], stack[-2] = stack[-2], stack[-1]
        elif op == "drop":
            stack.pop()
        elif op == "copy":
            stack.append(stack[-1 - ins[1]])
        elif op == "slide":
            top = stack.pop()
            del stack[len(stack) - ins[1]:]
            stack.append(top)
        elif op in ("add", "sub", "mul", "div", "mod"):
            b, a = stack.pop(), stack.pop()
            stack.append({
                "add": a + b, "sub": a - b, "mul": a * b,
                "div": a // b if b else 0, "mod": a % b if b else 0,
            }[op])
        elif op == "store":
            val, addr = stack.pop(), stack.pop()
            heap[addr] = val
        elif op == "load":
            stack.append(heap.get(stack.pop(), 0))
        elif op == "outc":
            sys.stdout.write(chr(stack.pop()))
        elif op == "outn":
            sys.stdout.write(str(stack.pop()))
        elif op == "readc":
            heap[stack.pop()] = ord(sys.stdin.read(1))
        elif op == "readn":
            heap[stack.pop()] = int(sys.stdin.readline().strip())
        elif op == "mark":
            pass
        elif op == "call":
            calls.append(ip)
            ip = labels[ins[1]]
        elif op == "jmp":
            ip = labels[ins[1]]
        elif op == "jz":
            if stack.pop() == 0:
                ip = labels[ins[1]]
        elif op == "jneg":
            if stack.pop() < 0:
                ip = labels[ins[1]]
        elif op == "ret":
            ip = calls.pop()
        elif op == "end":
            break

        ip += 1

    sys.stdout.flush()


def main() -> int:
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} program.ws", file=sys.stderr)
        return 2
    run(parse(Path(sys.argv[1]).read_text()))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
