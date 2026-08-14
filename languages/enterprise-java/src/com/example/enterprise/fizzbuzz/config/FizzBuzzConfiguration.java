package com.example.enterprise.fizzbuzz.config;

import com.example.enterprise.fizzbuzz.factory.ClassificationRuleFactory;
import com.example.enterprise.fizzbuzz.factory.DefaultClassificationRuleFactoryImpl;
import com.example.enterprise.fizzbuzz.io.StandardOutputSinkImpl;
import com.example.enterprise.fizzbuzz.service.BoundedIntegerSequenceProviderImpl;
import com.example.enterprise.fizzbuzz.service.ChainOfResponsibilityClassificationStrategyImpl;
import com.example.enterprise.fizzbuzz.service.FizzBuzzOrchestrationService;
import com.example.enterprise.fizzbuzz.service.FizzBuzzOrchestrationServiceImpl;
import com.example.enterprise.fizzbuzz.spi.NumberClassificationStrategy;
import com.example.enterprise.fizzbuzz.spi.OutputSink;
import com.example.enterprise.fizzbuzz.spi.SequenceProvider;

/** Wires the object graph. The one place where concrete types are named. */
public final class FizzBuzzConfiguration {

    private static final int SEQUENCE_LOWER_BOUND_INCLUSIVE = 1;
    private static final int SEQUENCE_UPPER_BOUND_INCLUSIVE = 100;

    private FizzBuzzConfiguration() {
        throw new UnsupportedOperationException("Configuration class");
    }

    public static ApplicationContext bootstrapApplicationContext() {
        final ApplicationContext context = new ApplicationContext();

        final ClassificationRuleFactory ruleFactory =
                new DefaultClassificationRuleFactoryImpl();
        context.registerSingleton(ClassificationRuleFactory.class, ruleFactory);

        context.registerSingleton(
                SequenceProvider.class,
                new BoundedIntegerSequenceProviderImpl(
                        SEQUENCE_LOWER_BOUND_INCLUSIVE,
                        SEQUENCE_UPPER_BOUND_INCLUSIVE));

        context.registerSingleton(
                NumberClassificationStrategy.class,
                new ChainOfResponsibilityClassificationStrategyImpl(
                        ruleFactory.createClassificationRules()));

        context.registerSingleton(OutputSink.class, new StandardOutputSinkImpl());

        context.registerSingleton(
                FizzBuzzOrchestrationService.class,
                new FizzBuzzOrchestrationServiceImpl(
                        context.getBean(SequenceProvider.class),
                        context.getBean(NumberClassificationStrategy.class),
                        context.getBean(OutputSink.class)));

        return context;
    }
}
