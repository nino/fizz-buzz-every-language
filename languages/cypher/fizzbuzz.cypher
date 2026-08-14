// FizzBuzz in Cypher (Neo4j). range() builds the list, UNWIND turns it into
// rows, and CASE picks the label.
UNWIND range(1, 100) AS n
RETURN CASE
         WHEN n % 15 = 0 THEN 'FizzBuzz'
         WHEN n % 3 = 0 THEN 'Fizz'
         WHEN n % 5 = 0 THEN 'Buzz'
         ELSE toString(n)
       END AS fizzbuzz
ORDER BY n
