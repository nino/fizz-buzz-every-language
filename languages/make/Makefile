# FizzBuzz using only GNU Make's text functions (no shell loop).
NUMBERS := $(shell seq 1 100)

# $(call fizzbuzz,N)
define fizzbuzz
$(if $(filter 0,$(shell expr $(1) % 15)),FizzBuzz,\
$(if $(filter 0,$(shell expr $(1) % 3)),Fizz,\
$(if $(filter 0,$(shell expr $(1) % 5)),Buzz,$(1))))
endef

.PHONY: all
all:
	@$(foreach n,$(NUMBERS),echo '$(strip $(call fizzbuzz,$(n)))';)
