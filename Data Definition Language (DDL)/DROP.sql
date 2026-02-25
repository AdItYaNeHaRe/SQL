/*
=================================================================
QUERY PURPOSE: Safely delete/remove an entire table from the database
=================================================================

CONCEPT EXPLANATION (English):
DROP TABLE is a DDL (Data Definition Language) command that completely
removes a table from the database. This includes:
- The table structure (all column definitions)
- ALL data stored in the table (every single row)
- All associated indexes
- All constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK)
- All triggers associated with the table

The "IF EXISTS" clause makes this operation conditional - it only drops
the table if it exists, preventing errors if the table doesn't exist.

This is a DESTRUCTIVE operation - once executed, the table and all its
data are PERMANENTLY deleted (unless you have backups).

CONCEPT EXPLANATION (Hinglish):
DROP TABLE ek DDL (Data Definition Language) command hai jo table ko
database se completely remove kar deta hai. Isme include hota hai:
- Table structure (saare column definitions)
- SAARA data jo table mein store hai (har ek row)
- Saare indexes
- Saare constraints (PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK)
- Saare triggers jo table se associated hain

"IF EXISTS" clause yeh operation ko conditional banata hai - yeh table
ko sirf tab drop karega jab woh exist karti ho, warna error nahi aayega
agar table exist hi nahi karti.

Yeh ek DESTRUCTIVE operation hai - execute hone ke baad table aur uska
saara data PERMANENTLY delete ho jata hai (jab tak backup na ho).

USE CASES:
- Database cleanup: Removing obsolete or temporary tables
- Schema redesign: Dropping old tables before creating new structure
- Testing/Development: Resetting test database to clean state
- Data migration: Removing old tables after successful migration
- Deployment scripts: Ensuring clean slate before creating tables
- Removing duplicate/backup tables that are no longer needed
- Decommissioning features: Removing tables for retired functionality
- Emergency situations: Removing corrupted tables
- CI/CD pipelines: Cleaning up test environments between runs
- Development workflow: Recreating tables with new schema

SPECIFIC QUERY BREAKDOWN:

Line 1: DROP TABLE IF EXISTS Employees;

DROP TABLE: Command to delete table
  → DROP: SQL keyword for removing database objects
  → TABLE: Specifies we're dropping a table (not view, database, etc.)
  → Permanently removes the table and ALL its data

IF EXISTS: Conditional clause (optional but recommended)
  → IF EXISTS: Only drop if table exists
  → Prevents error if table doesn't exist
  → Makes script rerunnable/idempotent
  → Without this: Error occurs if table doesn't exist
  → With this: No error, script continues smoothly

Employees: Name of table to drop
  → The specific table being deleted
  → Case-sensitive in some databases (Linux-based MySQL, PostgreSQL)
  → Case-insensitive in others (Windows MySQL, SQL Server)

; : Statement terminator
  → Marks end of SQL statement

WHAT HAPPENS STEP-BY-STEP:

Before execution:
Database contains:
- Employees table with structure
- 1000 rows of employee data
- Indexes on EmployeeID, Email
- Foreign keys from Orders table
- Triggers for audit logging

Execution process:
1. Database checks: Does "Employees" table exist?

   If YES:
   - Checks for dependent objects (foreign keys from other tables)
   - If foreign keys exist → ERROR (must drop foreign keys first)
   - If no dependencies → Proceeds to drop
   - Removes all indexes
   - Removes all constraints
   - Removes all triggers
   - Deletes all data (1000 rows gone)
   - Removes table definition
   - Frees up disk space
   - Returns: "Query OK, 0 rows affected"

   If NO:
   - With IF EXISTS: Silently continues, no error
   - Without IF EXISTS: Returns ERROR "Table doesn't exist"

After execution:
- Employees table: GONE (doesn't exist anymore)
- All employee data: LOST PERMANENTLY
- Queries referencing Employees: WILL FAIL
- Application code using Employees: WILL CRASH

COMPARISON: DROP vs DELETE vs TRUNCATE

DROP TABLE Employees;
- Removes entire table structure AND data
- Cannot be rolled back (auto-commits)
- Frees disk space immediately
- Fast operation
- Table no longer exists
- Use when: Removing table permanently

DELETE FROM Employees;
- Removes only data, keeps table structure
- Can be rolled back (within transaction)
- Does NOT free disk space immediately
- Slower (logs each row deletion)
- Table still exists (empty)
- WHERE clause can filter rows
- Use when: Removing some/all data but keeping table

TRUNCATE TABLE Employees;
- Removes all data, keeps table structure
- Cannot be rolled back (usually)
- Frees disk space immediately
- Very fast (doesn't log individual rows)
- Table still exists (empty)
- Cannot use WHERE clause
- Resets AUTO_INCREMENT counter
- Use when: Quickly emptying entire table

Visual Comparison:
                  DROP          DELETE        TRUNCATE
Structure      ✗ Removed    ✓ Kept        ✓ Kept
Data           ✗ Removed    ✗ Removed     ✗ Removed
Rollback       ✗ No         ✓ Yes         ✗ No (usually)
Speed          ⚡ Fast       🐢 Slow        ⚡ Very Fast
Disk Space     ✓ Freed      ✗ Not freed   ✓ Freed
WHERE clause   ✗ No         ✓ Yes         ✗ No
Auto Reset     N/A          ✗ No          ✓ Yes

EXAMPLES:

Example 1: Basic DROP TABLE
*/
DROP TABLE Employees;
-- Drops table, ERROR if doesn't exist

