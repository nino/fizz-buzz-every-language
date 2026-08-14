-- FizzBuzz in SQL (SQLite dialect) using a recursive CTE.
WITH RECURSIVE nums(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM nums WHERE n < 100
)
SELECT CASE
           WHEN n % 15 = 0 THEN 'FizzBuzz'
           WHEN n % 3 = 0 THEN 'Fizz'
           WHEN n % 5 = 0 THEN 'Buzz'
           ELSE CAST(n AS TEXT)
       END
FROM nums;
