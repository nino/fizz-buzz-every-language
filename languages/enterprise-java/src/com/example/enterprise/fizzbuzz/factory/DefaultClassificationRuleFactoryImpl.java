package com.example.enterprise.fizzbuzz.factory;

import com.example.enterprise.fizzbuzz.rule.BuzzClassificationRuleImpl;
import com.example.enterprise.fizzbuzz.rule.FizzBuzzCompositeClassificationRuleImpl;
import com.example.enterprise.fizzbuzz.rule.FizzClassificationRuleImpl;
import com.example.enterprise.fizzbuzz.rule.IdentityFallbackClassificationRuleImpl;
import com.example.enterprise.fizzbuzz.spi.ClassificationRule;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/** Canonical rule catalogue, returned in priority order. */
public class DefaultClassificationRuleFactoryImpl implements ClassificationRuleFactory {

    @Override
    public List<ClassificationRule> createClassificationRules() {
        final List<ClassificationRule> rules = new ArrayList<ClassificationRule>();
        rules.add(new FizzBuzzCompositeClassificationRuleImpl());
        rules.add(new FizzClassificationRuleImpl());
        rules.add(new BuzzClassificationRuleImpl());
        rules.add(new IdentityFallbackClassificationRuleImpl());
        Collections.sort(rules, new Comparator<ClassificationRule>() {
            @Override
            public int compare(final ClassificationRule a, final ClassificationRule b) {
                return Integer.compare(a.getPriority(), b.getPriority());
            }
        });
        return Collections.unmodifiableList(rules);
    }
}
