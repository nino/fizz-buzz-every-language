# FizzBuzz in every programming language

FizzBuzz — print 1 to 100, but `Fizz` for multiples of 3, `Buzz` for multiples
of 5, and `FizzBuzz` for multiples of 15 — implemented in **201 languages**,
with a harness that actually runs them and checks the output.

The point isn't the algorithm. It's what 201 languages look like when they're
all solving the identical problem, side by side: where the `else` goes, whether
integers convert to strings for free, and what "print a line" costs you.

## Running it

```sh
tools/run-all.sh              # everything
tools/run-all.sh python c     # just these
VERBOSE=1 tools/run-all.sh    # show diffs for failures
```

Every implementation prints to stdout and is diffed against
[`expected.txt`](expected.txt). Each language directory has a `run.sh` that
builds and runs it:

```
languages/
  rust/
    fizzbuzz.rs
    run.sh          # generated -- see below
```

`run.sh` files are generated from [`tools/manifest.py`](tools/manifest.py),
which is the single source of truth for how each language is built and run.
Edit the manifest, then:

```sh
python3 tools/generate_runners.py
```

A runner exits `127` when its toolchain is missing, which the harness reports
as SKIP rather than FAIL — no single machine has 201 toolchains on it.

## Status

On the container this was developed in:

| | count |
|---|---|
| **Verified** — runs here and matches `expected.txt` byte for byte | 95 |
| **Skipped** — toolchain not installed, implementation untested | 76 |
| **Not runnable as a stdout program** — documented, see below | 30 |

Verified so far:

`ada` `agda` `algol68` `asm-arm64` `asm-mips` `asm-riscv` `asm-x86-64` `ats`
`awk` `bash` `basic` `bc` `befunge` `brainfuck` `c` `clojure` `cobol`
`coffeescript` `common-lisp` `cpp` `csharp` `d` `dash` `dc` `ed` `elixir`
`elvish` `emacs-lisp` `enterprise-java` `erlang` `fish` `forth` `fortran`
`fsharp` `gap` `go` `groff` `groovy` `haskell` `haxe` `icon` `java`
`javascript` `jq` `jsonnet` `ksh` `llvm-ir` `lua` `m4` `make` `maxima`
`minizinc` `modula2` `newlisp` `nickle` `nim` `objective-c` `ocaml` `octave`
`ook` `pari-gp` `pascal` `perl` `php` `pike` `postscript` `prolog` `python`
`r` `racket` `raku` `rexx` `ruby` `rust` `sass` `scala` `scheme` `sed`
`shakespeare` `singular` `sql` `systemverilog` `tcl` `tcsh` `tex` `typescript`
`vala` `verilog` `vimscript` `whitespace` `xonsh` `xslt` `yacas` `zsh`

Everything else is written but unverified — the compiler simply wasn't
available. Those are the ones most likely to contain a typo, so treat a SKIP
as "unreviewed", not "fine".

## The awkward ones

Some languages can't print 100 lines to stdout, and pretending otherwise would
make the harness lie. These exit 127 with a reason instead:

- **Pure CSS** (`html-css`) and **SVG** — the CSS version really does compute
  FizzBuzz, using `counter()` and `:nth-child(3n)` / `(5n)` / `(15n)` rules.
  It just needs a browser rather than a terminal.
- **GLSL / HLSL** render to a framebuffer or a compute buffer.
- **Solidity / Move** compile, but `all()` has to be called on-chain.
- **ABAP** needs SAP NetWeaver; **RPG** needs IBM i; **6502 / Z80 / MIPS**
  assembly need emulators.
- **Datalog / clingo / CUE** produce a relation or a value, not ordered text.
- **Coq**'s `Compute` prints a term, not lines — real output needs extraction.
- **UCBLogo** writes to its own GUI text window rather than stdout.
- **Batch** needs a real `cmd.exe`; the wine here is 64-bit only.

### Written by machine, on purpose

Three languages can't reasonably be typed by hand, so they're assembled from
macros — the committed artifact is an ordinary program any interpreter will
run, and all three are verified:

