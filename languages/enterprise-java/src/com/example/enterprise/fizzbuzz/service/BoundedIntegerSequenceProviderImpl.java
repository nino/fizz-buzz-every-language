package com.example.enterprise.fizzbuzz.service;

import com.example.enterprise.fizzbuzz.spi.SequenceProvider;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/** Provides a closed integer interval, inclusive of both bounds. */
public class BoundedIntegerSequenceProviderImpl implements SequenceProvider {

    private final int lowerBoundInclusive;
    private final int upperBoundInclusive;

    public BoundedIntegerSequenceProviderImpl(
            final int lowerBoundInclusive, final int upperBoundInclusive) {
        if (lowerBoundInclusive > upperBoundInclusive) {
            throw new IllegalArgumentException("lower bound exceeds upper bound");
        }
        this.lowerBoundInclusive = lowerBoundInclusive;
        this.upperBoundInclusive = upperBoundInclusive;
    }

    @Override
    public List<Integer> provideSequence() {
        final List<Integer> sequence = new ArrayList<Integer>();
        for (int i = this.lowerBoundInclusive; i <= this.upperBoundInclusive; i++) {
            sequence.add(Integer.valueOf(i));
        }
        return Collections.unmodifiableList(sequence);
    }
}
