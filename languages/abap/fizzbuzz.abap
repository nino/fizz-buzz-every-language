REPORT zfizzbuzz.

DATA: lv_i TYPE i.

DO 100 TIMES.
  lv_i = sy-index.
  IF lv_i MOD 15 = 0.
    WRITE / 'FizzBuzz'.
  ELSEIF lv_i MOD 3 = 0.
    WRITE / 'Fizz'.
  ELSEIF lv_i MOD 5 = 0.
    WRITE / 'Buzz'.
  ELSE.
    WRITE / lv_i LEFT-JUSTIFIED.
  ENDIF.
ENDDO.
