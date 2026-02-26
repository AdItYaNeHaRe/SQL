/*
=================================================================
QUERY PURPOSE: Delete/remove specific rows from the customers table
=================================================================

CONCEPT EXPLANATION (English):
DELETE is a DML (Data Manipulation Language) statement used to remove
existing rows from a table. Unlike DROP TABLE (which removes the entire
table), DELETE only removes data rows while keeping the table structure
intact.

Key characteristics of DELETE:
- Removes one or more rows based on WHERE condition
- Table structure remains unchanged
- Can be rolled back (if used within a transaction)
- Logs each deleted row (slower than TRUNCATE)
- WHERE clause determines which rows to delete
- Without WHERE clause, deletes ALL rows (dangerous!)
- Triggers are fired for each deleted row
- Does not reset AUTO_INCREMENT counter

DELETE is reversible within a transaction, making it safer than DROP
for removing data while preserving the table structure.

CONCEPT EXPLANATION (Hinglish):
DELETE ek DML (Data Manipulation Language) statement hai jo table se
existing rows ko remove karne ke liye use hoti hai. DROP TABLE se unlike
(jo puri table remove kar deta hai), DELETE sirf data rows remove karta
hai jabki table structure intact rahta hai.

DELETE ki key characteristics:
- WHERE condition ke basis pe ek ya zyada rows remove karta hai
- Table structure unchanged rahta hai
- Rollback ho sakta hai (agar transaction ke andar use ho)
- Har deleted row ko log karta hai (TRUNCATE se slow)
- WHERE clause decide karta hai kaunsi rows delete hongi
- WHERE clause ke bina, SAARI rows delete ho jaati hain (dangerous!)
- Har deleted row ke liye triggers fire hote hain
- AUTO_INCREMENT counter reset nahi hota

DELETE reversible hai transaction ke andar, isliye DROP se zyada safe
hai data remove karne ke liye jabki table structure preserve karna ho.

USE CASES:
- Removing inactive or obsolete user accounts
- Deleting cancelled orders or expired data
- Cleaning up test data from database
- Removing duplicate records
- Archiving old data (delete after backup)
- GDPR/data privacy compliance (removing user data on request)
- Deleting failed transactions or error logs
- Removing spam or flagged content
- Purging temporary records
- Data quality maintenance (removing invalid entries)

SPECIFIC QUERY BREAKDOWN:

=================================================================
QUERY 1: DELETE Single Row by ID
=================================================================

DELETE FROM customers
WHERE id = 11;

Line 1: DELETE FROM customers
  → DELETE: SQL command to remove rows
  → FROM: Specifies which table to delete from
  → customers: Target table name

Line 2: WHERE id = 11;
  → WHERE: Condition clause - CRITICAL for targeted deletion
  → id = 11: Condition - only rows where id equals 11 are deleted
  → = : Equality operator
  → 11: Specific value to match
  → ; : Statement terminator

HOW IT WORKS:
1. Database scans customers table
2. Finds all rows where id = 11
3. Deletes matching row(s)
4. Returns number of affected rows

Before DELETE:
id | first_name | country    | score
---|------------|------------|-------
7  | Anjali     | India      | 88
8  | Liam       | Canada     | 92
9  | Sophia     | USA        | NULL
10 | Noah       | UK         | 75
11 | Emma       | Australia  | NULL    ← This row will be deleted

After DELETE:
id | first_name | country    | score
---|------------|------------|-------
7  | Anjali     | India      | 88
8  | Liam       | Canada     | 92
9  | Sophia     | USA        | NULL
10 | Noah       | UK         | 75
(Row with id=11 is GONE)

Result: "1 row affected" or "Query OK, 1 row deleted"

⚠️ IMPORTANT NOTES:
- If id=11 doesn't exist, 0 rows affected (no error)
- If multiple rows have id=11 (shouldn't happen with PRIMARY KEY), all deleted
- Deletion is permanent once committed
- Use transactions for safety

=================================================================
QUERY 2: DELETE Multiple Rows with Range Condition
=================================================================

DELETE FROM customers
WHERE id > 6;

Line 1: DELETE FROM customers
  → Same as Query 1

Line 2: WHERE id > 6;
  → WHERE id > 6: Deletes ALL rows where id is greater than 6
  → > : Greater than operator
  → Affects MULTIPLE rows (potentially many)

HOW IT WORKS:
1. Database scans customers table
2. Finds all rows where id > 6 (id = 7, 8, 9, 10, 11, etc.)
3. Deletes ALL matching rows
4. Returns total number of deleted rows

Before DELETE:
id | first_name | country    | score
---|------------|------------|-------
1  | John       | USA        | 95      ← Safe (id ≤ 6)
2  | Alice      | UK         | 87      ← Safe (id ≤ 6)
5  | Mike       | Canada     | 80      ← Safe (id ≤ 6)
7  | Anjali     | India      | 88      ← DELETED (id > 6)
8  | Liam       | Canada     | 92      ← DELETED (id > 6)
9  | Sophia     | USA        | NULL    ← DELETED (id > 6)
10 | Noah       | UK         | 75      ← DELETED (id > 6)
11 | Emma       | Australia  | NULL    ← DELETED (id > 6)

After DELETE:
id | first_name | country    | score
---|------------|------------|-------
1  | John       | USA        | 95
2  | Alice      | UK         | 87
5  | Mike       | Canada     | 80

Result: "5 rows affected" (assuming 5 rows had id > 6)

⚠️ CRITICAL WARNINGS:
- This deletes MULTIPLE rows at once
- Be ABSOLUTELY SURE of the condition
- Test with SELECT first: SELECT * FROM customers WHERE id > 6;
- No confirmation prompt - executes immediately
- More dangerous than single-row delete

WHERE CLAUSE OPERATORS:

Comparison Operators:
= : Equal to
> : Greater than
< : Less than
>= : Greater than or equal to
<= : Less than or equal to
!= or <> : Not equal to

Logical Operators:
AND : Both conditions must be true
OR : At least one condition must be true
NOT : Negates a condition

Pattern Matching:
LIKE : Pattern matching with wildcards (%, _)
IN : Matches any value in a list
BETWEEN : Within a range (inclusive)

NULL Handling:
IS NULL : Check if value is NULL
IS NOT NULL : Check if value is not NULL

EXAMPLES:

Example 1: DELETE by exact match (single condition)
*/
DELETE FROM customers
WHERE first_name = 'John';
-- Deletes all customers named 'John'

