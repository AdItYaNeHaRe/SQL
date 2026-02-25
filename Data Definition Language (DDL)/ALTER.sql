/*
=================================================================
QUERY PURPOSE: Modify existing table structure using ALTER TABLE commands
=================================================================

CONCEPT EXPLANATION (English):
ALTER TABLE is a DDL (Data Definition Language) command used to modify
the structure of an existing table AFTER it has been created. Unlike
CREATE TABLE which creates a new table, ALTER TABLE changes an existing one.

Common ALTER TABLE operations include:
- ADD: Add new columns to the table
- MODIFY/ALTER COLUMN: Change column definition (data type, constraints)
- DROP: Remove columns from the table
- RENAME: Rename columns or the table itself
- ADD/DROP constraints

These changes affect the table schema without deleting existing data
(unless you drop a column).

CONCEPT EXPLANATION (Hinglish):
ALTER TABLE ek DDL (Data Definition Language) command hai jo existing
table ki structure ko modify karne ke liye use hoti hai, table create
hone ke BAAD. CREATE TABLE naya table banata hai, lekin ALTER TABLE
existing table ko change karta hai.

Common ALTER TABLE operations:
- ADD: Table mein naye columns add karna
- MODIFY/ALTER COLUMN: Column definition change karna (data type, constraints)
- DROP: Table se columns remove karna
- RENAME: Columns ya table ka naam change karna
- ADD/DROP constraints

Yeh changes table schema ko affect karte hain bina existing data ko
delete kiye (jab tak aap column drop na karo).

USE CASES:
- Adding new fields to track additional information (e.g., Gender, Address)
- Expanding column size when current size is insufficient (Email: 100→150 chars)
- Removing obsolete columns that are no longer needed
- Changing data types to accommodate new requirements
- Adding or removing constraints based on business rules
- Database schema evolution during application development
- Fixing design mistakes in production databases
- Compliance requirements (adding audit fields, removing sensitive data)
- Performance optimization (changing data types, adding indexes)

SPECIFIC QUERY BREAKDOWN:

=================================================================
QUERY 1: ADD COLUMN
=================================================================

ALTER TABLE employees
ADD Gender VARCHAR(10) NOT NULL DEFAULT 'Male';

Line 1: ALTER TABLE employees
  → ALTER TABLE: Command to modify table structure
  → employees: Name of the table being modified

Line 2: ADD Gender VARCHAR(10) NOT NULL DEFAULT 'Male';
  → ADD: Operation to add a new column
  → Gender: Name of the new column being added
  → VARCHAR(10): Data type - variable character string, max 10 characters
  → NOT NULL: Constraint - column cannot contain NULL values
  → DEFAULT 'Male': If no value provided during INSERT, 'Male' is used automatically

IMPORTANT NOTES:
  ⚠️ Adding NOT NULL column to existing table with data:
     - If table already has rows, ALL existing rows will get DEFAULT value
     - Without DEFAULT, this would FAIL on tables with existing data
     - DEFAULT 'Male' ensures existing rows get a value immediately

  ⚠️ Gender values consideration:
     - VARCHAR(10) allows: 'Male', 'Female', 'Other', 'Non-binary'
     - Consider using ENUM for fixed values: ENUM('Male', 'Female', 'Other')
     - Or use CHECK constraint: CHECK (Gender IN ('Male', 'Female', 'Other'))

  ⚠️ Default value 'Male' assumption:
     - This assumes all existing employees are Male (potentially problematic!)
     - Better approach: Use DEFAULT NULL or DEFAULT 'Not Specified'

WHAT HAPPENS:
Before ALTER:
EmployeeID | FirstName | LastName | Email
-----------|-----------|----------|------------------
1          | John      | Doe      | john@company.com
2          | Jane      | Smith    | jane@company.com

After ALTER (Gender column added with default 'Male'):
EmployeeID | FirstName | LastName | Email            | Gender
-----------|-----------|----------|------------------|--------
1          | John      | Doe      | john@company.com | Male
2          | Jane      | Smith    | jane@company.com | Male

Notice: Both rows got 'Male' even though Jane is likely female!

=================================================================
QUERY 2: MODIFY COLUMN
=================================================================

ALTER TABLE employees
MODIFY COLUMN Email VARCHAR(150) UNIQUE;

Line 1: ALTER TABLE employees
  → Modifying the employees table

Line 2: MODIFY COLUMN Email VARCHAR(150) UNIQUE;
  → MODIFY COLUMN: Change definition of existing column
  → Email: Column being modified
  → VARCHAR(150): NEW data type - increased from VARCHAR(100) to VARCHAR(150)
  → UNIQUE: Ensures no duplicate email addresses

  Note: Syntax varies by database:
  - MySQL: MODIFY COLUMN
  - PostgreSQL: ALTER COLUMN
  - SQL Server: ALTER COLUMN
  - Oracle: MODIFY

IMPORTANT NOTES:
  ✓ Increasing VARCHAR size (100→150): SAFE operation, no data loss
  ✗ Decreasing VARCHAR size (150→50): DANGEROUS! May truncate data

  ⚠️ Adding UNIQUE constraint:
     - If table has duplicate emails, this will FAIL
     - Database checks existing data before applying constraint
     - Must clean up duplicates first

  ⚠️ MODIFY rewrites entire column definition:
     - If Email was NOT NULL before, you must specify it again!
     - Missing constraints in MODIFY statement removes them
     - Better: Specify all constraints explicitly

WHAT HAPPENS:
Before MODIFY: Email VARCHAR(100) UNIQUE
After MODIFY: Email VARCHAR(150) UNIQUE

- Max email length increased from 100 to 150 characters
- UNIQUE constraint maintained (or added if not present)
- Existing data unchanged (all emails fit in 150 chars)

Example: Now can store: 'very.long.email.address.with.many.characters@long-company-domain-name.com'

=================================================================
QUERY 3: DROP COLUMN
=================================================================

ALTER TABLE employees
DROP COLUMN Age;

Line 1: ALTER TABLE employees
  → Modifying the employees table

Line 2: DROP COLUMN Age;
  → DROP COLUMN: Removes column entirely from table
  → Age: Name of column to be deleted
  → All data in this column will be PERMANENTLY DELETED!

⚠️ CRITICAL WARNINGS:
  - This is IRREVERSIBLE without a backup!
  - ALL data in Age column is lost forever
  - Any queries, views, stored procedures using Age will BREAK
  - Foreign key constraints involving Age must be dropped first
  - Triggers referencing Age may fail
  - Application code using Age will cause errors

WHAT HAPPENS:
Before DROP:
EmployeeID | FirstName | LastName | Age | Email
-----------|-----------|----------|-----|------------------
1          | John      | Doe      | 30  | john@company.com
2          | Jane      | Smith    | 28  | jane@company.com

After DROP (Age column removed):
EmployeeID | FirstName | LastName | Email
-----------|-----------|----------|------------------
1          | John      | Doe      | john@company.com
2          | Jane      | Smith    | jane@company.com

All age data is GONE permanently!

WHY DROP Age column?
Possible reasons:
- Age changes over time (bad design - should calculate from BirthDate)
- Privacy/compliance requirements
- Redundant data (if BirthDate exists)
- Column no longer used by application

EXAMPLES:

Example 1: Better way to add Gender column
*/
-- Step 1: Add column allowing NULL first
ALTER TABLE employees
ADD Gender VARCHAR(10) DEFAULT NULL;

