/*
=================================================================
QUERY PURPOSE: Quickly remove all data from customers table
=================================================================

CONCEPT EXPLANATION (English):
TRUNCATE TABLE is a DDL (Data Definition Language) command that removes
ALL rows from a table quickly and efficiently. It's similar to DELETE
without a WHERE clause, but with important differences.

TRUNCATE is faster than DELETE because:
- It doesn't log individual row deletions
- It deallocates data pages instead of deleting row by row
- It uses minimal transaction log space
- It's a "bulk" operation rather than row-by-row

Key characteristics of TRUNCATE:
- Removes ALL data (cannot use WHERE clause)
- Table structure remains intact (columns, constraints, indexes)
- Resets AUTO_INCREMENT counter to its initial value
- Cannot be rolled back in most databases (auto-commits)
- Doesn't fire DELETE triggers (in most databases)
- Faster than DELETE for removing all rows
- Requires ALTER or DROP privilege (not just DELETE)
- Cannot truncate if table has foreign key references (in most databases)
- Frees disk space immediately

TRUNCATE is best used when you need to completely empty a table quickly,
such as clearing temporary data, resetting test tables, or purging logs.

CONCEPT EXPLANATION (Hinglish):
TRUNCATE TABLE ek DDL (Data Definition Language) command hai jo table
se SAARI rows ko quickly aur efficiently remove kar deta hai. Yeh DELETE
without WHERE clause jaisa hai, lekin important differences hain.

TRUNCATE, DELETE se zyada fast hai kyunki:
- Yeh individual row deletions ko log nahi karta
- Yeh row-by-row delete karne ki bajaye data pages deallocate karta hai
- Yeh minimal transaction log space use karta hai
- Yeh "bulk" operation hai, row-by-row nahi

TRUNCATE ki key characteristics:
- SAARA data remove kar deta hai (WHERE clause use nahi kar sakte)
- Table structure intact rahta hai (columns, constraints, indexes)
- AUTO_INCREMENT counter initial value pe reset ho jata hai
- Most databases mein rollback nahi ho sakta (auto-commit ho jata hai)
- DELETE triggers fire nahi hote (most databases mein)
- Sabhi rows remove karne ke liye DELETE se fast hai
- ALTER ya DROP privilege chahiye (sirf DELETE nahi)
- Foreign key references hai toh truncate nahi kar sakte (most databases)
- Disk space immediately free ho jata hai

TRUNCATE best use hota hai jab aapko puri table ko quickly empty karna
ho, jaise temporary data clear karna, test tables reset karna, ya logs
purge karna.

USE CASES:
- Clearing temporary/staging tables after data processing
- Resetting test databases between test runs
- Purging log tables periodically
- Clearing session data tables
- Emptying cache tables
- Resetting demo/sandbox environments
- Clearing import tables before fresh data load
- Removing all audit logs after archiving
- Resetting queue tables after processing
- Cleaning up development databases

SPECIFIC QUERY BREAKDOWN:

TRUNCATE TABLE customers;

TRUNCATE TABLE: Command to remove all rows
  → TRUNCATE: SQL keyword for fast table emptying
  → TABLE: Specifies we're truncating a table
  → Completely empties the table in one operation
  → Much faster than DELETE FROM customers;

customers: Target table name
  → The table that will be emptied
  → All rows will be removed
  → Table structure remains (can still INSERT new data)

; : Statement terminator
  → Marks end of SQL statement

HOW IT WORKS:

Step-by-step execution:
1. Database checks if TRUNCATE is allowed
   - Checks for foreign key constraints (may fail if referenced)
   - Checks user privileges (needs ALTER or DROP, not just DELETE)

2. If allowed, database:
   - Deallocates all data pages used by the table
   - Resets AUTO_INCREMENT counter to initial value (usually 1)
   - Doesn't log individual row deletions
   - Doesn't fire DELETE triggers
   - Commits immediately (auto-commit)

3. Result:
   - Table is empty (0 rows)
   - Structure preserved (all columns, indexes, constraints intact)
   - Disk space freed
   - Ready for new data

Before TRUNCATE:
customers table:
id | first_name | country    | score
---|------------|------------|-------
1  | John       | USA        | 95
2  | Alice      | UK         | 87
7  | Anjali     | India      | 88
8  | Liam       | Canada     | 92
9  | Sophia     | USA        | 100
10 | Noah       | UK         | 75
... 1000 rows total

After TRUNCATE:
customers table:
id | first_name | country    | score
---|------------|------------|-------
(empty - 0 rows)

Table structure still exists:
- Columns: id, first_name, country, score
- Constraints: PRIMARY KEY on id, etc.
- Can still INSERT new data

Next INSERT will start AUTO_INCREMENT from 1:
INSERT INTO customers (first_name, country, score)
VALUES ('NewUser', 'USA', 80);
-- Gets id = 1 (reset counter)

Result: "Query OK, 0 rows affected" or "Table truncated successfully"

TRUNCATE vs DELETE vs DROP COMPARISON:

Feature                    TRUNCATE              DELETE                DROP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Command Type              DDL                   DML                   DDL
Removes Data              ✓ All rows            ✓ Selected rows       ✓ All data
Removes Structure         ✗ No                  ✗ No                  ✓ Yes
WHERE Clause              ✗ Not allowed         ✓ Allowed             ✗ Not allowed
Speed                     ⚡ Very Fast           🐢 Slow               ⚡ Fast
Can Rollback              ✗ No (usually)        ✓ Yes (in trans.)     ✗ No
Triggers Fired            ✗ No (usually)        ✓ Yes                 N/A
Resets AUTO_INCREMENT     ✓ Yes                 ✗ No                  N/A
Frees Disk Space          ✓ Immediately         ✗ Not immediately     ✓ Yes
Requires Privilege        ALTER/DROP            DELETE                DROP
Logs Individual Rows      ✗ No                  ✓ Yes                 ✗ No
Table Still Exists        ✓ Yes                 ✓ Yes                 ✗ No
Foreign Key Check         ✓ Strict              ✓ Checked             ✓ Checked

Use When:
TRUNCATE → Need to empty entire table quickly
DELETE → Need to remove specific rows or need rollback
DROP → Need to remove table completely

Visual Comparison:

TRUNCATE TABLE customers;
┌─────────────────┐
│  Table: EXISTS  │
│  Data:  GONE    │     ⚡ Fast
│  Structure: OK  │     🔄 AUTO_INCREMENT reset
└─────────────────┘

DELETE FROM customers;
┌─────────────────┐
│  Table: EXISTS  │
│  Data:  GONE    │     🐢 Slower
│  Structure: OK  │     ❌ AUTO_INCREMENT NOT reset
└─────────────────┘

DROP TABLE customers;
┌─────────────────┐
│  Table: GONE    │
│  Data:  GONE    │     💥 Everything removed
│  Structure: GONE│
└─────────────────┘

EXAMPLES:

Example 1: Basic TRUNCATE
*/
TRUNCATE TABLE customers;
-- Removes all customers, resets id counter

