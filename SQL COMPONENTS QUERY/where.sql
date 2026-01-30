SELECT * FROM customers
WHERE country = 'USA' AND score != 0;





-- ENGLISH EXPLANATION FOR `WHERE`

-- The WHERE clause is used to filter rows in a table based on a given condition. [web:15][web:21]
-- It returns only those rows that satisfy the condition and ignores the rest. [web:19][web:24]
-- WHERE can be used with SELECT, UPDATE, and DELETE statements. [web:15][web:24]

-- Basic syntax with SELECT:
-- SELECT column1, column2, ...
-- FROM table_name
-- WHERE condition;          -- condition is a logical expression that is true/false. [web:15][web:17]

-- Example:
-- SELECT *
-- FROM Employees
-- WHERE salary > 50000;
-- This returns only those rows from Employees where salary is greater than 50000. [web:20][web:24]

-- Common operators used in WHERE: =, <, >, <=, >=, <>, BETWEEN, LIKE, IN, AND, OR, NOT. [web:15][web:24]


-- HINGLISH EXPLANATION FOR `WHERE`

-- WHERE clause ka use table ke rows ko filter karne ke liye hota hai condition ke basis par. [web:21][web:24]
-- Sirf wahi rows result mein aate hain jo condition ko satisfy karte hain, baaki ignore ho jaate hain. [web:19][web:20]
-- WHERE ko SELECT, UPDATE aur DELETE ke saath use kar sakte ho. [web:15][web:24]

-- Basic syntax (SELECT ke saath):
-- SELECT column1, column2, ...
-- FROM table_name
-- WHERE condition;          -- yahan condition ek logical expression hai jo true/false hota hai. [web:17][web:22]

-- Example (Hinglish samjhaav):
-- SELECT *
-- FROM Employees
-- WHERE salary > 50000;
-- Iska matlab: Employees table se sirf un employees ko lao jinki salary 50000 se zyada hai. [web:20][web:24]

-- Common operators jo WHERE ke saath use hote hain: =, <, >, <=, >=, <>, BETWEEN, LIKE, IN, AND, OR, NOT. [web:15][web:23]