-- Step 2: Update existing records based on business logic
UPDATE employees SET Gender = 'Female' WHERE FirstName IN ('Jane', 'Mary', 'Sarah');
UPDATE employees SET Gender = 'Male' WHERE Gender IS NULL;

-- Step 3: Add NOT NULL constraint after data is populated
ALTER TABLE employees
MODIFY COLUMN Gender VARCHAR(10) NOT NULL;

-- Example 2: Add multiple columns at once
ALTER TABLE employees
ADD COLUMN (
    MiddleName VARCHAR(50),
    Nickname VARCHAR(30),
    PreferredName VARCHAR(50)
);

-- Example 3: Modify column with all constraints explicitly
ALTER TABLE employees
MODIFY COLUMN Email VARCHAR(150) NOT NULL UNIQUE;
-- Safer: Specifies both NOT NULL and UNIQUE explicitly

-- Example 4: Change data type (be careful!)
ALTER TABLE employees
MODIFY COLUMN Salary DECIMAL(12, 2);  -- Increased from DECIMAL(10,2)

-- Example 5: Drop multiple columns
ALTER TABLE employees
DROP COLUMN Age,
DROP COLUMN OldEmailAddress,
DROP COLUMN TemporaryField;

-- Example 6: Rename column (safer than DROP + ADD)
ALTER TABLE employees
CHANGE COLUMN PhoneNumber ContactNumber VARCHAR(15);
-- MySQL syntax: CHANGE old_name new_name definition

