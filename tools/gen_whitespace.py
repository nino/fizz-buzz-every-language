#!/usr/bin/env python3
"""Assemble languages/whitespace/fizzbuzz.ws.

A Whitespace program is made only of spaces, tabs and linefeeds, so it cannot
be typed by hand in any reviewable way. This assembler spells the program out
in mnemonics and emits the invisible bytes; a companion listing is written to
fizzbuzz.ws.txt so the source is readable in a diff.
"""
from pathlib import Path

S, T, L = " ", "\t", "\n"

_out: list[str] = []
_listing: list[str] = []


def _num(n: int) -> str:
    sign = S if n >= 0 else T
    bits = format(abs(n), "b")
    return sign + "".join(S if b == "0" else T for b in bits) + L


def _label(name: str) -> str:
    # Encode a label name as its index in binary, using S/T as 0/1.
    idx = _label_ids.setdefault(name, len(_label_ids))
    return "".join(S if b == "0" else T for b in format(idx, "08b")) + L


_label_ids: dict[str, int] = {}


def emit(code: str, mnemonic: str) -> None:
    _out.append(code)
    _listing.append(mnemonic)


def push(n: int) -> None:
    emit(S + S + _num(n), f"push {n}")


def dup() -> None:
    emit(S + L + S, "dup")


def mark(lbl: str) -> None:
    emit(L + S + S + _label(lbl), f"{lbl}:")


def jmp(lbl: str) -> None:
    emit(L + S + L + _label(lbl), f"jmp {lbl}")


def jz(lbl: str) -> None:
    emit(L + T + S + _label(lbl), f"jz {lbl}")


def mod() -> None:
    emit(T + S + T + T, "mod")


def add() -> None:
    emit(T + S + S + S, "add")


def sub() -> None:
    emit(T + S + S + T, "sub")


def outn() -> None:
    emit(T + L + S + T, "outnum")


def outc() -> None:
    emit(T + L + S + S, "outchar")


def end() -> None:
    emit(L + L + L, "end")


def puts(text: str) -> None:
    for ch in text:
        push(ord(ch))
        outc()


def build() -> None:
    push(1)                     # the counter lives on the stack
    mark("LOOP")

    dup(); push(15); mod(); jz("FIZZBUZZ")
    dup(); push(3);  mod(); jz("FIZZ")
    dup(); push(5);  mod(); jz("BUZZ")

    dup(); outn()
    jmp("ENDIF")

    mark("FIZZBUZZ"); puts("FizzBuzz"); jmp("ENDIF")
    mark("FIZZ");     puts("Fizz");     jmp("ENDIF")
    mark("BUZZ");     puts("Buzz")

    mark("ENDIF")
    push(10); outc()            # newline

    push(1); add()              # counter += 1
    dup(); push(101); sub(); jz("END")
    jmp("LOOP")

    mark("END")
    end()


def main() -> None:
    build()
    root = Path(__file__).resolve().parent.parent
    d = root / "languages" / "whitespace"
    d.mkdir(parents=True, exist_ok=True)

    (d / "fizzbuzz.ws").write_text("".join(_out))
    (d / "fizzbuzz.ws.txt").write_text(
        "FizzBuzz in Whitespace -- readable listing of fizzbuzz.ws.\n"
        "Regenerate both with tools/gen_whitespace.py.\n\n"
        + "\n".join(_listing)
        + "\n"
    )
    print(f"wrote {d/'fizzbuzz.ws'} ({len(''.join(_out))} bytes)")


if __name__ == "__main__":
    main()
