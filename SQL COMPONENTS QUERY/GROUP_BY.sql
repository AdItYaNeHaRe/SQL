SELECT
    country,
    SUM(score),
    COUNT(id)
FROM customers
GROUP BY country;


-- ENGLISH EXPLANATION FOR `GROUP BY`

-- The GROUP BY clause groups rows that have the same value in one or more columns
-- so that aggregate functions (COUNT, SUM, AVG, MIN, MAX, etc.) can be applied
-- on each group to produce summary results. [web:41][web:44]

-- Basic syntax:
-- SELECT column1, aggregate_function(column2)
-- FROM table_name
-- WHERE condition            -- optional
-- GROUP BY column1, column2, ...;    -- columns used to form groups. [web:42][web:43]

-- Example 1: count employees in each department
-- SELECT department, COUNT(*) AS emp_count
-- FROM Employees
-- GROUP BY department;
-- This returns one row per department with the number of employees in that department. [web:43][web:48]

-- Example 2: total salary per department
-- SELECT department, SUM(salary) AS total_salary
-- FROM Employees
-- GROUP BY department;
-- This returns the sum of salary for each department. [web:44][web:47]

-- Notes:
-- 1. Every non-aggregated column in SELECT must appear in GROUP BY. [web:44][web:45]
-- 2. GROUP BY comes after WHERE and before ORDER BY in a query. [web:41][web:46]


-- HINGLISH EXPLANATION FOR `GROUP BY`

-- GROUP BY clause ka use un rows ko groups mein divide karne ke liye hota hai
-- jinke specified column(s) ke values same hote hain, taaki un groups par
-- aggregate functions (COUNT, SUM, AVG, MIN, MAX, etc.) lagaa sakein. [web:41][web:46]

-- Basic syntax (Hinglish samjhaav):
-- SELECT column1, aggregate_function(column2)
-- FROM table_name
-- WHERE condition            -- optional filter pehle lagta hai
-- GROUP BY column1, column2, ...;    -- yahi columns ke basis par grouping hoti hai. [web:42][web:43]

-- Example 1: har department mein kitne employees hain
-- SELECT department, COUNT(*) AS emp_count
-- FROM Employees
-- GROUP BY department;
-- Iska output: har department ke liye ek row, jisme us department ke employees ki count hoti hai. [web:43][web:48]

-- Example 2: har department ka total salary
-- SELECT department, SUM(salary) AS total_salary
-- FROM Employees
-- GROUP BY department;
-- Iska matlab: har department ki salaries ko add karke ek summary row dikhaana. [web:44][web:47]

-- Important points (Hinglish):
-- 1. Jo columns aggregate function ke bina SELECT mein likhe ho, unhe GROUP BY mein likhna zaroori hai. [web:44][web:45]
-- 2. Query order generally aisa hota hai: FROM → WHERE → GROUP BY → HAVING → ORDER BY. [web:41][web:46]
