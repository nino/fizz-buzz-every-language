package com.example.enterprise.fizzbuzz.spi;

/**
 * Service Provider Interface for a single unit of classification logic.
 *
 * <p>Implementations MUST be stateless, idempotent and thread-safe. Rules are
 * consulted in ascending {@link #getPriority()} order by the configured
 * {@link NumberClassificationStrategy}; the first rule whose
 * {@link #isApplicableTo(int)} predicate returns {@code true} wins.
 *
 * @since 1.0.0
 */
public interface ClassificationRule {

    /** @return whether this rule wishes to handle the candidate. */
    boolean isApplicableTo(int candidate);

    /** @return the textual classification. Called only when applicable. */
    String classify(int candidate);

    /** @return ordering weight; lower values are consulted first. */
    int getPriority();
}