-- Example 2: DELETE with multiple conditions (AND)
DELETE FROM customers
WHERE country = 'USA' AND score < 70;
-- Deletes USA customers with score below 70

-- Example 3: DELETE with OR condition
DELETE FROM customers
WHERE country = 'USA' OR country = 'Canada';
-- Deletes customers from USA or Canada

-- Example 4: DELETE using IN operator
DELETE FROM customers
WHERE id IN (1, 3, 5, 7, 9);
-- Deletes customers with ids 1, 3, 5, 7, or 9

-- Example 5: DELETE using NOT IN
DELETE FROM customers
WHERE country NOT IN ('USA', 'UK', 'Canada');
-- Deletes customers from countries other than USA, UK, Canada

-- Example 6: DELETE using BETWEEN
DELETE FROM customers
WHERE score BETWEEN 50 AND 70;
-- Deletes customers with scores from 50 to 70 (inclusive)

-- Example 7: DELETE NULL values
DELETE FROM customers
WHERE score IS NULL;
-- Deletes customers with NULL score

-- Example 8: DELETE NOT NULL values
DELETE FROM customers
WHERE email IS NOT NULL;
-- Deletes customers who have email addresses

-- Example 9: DELETE using LIKE (pattern matching)
DELETE FROM customers
WHERE first_name LIKE 'A%';
-- Deletes customers whose first name starts with 'A'
-- % = any characters, _ = single character

