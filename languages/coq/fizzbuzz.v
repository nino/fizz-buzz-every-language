(* FizzBuzz in Coq (Rocq). Extractable to OCaml / runnable via Compute. *)
Require Import Arith.
Require Import String.
Require Import List.
Import ListNotations.
Open Scope string_scope.

Fixpoint nat_to_string_aux (fuel n : nat) (acc : string) : string :=
  match fuel with
  | 0 => acc
  | S f =>
    let d := String (Ascii.ascii_of_nat (48 + Nat.modulo n 10)) EmptyString in
    match Nat.div n 10 with
    | 0 => append d acc
    | q => nat_to_string_aux f q (append d acc)
    end
  end.

Definition nat_to_string (n : nat) : string :=
  nat_to_string_aux 20 n EmptyString.

Definition fizzbuzz (n : nat) : string :=
  if Nat.eqb (Nat.modulo n 15) 0 then "FizzBuzz"
  else if Nat.eqb (Nat.modulo n 3) 0 then "Fizz"
  else if Nat.eqb (Nat.modulo n 5) 0 then "Buzz"
  else nat_to_string n.

Definition results : list string := map fizzbuzz (seq 1 100).

Compute results.
