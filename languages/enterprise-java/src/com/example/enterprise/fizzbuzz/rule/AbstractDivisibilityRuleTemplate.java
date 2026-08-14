package com.example.enterprise.fizzbuzz.rule;

import com.example.enterprise.fizzbuzz.spi.ClassificationRule;

/**
 * Template Method base class factoring out the divisibility predicate shared
 * by all concrete divisibility-based rules.
 */
public abstract class AbstractDivisibilityRuleTemplate implements ClassificationRule {

    private final int divisor;

    protected AbstractDivisibilityRuleTemplate(final int divisor) {
        if (divisor == 0) {
            throw new IllegalArgumentException("divisor must be non-zero");
        }
        this.divisor = divisor;
    }

    @Override
    public final boolean isApplicableTo(final int candidate) {
        return candidate % this.divisor == 0;
    }

    protected final int getDivisor() {
        return this.divisor;
    }
}
