-- =====================================================
-- SQL LOGICAL OPERATORS - Complete Reference with Examples
-- =====================================================

-- ENGLISH EXPLANATION FOR LOGICAL OPERATORS

-- Logical operators combine multiple conditions in WHERE, HAVING clauses.

-- 1. AND - TRUE only when ALL conditions are TRUE
-- SELECT * FROM Employees WHERE salary > 50000 AND department = 'IT';
-- Returns employees who have salary > 50000 AND work in IT department.

-- 2. OR - TRUE when ANY ONE condition is TRUE
-- SELECT * FROM Employees WHERE department = 'IT' OR department = 'HR';
-- Returns employees from IT OR HR department.

-- 3. NOT - Reverses the result (TRUE becomes FALSE, FALSE becomes TRUE)
-- SELECT * FROM Employees WHERE NOT department = 'Sales';
-- Returns employees from ALL departments EXCEPT Sales.

-- Complete example with sample data:
-- Sample data: Employees table (id, name, salary, dept)
-- (1, 'Rahul', 60000, 'IT'), (2, 'Priya', 45000, 'HR'),
-- (3, 'Amit', 70000, 'IT'), (4, 'Neha', 30000, 'Sales')

-- AND example:
SELECT * FROM Employees WHERE salary > 50000 AND dept = 'IT';
-- Result: rows 1, 3 (Rahul, Amit)

-- OR example:
SELECT * FROM Employees WHERE dept = 'IT' OR salary > 60000;
-- Result: rows 1, 3, 4 (Rahul, Amit, Neha)

-- NOT example:
SELECT * FROM Employees WHERE NOT dept = 'Sales';
-- Result: rows 1, 2, 3 (everyone except Neha)

-- Complex combination:
SELECT * FROM Employees
WHERE (salary > 50000 AND dept = 'IT')
   OR (salary < 40000 AND dept = 'HR');
-- Rahul (IT+high salary), Priya (HR+low salary)


-- HINGLISH EXPLANATION FOR LOGICAL OPERATORS

-- Logical operators multiple conditions ko combine karte hain WHERE mein.

-- 1. AND - TABHI TRUE jab SAARI conditions TRUE hon
-- SELECT * FROM Employees WHERE salary > 50000 AND department = 'IT';
-- Matlab: salary 50k se zyada HO HI aur dept IT HO HI chahiye.

-- 2. OR - KISI EK condition TRUE ho to TRUE
-- SELECT * FROM Employees WHERE department = 'IT' OR department = 'HR';
-- Matlab: ya to IT mein ho YA HR mein ho.

-- 3. NOT - Result ko ulta kar deta hai
-- SELECT * FROM Employees WHERE NOT department = 'Sales';
-- Matlab: Sales department WALE KO CHHODKE sabko lao.

-- Sample data ke saath examples:
-- AND → Dono conditions pass karni padti hain (salary > 50k AUR IT dept)
-- OR  → Ek bhi condition pass ho to chalega (IT YA high salary)
-- NOT → Jo condition FALSE hai usko TRUE bana deta hai

-- Bracket usage (bahut important):
-- SELECT * FROM Employees
-- WHERE salary > 50000 AND dept = 'IT' OR salary < 40000;
-- Ye galat hai! Priority issue.

-- Sahi way:
-- SELECT * FROM Employees
-- WHERE (salary > 50000 AND dept = 'IT') OR salary < 40000;
-- Brackets se clear karo ki kaun sa group saath mein evaluate hoga.

-- Priority Rule (Hinglish):
-- NOT > AND > OR
-- Brackets hamesha use karo complex conditions mein!