-- Example 2: TRUNCATE with verification
SELECT COUNT(*) FROM customers;  -- Check row count before
-- Returns: 1000 rows

TRUNCATE TABLE customers;

SELECT COUNT(*) FROM customers;  -- Check row count after
-- Returns: 0 rows

-- Example 3: TRUNCATE temporary table
CREATE TEMPORARY TABLE temp_imports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data VARCHAR(255)
);

INSERT INTO temp_imports (data) VALUES ('test1'), ('test2');
TRUNCATE TABLE temp_imports;  -- Clear for next batch

-- Example 4: TRUNCATE vs DELETE speed comparison
-- Slow way (DELETE):
DELETE FROM large_table;  -- Takes minutes on million-row table

-- Fast way (TRUNCATE):
TRUNCATE TABLE large_table;  -- Takes seconds

-- Example 5: TRUNCATE staging table in ETL process
-- Extract, Transform, Load (ETL) workflow
TRUNCATE TABLE staging_customers;  -- Clear staging area

LOAD DATA INFILE '/path/to/customers.csv'
INTO TABLE staging_customers;  -- Load fresh data

INSERT INTO customers
SELECT * FROM staging_customers;  -- Move to production

TRUNCATE TABLE staging_customers;  -- Clean up

-- Example 6: TRUNCATE with AUTO_INCREMENT reset demonstration
CREATE TABLE test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO test_table (name) VALUES ('Alice'), ('Bob'), ('Charlie');
-- ids: 1, 2, 3