-- Example 2: Safe DROP with IF EXISTS (RECOMMENDED)
DROP TABLE IF EXISTS Employees;
-- No error if table doesn't exist, script continues

-- Example 3: Drop multiple tables at once
DROP TABLE IF EXISTS Employees, Departments, Projects;
-- Drops all three tables (if they exist)

-- Example 4: Drop temporary table
DROP TEMPORARY TABLE IF EXISTS temp_calculations;
-- Specifically for temporary tables

-- Example 5: Common pattern in deployment scripts
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE
);
-- Ensures fresh table creation

-- Example 6: Dropping related tables in correct order (Foreign Keys)
-- WRONG ORDER (will fail):
DROP TABLE IF EXISTS Departments;  -- ❌ Referenced by Employees
DROP TABLE IF EXISTS Employees;

-- CORRECT ORDER:
DROP TABLE IF EXISTS Employees;     -- ✓ Drop child table first
DROP TABLE IF EXISTS Departments;   -- ✓ Then drop parent table

-- Example 7: Force drop with CASCADE (PostgreSQL)
DROP TABLE IF EXISTS Departments CASCADE;
-- Automatically drops dependent objects (views, foreign keys, etc.)

-- Example 8: Drop table and backup first
CREATE TABLE Employees_backup_20240226 AS SELECT * FROM Employees;
DROP TABLE IF EXISTS Employees;
-- Backup created before dropping

-- Example 9: Drop only if empty (safeguard)
DROP TABLE IF EXISTS Employees
WHERE (SELECT COUNT(*) FROM Employees) = 0;
-- ⚠️ Note: This syntax doesn't work in most databases
-- Instead use:
DO $$
BEGIN
    IF (SELECT COUNT(*) FROM Employees) = 0 THEN
        DROP TABLE Employees;
    END IF;
END $$;

-- Example 10: Drop with transaction (some databases)
START TRANSACTION;
DROP TABLE IF EXISTS temp_data;
-- Can rollback if needed
ROLLBACK;  -- Or COMMIT;

/*
REAL-WORLD SCENARIOS:

Scenario 1: Development workflow
*/
-- Developer creates test table, uses it, then cleans up
CREATE TABLE test_employees AS SELECT * FROM Employees WHERE DepartmentID = 5;
-- ... run tests ...
DROP TABLE IF EXISTS test_employees;  -- Cleanup

/*
Scenario 2: Database migration script
*/
-- Version 2.0 of application removes old tables
DROP TABLE IF EXISTS old_employee_records;
DROP TABLE IF EXISTS deprecated_timesheets;
DROP TABLE IF EXISTS legacy_payroll;
-- Remove tables from previous version

/*
Scenario 3: Recreating table with new structure
*/
-- Save data first
CREATE TABLE Employees_temp AS SELECT * FROM Employees;

-- Drop and recreate with new structure
DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,  -- Increased size
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(200) UNIQUE,
    Gender VARCHAR(10),               -- New column
    DateOfBirth DATE                  -- New column
);

-- Migrate data back
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email)
SELECT EmployeeID, FirstName, LastName, Email FROM Employees_temp;

-- Cleanup
DROP TABLE IF EXISTS Employees_temp;

/*
Scenario 4: Handling foreign key dependencies
*/
-- Complex scenario with relationships:
-- Orders table references Employees table

-- Step 1: Drop foreign key constraint first
ALTER TABLE Orders DROP FOREIGN KEY FK_Employee;

-- Step 2: Now safe to drop Employees table
DROP TABLE IF EXISTS Employees;

