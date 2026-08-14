# Enterprise Java

The same hundred lines of output, arrived at through fourteen classes across
six packages.

Everything here is real: a Chain of Responsibility over prioritised
`ClassificationRule` beans, an Abstract Factory for the rule catalogue, a
Template Method for the divisibility predicate, constructor injection through
a hand-rolled `ApplicationContext`, and an `OutputSink` so that nothing is
coupled to `System.out`.

Notably, the `if (i % 15 == 0)` that every other implementation in this
repository writes in one line has become
`FizzBuzzCompositeClassificationRuleImpl`, a class whose priority constant
(100) is what actually encodes "check this before Fizz and Buzz".

It compiles and runs, and its output is byte-identical to `expected.txt`.