DELETE FROM test_table;  -- Delete all rows

INSERT INTO test_table (name) VALUES ('David');
-- id: 4 (continues from last id)

TRUNCATE TABLE test_table;  -- Truncate all rows

INSERT INTO test_table (name) VALUES ('Eve');
-- id: 1 (reset to start)

-- Example 7: TRUNCATE multiple tables
TRUNCATE TABLE session_data;
TRUNCATE TABLE temp_calculations;
TRUNCATE TABLE import_queue;
-- Clear multiple tables sequentially

-- Example 8: TRUNCATE log table (common maintenance task)
-- Every month, clear old logs
TRUNCATE TABLE application_logs;
TRUNCATE TABLE error_logs;
TRUNCATE TABLE access_logs;

-- Example 9: TRUNCATE with foreign key constraints (will fail)
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

INSERT INTO departments VALUES (1, 'Sales');
INSERT INTO employees VALUES (1, 1);

TRUNCATE TABLE departments;
-- ❌ ERROR! employees table references departments
-- "Cannot truncate a table referenced in a foreign key constraint"

-- Solutions:
-- Option 1: Truncate child table first
TRUNCATE TABLE employees;   -- ✓ Child first
TRUNCATE TABLE departments; -- ✓ Then parent

-- Option 2: Drop foreign key temporarily
ALTER TABLE employees DROP FOREIGN KEY fk_dept;
TRUNCATE TABLE departments;
ALTER TABLE employees ADD FOREIGN KEY (dept_id) REFERENCES departments(dept_id);

-- Option 3: Use DELETE instead
DELETE FROM departments;  -- Works but slower

-- Example 10: TRUNCATE in database reset script
-- Script to reset development database
TRUNCATE TABLE orders;
TRUNCATE TABLE customers;
TRUNCATE TABLE products;
TRUNCATE TABLE categories;

-- Insert fresh test data
INSERT INTO categories VALUES (1, 'Electronics'), (2, 'Books');
INSERT INTO products VALUES (1, 'Laptop', 1), (2, 'Novel', 2);
INSERT INTO customers VALUES (1, 'TestUser', 'USA', 80);

/*
IMPORTANT WARNINGS AND LIMITATIONS:

⚠️ WARNING 1: Cannot rollback (usually)
*/
START TRANSACTION;
TRUNCATE TABLE customers;
-- Data is GONE immediately (auto-commit in most databases)
ROLLBACK;  -- ❌ Does NOT restore data!

-- Exception: Some databases like PostgreSQL allow TRUNCATE in transactions
-- But MySQL auto-commits TRUNCATE

/*
⚠️ WARNING 2: Foreign key constraints prevent TRUNCATE
*/
TRUNCATE TABLE departments;
-- ❌ ERROR if employees table has foreign key to departments

-- Must truncate child tables first:
TRUNCATE TABLE employees;
TRUNCATE TABLE departments;

/*
⚠️ WARNING 3: Triggers don't fire
*/
CREATE TRIGGER before_delete_customer
BEFORE DELETE ON customers
FOR EACH ROW
    INSERT INTO audit_log VALUES (OLD.id, NOW());

DELETE FROM customers;  -- ✓ Trigger fires, audit_log updated
TRUNCATE TABLE customers;  -- ✗ Trigger does NOT fire, no audit

/*
⚠️ WARNING 4: Cannot use WHERE clause
*/
TRUNCATE TABLE customers WHERE country = 'USA';
-- ❌ SYNTAX ERROR! TRUNCATE doesn't support WHERE

-- Use DELETE instead:
DELETE FROM customers WHERE country = 'USA';

/*
⚠️ WARNING 5: Requires special privileges
*/
TRUNCATE TABLE customers;
-- ❌ May fail if user only has DELETE privilege
-- Requires: ALTER or DROP privilege

-- Check privileges:
SHOW GRANTS FOR CURRENT_USER;

/*
⚠️ WARNING 6: No confirmation prompt
*/
TRUNCATE TABLE customers;
-- ⚡ Executes IMMEDIATELY, no "Are you sure?" prompt
-- All data GONE in seconds!

