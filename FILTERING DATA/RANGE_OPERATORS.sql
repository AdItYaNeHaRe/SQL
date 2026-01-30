-- =====================================================
-- SQL RANGE OPERATORS - Complete Reference with Examples
-- =====================================================

-- ENGLISH EXPLANATION FOR RANGE OPERATORS

-- Range operators test if values fall within specified ranges (inclusive).

-- 1. BETWEEN - TRUE if value is within range (inclusive of both ends)
-- SELECT * FROM Employees WHERE salary BETWEEN 50000 AND 70000;
-- Returns employees with salary from 50000 to 70000 (both 50000 & 70000 included).

-- 2. NOT BETWEEN - TRUE if value is outside the range
-- SELECT * FROM Employees WHERE salary NOT BETWEEN 50000 AND 70000;
-- Returns employees with salary < 50000 OR salary > 70000.

-- Complete example with sample data:
-- Sample data: Employees (id, name, salary)
-- (1, 'Rahul', 45000), (2, 'Priya', 55000), (3, 'Amit', 65000), (4, 'Neha', 85000)

-- BETWEEN example:
SELECT * FROM Employees WHERE salary BETWEEN 50000 AND 70000;
-- Result: rows 2, 3 (Priya:55000, Amit:65000)

-- NOT BETWEEN example:
SELECT * FROM Employees WHERE salary NOT BETWEEN 50000 AND 70000;
-- Result: rows 1, 4 (Rahul:45000, Neha:85000)

-- Date range example:
SELECT * FROM Orders WHERE order_date BETWEEN '2025-01-01' AND '2025-12-31';
-- All orders from entire year 2025 (inclusive).

-- String range example:
SELECT * FROM Employees WHERE name BETWEEN 'A' AND 'M';
-- Names starting from A to M alphabetically.


-- HINGLISH EXPLANATION FOR RANGE OPERATORS

-- Range operators check karte hain ki value range ke andar hai ya bahar.

-- 1. BETWEEN - value range ke ANDAR ho ( dono ends INCLUDE hote hain )
-- SELECT * FROM Employees WHERE salary BETWEEN 50000 AND 70000;
-- Matlab: salary 50k SE 70k TAK (50k aur 70k dono include).

-- 2. NOT BETWEEN - value range ke BAHAR ho
-- SELECT * FROM Employees WHERE salary NOT BETWEEN 50000 AND 70000;
-- Matlab: salary 50k SE KAM ya 70k SE ZYADA.

-- Sample data ke saath examples:
-- Sample: (Rahul:45000), (Priya:55000), (Amit:65000), (Neha:85000)

-- BETWEEN 50k-70k → Priya(55k), Amit(65k)
-- NOT BETWEEN 50k-70k → Rahul(45k), Neha(85k)

-- Date range (Hinglish):
SELECT * FROM Orders WHERE order_date BETWEEN '2025-01-01' AND '2025-03-31';
-- Matlab: January se March 2025 tak ke orders (dono dates include).

-- String range (Hinglish):
SELECT * FROM Employees WHERE name BETWEEN 'A' AND 'M';
-- Matlab: naam A se M tak alphabetically (Amit aayega, Rahul nahi).

-- ⚠️ Important Rule (Hinglish):
-- BETWEEN HAMESHA INCLUSIVE hota hai:
-- 50 BETWEEN 40 AND 60 → TRUE (50 >= 40 AND 50 <= 60)
-- NOT BETWEEN → 50 NOT BETWEEN 40 AND 60 → FALSE

-- Quick Equivalent (Hinglish):
-- salary BETWEEN 50k AND 70k  =  salary >= 50k AND salary <= 70k
-- salary NOT BETWEEN 50k AND 70k = salary < 50k OR salary > 70k
