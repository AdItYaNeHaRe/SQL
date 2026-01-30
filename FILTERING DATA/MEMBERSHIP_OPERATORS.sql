-- =====================================================
-- SQL MEMBERSHIP OPERATORS - Complete Reference with Examples
-- =====================================================

-- ENGLISH EXPLANATION FOR MEMBERSHIP OPERATORS

-- Membership operators check if a value exists in a list or subquery result.

-- 1. IN - TRUE if value matches ANY value in the list/subquery
-- SELECT * FROM Employees WHERE department IN ('IT', 'HR', 'Finance');
-- Returns employees from IT, HR, or Finance departments.

-- 2. NOT IN - TRUE if value matches NONE of the values in the list
-- SELECT * FROM Employees WHERE department NOT IN ('Sales', 'Marketing');
-- Returns employees from ALL departments EXCEPT Sales and Marketing.

-- 3. EXISTS - TRUE if subquery returns at least one row
-- SELECT * FROM Employees e
-- WHERE EXISTS (SELECT 1 FROM Departments d WHERE d.id = e.dept_id);
-- Returns employees whose department exists in Departments table.

-- Complete example with sample data:
-- Sample data: Employees (id, name, dept)
-- (1, 'Rahul', 'IT'), (2, 'Priya', 'HR'), (3, 'Amit', 'Sales'), (4, 'Neha', 'IT')

-- IN example:
SELECT * FROM Employees WHERE dept IN ('IT', 'HR');
-- Result: rows 1, 2, 4 (Rahul, Priya, Neha)

-- NOT IN example:
SELECT * FROM Employees WHERE dept NOT IN ('Sales', 'Marketing');
-- Result: rows 1, 2, 4 (everyone except Amit)

-- Subquery IN example:
SELECT * FROM Employees e
WHERE e.dept IN (SELECT dept_name FROM ActiveDepts);
-- Only employees from active departments.


-- HINGLISH EXPLANATION FOR MEMBERSHIP OPERATORS

-- Membership operators check karte hain ki value list mein hai ya nahi.

-- 1. IN - value LIST mein SE KISI EK se match kare
-- SELECT * FROM Employees WHERE department IN ('IT', 'HR', 'Finance');
-- Matlab: IT YA HR YA Finance department wale employees.

-- 2. NOT IN - value list mein SE KISI SE BHI match NA kare
-- SELECT * FROM Employees WHERE department NOT IN ('Sales', 'Marketing');
-- Matlab: Sales aur Marketing WALE KO CHHODKE sab departments.

-- 3. EXISTS - subquery mein KUCH BHI mile to TRUE
-- SELECT * FROM Employees e
-- WHERE EXISTS (SELECT 1 FROM Departments d WHERE d.id = e.dept_id);
-- Matlab: sirf un employees ko lao jinka department Departments table mein exist karta hai.

-- Sample data ke saath examples:
-- Sample: Rahul(IT), Priya(HR), Amit(Sales), Neha(IT)

-- IN ('IT','HR') → Rahul, Priya, Neha
-- NOT IN ('Sales') → Rahul, Priya, Neha
-- EXISTS (subquery) → sirf valid departments wale

-- ⚠️ NULL Trap (bahut important):
-- IN mein NULL ho to unexpected results:
SELECT * FROM Employees WHERE dept IN ('IT', NULL);  -- Kabhi bhi mat karo!
-- Sahi way:
SELECT * FROM Employees WHERE dept IN ('IT') OR dept IS NULL;

-- Quick Equivalent (Hinglish):
-- dept IN ('IT', 'HR')     =  dept = 'IT' OR dept = 'HR'
-- dept NOT IN ('Sales')    =  dept <> 'Sales' AND dept IS NOT NULL
