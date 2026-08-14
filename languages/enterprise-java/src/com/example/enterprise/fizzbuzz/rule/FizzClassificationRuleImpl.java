package com.example.enterprise.fizzbuzz.rule;

public class FizzClassificationRuleImpl extends AbstractDivisibilityRuleTemplate {

    private static final int DIVISOR = 3;
    private static final int PRIORITY = 200;
    private static final String CLASSIFICATION = "Fizz";

    public FizzClassificationRuleImpl() {
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