- **Brainfuck** — [`tools/gen_brainfuck.py`](tools/gen_brainfuck.py). Cycle-based
  rather than division-based: a two-digit decimal counter, plus counters that
  tick 3 and 5. `FizzBuzz` needs no special case — print `Fizz` then `Buzz`.
  Since the number is only printed when neither fired, 100 is a `Buzz` and two
  digits are always enough.
  Gotcha: Brainfuck has no comment syntax, so a `.` or `-` in a header comment
  is an *instruction*. The generator asserts the header is clean.
- **Whitespace** — [`tools/gen_whitespace.py`](tools/gen_whitespace.py). The
  program is invisible by construction, so a readable listing is emitted
  alongside it as `fizzbuzz.ws.txt`.
- **Ook!** — a one-to-one transliteration of the Brainfuck source, so the two
  stay in sync.

Befunge-93 *is* hand-written — an 8-row grid where `#v_` diverts the
instruction pointer into each handler, and the handlers are traversed
right-to-left so the string literals pop in the correct order.

**Shakespeare** is a real play, and it runs. Romeo holds the counter, Juliet
is whatever is about to be said, and since a line of dialogue addresses the
*other* character on stage, the two take turns mutating each other. Every
constant is a noun phrase — the noun carries the sign and each adjective
doubles — so the letter `F` is written as a sum reaching 70. `FizzBuzz` needs
no special scene: it speaks Fizz and then Buzz. There is no SPL compiler in
any distro, so `tools/spl.py` interprets it.

**ed** has no arithmetic, no variables and no loops, so its FizzBuzz is a pure
text transformation: `seq` fills the buffer and one addressed substitution
rewrites each line that needs a word. Every address is written out, because
there is no way not to.

The x86-64, ARM64 and RISC-V assembly is hand-written against raw Linux
syscalls, and all three are verified — the non-native pair through
`qemu-user` with the matching cross-assembler.

Interpreters and generators for these live in `tools/` (`bf.c`,
`whitespace.py`, `befunge93.py`, `ook2bf.py`, `spl.py`, `gen_ed.py`) so the
harness doesn't depend on anything exotic.

### Enterprise Java

`enterprise-java` is the same hundred lines by way of nineteen files across
six packages: a Chain of Responsibility over prioritised rules, an Abstract
Factory for the rule catalogue, a Template Method for the divisibility test,
and constructor injection through a hand-rolled `ApplicationContext`. The
`i % 15 == 0` that every other implementation writes inline is a class here,
and its priority constant is what actually encodes "check this first". It
compiles, and its output is byte-identical to everyone else's.

### Genuine gaps

Two entries are deliberately empty, with a `NOTES.md` explaining why:

- **Malbolge** — non-trivial Malbolge programs aren't written, they're *found*
  by search over the encryption schedule. A real FizzBuzz means running that
  search.
- **Piet** — programs are images, where block *area* encodes the integers.

**Chef** and **INTERCAL** are present but partial, also with notes. INTERCAL
is the interesting one: `READ OUT` emits Roman numerals, so matching
`expected.txt` needs a non-standard output routine.

A stub that doesn't run is worse than an honest gap, so there are no stubs.

## CI

[`.github/workflows/test.yml`](.github/workflows/test.yml) runs the suite, and
is **manual only** (`workflow_dispatch`) — it installs a large pile of
compilers, so it isn't something you want firing on every push. Run it from
the Actions tab.

Inputs:

| input | effect |
|---|---|
| `languages` | space-separated subset, e.g. `python c rust`; empty runs everything |
| `toolchains` | `apt` (quick) · `common` (+ tarball languages) · `all` (+ Swift, Lean, Nix) |
| `verbose` | show a diff for each failure |

The GitHub runner can reach hosts this development container can't, which is
the point of the `common` and `all` tiers: Zig, Julia, Kotlin, Gleam, Dart,
Crystal, V, Odin, Nushell, Factor, wasmtime, sbt and Swift are all installed
from pinned release archives. Each download is **non-fatal** — an upstream URL
that has moved downgrades that one language to SKIP instead of failing the
run, and leaves a warning annotation.

Versions are pinned in the workflow's `env:` block rather than tracking
`latest`, so an unrelated upstream release can't turn into a mystery failure.
Bump them deliberately.

## Adding a language

1. `mkdir languages/<name>` and write the implementation.
2. Add an entry to `tools/manifest.py`.
3. `python3 tools/generate_runners.py`
4. `tools/run-all.sh <name>`
