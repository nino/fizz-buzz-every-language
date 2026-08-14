package com.example.enterprise.fizzbuzz.rule;

/**
 * Handles the composite case. Registered at the highest priority so that it is
 * evaluated before its constituent rules, in accordance with the
 * most-specific-rule-first principle.
 */
public class FizzBuzzCompositeClassificationRuleImpl
        extends AbstractDivisibilityRuleTemplate {

    private static final int DIVISOR = 15;
    private static final int PRIORITY = 100;
    private static final String CLASSIFICATION = "FizzBuzz";

    public FizzBuzzCompositeClassificationRuleImpl() {
        super(DIVISOR);
    }

    @Override
    public String classify(final int candidate) {
        return CLASSIFICATION;
    }

    @Override
    public int getPriority() {
        return PRIORITY;
    }
}
