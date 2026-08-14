package com.example.enterprise.fizzbuzz.spi;

import java.util.List;

/** Supplies the candidate sequence, decoupling iteration from classification. */
public interface SequenceProvider {
    List<Integer> provideSequence();
}