-- Or in other databases:
ALTER TABLE employees
RENAME COLUMN PhoneNumber TO ContactNumber;

-- Example 7: Add column with CHECK constraint
ALTER TABLE employees
ADD COLUMN Age INT CHECK (Age >= 18 AND Age <= 100);

-- Example 8: Add ENUM column (MySQL specific)
ALTER TABLE employees
ADD COLUMN EmploymentType ENUM('Full-Time', 'Part-Time', 'Contract', 'Intern')
DEFAULT 'Full-Time';

-- Example 9: Add column with FOREIGN KEY
ALTER TABLE employees
ADD COLUMN ManagerID INT,
ADD CONSTRAINT FK_Manager
FOREIGN KEY (ManagerID) REFERENCES employees(EmployeeID);

-- Example 10: Drop constraint before dropping column
ALTER TABLE employees
DROP FOREIGN KEY FK_Department;  -- Drop foreign key first
ALTER TABLE employees
DROP COLUMN DepartmentID;  -- Then drop column

/*
COMPREHENSIVE REAL-WORLD SCENARIO:

Company is evolving their HR system:

Phase 1: Add new tracking fields
*/
ALTER TABLE employees
ADD COLUMN EmergencyContact VARCHAR(100),
ADD COLUMN EmergencyPhone VARCHAR(15),
ADD COLUMN BloodGroup VARCHAR(5),
ADD COLUMN JoiningBonus DECIMAL(10,2) DEFAULT 0.00;

/*
Phase 2: Fix design issues (Age should be calculated, not stored)
*/
-- Remove Age column (data changes daily)
ALTER TABLE employees
DROP COLUMN Age;

-- BirthDate should remain (static data)
-- Calculate age when needed:
-- SELECT TIMESTAMPDIFF(YEAR, BirthDate, CURDATE()) AS Age FROM employees;

/*
Phase 3: Expand existing fields (business growth)
*/
ALTER TABLE employees
MODIFY COLUMN Email VARCHAR(200) NOT NULL UNIQUE,  -- Longer corporate emails
MODIFY COLUMN FirstName VARCHAR(100),  -- Support longer international names
MODIFY COLUMN PhoneNumber VARCHAR(20);  -- International phone formats

/*
Phase 4: Add compliance/audit fields
*/
ALTER TABLE employees
ADD COLUMN CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN UpdatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
ADD COLUMN CreatedBy VARCHAR(50),
ADD COLUMN IsActive BOOLEAN DEFAULT TRUE,
ADD COLUMN TerminationDate DATE DEFAULT NULL;

/*
SYNTAX DIFFERENCES ACROSS DATABASES:

MySQL:
*/
ALTER TABLE employees MODIFY COLUMN Email VARCHAR(150);
ALTER TABLE employees CHANGE COLUMN OldName NewName VARCHAR(100);
ALTER TABLE employees ADD COLUMN NewCol VARCHAR(50);

/*
PostgreSQL:
*/
ALTER TABLE employees ALTER COLUMN Email TYPE VARCHAR(150);
ALTER TABLE employees RENAME COLUMN OldName TO NewName;
ALTER TABLE employees ADD COLUMN NewCol VARCHAR(50);

