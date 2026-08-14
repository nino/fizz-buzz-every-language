/* A small Brainfuck interpreter, used to run languages/brainfuck and
 * languages/ook.  Usage: bf PROGRAM.b  */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define TAPE 65536
#define MAXP (1 << 20)

int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "usage: %s program.b\n", argv[0]);
        return 2;
    }

    FILE *f = fopen(argv[1], "rb");
    if (!f) {
        perror(argv[1]);
        return 2;
    }

    static char prog[MAXP];
    size_t n = 0;
    int ch;
    while ((ch = fgetc(f)) != EOF && n < MAXP - 1) {
        if (strchr("><+-.,[]", ch)) prog[n++] = (char)ch;
    }
    prog[n] = '\0';
    fclose(f);

    /* Precompute bracket matches so loops are O(1) to enter and leave. */
    static long jump[MAXP];
    long *stack = malloc(n * sizeof(long) + 8);
    long sp = 0;
    for (size_t i = 0; i < n; i++) {
        if (prog[i] == '[') {
            stack[sp++] = (long)i;
        } else if (prog[i] == ']') {
            if (sp == 0) {
                fprintf(stderr, "unmatched ] at %zu\n", i);
                return 2;
            }
            long open = stack[--sp];
            jump[open] = (long)i;
            jump[i] = open;
        }
    }
    if (sp != 0) {
        fprintf(stderr, "unmatched [\n");
        return 2;
    }
    free(stack);

    static unsigned char tape[TAPE];
    size_t ptr = 0;

    for (size_t ip = 0; ip < n; ip++) {
        switch (prog[ip]) {
            case '>': ptr = (ptr + 1) % TAPE; break;
            case '<': ptr = (ptr + TAPE - 1) % TAPE; break;
            case '+': tape[ptr]++; break;
            case '-': tape[ptr]--; break;
            case '.': putchar(tape[ptr]); break;
            case ',': { int c = getchar(); tape[ptr] = (c == EOF) ? 0 : (unsigned char)c; break; }
            case '[': if (!tape[ptr]) ip = (size_t)jump[ip]; break;
            case ']': if (tape[ptr]) ip = (size_t)jump[ip]; break;
            default: break;
        }
    }

    return 0;
}