-- Alternative: Drop in reverse dependency order
DROP TABLE IF EXISTS Orders;      -- Child table
DROP TABLE IF EXISTS Employees;   -- Parent table

/*
Scenario 5: CI/CD automated testing
*/
-- test_setup.sql (runs before tests)
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
CREATE TABLE Employees (...);
CREATE TABLE Departments (...);
INSERT INTO Employees VALUES (...);  -- Test data
-- Run tests...
-- test_cleanup.sql (runs after tests)
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

/*
SAFETY CHECKLIST BEFORE DROPPING TABLES:

1. ✓ Backup the data:
*/
-- Method 1: Create backup table
CREATE TABLE Employees_backup AS SELECT * FROM Employees;

-- Method 2: Export to file
mysqldump -u username -p database_name Employees > employees_backup.sql

-- Method 3: Export to CSV
SELECT * INTO OUTFILE '/tmp/employees_backup.csv'
FIELDS TERMINATED BY ','
FROM Employees;

/*
2. ✓ Check for dependent objects:
*/
-- Check foreign keys referencing this table
SELECT
    TABLE_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_NAME = 'Employees';

-- Check views using this table
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.VIEWS
WHERE VIEW_DEFINITION LIKE '%Employees%';

-- Check stored procedures using this table
SELECT ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_DEFINITION LIKE '%Employees%';

/*
3. ✓ Verify in development first:
*/
-- Test in dev environment
USE development_db;
DROP TABLE IF EXISTS Employees;
-- If successful, then production

/*
4. ✓ Communicate with team:
*/
-- Schedule maintenance window
-- Notify stakeholders
-- Update documentation

/*
5. ✓ Check application dependencies:
*/
-- Search codebase for references to 'Employees' table
-- Update all queries, ORM models, API endpoints
-- Deploy code changes BEFORE dropping table

/*
COMMON MISTAKES TO AVOID:

1. ❌ Dropping table without backup:
*/
DROP TABLE Employees;  -- ❌ No backup = data loss disaster!

-- ✓ Correct:
CREATE TABLE Employees_backup AS SELECT * FROM Employees;
DROP TABLE IF EXISTS Employees;

/*
2. ❌ Dropping parent table before child table:
*/
DROP TABLE Departments;  -- ❌ Has foreign keys from Employees
DROP TABLE Employees;

-- ✓ Correct order:
DROP TABLE IF EXISTS Employees;     -- Child first
DROP TABLE IF EXISTS Departments;   -- Parent second

/*
3. ❌ Not using IF EXISTS in scripts:
*/
DROP TABLE Employees;  -- ❌ Script fails on second run

-- ✓ Correct:
DROP TABLE IF EXISTS Employees;  -- ✓ Rerunnable script

/*
4. ❌ Dropping production table accidentally:
*/
-- Connected to production database
DROP TABLE Employees;  -- ❌ DISASTER!

-- ✓ Correct: Always verify database
SELECT DATABASE();  -- Check which database you're in!
USE development_db;  -- Switch to correct database
DROP TABLE IF EXISTS Employees;

/*
5. ❌ Not checking application dependencies:
*/
DROP TABLE UserSessions;  -- ❌ App crashes because code expects this table

-- ✓ Correct:
-- 1. Update application code to not use UserSessions
-- 2. Deploy new code
-- 3. Wait for cache clear/sessions expire
-- 4. Then drop table

/*
6. ❌ Confusing DROP with DELETE:
*/
DELETE Employees;  -- ❌ Wrong syntax, removes data but keeps table
DROP TABLE Employees;  -- ✓ Removes entire table

/*
PERMISSION REQUIREMENTS:

To execute DROP TABLE, you need:
- DROP privilege on the table
- Or DROP privilege on the database
- Or ALTER privilege on the database
- Or ALL PRIVILEGES

Check your privileges:
*/
SHOW GRANTS FOR CURRENT_USER;

-- Grant DROP privilege:
GRANT DROP ON database_name.Employees TO 'username'@'localhost';

/*
RECOVERY OPTIONS (if dropped accidentally):

1. From backup:
*/
-- Restore from mysqldump
mysql -u username -p database_name < employees_backup.sql

-- Or restore from backup table
CREATE TABLE Employees AS SELECT * FROM Employees_backup;

/*
2. From binary logs (MySQL):
*/
-- Use mysqlbinlog to find and replay transactions
mysqlbinlog binlog.000001 | mysql -u root -p database_name

/*
3. From transaction log (if DROP was in transaction and not committed):
*/
START TRANSACTION;
DROP TABLE Employees;
-- Oh no, mistake!
ROLLBACK;  -- ⚠️ This WON'T work - DROP auto-commits!

