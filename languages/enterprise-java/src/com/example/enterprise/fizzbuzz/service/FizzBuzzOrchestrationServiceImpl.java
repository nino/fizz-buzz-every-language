package com.example.enterprise.fizzbuzz.service;

import com.example.enterprise.fizzbuzz.spi.NumberClassificationStrategy;
import com.example.enterprise.fizzbuzz.spi.OutputSink;
import com.example.enterprise.fizzbuzz.spi.SequenceProvider;

/** Constructor-injected implementation of the orchestration facade. */
public class FizzBuzzOrchestrationServiceImpl implements FizzBuzzOrchestrationService {

    private final SequenceProvider sequenceProvider;
    private final NumberClassificationStrategy classificationStrategy;
    private final OutputSink outputSink;

    public FizzBuzzOrchestrationServiceImpl(
            final SequenceProvider sequenceProvider,
            final NumberClassificationStrategy classificationStrategy,
            final OutputSink outputSink) {
        this.sequenceProvider = sequenceProvider;
        this.classificationStrategy = classificationStrategy;
        this.outputSink = outputSink;
    }

    @Override
    public void executeFizzBuzzWorkflow() {
        for (final Integer candidate : this.sequenceProvider.provideSequence()) {
            this.outputSink.emit(
                    this.classificationStrategy.classify(candidate.intValue()));
        }
    }
}
