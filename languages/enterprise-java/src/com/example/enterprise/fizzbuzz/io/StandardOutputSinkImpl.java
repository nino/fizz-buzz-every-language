package com.example.enterprise.fizzbuzz.io;

import com.example.enterprise.fizzbuzz.spi.OutputSink;
import java.io.PrintStream;

/** Emits to an injected {@link PrintStream}, defaulting to standard output. */
public class StandardOutputSinkImpl implements OutputSink {

    private final PrintStream delegate;

    public StandardOutputSinkImpl() {
        this(System.out);
    }

    public StandardOutputSinkImpl(final PrintStream delegate) {
        if (delegate == null) {
            throw new IllegalArgumentException("delegate must not be null");
        }
        this.delegate = delegate;
    }

    @Override
    public void emit(final String payload) {
        this.delegate.println(payload);
    }
}
