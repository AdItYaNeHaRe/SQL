SELECT DISTINCT country FROM customers;

-- ENGLISH EXPLANATION FOR `DISTINCT`

-- DISTINCT is used with SELECT to return only unique (non-duplicate) rows in the result.
-- It removes duplicate values so each combination of selected columns appears only once.

-- Basic syntax:
-- SELECT DISTINCT column1, column2, ...
-- FROM table_name;

-- Meaning of parts:
-- DISTINCT → tells SQL to keep only unique rows based on the listed columns.
-- column1, column2, ... → columns whose unique combinations you want.

-- Example 1: unique departments
-- SELECT DISTINCT Department
-- FROM Employees;
-- This returns each department name only once, even if many employees share it.

-- Example 2: unique combinations of department and role
-- SELECT DISTINCT Department, Role
-- FROM Employees;
-- This returns one row per unique (Department, Role) pair.


-- HINGLISH EXPLANATION FOR `DISTINCT`

-- DISTINCT ko SELECT ke saath use karte hain taaki result mein sirf unique
-- (non-duplicate) rows aayein.
-- Ye duplicate values hata deta hai, aur har combination sirf ek baar dikhata hai.

-- Basic syntax (Hinglish samjhaav):
-- SELECT DISTINCT column1, column2, ...
-- FROM table_name;

-- Yahan:
-- DISTINCT → SQL ko bolta hai ki sirf unique rows rakho.
-- column1, column2, ... → jin columns ke basis par uniqueness check karni hai.

-- Example 1: unique departments nikalna
-- SELECT DISTINCT Department
-- FROM Employees;
-- Iska matlab: Employees table se har Department sirf ek baar dikhana,
-- chahe us department mein kitne bhi employees ho.

-- Example 2: Department + Role ka unique combination
-- SELECT DISTINCT Department, Role
-- FROM Employees;
-- Iska matlab: har unique (Department, Role) pair sirf ek row ke form mein dikhana.
