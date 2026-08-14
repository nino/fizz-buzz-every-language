-- FizzBuzz in PL/pgSQL.
DO $$
DECLARE
    i INTEGER;
BEGIN
    FOR i IN 1..100 LOOP
        IF i % 15 = 0 THEN
            RAISE NOTICE 'FizzBuzz';
        ELSIF i % 3 = 0 THEN
            RAISE NOTICE 'Fizz';
        ELSIF i % 5 = 0 THEN
            RAISE NOTICE 'Buzz';
        ELSE
            RAISE NOTICE '%', i;
        END IF;
    END LOOP;
END $$;
