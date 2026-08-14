; FizzBuzz in LLVM IR. Compile with: clang fizzbuzz.ll -o fizzbuzz
@.fizzbuzz = private unnamed_addr constant [10 x i8] c"FizzBuzz\0A\00"
@.fizz     = private unnamed_addr constant [6 x i8]  c"Fizz\0A\00"
@.buzz     = private unnamed_addr constant [6 x i8]  c"Buzz\0A\00"
@.num      = private unnamed_addr constant [4 x i8]  c"%d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main() {
entry:
  br label %loop

loop:
  %i = phi i32 [ 1, %entry ], [ %inext, %cont ]
  %m15 = srem i32 %i, 15
  %is15 = icmp eq i32 %m15, 0
  br i1 %is15, label %fizzbuzz, label %check3

check3:
  %m3 = srem i32 %i, 3
  %is3 = icmp eq i32 %m3, 0
  br i1 %is3, label %fizz, label %check5

check5:
  %m5 = srem i32 %i, 5
  %is5 = icmp eq i32 %m5, 0
  br i1 %is5, label %buzz, label %number

fizzbuzz:
  %pfb = getelementptr [10 x i8], [10 x i8]* @.fizzbuzz, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %pfb)
  br label %cont

fizz:
  %pf = getelementptr [6 x i8], [6 x i8]* @.fizz, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %pf)
  br label %cont

buzz:
  %pb = getelementptr [6 x i8], [6 x i8]* @.buzz, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %pb)
  br label %cont

number:
  %pn = getelementptr [4 x i8], [4 x i8]* @.num, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %pn, i32 %i)
  br label %cont

cont:
  %inext = add i32 %i, 1
  %done = icmp sgt i32 %inext, 100
  br i1 %done, label %exit, label %loop

exit:
  ret i32 0
}