-- Example 10: DELETE with complex conditions
DELETE FROM customers
WHERE (country = 'India' AND score > 85)
   OR (country = 'USA' AND score < 60);
-- Deletes high-scoring Indians OR low-scoring Americans

-- Example 11: DELETE based on date
DELETE FROM orders
WHERE order_date < '2023-01-01';
-- Deletes orders placed before January 1, 2023

-- Example 12: DELETE with subquery
DELETE FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
    WHERE order_status = 'Cancelled'
);
-- Deletes customers who have cancelled orders

-- Example 13: DELETE with JOIN (MySQL syntax)
DELETE c
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
WHERE o.order_status = 'Fraud';
-- Deletes customers with fraudulent orders

-- Example 14: DELETE all inactive users (based on last login)
DELETE FROM users
WHERE last_login < DATE_SUB(NOW(), INTERVAL 2 YEAR);
-- Deletes users who haven't logged in for 2+ years

-- Example 15: DELETE duplicates (keep only one)
DELETE FROM customers
WHERE id NOT IN (
    SELECT MIN(id)
    FROM (SELECT id, email FROM customers) AS temp
    GROUP BY email
);
-- Keeps earliest customer for each email, deletes duplicates

/*
DANGEROUS DELETE OPERATIONS:

⚠️ WARNING 1: DELETE without WHERE (DELETES EVERYTHING!)
*/
DELETE FROM customers;
-- ❌ DISASTER! Deletes ALL rows in the table
-- Table structure remains, but ALL data is GONE
-- Use TRUNCATE if you really want to empty the table

-- ✓ ALWAYS use WHERE unless you truly want to delete everything:
DELETE FROM customers WHERE id > 0;  -- Still deletes all, but more explicit

/*
⚠️ WARNING 2: DELETE with wrong condition
*/
DELETE FROM customers
WHERE country = 'USA';  -- Oops! Meant to delete just inactive USA users
-- ❌ Deletes ALL USA customers, not just inactive ones

-- ✓ Correct:
DELETE FROM customers
WHERE country = 'USA' AND is_active = FALSE;

/*
SAFETY BEST PRACTICES:

1. ALWAYS test with SELECT first:
*/
-- Step 1: Test the condition with SELECT
SELECT * FROM customers WHERE id > 6;
-- Check: Are these the rows you want to delete?

-- Step 2: If correct, change SELECT to DELETE
DELETE FROM customers WHERE id > 6;

/*
2. Use transactions for safety (allows rollback):
*/
START TRANSACTION;

DELETE FROM customers WHERE id > 6;
-- Check result
SELECT * FROM customers;

-- If mistake, rollback:
ROLLBACK;  -- Undoes the DELETE

-- If correct, commit:
COMMIT;  -- Makes DELETE permanent

/*
3. Create backup before bulk delete:
*/
-- Backup the data first
CREATE TABLE customers_backup AS SELECT * FROM customers;

-- Now safe to delete
DELETE FROM customers WHERE id > 6;

-- If mistake, restore:
INSERT INTO customers SELECT * FROM customers_backup;

/*
4. Use LIMIT for testing (MySQL):
*/
DELETE FROM customers
WHERE country = 'USA'
LIMIT 5;
-- Deletes only first 5 matching rows (safer for testing)

/*
5. Count rows before deleting:
*/
-- Check how many rows will be affected
SELECT COUNT(*) FROM customers WHERE id > 6;
-- If count looks wrong, DON'T DELETE!

-- If count is correct:
DELETE FROM customers WHERE id > 6;

/*
6. Add confirmation in application code:
*/
-- In application (pseudo-code):
if (user_confirmed) {
    DELETE FROM customers WHERE id = user_id;
}

/*
REAL-WORLD SCENARIOS:

Scenario 1: User Account Deletion (GDPR Compliance)
*/
-- User requests account deletion
START TRANSACTION;

-- Delete user's orders
DELETE FROM orders WHERE customer_id = 11;

-- Delete user's reviews
DELETE FROM reviews WHERE customer_id = 11;

-- Delete user account
DELETE FROM customers WHERE id = 11;