/*
SQL Server:
*/
ALTER TABLE employees ALTER COLUMN Email VARCHAR(150);
EXEC sp_rename 'employees.OldName', 'NewName', 'COLUMN';
ALTER TABLE employees ADD NewCol VARCHAR(50);

/*
Oracle:
*/
ALTER TABLE employees MODIFY (Email VARCHAR2(150));
ALTER TABLE employees RENAME COLUMN OldName TO NewName;
ALTER TABLE employees ADD NewCol VARCHAR2(50);

/*
SAFETY BEST PRACTICES:

1. ALWAYS backup before ALTER TABLE:
*/
-- Create backup table
CREATE TABLE employees_backup AS SELECT * FROM employees;

-- Or export data
mysqldump -u username -p database_name employees > employees_backup.sql

/*
2. Test in development environment first:
*/
-- Development
ALTER TABLE employees_dev ADD COLUMN TestColumn VARCHAR(50);
-- If successful, then production
ALTER TABLE employees ADD COLUMN TestColumn VARCHAR(50);

/*
3. Check for dependencies before DROP:
*/
-- Find views using the column
SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE
WHERE COLUMN_NAME = 'Age';

-- Find stored procedures using column
SELECT ROUTINE_NAME
FROM INFORMATION_SCHEMA.ROUTINES
WHERE ROUTINE_DEFINITION LIKE '%Age%';

/*
4. For NOT NULL columns, use multi-step approach:
*/
-- Step 1: Add column as nullable
ALTER TABLE employees ADD COLUMN NewCol VARCHAR(50) DEFAULT NULL;

-- Step 2: Populate data
UPDATE employees SET NewCol = 'default_value' WHERE NewCol IS NULL;

-- Step 3: Make it NOT NULL
ALTER TABLE employees MODIFY COLUMN NewCol VARCHAR(50) NOT NULL;

/*
5. Document changes:
*/
-- Add comment to column (MySQL 8.0+)
ALTER TABLE employees
MODIFY COLUMN Gender VARCHAR(10) COMMENT 'Employee gender: Male, Female, Other';

/*
PERFORMANCE CONSIDERATIONS:

1. ALTER TABLE can LOCK the entire table (depending on database)
   - On large tables, this can take hours
   - Production impact: Queries may wait/timeout

2. Some operations require table rebuild:
   - Changing data type
   - Adding NOT NULL columns
   - Reordering columns

3. Fast operations (usually):
   - Adding nullable column with DEFAULT
   - Dropping column (some databases)
   - Adding index (in background)

4. Slow operations:
   - Adding NOT NULL without DEFAULT (must scan all rows)
   - Changing data type (must convert all values)
   - Adding UNIQUE (must check all existing data)

5. Use ALGORITHM and LOCK clauses (MySQL 5.6+):
*/
ALTER TABLE employees
ADD COLUMN NewCol VARCHAR(50),
ALGORITHM=INPLACE,  -- Try to avoid table copy
LOCK=NONE;  -- Allow concurrent reads/writes

/*
COMMON MISTAKES TO AVOID:

1. ❌ Adding NOT NULL without DEFAULT on table with data:
*/
ALTER TABLE employees ADD COLUMN MustHaveValue VARCHAR(50) NOT NULL;
-- ❌ FAILS if table has existing rows!

-- ✓ Correct:
ALTER TABLE employees ADD COLUMN MustHaveValue VARCHAR(50) NOT NULL DEFAULT 'temp';

/*
2. ❌ Dropping column without checking dependencies:
*/
ALTER TABLE employees DROP COLUMN DepartmentID;
-- ❌ May break foreign keys, views, stored procedures!

-- ✓ Correct: Check first
SHOW CREATE TABLE employees;  -- Check constraints
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE COLUMN_NAME = 'DepartmentID';

