package com.example.enterprise.fizzbuzz.rule;

import com.example.enterprise.fizzbuzz.spi.ClassificationRule;

/** Terminal rule guaranteeing the chain always yields a classification. */
public class IdentityFallbackClassificationRuleImpl implements ClassificationRule {

    private static final int PRIORITY = Integer.MAX_VALUE;

    @Override
    public boolean isApplicableTo(final int candidate) {
        return true;
    }

    @Override
    public String classify(final int candidate) {
        return String.valueOf(candidate);
    }

    @Override
    public int getPriority() {
        return PRIORITY;
    }
}
