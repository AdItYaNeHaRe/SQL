SELECT
    country,
    SUM(score) AS total_score,
    COUNT(id) AS total_customers
FROM customers
GROUP BY country
HAVING total_score > 1000;

-- ENGLISH EXPLANATION FOR `HAVING`

-- The HAVING clause is used to filter groups created by GROUP BY,
-- usually based on aggregate functions like SUM, COUNT, AVG, MIN, MAX. [web:51]
-- It works like WHERE, but WHERE cannot be used directly with aggregate functions,
-- so HAVING was introduced for post-aggregation filtering. [web:51][web:55]

-- General syntax:
-- SELECT column1, aggregate_function(column2)
-- FROM table_name
-- WHERE row_condition              -- optional, filters rows before grouping
-- GROUP BY column1
-- HAVING group_condition;          -- filters groups after aggregation. [web:52][web:57]

-- Example 1: countries with more than 5 customers
-- SELECT COUNT(CustomerID) AS cust_count, Country
-- FROM Customers
-- GROUP BY Country
-- HAVING COUNT(CustomerID) > 5;
-- This returns only those countries where the number of customers is greater than 5. [web:51][web:56]

-- Example 2: departments with total salary >= 250000
-- SELECT Department, SUM(Salary) AS Total_Salary
-- FROM Employee
-- GROUP BY Department
-- HAVING SUM(Salary) >= 250000;
-- This keeps only those department groups whose total salary meets the condition. [web:53][web:55]

-- Key difference from WHERE:
-- - WHERE filters individual rows before GROUP BY.
-- - HAVING filters grouped results after GROUP BY, often using aggregates. [web:54][web:58]


-- HINGLISH EXPLANATION FOR `HAVING`

-- HAVING clause ka use un groups ko filter karne ke liye hota hai
-- jo GROUP BY se ban chuke hote hain, usually SUM, COUNT, AVG, MIN, MAX jaise
-- aggregate functions ke result ke basis par. [web:51][web:55]
-- WHERE rows ko pehle filter karta hai, lekin aggregate functions ke saath directly
-- use nahi ho sakta, isliye HAVING post-aggregation filtering ke liye use hota hai. [web:51][web:54]

-- General syntax (Hinglish samjhaav):
-- SELECT column1, aggregate_function(column2)
-- FROM table_name
-- WHERE row_condition              -- yahan pehle normal rows filter hote hain
-- GROUP BY column1
-- HAVING group_condition;          -- yahan grouping ke baad groups filter hote hain. [web:52][web:57]

-- Example 1: sirf un countries ko dikhana jahan 5 se zyada customers hain
-- SELECT COUNT(CustomerID) AS cust_count, Country
-- FROM Customers
-- GROUP BY Country
-- HAVING COUNT(CustomerID) > 5;
-- Iska matlab: har country ke customers count karo, phir sirf wahi countries dikhao
-- jinke customers 5 se zyada hain. [web:51][web:56]

-- Example 2: un departments ko dikhana jinka total salary >= 250000 hai
-- SELECT Department, SUM(Salary) AS Total_Salary
-- FROM Employee
-- GROUP BY Department
-- HAVING SUM(Salary) >= 250000;
-- Yahan pehle department ke hisaab se salary ka sum niklega,
-- phir sirf wahi departments result mein rahenge jinka total salary condition ko pass karta hai. [web:53][web:55]

-- Short comparison (Hinglish):
-- WHERE → rows par condition, GROUP BY se pehle apply hota hai.
-- HAVING → groups par condition, GROUP BY ke baad apply hota hai,
-- aur generally aggregate functions ke saath use hota hai. [web:54][web:58]
