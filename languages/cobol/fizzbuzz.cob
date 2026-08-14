       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIZZBUZZ.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 I            PIC 9(3).
       01 R            PIC 9(3).
       01 I-DISPLAY    PIC Z(2)9.
       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 100
               DIVIDE I BY 15 GIVING R REMAINDER R
               IF R = 0
                   DISPLAY "FizzBuzz"
               ELSE
                   DIVIDE I BY 3 GIVING R REMAINDER R
                   IF R = 0
                       DISPLAY "Fizz"
                   ELSE
                       DIVIDE I BY 5 GIVING R REMAINDER R
                       IF R = 0
                           DISPLAY "Buzz"
                       ELSE
                           MOVE I TO I-DISPLAY
                           DISPLAY FUNCTION TRIM(I-DISPLAY)
                       END-IF
                   END-IF
               END-IF
           END-PERFORM
           STOP RUN.
