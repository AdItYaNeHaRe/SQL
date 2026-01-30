SELECT
country,
AVG(score) AS avg_score
FROM customers
WHERE score !=0
GROUP BY country
HAVING avg_score > 50;