COMMIT;
-- All related data deleted in one atomic transaction

/*
Scenario 2: Cleaning Up Old Data
*/
-- Delete orders older than 5 years
DELETE FROM orders
WHERE order_date < DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- Delete expired sessions
DELETE FROM user_sessions
WHERE expires_at < NOW();

-- Delete unverified accounts older than 7 days
DELETE FROM customers
WHERE is_verified = FALSE
  AND created_at < DATE_SUB(NOW(), INTERVAL 7 DAY);

/*
Scenario 3: Removing Test Data
*/
-- Delete all test customers
DELETE FROM customers
WHERE email LIKE '%@test.com' OR email LIKE '%@example.com';

-- Delete test orders
DELETE FROM orders
WHERE customer_id IN (
    SELECT id FROM customers WHERE email LIKE '%@test.com'
);

/*
Scenario 4: Data Quality - Remove Duplicates
*/
-- Find and delete duplicate customers (keep oldest)
DELETE c1 FROM customers c1
INNER JOIN customers c2
WHERE c1.email = c2.email
  AND c1.id > c2.id;
-- Keeps customer with lower ID (older account)

/*
Scenario 5: Cascade Delete (with foreign keys)
*/
-- If foreign key with ON DELETE CASCADE is set:
DELETE FROM customers WHERE id = 11;
-- Automatically deletes related orders, reviews, etc.

-- Without cascade, manual deletion needed:
DELETE FROM order_items WHERE order_id IN (SELECT id FROM orders WHERE customer_id = 11);
DELETE FROM orders WHERE customer_id = 11;
DELETE FROM customers WHERE id = 11;

/*
PERFORMANCE CONSIDERATIONS:

1. Deleting with indexes:
*/
-- Fast (indexed column):
DELETE FROM customers WHERE id = 11;  -- id is PRIMARY KEY (indexed)

-- Slower (non-indexed column):
DELETE FROM customers WHERE phone = '555-0123';  -- phone not indexed

-- Consider adding index for frequently deleted columns:
CREATE INDEX idx_phone ON customers(phone);

/*
2. Bulk delete vs individual deletes:
*/
-- ❌ Slow (individual deletes in loop):
DELETE FROM customers WHERE id = 1;
DELETE FROM customers WHERE id = 2;
DELETE FROM customers WHERE id = 3;
-- ... 1000 times

-- ✓ Fast (single bulk delete):
DELETE FROM customers WHERE id IN (1, 2, 3, ..., 1000);
-- Or:
DELETE FROM customers WHERE id BETWEEN 1 AND 1000;

/*
3. DELETE vs TRUNCATE (for deleting all rows):
*/
-- TRUNCATE: Faster, resets AUTO_INCREMENT
TRUNCATE TABLE customers;  -- Instant, cannot rollback

-- DELETE: Slower, keeps AUTO_INCREMENT
DELETE FROM customers;  -- Logs each row, can rollback in transaction

/*
4. Archiving before deletion (best practice for large deletes):
*/
-- Step 1: Move to archive table
INSERT INTO customers_archive
SELECT * FROM customers WHERE id > 6;

-- Step 2: Verify archive
SELECT COUNT(*) FROM customers_archive;

-- Step 3: Delete from main table
DELETE FROM customers WHERE id > 6;

/*
CHECKING DELETED DATA:

After DELETE, verify:
*/
-- Check remaining data
SELECT * FROM customers;

-- Check specific IDs were deleted
SELECT * FROM customers WHERE id = 11;  -- Should return no rows

-- Count total rows
SELECT COUNT(*) FROM customers;

-- Check affected rows (immediately after DELETE)
-- MySQL returns: "Query OK, X rows affected"

/*
RECOVERING DELETED DATA:

If deletion was a mistake:

1. From transaction rollback (if not committed):
*/
START TRANSACTION;
DELETE FROM customers WHERE id > 6;
-- Oh no, mistake!
ROLLBACK;  -- Data restored!