/*
SAFETY PRACTICES:

1. Backup before TRUNCATE:
*/
-- Create backup
CREATE TABLE customers_backup AS SELECT * FROM customers;

-- Now safe to truncate
TRUNCATE TABLE customers;

-- If mistake, restore:
INSERT INTO customers SELECT * FROM customers_backup;

/*
2. Verify table name:
*/
-- Check current database
SELECT DATABASE();

-- Verify table exists and content
SELECT COUNT(*) FROM customers;
SELECT * FROM customers LIMIT 5;

-- Then truncate
TRUNCATE TABLE customers;

/*
3. Use in transactions (if database supports):
*/
-- PostgreSQL example:
BEGIN;
TRUNCATE TABLE customers;
-- Check if this is what you wanted
ROLLBACK;  -- Or COMMIT;

-- MySQL: TRUNCATE auto-commits, cannot rollback

/*
4. Test in development first:
*/
-- In development database:
USE development_db;
TRUNCATE TABLE customers;
-- Test application behavior

-- Then in production:
USE production_db;
TRUNCATE TABLE customers;

/*
5. Document and schedule:
*/
-- Create maintenance script
-- maintenance.sql
-- Schedule: Every Sunday 2 AM
TRUNCATE TABLE session_data;
TRUNCATE TABLE temp_logs;
TRUNCATE TABLE cache_entries;

/*
REAL-WORLD SCENARIOS:

Scenario 1: ETL Pipeline - Daily Data Load
*/
-- Every morning, clear staging and load fresh data
TRUNCATE TABLE staging_sales_data;

LOAD DATA INFILE '/data/daily_sales.csv'
INTO TABLE staging_sales_data
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Process and move to production tables
INSERT INTO sales_fact
SELECT * FROM staging_sales_data WHERE is_valid = TRUE;

-- Clean up
TRUNCATE TABLE staging_sales_data;

/*
Scenario 2: Session Management
*/
-- Clear expired sessions (runs hourly via cron)
TRUNCATE TABLE user_sessions;  -- Fast, simple
-- Users will need to log in again

/*
Scenario 3: Test Environment Reset
*/
-- Reset test database between test suites
TRUNCATE TABLE test_orders;
TRUNCATE TABLE test_customers;
TRUNCATE TABLE test_products;

-- Insert fresh test fixtures
INSERT INTO test_customers VALUES
    (1, 'Test User 1', 'USA', 80),
    (2, 'Test User 2', 'UK', 90);

/*
Scenario 4: Log Rotation
*/
-- Archive logs before truncating
INSERT INTO archived_logs
SELECT * FROM application_logs
WHERE log_date < DATE_SUB(NOW(), INTERVAL 90 DAY);

-- Clear current logs
TRUNCATE TABLE application_logs;

/*
Scenario 5: Cache Clearing
*/
-- Clear cache tables (faster than DELETE)
TRUNCATE TABLE product_cache;
TRUNCATE TABLE search_cache;
TRUNCATE TABLE api_response_cache;

-- Cache will rebuild as needed

/*
Scenario 6: Demo/Sandbox Reset
*/
-- Reset demo environment for next demo
TRUNCATE TABLE demo_orders;
TRUNCATE TABLE demo_carts;
TRUNCATE TABLE demo_wishlists;

-- Reload demo data
SOURCE demo_data.sql;

/*
PERFORMANCE COMPARISON:

Test: Remove 1,000,000 rows from table
*/

-- Method 1: DELETE (slow)
START TRANSACTION;
DELETE FROM large_table;
COMMIT;
-- Time: ~5 minutes
-- Logs: Full transaction log (1M row deletions)
-- Disk: Space not freed immediately

-- Method 2: TRUNCATE (fast)
TRUNCATE TABLE large_table;
-- Time: ~2 seconds
-- Logs: Minimal (just table metadata)
-- Disk: Space freed immediately

-- Method 3: DROP and RECREATE (also fast)
DROP TABLE large_table;
CREATE TABLE large_table (...);  -- Same structure
-- Time: ~3 seconds
-- Loses indexes, constraints, triggers (must recreate)

/*
CHECKING RESULTS:

After TRUNCATE, verify:
*/
-- Check row count
SELECT COUNT(*) FROM customers;
-- Should return: 0