-- DDL statements (CREATE, DROP, ALTER) auto-commit in most databases

/*
4. From storage snapshots (cloud databases):
*/
-- AWS RDS: Restore from automated snapshot
-- Azure SQL: Point-in-time restore
-- Google Cloud SQL: Restore from backup

/*
DATABASE-SPECIFIC SYNTAX VARIATIONS:

MySQL:
*/
DROP TABLE IF EXISTS Employees;
DROP TEMPORARY TABLE IF EXISTS temp_data;

/*
PostgreSQL:
*/
DROP TABLE IF EXISTS Employees CASCADE;  -- Drops dependent objects too
DROP TABLE IF EXISTS Employees RESTRICT;  -- Fails if dependencies exist (default)

/*
SQL Server:
*/
IF OBJECT_ID('Employees', 'U') IS NOT NULL
    DROP TABLE Employees;
-- Or (SQL Server 2016+):
DROP TABLE IF EXISTS Employees;

/*
Oracle:
*/
DROP TABLE Employees;  -- No IF EXISTS in older versions
-- Oracle 12c+:
DROP TABLE Employees;
-- Check first:
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Employees';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;

/*
SQLite:
*/
DROP TABLE IF EXISTS Employees;

/*
PERFORMANCE NOTES:

- DROP TABLE is generally fast (even on large tables)
- Doesn't need to process individual rows
- May need to remove indexes (can take time on huge tables)
- May lock the table briefly (blocking other operations)
- Disk space freed immediately (in most databases)
- Faster than DELETE (which logs each row)
- In InnoDB (MySQL): May need to rebuild tablespace

Large table considerations:
- On multi-terabyte tables, can take minutes
- Can cause replication lag in master-slave setups
- Consider maintenance window for production

ALTERNATIVE APPROACHES:

Instead of DROP TABLE, consider:

1. Rename table (soft delete):
*/
RENAME TABLE Employees TO Employees_deleted_20240226;
-- Keep for recovery period, then drop later

/*
2. Move to archive database:
*/
CREATE TABLE archive_db.Employees AS SELECT * FROM Employees;
DROP TABLE Employees;

/*
3. Use views to hide table:
*/
-- Instead of dropping, hide from users
REVOKE ALL PRIVILEGES ON Employees FROM PUBLIC;
-- Only admins can access

/*
HINGLISH SUMMARY:

DROP TABLE IF EXISTS Employees; ek dangerous command hai jo:

1. Puri table ko database se PERMANENTLY delete kar deta hai
2. Saara data (har ek row) permanently khatam ho jata hai
3. Table ka structure, indexes, constraints - sab kuch delete ho jata hai
4. Yeh operation UNDO nahi ho sakta (auto-commit ho jata hai)

"IF EXISTS" bohot important hai:
- Agar table exist karti hai → Drop ho jayegi
- Agar table exist nahi karti → Koi error nahi, script chalti rahegi
- Scripts ko rerunnable banata hai

Hamesha DROP karne se pehle:
✓ Backup bana lo (CREATE TABLE backup ya mysqldump)
✓ Dependencies check karo (foreign keys, views, stored procedures)
✓ Development mein test karo pehle
✓ Team ko inform karo
✓ Application code update karo
✓ Database confirm karo (production mein accidentally mat karo!)

DROP vs DELETE vs TRUNCATE:
- DROP: Table + Data dono delete (table exist hi nahi karega)
- DELETE: Sirf data delete, table rahega
- TRUNCATE: Saara data delete, table rahega, fast

Foreign keys ka dhyan rakho:
- Pehle child table drop karo
- Phir parent table drop karo
- Ya CASCADE use karo (PostgreSQL)

Recovery options limited hain:
- Backup se restore karo
- Binary logs se recover karo (MySQL)
- Cloud snapshots se restore karo
- Prevention is better than cure - BACKUP ZAROORI HAI!

KEY TAKEAWAYS:
✓ Always use IF EXISTS for safety
✓ BACKUP before dropping tables
✓ Check dependencies (foreign keys, views, procedures)
✓ Test in development first
✓ Verify correct database connection
✓ DROP is permanent - cannot rollback
✓ Understand DROP vs DELETE vs TRUNCATE
✓ Handle foreign keys properly
✓ Communicate with team
✓ Update application code first
✓ Consider soft delete (rename) instead
✓ Have recovery plan ready

=================================================================
*/

DROP TABLE IF EXISTS Employees;
