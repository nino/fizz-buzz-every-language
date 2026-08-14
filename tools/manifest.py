#!/usr/bin/env python3
"""Single source of truth for how each language is built and run.

Each entry maps a language directory to:
  probe -- an executable that must exist on PATH for the language to run here
  body  -- the shell body of languages/<slug>/run.sh

`generate_runners.py` turns this into one run.sh per language. A run.sh exits
127 when its toolchain is missing, which the harness reports as SKIP rather
than FAIL.

`status` records whether the implementation is expected to reproduce
expected.txt:
  "verified" -- runs here and matches
  "partial"  -- deliberately incomplete, see the directory's NOTES.md
  "untested" -- believed correct, but no toolchain available in this image
"""

# fmt: off
LANGUAGES = {
    # ---- systems / compiled -------------------------------------------------
    "c":            ("gcc",    "gcc -O2 -o $T/fizzbuzz fizzbuzz.c && $T/fizzbuzz"),
    "cpp":          ("g++",    "g++ -O2 -std=c++17 -o $T/fizzbuzz fizzbuzz.cpp && $T/fizzbuzz"),
    "rust":         ("rustc",  "rustc -O -o $T/fizzbuzz fizzbuzz.rs && $T/fizzbuzz"),
    "zig":          ("zig",    "zig build-exe -femit-bin=$T/fizzbuzz fizzbuzz.zig && $T/fizzbuzz"),
    "go":           ("go",     "GOCACHE=$T/cache go run fizzbuzz.go"),
    "d":            ("gdc",    "gdc -o $T/fizzbuzz fizzbuzz.d && $T/fizzbuzz"),
    "odin":         ("odin",   "odin run fizzbuzz.odin -file -out:$T/fizzbuzz"),
    "v":            ("v",      "v run fizzbuzz.v"),
    "nim":          ("nim",    "nim c --hints:off --nimcache:$T/cache -o:$T/fizzbuzz fizzbuzz.nim >/dev/null && $T/fizzbuzz"),
    "ada":          ("gnatmake", "gnatmake -q -D $T -o $T/fizzbuzz fizzbuzz.adb && $T/fizzbuzz"),
    "fortran":      ("gfortran", "gfortran -o $T/fizzbuzz fizzbuzz.f90 && $T/fizzbuzz"),
    "pascal":       ("fpc",    "fpc -v0 -FE$T -o$T/fizzbuzz fizzbuzz.pas >/dev/null && $T/fizzbuzz"),
    "modula2":      ("gm2",    "gm2 -o $T/fizzbuzz fizzbuzz.mod && $T/fizzbuzz"),
    "objective-c":  ("clang",  "clang -o $T/fizzbuzz fizzbuzz.m && $T/fizzbuzz"),
    "carbon":       ("carbon", "carbon run fizzbuzz.carbon"),
    "hare":         ("hare",   "HARECACHE=$T/cache hare run fizzbuzz.ha"),

    # ---- JVM / .NET ---------------------------------------------------------
    "java":         ("javac",  "javac -d $T Fizzbuzz.java && java -cp $T Fizzbuzz"),
    "kotlin":       ("kotlinc", "kotlinc fizzbuzz.kt -include-runtime -d $T/fb.jar 2>/dev/null && java -jar $T/fb.jar"),
    "scala":        ("scalac", "scalac -d $T fizzbuzz.scala && scala -cp $T FizzBuzz"),
    "groovy":       ("groovy", "groovy fizzbuzz.groovy"),
    "clojure":      ("clojure", "clojure fizzbuzz.clj"),
    "ceylon":       ("ceylon", "ceylon run --compile=force fizzbuzz"),
    "csharp":       ("mcs",    "mcs -out:$T/fizzbuzz.exe Fizzbuzz.cs && mono $T/fizzbuzz.exe"),
    "fsharp":       ("dotnet", "dotnet fsi fizzbuzz.fsx"),
    "vbnet":        ("vbnc",   "vbnc -out:$T/fizzbuzz.exe Fizzbuzz.vb >/dev/null && mono $T/fizzbuzz.exe"),

    # ---- scripting / dynamic ------------------------------------------------
    "python":       ("python3", "python3 fizzbuzz.py"),
    "ruby":         ("ruby",   "ruby fizzbuzz.rb"),
    "perl":         ("perl",   "perl fizzbuzz.pl"),
    "php":          ("php",    "php fizzbuzz.php"),
    "lua":          ("lua5.4", "lua5.4 fizzbuzz.lua"),
    "tcl":          ("tclsh",  "tclsh fizzbuzz.tcl"),
    "javascript":   ("node",   "node fizzbuzz.js"),
    "typescript":   ("bun",    "bun run fizzbuzz.ts"),
    "coffeescript": ("coffee", "coffee fizzbuzz.coffee"),
    "dart":         ("dart",   "dart run fizzbuzz.dart"),
    "crystal":      ("crystal", "crystal run --no-color fizzbuzz.cr"),
    "elixir":       ("elixir", "elixir fizzbuzz.exs"),
    "erlang":       ("escript", "escript fizzbuzz.escript"),
    "julia":        ("julia",  "julia fizzbuzz.jl"),
    "raku":         ("raku",   "raku fizzbuzz.raku"),

    # ---- functional ---------------------------------------------------------
    "haskell":      ("runghc", "runghc fizzbuzz.hs"),
    "ocaml":        ("ocaml",  "ocaml fizzbuzz.ml"),
    "standard-ml":  ("polyml", "polyml --script fizzbuzz.sml"),
    "elm":          (None, "compiles to HTML, not stdout"),
    "purescript":   ("spago",  "spago run"),
    "scheme":       ("guile",  "guile -s fizzbuzz.scm"),
    "racket":       ("racket", "racket fizzbuzz.rkt"),
    "common-lisp":  ("sbcl",   "sbcl --script fizzbuzz.lisp"),
    "emacs-lisp":   ("emacs",  "emacs --batch --quick --script fizzbuzz.el 2>/dev/null"),
    "idris":        ("idris2", "idris2 -o fizzbuzz --output-dir $T Fizzbuzz.idr >/dev/null && $T/fizzbuzz"),
    "agda":         ("agda",   "agda --compile --compile-dir=$T Fizzbuzz.agda >/dev/null && $T/Fizzbuzz"),
    "coq":          (None, "Compute prints a Coq term; needs extraction to run"),
    "lean":         ("lean",   "lean --run Fizzbuzz.lean"),
    "roc":          ("roc",    "roc run fizzbuzz.roc"),
    "gleam":        ("gleam",  "gleam run"),
    "unison":       ("ucm",    "ucm run.file fizzbuzz.u main"),

    # ---- shell / glue -------------------------------------------------------
    "bash":         ("bash",   "bash fizzbuzz.sh"),
    "zsh":          ("zsh",    "zsh fizzbuzz.zsh"),
    "fish":         ("fish",   "fish fizzbuzz.fish"),
    "powershell":   ("pwsh",   "pwsh -NoProfile -File fizzbuzz.ps1"),
    "batch":        (None, "requires Windows cmd.exe (wine32 not available)"),
    "nushell":      ("nu",     "nu fizzbuzz.nu"),
    "awk":          ("awk",    "awk -f fizzbuzz.awk </dev/null"),
    "sed":          ("sed",    "seq 1 100 | sed -f fizzbuzz.sed"),
    "make":         ("make",   "make -s -f Makefile"),
    "nix":          ("nix-instantiate", "nix-instantiate --eval --strict fizzbuzz.nix | sed -e 's/^\"//' -e 's/\"$//' -e 's/\\\\n/\\n/g'"),

    # ---- data / scientific --------------------------------------------------
    "r":            ("Rscript", "Rscript fizzbuzz.R"),
    "matlab":       ("matlab", "matlab -batch \"run('fizzbuzz.m')\""),
    "octave":       ("octave", "octave -qf fizzbuzz.m"),
    "sas":          ("sas",    "sas -stdio fizzbuzz.sas"),
    "stata":        ("stata",  "stata -b do fizzbuzz.do"),
    "wolfram":      ("wolframscript", "wolframscript -file fizzbuzz.wl"),
    "apl":          ("apl",    "apl --script fizzbuzz.apl"),
    "j":            ("ijconsole", "ijconsole fizzbuzz.ijs"),
    "k":            ("k",      "k fizzbuzz.k"),
    "q":            ("q",      "q fizzbuzz.q"),
    "futhark":      (None, "returns classification codes, not text"),
    # ---- query / declarative ------------------------------------------------
    "sql":          ("sqlite3", "sqlite3 -noheader -batch < fizzbuzz.sql"),
    "plpgsql":      ("psql",   "pg_isready -q 2>/dev/null || { echo 'no postgres server' >&2; exit 127; }\n"
                               "psql -q -f fizzbuzz.sql 2>&1 | sed -e 's/^NOTICE:  //'"),
    "xslt":         ("xsltproc", "xsltproc fizzbuzz.xsl input.xml"),
    "prolog":       ("swipl",  "swipl -q fizzbuzz.pl"),
    "datalog":      (None, "writes a relation, not ordered stdout text"),
    "mercury":      ("mmc",    "mmc --output-dir $T -o $T/fizzbuzz fizzbuzz.m && $T/fizzbuzz"),
    "clingo":       (None, "emits an answer set, not ordered stdout text"),
    # ---- markup / config ----------------------------------------------------
    "html-css":     (None, "pure CSS counters; open fizzbuzz.html in a browser"),
    "svg":          (None, "static image; open fizzbuzz.svg in a browser"),
    "sass":         ("sass",   "sass --no-source-map fizzbuzz.scss $T/out.css && grep -o 'content: \"[^\"]*\"' $T/out.css | sed -e 's/content: \"//' -e 's/\"$//'"),
    "jsonnet":      ("jsonnet", "jsonnet -S fizzbuzz.jsonnet"),
    "dhall":        ("dhall",  "dhall text --file fizzbuzz.dhall"),
    "cue":          (None, "evaluates to a list value, not stdout text"),
    # ---- mobile / platform --------------------------------------------------
    "swift":        ("swift",  "swift fizzbuzz.swift"),
    "vala":         ("valac",  "valac -o $T/fizzbuzz fizzbuzz.vala && $T/fizzbuzz"),

    # ---- legacy / historical ------------------------------------------------
    "cobol":        ("cobc",   "cobc -x -free -o $T/fizzbuzz fizzbuzz.cob && $T/fizzbuzz"),
    "algol68":      ("a68g",   "a68g fizzbuzz.a68"),
    "basic":        ("bwbasic", "bwbasic fizzbuzz.bas </dev/null | tr -d '\\r' | sed -e '1,4d' | grep -v '^bwBASIC:'"),
    "qbasic":       ("qb64",   "qb64 -x fizzbuzz.bas -o $T/fizzbuzz && $T/fizzbuzz"),
    "logo":         (None, "ucblogo writes to its GUI text window, not stdout"),
    "forth":        ("gforth", "gforth fizzbuzz.fth"),
    "smalltalk":    ("gst",    "gst fizzbuzz.st"),
    "eiffel":       ("ec",     "ec -batch -config fizzbuzz.ecf"),
    "simula":       ("cim",    "cim fizzbuzz.sim && ./fizzbuzz"),
    "pl1":          ("pli",    "pli fizzbuzz.pli"),
    "rpg":          (None, "requires IBM i (ILE RPG compiler)"),
    "abap":         (None, "requires an SAP NetWeaver system"),
    "rexx":         ("rexx",   "rexx ./fizzbuzz.rexx"),
    "icon":         ("icont",  "icont -s -o $T/fizzbuzz fizzbuzz.icn && $T/fizzbuzz"),
    "snobol":       ("snobol4", "snobol4 -b fizzbuzz.sno"),
    "vimscript":    ("vim",    "vim -es -u NONE -c 'source fizzbuzz.vim' -c 'qa!' 2>/dev/null"),
    "m4":           ("m4",     "m4 fizzbuzz.m4"),
    "bc":           ("bc",     "bc -q fizzbuzz.bc"),
    "dc":           ("dc",     "dc fizzbuzz.dc"),

    # ---- assembly / low level -----------------------------------------------
    "asm-x86-64":   ("as",     "as -o $T/fb.o fizzbuzz.s && ld -o $T/fizzbuzz $T/fb.o && $T/fizzbuzz"),
    "asm-arm64":    ("aarch64-linux-gnu-as", "aarch64-linux-gnu-as -o $T/fb.o fizzbuzz.s && aarch64-linux-gnu-ld -o $T/fizzbuzz $T/fb.o && qemu-aarch64 $T/fizzbuzz"),
    "asm-riscv":    ("riscv64-linux-gnu-as", "riscv64-linux-gnu-as -o $T/fb.o fizzbuzz.s && riscv64-linux-gnu-ld -o $T/fizzbuzz $T/fb.o && qemu-riscv64 $T/fizzbuzz"),
    "asm-mips":     ("spim",   "spim -file fizzbuzz.s | sed -e '1,5d'"),
    "asm-6502":     (None, "assemble with ca65/acme, run in a C64 emulator"),
    "asm-z80":      (None, "assemble with z80asm, run under a CP/M emulator"),
    "wasm-wat":     ("wasmtime", "command -v wat2wasm >/dev/null || { echo 'missing toolchain: wat2wasm' >&2; exit 127; }\n"
                                "wat2wasm fizzbuzz.wat -o $T/fizzbuzz.wasm && wasmtime $T/fizzbuzz.wasm"),
    "llvm-ir":      ("clang",  "clang -Wno-override-module -o $T/fizzbuzz fizzbuzz.ll && $T/fizzbuzz"),

    # ---- esoteric -----------------------------------------------------------
    "brainfuck":    ("cc",     "cc -O2 -o $T/bf ../../tools/bf.c && $T/bf fizzbuzz.b"),
    "ook":          ("python3", "python3 generate.py >/dev/null && cc -O2 -o $T/bf ../../tools/bf.c && python3 ../../tools/ook2bf.py fizzbuzz.ook > $T/fizzbuzz.b && $T/bf $T/fizzbuzz.b"),
    "whitespace":   ("python3", "python3 ../../tools/whitespace.py fizzbuzz.ws"),
    "befunge":      ("python3", "python3 ../../tools/befunge93.py fizzbuzz.bf93"),
    "intercal":     (None, "partial: INTERCAL prints Roman numerals, see NOTES.md"),
    "malbolge":     (None, "not implemented, see NOTES.md"),
    "piet":         (None, "not implemented, see NOTES.md"),
    "lolcode":      ("lci",    "lci fizzbuzz.lol"),
    "chef":         (None, "partial, see NOTES.md"),
    "shakespeare":  (None, "partial, see NOTES.md"),
    "arnoldc":      (None, "requires the ArnoldC jar"),
    "rockstar":     ("rockstar", "rockstar fizzbuzz.rock"),
    "emojicode":    ("emojicodec", "emojicodec fizzbuzz.emojic -o $T/fizzbuzz && $T/fizzbuzz"),

    # ---- hardware / other paradigms -----------------------------------------
    "vhdl":         ("ghdl",   "ghdl -a --workdir=$T fizzbuzz.vhd && ghdl -e --workdir=$T -o $T/fizzbuzz fizzbuzz && $T/fizzbuzz"),
    "verilog":      ("iverilog", "iverilog -o $T/fizzbuzz fizzbuzz.v && vvp $T/fizzbuzz"),
    "systemverilog": ("verilator", "verilator --binary --top-module fizzbuzz --Mdir $T fizzbuzz.sv >/dev/null && "
                                  "$T/Vfizzbuzz | grep -v '\\$finish'"),
    "chisel":       ("sbt",    "sbt 'runMain FizzBuzzApp'"),
    "solidity":     (None, "compile-only; all() must be called on-chain"),
    "move":         (None, "compile-only; all() must be called on-chain"),
    "glsl":         (None, "renders to a framebuffer, not stdout"),
    "hlsl":         (None, "writes to a compute buffer, not stdout"),
    "ballerina":    ("bal",    "bal run fizzbuzz.bal"),
    "pony":         ("ponyc",  "ponyc -b fizzbuzz -o $T . >/dev/null && $T/fizzbuzz"),
    "chapel":       ("chpl",   "chpl -o $T/fizzbuzz fizzbuzz.chpl && $T/fizzbuzz"),
    "hy":           ("hy",     "hy fizzbuzz.hy"),
    "io":           ("io",     "io fizzbuzz.io"),
    "factor":       ("factor", "factor --version 2>&1 | grep -qi coreutils && "
                               "{ echo 'PATH factor is coreutils, not the language' >&2; exit 127; }\n"
                               "factor fizzbuzz.factor"),
    "red":          ("red",    "red fizzbuzz.red"),
    "ats":          ("patscc", "patscc -o $T/fizzbuzz fizzbuzz.dats && $T/fizzbuzz"),
}
# fmt: on
