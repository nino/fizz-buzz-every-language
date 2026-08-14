# Malbolge

Malbolge was designed to be as close to impossible to program in as its
author could manage: instructions are selected by the value at the
instruction pointer *modulo 94 plus the pointer's own position*, every
executed instruction is then overwritten by an encrypted variant, and the
only arithmetic is a base-3 "crazy" tritwise operation.

In practice, Malbolge programs beyond "Hello, world" are not written — they
are found, by running a search (usually a genetic algorithm or a
constraint solver over the encryption schedule) until a byte string happens
to decode into the desired behaviour. Published Malbolge programs with
loops and conditionals are the output of such searches, not of authorship.

A genuine FizzBuzz here would mean running that search. This directory is a
deliberate gap rather than a fabricated program that does not run.

Status: not implemented.
