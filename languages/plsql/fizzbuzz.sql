-- FizzBuzz in PL/SQL (Oracle).
SET SERVEROUTPUT ON
BEGIN
    FOR i IN 1 .. 100 LOOP
        IF MOD(i, 15) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('FizzBuzz');
        ELSIF MOD(i, 3) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Fizz');
        ELSIF MOD(i, 5) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Buzz');
        ELSE
            DBMS_OUTPUT.PUT_LINE(TO_CHAR(i));
        END IF;
    END LOOP;
END;
/
