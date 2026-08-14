package com.example.enterprise.fizzbuzz.rule;

public class BuzzClassificationRuleImpl extends AbstractDivisibilityRuleTemplate {

    private static final int DIVISOR = 5;
    private static final int PRIORITY = 300;
    private static final String CLASSIFICATION = "Buzz";

    public BuzzClassificationRuleImpl() {
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
