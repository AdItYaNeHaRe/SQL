SELECT * FROM customers
ORDER BY country ASC, score DESC;



-- ENGLISH EXPLANATION FOR `ORDER BY`

-- The ORDER BY clause is used to sort the rows returned by a query. [web:33]
-- It can sort data in ascending order (ASC, default) or descending order (DESC). [web:33]

-- Basic syntax:
-- SELECT column1, column2, ...
-- FROM table_name
-- ORDER BY columnA [ASC | DESC], columnB [ASC | DESC], ...;    -- ASC is default if not specified. [web:33][web:36]

-- Example 1: sort by one column in ascending order (default)
-- SELECT *
-- FROM Employees
-- ORDER BY salary;
-- This returns all rows from Employees sorted from lowest to highest salary. [web:35][web:39]

-- Example 2: sort by one column in descending order
-- SELECT *
-- FROM Employees
-- ORDER BY salary DESC;
-- This returns all rows from Employees sorted from highest to lowest salary. [web:33][web:37]

-- Example 3: sort by multiple columns
-- SELECT *
-- FROM Employees
-- ORDER BY department ASC, salary DESC;
-- This first sorts by department alphabetically, and within the same department,
-- sorts employees by salary from highest to lowest. [web:33][web:36]


-- HINGLISH EXPLANATION FOR `ORDER BY`

-- ORDER BY clause ka use query ke result rows ko sort (order) karne ke liye hota hai. [web:37]
-- Ye data ko ascending (ASC, default) ya descending (DESC) order mein laga sakta hai. [web:33][web:35]

-- Basic syntax (Hinglish samjhaav):
-- SELECT column1, column2, ...
-- FROM table_name
-- ORDER BY columnA [ASC | DESC], columnB [ASC | DESC], ...;    -- agar kuch nahi likhoge, to ASC maana jaata hai. [web:33][web:36]

-- Example 1: ek column par ascending order
-- SELECT *
-- FROM Employees
-- ORDER BY salary;
-- Iska matlab: Employees ki saari rows ko salary ke hisaab se chhoti se badi salary tak arrange karo. [web:35][web:39]

-- Example 2: ek column par descending order
-- SELECT *
-- FROM Employees
-- ORDER BY salary DESC;
-- Iska matlab: Employees ko unki salary ke hisaab se sabse badi se sabse chhoti salary tak order karo. [web:33][web:37]

-- Example 3: multiple columns ke saath
-- SELECT *
-- FROM Employees
-- ORDER BY department ASC, salary DESC;
-- Yahan pehle department naam ke hisaab se A–Z order mein sort hoga,
-- aur same department ke andar salary ke hisaab se highest se lowest tak sort hoga. [web:33][web:36]
