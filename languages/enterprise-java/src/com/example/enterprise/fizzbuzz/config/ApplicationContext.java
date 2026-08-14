package com.example.enterprise.fizzbuzz.config;

import java.util.HashMap;
import java.util.Map;

/**
 * A minimal inversion-of-control container.
 *
 * <p>Beans are registered under their interface type and resolved lazily. No
 * classpath scanning is performed, because the deployment descriptor
 * ({@link FizzBuzzConfiguration}) is authoritative.
 */
public final class ApplicationContext {

    private final Map<Class<?>, Object> singletonRegistry =
            new HashMap<Class<?>, Object>();

    public <T> void registerSingleton(final Class<T> contract, final T instance) {
        if (this.singletonRegistry.containsKey(contract)) {
            throw new IllegalStateException(
                    "Duplicate bean definition for " + contract.getName());
        }
        this.singletonRegistry.put(contract, instance);
    }

    public <T> T getBean(final Class<T> contract) {
        final Object bean = this.singletonRegistry.get(contract);
        if (bean == null) {
            throw new IllegalStateException(
                    "No qualifying bean of type " + contract.getName()
                            + " is defined.");
        }
        return contract.cast(bean);
    }
}
