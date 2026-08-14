;; FizzBuzz in WebAssembly text format (WASI).
(module
  (import "wasi_snapshot_preview1" "fd_write"
    (func $fd_write (param i32 i32 i32 i32) (result i32)))

  (memory (export "memory") 1)

  ;; Static strings
  (data (i32.const 100) "FizzBuzz\n")
  (data (i32.const 120) "Fizz\n")
  (data (i32.const 130) "Buzz\n")

  ;; iovec lives at 0..8, scratch number buffer at 200..216
  (func $write (param $ptr i32) (param $len i32)
    (i32.store (i32.const 0) (local.get $ptr))
    (i32.store (i32.const 4) (local.get $len))
    (drop (call $fd_write (i32.const 1) (i32.const 0) (i32.const 1) (i32.const 8))))

  (func $write_int (param $n i32)
    (local $p i32)
    (local $len i32)
    (local.set $p (i32.const 216))
    ;; trailing newline
    (local.set $p (i32.sub (local.get $p) (i32.const 1)))
    (i32.store8 (local.get $p) (i32.const 10))
    (block $done
      (loop $conv
        (local.set $p (i32.sub (local.get $p) (i32.const 1)))
        (i32.store8 (local.get $p)
          (i32.add (i32.const 48) (i32.rem_u (local.get $n) (i32.const 10))))
        (local.set $n (i32.div_u (local.get $n) (i32.const 10)))
        (br_if $done (i32.eqz (local.get $n)))
        (br $conv)))
    (local.set $len (i32.sub (i32.const 216) (local.get $p)))
    (call $write (local.get $p) (local.get $len)))

  (func $main (export "_start")
    (local $i i32)
    (local.set $i (i32.const 1))
    (block $exit
      (loop $loop
        (br_if $exit (i32.gt_u (local.get $i) (i32.const 100)))
        (if (i32.eqz (i32.rem_u (local.get $i) (i32.const 15)))
          (then (call $write (i32.const 100) (i32.const 9)))
          (else
            (if (i32.eqz (i32.rem_u (local.get $i) (i32.const 3)))
              (then (call $write (i32.const 120) (i32.const 5)))
              (else
                (if (i32.eqz (i32.rem_u (local.get $i) (i32.const 5)))
                  (then (call $write (i32.const 130) (i32.const 5)))
                  (else (call $write_int (local.get $i))))))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $loop))))
)