-- Check table still exists
SHOW TABLES LIKE 'customers';
-- Should return: customers

-- Check structure is intact
DESCRIBE customers;
-- Should show all columns

-- Check AUTO_INCREMENT reset
SHOW CREATE TABLE customers;
-- AUTO_INCREMENT should be back to 1

-- Test INSERT
INSERT INTO customers (first_name, country, score)
VALUES ('First After Truncate', 'USA', 85);

SELECT * FROM customers;
-- id should be 1 (or initial AUTO_INCREMENT value)

/*
DATABASE-SPECIFIC SYNTAX:

MySQL:
*/
TRUNCATE TABLE customers;
-- Auto-commits, cannot rollback
-- Cannot truncate if foreign key references exist

/*
PostgreSQL:
*/
TRUNCATE TABLE customers;
-- Can be used in transaction with ROLLBACK
TRUNCATE TABLE customers CASCADE;  -- Also truncates referencing tables
TRUNCATE TABLE customers RESTART IDENTITY;  -- Reset serial (like AUTO_INCREMENT)

/*
SQL Server:
*/
TRUNCATE TABLE customers;
-- Similar to MySQL
-- Cannot truncate if foreign key references exist

/*
Oracle:
*/
TRUNCATE TABLE customers;
-- Also has: TRUNCATE TABLE customers DROP STORAGE;  -- Free space
-- Or: TRUNCATE TABLE customers REUSE STORAGE;  -- Keep space

/*
SQLite:
*/
-- SQLite doesn't have TRUNCATE
-- Use DELETE instead:
DELETE FROM customers;

-- To reset AUTO_INCREMENT:
DELETE FROM sqlite_sequence WHERE name='customers';

/*
ALTERNATIVES TO TRUNCATE:

When TRUNCATE can't be used:
*/

-- Alternative 1: DELETE (when need WHERE clause)
DELETE FROM customers WHERE created_date < '2020-01-01';

-- Alternative 2: DELETE all (when foreign keys prevent TRUNCATE)
DELETE FROM customers;

-- Alternative 3: DROP and RECREATE (when need complete reset)
DROP TABLE customers;
CREATE TABLE customers (...);

-- Alternative 4: Disable foreign keys temporarily (MySQL)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE customers;
TRUNCATE TABLE orders;
SET FOREIGN_KEY_CHECKS = 1;

-- Alternative 5: Rename old, create new (zero downtime)
RENAME TABLE customers TO customers_old;
CREATE TABLE customers LIKE customers_old;
-- Later: DROP TABLE customers_old;

/*
COMMON MISTAKES TO AVOID:

1. ❌ Truncating production table accidentally:
*/
-- Connected to production
TRUNCATE TABLE customers;  -- ❌ DISASTER! All customer data gone!

-- ✓ Correct: Always verify database
SELECT DATABASE();
USE development_db;
TRUNCATE TABLE customers;

/*
2. ❌ Expecting ROLLBACK to work:
*/
START TRANSACTION;
TRUNCATE TABLE customers;
ROLLBACK;  -- ❌ Data already gone (auto-commit)!

-- ✓ Correct: Use DELETE if need rollback
START TRANSACTION;
DELETE FROM customers;
ROLLBACK;  -- ✓ Data restored

/*
3. ❌ Forgetting foreign key constraints:
*/
TRUNCATE TABLE departments;
-- ❌ ERROR: employees table references departments

-- ✓ Correct: Truncate in right order
TRUNCATE TABLE employees;
TRUNCATE TABLE departments;

