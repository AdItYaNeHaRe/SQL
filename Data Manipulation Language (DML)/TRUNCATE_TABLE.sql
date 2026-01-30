TRUNCATE TABLE customers;

-- ENGLISH EXPLANATION FOR `TRUNCATE TABLE Table_name`

-- TRUNCATE TABLE is a DDL command that removes ALL rows from a table instantly
-- while keeping the table structure, indexes, and constraints intact.
-- It's much faster than DELETE for large tables as it doesn't log individual row deletions.

-- Basic syntax:
-- TRUNCATE TABLE Table_name;

-- Example:
-- TRUNCATE TABLE Employees;
-- This empties the entire Employees table but keeps its structure for future use.

-- Key characteristics:
-- - DDL command (auto-commits in most databases)
-- - Cannot use WHERE clause (deletes ALL rows)
-- - Resets auto-increment counters to 1
-- - Faster than DELETE for large tables
-- - Cannot truncate tables with foreign key references


-- HINGLISH EXPLANATION FOR `TRUNCATE TABLE Table_name`

-- TRUNCATE TABLE ek DDL command hai jo table se saari rows turant hata deta hai
-- lekin table ka structure, indexes aur constraints waisa hi rakhta hai.
-- Large tables ke liye DELETE se kahi zyada fast hai kyunki har row ka log nahi banata.

-- Basic syntax:
-- TRUNCATE TABLE Table_name;

-- Example (Hinglish):
-- TRUNCATE TABLE Employees;
-- Matlab: Employees table ka saara data hatado lekin table ka structure rakho.

-- Key points (Hinglish):
-- - DDL command hai (auto-commit hota hai zyadatar databases mein)
-- - WHERE clause nahi laga sakte (saari rows hi delete hongi)
-- - Auto-increment counter reset ho jaata hai (1 se shuru)
-- - Large tables ke liye DELETE se bohot fast
-- - Foreign key wale tables ko truncate nahi kar sakte

-- TRUNCATE vs DELETE vs DROP Quick Comparison:
-- TRUNCATE TABLE → Data gone, structure remains, fastest
-- DELETE FROM → Data gone, structure remains, slower (logs each row)
-- DROP TABLE → Everything gone (structure + data), permanent
