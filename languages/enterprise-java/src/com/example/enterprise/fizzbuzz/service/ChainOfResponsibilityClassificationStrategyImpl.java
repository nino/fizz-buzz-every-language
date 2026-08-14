package com.example.enterprise.fizzbuzz.service;

import com.example.enterprise.fizzbuzz.spi.ClassificationRule;
import com.example.enterprise.fizzbuzz.spi.NumberClassificationStrategy;
import java.util.List;

/** Walks the rule chain and delegates to the first applicable rule. */
public class ChainOfResponsibilityClassificationStrategyImpl
        implements NumberClassificationStrategy {

    private final List<ClassificationRule> orderedRules;

    public ChainOfResponsibilityClassificationStrategyImpl(
            final List<ClassificationRule> orderedRules) {
        if (orderedRules == null || orderedRules.isEmpty()) {
            throw new IllegalArgumentException("rule chain must not be empty");
        }
        this.orderedRules = orderedRules;
    }

    @Override
    public String classify(final int candidate) {
        for (final ClassificationRule rule : this.orderedRules) {
            if (rule.isApplicableTo(candidate)) {
                return rule.classify(candidate);
            }
        }
        throw new IllegalStateException(
                "No applicable rule for candidate " + candidate
                        + "; the fallback rule appears to be missing.");
    }
}
