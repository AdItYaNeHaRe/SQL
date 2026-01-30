DROP TABLE IF EXISTS Employees;

-- ENGLISH EXPLANATION FOR DDL `DROP TABLE`

-- DROP TABLE is a DDL command that completely removes a table from the database,
-- including its structure, data, indexes, constraints, and triggers. [web:101][web:103]
-- Once dropped, the table is permanently deleted and cannot be recovered without backups. [web:102][web:105]

-- Basic syntax:
-- DROP TABLE table_name;
-- DROP TABLE IF EXISTS table_name;    -- Safe version, no error if table doesn't exist. [web:101][web:102]

-- Example 1: Drop single table
-- DROP TABLE Students;
-- This permanently deletes the Students table and all its data. [web:101][web:103]

-- Example 2: Drop multiple tables
-- DROP TABLE Students, Orders, Courses;
-- This deletes all three tables at once (supported in MySQL). [web:106]

-- Example 3: Safe drop (recommended)
-- DROP TABLE IF EXISTS TempTable;
-- No error if TempTable doesn't exist. [web:102][web:108]


-- HINGLISH EXPLANATION FOR DDL `DROP TABLE`

-- DROP TABLE DDL command hai jo database se table ko completely hata deta hai -
-- structure, data, indexes, constraints, sab kuch permanently delete ho jaata hai. [web:101][web:103]
-- Ek baar drop kar diya to backup na ho to recover nahi kar sakte. [web:102][web:105]

-- Basic syntax (Hinglish samjhaav):
-- DROP TABLE table_name;                          -- normal drop
-- DROP TABLE IF EXISTS table_name;                -- safe drop, error nahi aayega agar table nahi hai. [web:101][web:102]

-- Example 1: Ek table drop karna
-- DROP TABLE Students;
-- Students table aur uska saara data permanently gayab! [web:101][web:103]

-- Example 2: Multiple tables drop karna
-- DROP TABLE Students, Orders, Courses;
-- Teeno tables ek saath delete (MySQL mein supported). [web:106]

-- Example 3: Safe approach (hamesha use karo)
-- DROP TABLE IF EXISTS TempTable;
-- Agar TempTable exist nahi karta to bhi koi error nahi aayega. [web:102][web:108]

-- ⚠️ WARNING (Hinglish):
-- - DROP TABLE = PERMANENT DELETE (TRUNCATE sirf data hatata hai, structure rehta hai)
-- - Hamesha backup lo pehle!
-- - Production mein IF EXISTS use karo safety ke liye. [web:101][web:109]
