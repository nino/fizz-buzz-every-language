-- FizzBuzz in T-SQL (SQL Server).
SET NOCOUNT ON;

WITH nums AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM nums WHERE n < 100
)
SELECT CASE
           WHEN n % 15 = 0 THEN 'FizzBuzz'
           WHEN n % 3 = 0 THEN 'Fizz'
           WHEN n % 5 = 0 THEN 'Buzz'
           ELSE CAST(n AS VARCHAR(3))
       END
FROM nums
ORDER BY n
OPTION (MAXRECURSION 100);
