package com.example.enterprise.fizzbuzz.spi;

/** Abstraction over the emission destination, so tests need not capture stdout. */
public interface OutputSink {
    void emit(String payload);
}