/*
2. From backup:
*/
-- Restore from backup table
INSERT INTO customers
SELECT * FROM customers_backup
WHERE id > 6;

-- Or restore entire table from SQL dump
SOURCE customers_backup.sql;

/*
3. From binary logs (MySQL - advanced):
*/
-- Use mysqlbinlog to replay transactions up to point before deletion
-- This is complex and requires DBA knowledge

/*
4. From point-in-time restore (cloud databases):
*/
-- AWS RDS, Azure SQL, Google Cloud SQL offer point-in-time recovery
-- Restore database to timestamp before deletion

/*
COMMON MISTAKES TO AVOID:

1. ❌ Forgetting WHERE clause:
*/
DELETE FROM customers;  -- ❌ Deletes EVERYTHING!

-- ✓ Correct:
DELETE FROM customers WHERE id = 11;

/*
2. ❌ Using = instead of IN for multiple values:
*/
DELETE FROM customers WHERE id = 1 OR id = 2 OR id = 3;  -- ⚠️ Works but verbose

-- ✓ Better:
DELETE FROM customers WHERE id IN (1, 2, 3);

/*
3. ❌ Wrong NULL comparison:
*/
DELETE FROM customers WHERE score = NULL;  -- ❌ Wrong! Always returns 0 rows

-- ✓ Correct:
DELETE FROM customers WHERE score IS NULL;

/*
4. ❌ Not testing condition first:
*/
DELETE FROM customers WHERE country = 'USA';  -- ❌ Immediate execution

-- ✓ Correct: Test first
SELECT * FROM customers WHERE country = 'USA';  -- Verify first
DELETE FROM customers WHERE country = 'USA';  -- Then delete

/*
5. ❌ Not using transaction for important deletes:
*/
DELETE FROM customers WHERE id IN (1, 2, 3);  -- ❌ Immediate commit

-- ✓ Correct:
START TRANSACTION;
DELETE FROM customers WHERE id IN (1, 2, 3);
COMMIT;  -- Or ROLLBACK if mistake

/*
6. ❌ Ignoring foreign key constraints:
*/
DELETE FROM departments WHERE dept_id = 5;
-- ❌ Fails if employees reference this department

-- ✓ Correct: Delete in proper order
DELETE FROM employees WHERE dept_id = 5;  -- Child first
DELETE FROM departments WHERE dept_id = 5;  -- Parent second

/*
7. ❌ Not backing up before bulk delete:
*/
DELETE FROM customers WHERE created_at < '2020-01-01';  -- ❌ No backup

-- ✓ Correct:
CREATE TABLE old_customers AS
SELECT * FROM customers WHERE created_at < '2020-01-01';
DELETE FROM customers WHERE created_at < '2020-01-01';

/*
DELETE vs DROP vs TRUNCATE COMPARISON:

DELETE FROM customers WHERE id = 11;
- Removes specific rows based on condition
- Table structure remains
- Can use WHERE clause
- Can be rolled back (in transaction)
- Slower (logs each row)
- Triggers are fired
- AUTO_INCREMENT not reset
- Use when: Deleting specific rows

TRUNCATE TABLE customers;
- Removes ALL rows (cannot use WHERE)
- Table structure remains
- Cannot be rolled back (usually)
- Very fast (doesn't log rows)
- Triggers NOT fired (usually)
- AUTO_INCREMENT reset to 1
- Use when: Emptying entire table

DROP TABLE customers;
- Removes entire table (structure + data)
- Table no longer exists
- Cannot be rolled back
- Very fast
- Triggers irrelevant (table gone)
- Use when: Removing table permanently

Visual Summary:
                DELETE          TRUNCATE        DROP
Structure     ✓ Kept          ✓ Kept          ✗ Removed
Data          ✗ Removed       ✗ All Removed   ✗ Removed
WHERE clause  ✓ Yes           ✗ No            ✗ No
Rollback      ✓ Yes*          ✗ No**          ✗ No
Speed         🐢 Slow         ⚡ Very Fast     ⚡ Fast
Triggers      ✓ Fired         ✗ Not Fired     N/A
Auto Reset    ✗ No            ✓ Yes           N/A

*Within transaction
**Some databases allow in transaction

AUDIT AND LOGGING:

For important deletions, consider audit trail:
*/
-- Before deleting, log the action
INSERT INTO audit_log (user_id, action, table_name, record_id, timestamp)
VALUES (CURRENT_USER(), 'DELETE', 'customers', 11, NOW());

