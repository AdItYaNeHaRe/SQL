ALTER TABLE employees
ADD Gender VARCHAR(10) NOT NULL DEFAULT 'Male';

ALTER TABLE employees
MODIFY COLUMN Email VARCHAR(150) UNIQUE;

ALTER TABLE employees
DROP COLUMN Age;
-- ENGLISH EXPLANATION FOR DDL `ALTER TABLE`

-- ALTER TABLE is a DDL command used to modify the structure of an existing table.
-- Common operations: ADD column, DROP column, MODIFY column datatype, ADD/DROP constraints,
-- RENAME column/table. [web:91][web:92]

-- Basic syntax patterns:

-- 1. ADD COLUMN:
-- ALTER TABLE table_name
-- ADD column_name datatype [constraints];

-- 2. DROP COLUMN:
-- ALTER TABLE table_name
-- DROP COLUMN column_name;

-- 3. MODIFY COLUMN (syntax varies by DBMS):
-- ALTER TABLE table_name
-- ALTER COLUMN column_name new_datatype;    -- SQL Server
-- ALTER TABLE table_name
-- MODIFY COLUMN column_name new_datatype;   -- MySQL/Oracle [web:91][web:96]

-- Example 1: Add phone column to Students
-- ALTER TABLE Students
-- ADD phone VARCHAR(15);

-- Example 2: Increase email size
-- ALTER TABLE Students
-- ALTER COLUMN email VARCHAR(150);     -- SQL Server style [web:91]

-- Example 3: Drop age column
-- ALTER TABLE Students
-- DROP COLUMN age;

-- Example 4: Add primary key constraint
-- ALTER TABLE Students
-- ADD CONSTRAINT PK_Students PRIMARY KEY (student_id);


-- HINGLISH EXPLANATION FOR DDL `ALTER TABLE`

-- ALTER TABLE DDL command hai jo existing table ki structure ko modify karta hai.
-- Main kaam: column add karna, column delete karna, datatype change karna,
-- constraints add/remove karna, column/table rename karna. [web:91][web:92]

-- Basic syntax (Hinglish samjhaav):

-- 1. Naya column add karna:
-- ALTER TABLE table_name
-- ADD column_name datatype [constraints];

-- 2. Column hatana:
-- ALTER TABLE table_name
-- DROP COLUMN column_name;

-- 3. Column ka datatype change karna (DBMS ke hisaab se thoda alag):
-- ALTER TABLE table_name
-- ALTER COLUMN column_name new_datatype;    -- SQL Server
-- ALTER TABLE table_name
-- MODIFY COLUMN column_name new_datatype;   -- MySQL [web:91][web:96]

-- Example 1: Students table mein phone column add karna
-- ALTER TABLE Students
-- ADD phone VARCHAR(15);

-- Example 2: Email column ka size badhana
-- ALTER TABLE Students
-- MODIFY COLUMN email VARCHAR(150);     -- MySQL style [web:96]

-- Example 3: Age column hatana
-- ALTER TABLE Students
-- DROP COLUMN age;

-- Example 4: Primary key constraint add karna
-- ALTER TABLE Students
-- ADD CONSTRAINT PK_Students PRIMARY KEY (student_id);

-- Important note (Hinglish):
-- - Syntax thoda DBMS ke hisaab se alag hota hai (SQL Server, MySQL, PostgreSQL).
-- - Large tables par ALTER operations slow ho sakte hain kyunki table lock ho jaata hai. [web:91][web:93]
