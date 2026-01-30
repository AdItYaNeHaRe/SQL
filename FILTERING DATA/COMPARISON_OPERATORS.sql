-- =====================================================
-- SQL COMPARISON OPERATORS - Complete Reference with Examples
-- =====================================================

-- ENGLISH EXPLANATION FOR COMPARISON OPERATORS

-- Comparison operators are used in WHERE, HAVING clauses to filter data based on conditions.

-- 1. EQUAL TO (=)
-- SELECT * FROM Employees WHERE salary = 50000;
-- Returns rows where salary is exactly 50000.

-- 2. NOT EQUAL TO (<> or !=)
-- SELECT * FROM Employees WHERE department <> 'HR';
-- SELECT * FROM Employees WHERE department != 'HR';  -- SQL Server style
-- Returns rows where department is NOT 'HR'.

-- 3. GREATER THAN (>)
-- SELECT * FROM Employees WHERE salary > 50000;
-- Returns employees with salary higher than 50000.

-- 4. LESS THAN (<)
-- SELECT * FROM Employees WHERE age < 30;
-- Returns employees younger than 30.

-- 5. GREATER THAN OR EQUAL TO (>=)
-- SELECT * FROM Employees WHERE salary >= 50000;
-- Returns employees with salary 50000 or higher.

-- 6. LESS THAN OR EQUAL TO (<=)
-- SELECT * FROM Employees WHERE age <= 25;
-- Returns employees 25 years old or younger.

-- Complete example with sample data:
-- CREATE TABLE TestData (id INT, marks INT);
-- INSERT INTO TestData VALUES
--   (1, 85), (2, 92), (3, 78), (4, 85), (5, 60);

-- All comparison operators demo:
SELECT id, marks FROM TestData WHERE marks = 85;      -- (=) Equal: rows 1,4
SELECT id, marks FROM TestData WHERE marks <> 85;    -- (<>) Not equal: rows 2,3,5
SELECT id, marks FROM TestData WHERE marks > 80;     -- (>) Greater: rows 1,2,4
SELECT id, marks FROM TestData WHERE marks < 80;     -- (<) Less: row 3,5
SELECT id, marks FROM TestData WHERE marks >= 85;    -- (>=) Greater/equal: rows 1,2,4
SELECT id, marks FROM TestData WHERE marks <= 80;    -- (<=) Less/equal: rows 3,5


-- HINGLISH EXPLANATION FOR COMPARISON OPERATORS

-- Comparison operators WHERE, HAVING mein use hote hain data filter karne ke liye.

-- 1. BARABAR (=)
-- SELECT * FROM Employees WHERE salary = 50000;
-- Salary exactly 50000 wale employees.

-- 2. NA-BARABAR (<> ya !=)
-- SELECT * FROM Employees WHERE department <> 'HR';
-- SELECT * FROM Employees WHERE department != 'HR';  -- SQL Server
-- HR department wale EXCEPT karke baaki sab.

-- 3. USSE BADHA (>)
-- SELECT * FROM Employees WHERE salary > 50000;
-- 50000 se zyada salary wale.

-- 4. USSE CHHOTA (<)
-- SELECT * FROM Employees WHERE age < 30;
-- 30 se kam umar wale.

-- 5. USSE BADHA YA BARABAR (>=)
-- SELECT * FROM Employees WHERE salary >= 50000;
-- 50000 ya usse zyada salary wale.

-- 6. USSE CHHOTA YA BARABAR (<=)
-- SELECT * FROM Employees WHERE age <= 25;
-- 25 ya usse kam umar wale.

-- Quick Reference Table (Hinglish):
-- =     → barabar
-- <> != → na-barabar
-- >     → usse bada
-- <     → usse chhota
-- >=    → usse bada ya barabar
-- <=    → usse chhota ya barabar

-- Pro Tip: Hamesha pehle SELECT se test karo, phir UPDATE/DELETE mein use karo!