-- Then delete
DELETE FROM customers WHERE id = 11;

-- Or create trigger for automatic logging:
CREATE TRIGGER before_customer_delete
BEFORE DELETE ON customers
FOR EACH ROW
INSERT INTO audit_log (action, table_name, record_id, old_data, timestamp)
VALUES ('DELETE', 'customers', OLD.id, JSON_OBJECT('name', OLD.first_name, 'country', OLD.country), NOW());

/*
HINGLISH SUMMARY:

DELETE statement table se specific rows ko remove karne ke liye use hoti hai.

Query 1: DELETE FROM customers WHERE id = 11;
- Sirf ek row delete hoti hai (id = 11)
- WHERE clause specify karta hai kaunsi row delete karni hai
- Safe operation - targeted deletion

Query 2: DELETE FROM customers WHERE id > 6;
- Multiple rows delete hoti hain (id greater than 6)
- Sabhi matching rows ek saath delete ho jaati hain
- Zyada dangerous - bulk deletion

WHERE clause BOHOT IMPORTANT hai:
- WHERE ke bina: SAARI rows delete (disaster!)
- WHERE ke saath: Sirf matching rows delete
- Hamesha WHERE use karo unless truly sab delete karna ho

DELETE vs TRUNCATE vs DROP:
- DELETE: Specific rows, WHERE clause, rollback possible
- TRUNCATE: Saari rows, fast, no WHERE, no rollback
- DROP: Puri table + data, permanent

Safety practices:
1. Pehle SELECT se test karo: SELECT * FROM customers WHERE id > 6;
2. Transaction use karo: START TRANSACTION; ... COMMIT; (ya ROLLBACK;)
3. Backup banao: CREATE TABLE backup AS SELECT * FROM customers;
4. Count check karo: SELECT COUNT(*) FROM customers WHERE id > 6;
5. Development mein pehle test karo

Common mistakes:
❌ WHERE clause bhool jana (sab delete ho jayega!)
❌ Galat condition (wrong rows delete hongi)
❌ NULL comparison mein = use karna (IS NULL use karo)
❌ Bina test kiye direct DELETE karna
❌ Foreign key constraints ignore karna
❌ Bina backup ke bulk delete karna

Performance tips:
- Indexed columns pe WHERE fast hai
- Bulk delete individual deletes se fast hai
- Large deletes ke liye pehle archive karo
- TRUNCATE, DELETE se fast hai (jab sab delete karna ho)

Recovery options:
- Transaction ROLLBACK (agar committed nahi hai)
- Backup se restore karo
- Point-in-time recovery (cloud databases)
- Binary logs se replay (advanced)

Hamesha yaad rakho: DELETE permanent hai (agar commit ho gaya)!
Test, backup, aur transaction ka use karo production mein.

KEY TAKEAWAYS:
✓ ALWAYS use WHERE clause (unless deleting all)
✓ Test with SELECT before DELETE
✓ Use transactions for safety (ROLLBACK option)
✓ Backup data before bulk deletes
✓ Count rows before deleting
✓ Handle foreign key constraints properly
✓ Consider archiving before deletion
✓ Use proper NULL comparison (IS NULL)
✓ Be extra careful with bulk deletes
✓ Audit important deletions
✓ Understand DELETE vs TRUNCATE vs DROP
✓ Test in development first

=================================================================
*/

-- DML: DELETE Statements

-- Query 1: Delete single row by ID
DELETE FROM customers
WHERE id = 11;

-- Query 2: Delete multiple rows with range condition
DELETE FROM customers
WHERE id > 6;
