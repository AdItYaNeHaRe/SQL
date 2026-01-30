UPDATE customers
SET score = 95
WHERE id = 11;

UPDATE customers
SET score = 100
WHERE score IS NULL;

-- ENGLISH EXPLANATION FOR `UPDATE Table_Name SET column1 = value1, column2 = value2 ...`

-- The UPDATE statement is a DML command used to modify existing rows in a table. [web:11][web:13]
-- It changes the values of one or more columns for the rows that match an optional WHERE condition. [web:12][web:15]

-- General syntax:
-- UPDATE Table_Name
-- SET column1 = value1,
--     column2 = value2,
--     ...
-- WHERE condition;      -- optional but VERY important. [web:11][web:17]

-- Parts:
-- Table_Name  → name of the table whose data you want to change. [web:12][web:15]
-- SET         → lists columns and their new values.
-- WHERE       → specifies which rows to update; without it, ALL rows are updated. [web:11][web:17]

-- Example 1: update single row, multiple columns
-- UPDATE Employees
-- SET Salary = 65000,
--     City   = 'Hyderabad'
-- WHERE EmpID = 1;
-- This changes Salary and City only for the employee whose EmpID is 1. [web:12][web:15]

-- Example 2: update multiple rows
-- UPDATE Employees
-- SET City = 'Delhi'
-- WHERE Country = 'India';
-- All employees having Country = 'India' will now have City = 'Delhi'. [web:13][web:17]

-- ⚠️ WARNING:
-- If you write:
-- UPDATE Employees
-- SET Salary = 0;
-- and omit WHERE, Salary for ALL employees becomes 0. [web:11][web:16]


-- HINGLISH EXPLANATION FOR `UPDATE Table_Name SET column1 = value1, column2 = value2 ...`

-- UPDATE ek DML statement hai jo existing rows ka data change karne ke kaam aata hai. [web:13][web:15]
-- Isse tum ek ya multiple columns ke values update kar sakte ho un rows ke liye
-- jo WHERE condition ko satisfy karte hain. [web:12][web:17]

-- General syntax (Hinglish samjhaav):
-- UPDATE Table_Name
-- SET column1 = value1,
--     column2 = value2,
--     ...
-- WHERE condition;      -- WHERE bahut important hai. [web:11][web:17]

-- Yahan:
-- Table_Name  → jis table ke data ko update karna hai. [web:12][web:15]
-- SET         → kaun se columns ko kis new value se update karna hai.
-- WHERE       → kin rows par ye update apply hoga; agar ye hata diya to saari rows change ho jayengi. [web:11][web:17]

-- Example 1 (Hinglish): ek employee ka salary aur city change karna
-- UPDATE Employees
-- SET Salary = 65000,
--     City   = 'Hyderabad'
-- WHERE EmpID = 1;
-- Matlab: sirf EmpID = 1 wale employee ka Salary aur City update hoga. [web:12][web:15]

-- Example 2 (Hinglish): multiple rows update karna
-- UPDATE Employees
-- SET City = 'Delhi'
-- WHERE Country = 'India';
-- Jitne bhi employees ka Country 'India' hai, sabki City 'Delhi' ho jayegi. [web:13][web:17]

-- ⚠️ Important note (Hinglish):
-- - WHERE bhool gaye to poori table update ho jaayegi.
-- - Pehle hamesha WHERE ke saath SELECT run karke check karo ki kaun‑kaun si rows affect hongi. [web:11][web:16]
