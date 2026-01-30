DELETE FROM customers
WHERE id = 11;


DELETE FROM customers
WHERE id > 6;



-- ENGLISH EXPLANATION FOR `DELETE FROM Table_Name WHERE <conditions>`

-- The DELETE statement is a DML command used to remove existing rows from a table. [web:21][web:25]
-- The WHERE clause controls which rows are deleted; without WHERE, ALL rows in the table are removed. [web:22][web:26]

-- General syntax:
-- DELETE FROM Table_Name
-- WHERE <conditions>;

-- Parts:
-- Table_Name   → the table from which rows will be deleted. [web:25]
-- WHERE clause → condition that decides which rows to delete (e.g., id = 5). [web:22][web:28]

-- Example 1: delete a single row
-- DELETE FROM Employees
-- WHERE EmployeeID = 5;
-- This removes only the row where EmployeeID is 5. [web:22][web:25]

-- Example 2: delete multiple rows
-- DELETE FROM Employees
-- WHERE Department = 'Sales';
-- All employees in the Sales department will be deleted. [web:25][web:28]

-- Example 3: delete ALL rows (be careful!)
-- DELETE FROM Employees;
-- This empties the Employees table but keeps its structure. [web:22][web:28]


-- HINGLISH EXPLANATION FOR `DELETE FROM Table_Name WHERE <conditions>`

-- DELETE ek DML statement hai jo table se existing rows ko remove karne ke kaam aata hai. [web:21][web:25]
-- WHERE clause batata hai kaun‑kaun si rows delete hongi; agar WHERE hata doge
-- to poori table ki saari rows delete ho jaayengi. [web:22][web:26]

-- General syntax (Hinglish samjhaav):
-- DELETE FROM Table_Name
-- WHERE <conditions>;

-- Yahan:
-- Table_Name   → jis table se rows delete karni hain. [web:25]
-- WHERE        → condition jiske basis par rows delete hongi, jaise id = 5, age > 30, etc. [web:22][web:28]

-- Example 1 (single row):
-- DELETE FROM Employees
-- WHERE EmployeeID = 5;
-- Matlab: sirf EmployeeID = 5 wali row delete ho jaayegi. [web:22][web:25]

-- Example 2 (multiple rows):
-- DELETE FROM Employees
-- WHERE Department = 'Sales';
-- Jitne bhi employees Sales department mein hain, sab delete ho jaayenge. [web:25][web:28]

-- Example 3 (saari rows delete karna – risky):
-- DELETE FROM Employees;
-- Isse Employees table ka saara data udd jaata hai, lekin table ka structure rehta hai. [web:22][web:28]

-- ⚠️ Important (Hinglish):
-- - WHERE lagana bhool gaye to poori table wipe ho sakti hai.
-- - Pehle SELECT ke saath WHERE condition test karlo:
--   SELECT * FROM Employees WHERE Department = 'Sales';
--   phir same WHERE ke saath DELETE chalao. [web:24][web:26]