/*
4. ❌ Expecting triggers to fire:
*/
-- Has audit trigger on DELETE
TRUNCATE TABLE customers;
-- ❌ Audit log NOT updated (trigger doesn't fire)

-- ✓ Correct: Use DELETE if need triggers
DELETE FROM customers;

/*
5. ❌ Truncating without backup:
*/
TRUNCATE TABLE important_data;
-- ❌ Oops! Needed that data!

-- ✓ Correct: Always backup first
CREATE TABLE important_data_backup AS SELECT * FROM important_data;
TRUNCATE TABLE important_data;

/*
6. ❌ Using TRUNCATE when need partial delete:
*/
TRUNCATE TABLE customers WHERE country = 'USA';
-- ❌ SYNTAX ERROR!

-- ✓ Correct: Use DELETE with WHERE
DELETE FROM customers WHERE country = 'USA';

/*
RECOVERY FROM ACCIDENTAL TRUNCATE:

If truncated by mistake:

1. From transaction (PostgreSQL only):
*/
BEGIN;
TRUNCATE TABLE customers;
-- Oops!
ROLLBACK;  -- ✓ Data restored (PostgreSQL only!)

/*
2. From backup table:
*/
INSERT INTO customers SELECT * FROM customers_backup;

/*
3. From SQL dump:
*/
SOURCE customers_backup.sql;
-- Or:
mysql -u username -p database_name < customers_backup.sql

/*
4. From binary logs (MySQL - advanced):
*/
-- Use mysqlbinlog to replay transactions before TRUNCATE
mysqlbinlog --start-datetime="2024-02-26 08:00:00" \
            --stop-datetime="2024-02-26 08:59:59" \
            binlog.000001 | mysql -u root -p

/*
5. From point-in-time restore (cloud):
*/
-- AWS RDS, Azure SQL, Google Cloud SQL
-- Restore database to point before TRUNCATE

/*
HINGLISH SUMMARY:

TRUNCATE TABLE customers; ek fast command hai jo table se SAARE rows
ko ek baar mein remove kar deta hai.

Key points:
- DELETE se zyada FAST (seconds mein million rows delete)
- Table structure rahta hai, sirf data jata hai
- AUTO_INCREMENT counter reset ho jata hai (1 se shuru)
- Rollback nahi ho sakta (auto-commit)
- WHERE clause use nahi kar sakte (sab delete hoga)
- Triggers fire nahi hote (audit problems ho sakte hain)
- Foreign key references ho toh error aata hai
- Disk space immediately free ho jata hai

TRUNCATE vs DELETE vs DROP:
- TRUNCATE: Fast, saare rows, table structure rahta hai, reset counter
- DELETE: Slow, specific rows, table structure rahta hai, no reset
- DROP: Table + data dono delete, kuch nahi bachta

Use cases:
- Temporary/staging tables clear karna
- Test databases reset karna
- Log tables purge karna
- Session data clear karna
- Cache tables empty karna
- Demo environments reset karna

Foreign key problem:
- Parent table truncate nahi kar sakte agar child table reference kar rahi ho
- Pehle child truncate karo, phir parent

Safety:
✓ Hamesha backup banao pehle
✓ Database verify karo (production vs development)
✓ Foreign key constraints check karo
✓ Test environment mein pehle try karo
✓ Triggers ki zarurat hai toh DELETE use karo

Mistakes to avoid:
❌ Production mein accidentally truncate
❌ ROLLBACK expect karna (MySQL mein nahi hota)
❌ Foreign keys ignore karna
❌ Bina backup ke truncate karna
❌ WHERE clause use karne ki koshish
❌ Triggers fire hone ki expectation

Speed comparison (1 million rows):
- DELETE: ~5 minutes 🐢
- TRUNCATE: ~2 seconds ⚡
- DROP + CREATE: ~3 seconds ⚡

Recovery difficult hai:
- MySQL: Backup se restore karo (ROLLBACK nahi hota)
- PostgreSQL: Transaction mein ROLLBACK ho sakta hai
- Cloud: Point-in-time restore use karo

TRUNCATE powerful but dangerous hai! Hamesha:
1. Backup lo
2. Database verify karo
3. Test mein try karo
4. Production mein carefully use karo

KEY TAKEAWAYS:
✓ Very fast for removing all rows
✓ Resets AUTO_INCREMENT counter
✓ Cannot use WHERE clause
✓ Cannot rollback (usually)
✓ Requires ALTER/DROP privilege
✓ Blocked by foreign key references
✓ Doesn't fire triggers
✓ Frees disk space immediately
✓ Always backup before truncating
✓ Verify database before executing
✓ Use DELETE if need: WHERE, rollback, or triggers
✓ Use DROP if removing table entirely
✓ Test in development first
✓ Handle foreign keys properly

=================================================================
*/

TRUNCATE TABLE customers;
