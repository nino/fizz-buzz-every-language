package com.example.enterprise.fizzbuzz.factory;

import com.example.enterprise.fizzbuzz.spi.ClassificationRule;
import java.util.List;

/** Abstract Factory for the rule set, permitting alternative rule catalogues. */
public interface ClassificationRuleFactory {
    List<ClassificationRule> createClassificationRules();
}