/*
3. ❌ Using MODIFY without specifying all constraints:
*/
ALTER TABLE employees MODIFY COLUMN Email VARCHAR(150);
-- ❌ May lose NOT NULL or UNIQUE constraints!

-- ✓ Correct:
ALTER TABLE employees MODIFY COLUMN Email VARCHAR(150) NOT NULL UNIQUE;

/*
4. ❌ Decreasing VARCHAR size without checking data:
*/
ALTER TABLE employees MODIFY COLUMN Email VARCHAR(20);
-- ❌ Will truncate or fail if emails are longer than 20 chars!

-- ✓ Correct: Check first
SELECT MAX(LENGTH(Email)) FROM employees;  -- Check max length
-- If result is ≤ 20, safe to proceed

/*
5. ❌ Not testing in development first:
*/
ALTER TABLE employees DROP COLUMN ImportantData;
-- ❌ Directly on production = DISASTER!

-- ✓ Correct: Test → Backup → Execute
-- Test in dev → Create backup → Run on production

/*
6. ❌ Forgetting about application code:
*/
ALTER TABLE employees DROP COLUMN Age;
-- ❌ Application code using Age will crash!

-- ✓ Correct:
-- 1. Update application code to not use Age
-- 2. Deploy new code
-- 3. Then drop column

/*
ROLLBACK STRATEGIES:

ALTER TABLE cannot be rolled back directly (DDL auto-commits).
Preparation:

1. Backup before changes:
*/
CREATE TABLE employees_backup_20240226 AS SELECT * FROM employees;

/*
2. Document the reverse operations:
*/
-- If you ADD column:
ALTER TABLE employees ADD COLUMN Gender VARCHAR(10);
-- Reverse:
ALTER TABLE employees DROP COLUMN Gender;

-- If you MODIFY column:
ALTER TABLE employees MODIFY COLUMN Email VARCHAR(150);  -- Changed from 100
-- Reverse:
ALTER TABLE employees MODIFY COLUMN Email VARCHAR(100);

-- If you DROP column (CANNOT easily reverse without backup!):
ALTER TABLE employees DROP COLUMN Age;
-- Reverse: Restore from backup or
ALTER TABLE employees ADD COLUMN Age INT;
UPDATE employees e
SET Age = TIMESTAMPDIFF(YEAR, e.BirthDate, CURDATE());

/*
HINGLISH SUMMARY:

ALTER TABLE se hum existing table ki structure change karte hain:

1. ADD: Naya column add karna
   - NOT NULL column add karte waqt DEFAULT value dena zaroori hai
   - Warna existing rows mein error aayega

2. MODIFY/ALTER COLUMN: Column definition change karna
   - VARCHAR size increase karna safe hai (100→150)
   - VARCHAR size decrease karna dangerous hai (data loss ho sakta hai)
   - Saare constraints explicitly specify karo, warna lost ho jayenge

3. DROP COLUMN: Column delete karna
   - Yeh PERMANENT hai! Data wapas nahi aa sakta
   - Pehle backup lo aur dependencies check karo
   - Application code update karo pehle

Hamesha development mein test karo, production pe direct changes mat karo!
Backup zaroori hai kyunki ALTER TABLE undo nahi ho sakta.

Performance dhyan rakho - large tables pe ALTER slow ho sakta hai aur
table lock bhi ho sakta hai, jisse production affect ho sakta hai.

KEY TAKEAWAYS:
✓ BACKUP before any ALTER TABLE operation
✓ TEST in development environment first
✓ ADD NOT NULL columns with DEFAULT values
✓ MODIFY columns by specifying ALL constraints
✓ DROP columns only after checking dependencies
✓ Document reverse operations for rollback
✓ Consider application code impact
✓ Check performance impact on large tables
✓ Use appropriate syntax for your database system
✓ Verify data integrity after changes

=================================================================
*/

ALTER TABLE employees
ADD Gender VARCHAR(10) NOT NULL DEFAULT 'Male';

ALTER TABLE employees
MODIFY COLUMN Email VARCHAR(150) UNIQUE;

ALTER TABLE employees
DROP COLUMN Age;
