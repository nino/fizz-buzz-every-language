package com.example.enterprise.fizzbuzz.spi;

/** Strategy abstraction over the rule set. */
public interface NumberClassificationStrategy {
    String classify(int candidate);
}
