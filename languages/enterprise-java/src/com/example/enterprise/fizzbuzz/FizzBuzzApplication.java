package com.example.enterprise.fizzbuzz;

import com.example.enterprise.fizzbuzz.config.ApplicationContext;
import com.example.enterprise.fizzbuzz.config.FizzBuzzConfiguration;
import com.example.enterprise.fizzbuzz.service.FizzBuzzOrchestrationService;

/**
 * Application entry point.
 *
 * <p>Responsibilities are strictly limited to bootstrapping the container and
 * delegating to the orchestration facade. No business logic resides here.
 */
public final class FizzBuzzApplication {

    private FizzBuzzApplication() {
        throw new UnsupportedOperationException("Entry point class");
    }

    public static void main(final String[] args) {
        final ApplicationContext context =
                FizzBuzzConfiguration.bootstrapApplicationContext();
        context.getBean(FizzBuzzOrchestrationService.class)
               .executeFizzBuzzWorkflow();
    }
}
