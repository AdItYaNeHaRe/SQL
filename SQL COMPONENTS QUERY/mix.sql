-- We are going to use all SQL components in a single query to demonstrate their combined usage.

SELECT DISTINCT
country,
AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 50
ORDER BY avg_score DESC;
