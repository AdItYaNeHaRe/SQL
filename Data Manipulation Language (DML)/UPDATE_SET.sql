/*
=================================================================
QUERY PURPOSE: Modify/update existing data in the customers table
=================================================================

CONCEPT EXPLANATION (English):
UPDATE is a DML (Data Manipulation Language) statement used to modify
existing data in a table. Unlike INSERT (which adds new rows) or DELETE
(which removes rows), UPDATE changes the values in existing rows.

Key characteristics of UPDATE:
- Modifies existing data without adding or removing rows
- Can update one or multiple columns simultaneously
- WHERE clause determines which rows to update
- Without WHERE clause, updates ALL rows (dangerous!)
- Can be rolled back if used within a transaction
- Logs each updated row
- Triggers are fired for each updated row
- Can use expressions, functions, and calculations in SET clause
- Can reference the current row's values in calculations

UPDATE is essential for maintaining and correcting data, implementing
business logic changes, and keeping database information current.

CONCEPT EXPLANATION (Hinglish):
UPDATE ek DML (Data Manipulation Language) statement hai jo table mein
existing data ko modify karne ke liye use hoti hai. INSERT se unlike
(jo naye rows add karta hai) ya DELETE se unlike (jo rows remove karta
hai), UPDATE existing rows ki values ko change karta hai.

UPDATE ki key characteristics:
- Existing data ko modify karta hai bina rows add ya remove kiye
- Ek saath ek ya multiple columns update kar sakta hai
- WHERE clause decide karta hai kaunsi rows update hongi
- WHERE ke bina, SAARI rows update ho jaati hain (dangerous!)
- Transaction ke andar rollback ho sakta hai
- Har updated row ko log karta hai
- Har updated row ke liye triggers fire hote hain
- SET clause mein expressions, functions, calculations use kar sakte hain
- Current row ki values ko calculations mein reference kar sakte hain

UPDATE data maintain karne, correct karne, business logic changes
implement karne, aur database information ko current rakhne ke liye
zaroori hai.

USE CASES:
- Correcting data entry errors or typos
- Updating user profile information (email, phone, address)
- Changing order status (pending → shipped → delivered)
- Applying price changes to products
- Updating inventory quantities after sales
- Marking records as active/inactive
- Implementing score/rating adjustments
- Applying bulk discounts or promotions
- Updating timestamps (last_login, last_modified)
- Normalizing or cleaning data (UPPER case, formatting)
- Implementing business rule changes
- Filling in missing/NULL values with defaults

SPECIFIC QUERY BREAKDOWN:

=================================================================
QUERY 1: UPDATE Single Row with Specific ID
=================================================================

UPDATE customers
SET score = 95
WHERE id = 11;

Line 1: UPDATE customers
  → UPDATE: SQL command to modify existing data
  → customers: Target table name where data will be updated

Line 2: SET score = 95
  → SET: Keyword that precedes the column assignments
  → score: Column name to be updated
  → =: Assignment operator (not comparison!)
  → 95: New value to be assigned to the score column
  → Can update multiple columns: SET col1 = val1, col2 = val2

Line 3: WHERE id = 11;
  → WHERE: Condition clause - determines which rows to update
  → id = 11: Only rows where id equals 11 will be updated
  → Without WHERE: ALL rows would be updated (disaster!)
  → ; : Statement terminator

HOW IT WORKS:
1. Database scans customers table
2. Finds all rows where id = 11
3. Sets score column to 95 for matching row(s)
4. Returns number of affected rows
5. Other columns remain unchanged

Before UPDATE:
id | first_name | country    | score
---|------------|------------|-------
7  | Anjali     | India      | 88
10 | Noah       | UK         | 75
11 | Emma       | Australia  | NULL    ← This row will be updated

After UPDATE:
id | first_name | country    | score
---|------------|------------|-------
7  | Anjali     | India      | 88
10 | Noah       | UK         | 75
11 | Emma       | Australia  | 95      ← score changed from NULL to 95

Changes:
- Emma's score: NULL → 95
- All other columns unchanged (first_name, country still same)
- All other rows unchanged

Result: "1 row affected" or "Query OK, 1 row updated"

⚠️ IMPORTANT NOTES:
- Only the score column is modified
- If id=11 doesn't exist: 0 rows affected (no error)
- If multiple rows have id=11: all would be updated (shouldn't happen with PRIMARY KEY)
- Update is permanent once committed
- Original value (NULL) is lost unless backed up

=================================================================
QUERY 2: UPDATE Multiple Rows Based on Condition
=================================================================

UPDATE customers
SET score = 100
WHERE score IS NULL;

Line 1: UPDATE customers
  → Same as Query 1

Line 2: SET score = 100
  → Sets score column to 100
  → Replaces NULL values with 100

Line 3: WHERE score IS NULL;
  → WHERE score IS NULL: Finds all rows where score is NULL
  → IS NULL: Proper way to check for NULL (not = NULL)
  → Affects MULTIPLE rows (all with NULL scores)
  → Note: Using = NULL would not work (always false)

HOW IT WORKS:
1. Database scans entire customers table
2. Finds ALL rows where score IS NULL
3. Sets score to 100 for each matching row
4. Returns total number of updated rows

Before UPDATE:
id | first_name | country    | score
---|------------|------------|-------
7  | Anjali     | India      | 88      ← Not NULL (no change)
8  | Liam       | Canada     | 92      ← Not NULL (no change)
9  | Sophia     | USA        | NULL    ← NULL (will update)
10 | Noah       | UK         | 75      ← Not NULL (no change)
11 | Emma       | Australia  | NULL    ← NULL (will update)
15 | Oliver     | France     | NULL    ← NULL (will update)

After UPDATE:
id | first_name | country    | score
---|------------|------------|-------
7  | Anjali     | India      | 88      ← Unchanged
8  | Liam       | Canada     | 92      ← Unchanged
9  | Sophia     | USA        | 100     ← Changed: NULL → 100
10 | Noah       | UK         | 75      ← Unchanged
11 | Emma       | Australia  | 100     ← Changed: NULL → 100
15 | Oliver     | France     | 100     ← Changed: NULL → 100

Changes:
- All NULL scores changed to 100
- Rows with existing scores unchanged
- 3 rows affected (assuming 3 had NULL scores)

Result: "3 rows affected" or "Query OK, 3 rows updated"

⚠️ CRITICAL NOTES:
- This is a BULK update (multiple rows)
- All NULL scores become 100 simultaneously
- Be careful: once updated, you can't tell which were originally NULL
- Consider backing up or logging before bulk updates

WHERE CLAUSE CONDITIONS FOR UPDATE:

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

NULL Handling:
IS NULL : Check if value is NULL
IS NOT NULL : Check if value is not NULL

Pattern Matching:
LIKE : Pattern matching with wildcards
IN : Matches any value in a list
BETWEEN : Within a range

EXAMPLES:

Example 1: UPDATE single column with exact match
*/
UPDATE customers
SET country = 'United Kingdom'
WHERE country = 'UK';
-- Changes 'UK' to full name 'United Kingdom'

-- Example 2: UPDATE multiple columns at once
UPDATE customers
SET score = 90,
    country = 'India'
WHERE id = 7;
-- Updates both score AND country for customer 7

-- Example 3: UPDATE using expressions and calculations
UPDATE customers
SET score = score + 5
WHERE country = 'India';
-- Adds 5 points to all Indian customers' scores
-- Uses current value in calculation

-- Example 4: UPDATE using mathematical operations
UPDATE products
SET price = price * 1.10
WHERE category = 'Electronics';
-- Increases all electronics prices by 10%

-- Example 5: UPDATE using string functions
UPDATE customers
SET first_name = UPPER(first_name),
    country = LOWER(country)
WHERE id = 11;
-- Converts name to UPPERCASE, country to lowercase

-- Example 6: UPDATE with multiple conditions (AND)
UPDATE customers
SET score = 85
WHERE country = 'USA' AND score < 70;
-- Updates only USA customers with score below 70

-- Example 7: UPDATE with OR condition
UPDATE customers
SET score = 80
WHERE country = 'USA' OR country = 'Canada';
-- Updates customers from either USA or Canada

-- Example 8: UPDATE using IN operator
UPDATE customers
SET score = 95
WHERE id IN (1, 3, 5, 7, 9);
-- Updates multiple specific IDs at once

-- Example 9: UPDATE using BETWEEN
UPDATE customers
SET country = 'North America'
WHERE score BETWEEN 80 AND 90;
-- Updates customers with scores from 80 to 90

-- Example 10: UPDATE using LIKE (pattern matching)
UPDATE customers
SET country = 'USA'
WHERE first_name LIKE 'J%';
-- Updates customers whose name starts with 'J'

-- Example 11: UPDATE with date functions
UPDATE orders
SET shipping_date = NOW(),
    status = 'Shipped'
WHERE order_id = 1001;
-- Sets shipping date to current timestamp

-- Example 12: UPDATE with CASE statement (conditional logic)
UPDATE customers
SET score = CASE
    WHEN score < 70 THEN score + 10
    WHEN score BETWEEN 70 AND 89 THEN score + 5
    WHEN score >= 90 THEN score + 2
    ELSE score
END
WHERE country = 'India';
-- Different score increases based on current score

-- Example 13: UPDATE using subquery
UPDATE customers
SET score = (
    SELECT AVG(score)
    FROM customers
    WHERE country = 'USA'
)
WHERE id = 11;
-- Sets customer 11's score to USA average

-- Example 14: UPDATE with JOIN (MySQL syntax)
UPDATE customers c
INNER JOIN orders o ON c.id = o.customer_id
SET c.score = c.score + 5
WHERE o.order_total > 1000;
-- Increases score for customers with orders over $1000

-- Example 15: UPDATE to NULL (clearing data)
UPDATE customers
SET score = NULL
WHERE score < 50;
-- Sets low scores back to NULL

-- Example 16: UPDATE using CONCAT (string concatenation)
UPDATE customers
SET first_name = CONCAT(first_name, ' (VIP)')
WHERE score > 95;
-- Adds '(VIP)' suffix to high scorers' names

-- Example 17: UPDATE with NOT condition
UPDATE customers
SET score = 70
WHERE country NOT IN ('USA', 'UK', 'Canada');
-- Updates customers from countries other than USA, UK, Canada

-- Example 18: UPDATE based on another column
UPDATE customers
SET country = 'Unknown'
WHERE country IS NULL OR country = '';
-- Replaces NULL or empty countries with 'Unknown'

-- Example 19: UPDATE with date arithmetic
UPDATE subscriptions
SET expiry_date = DATE_ADD(expiry_date, INTERVAL 1 MONTH)
WHERE status = 'Active';
-- Extends all active subscriptions by 1 month

-- Example 20: UPDATE using REPLACE function
UPDATE customers
SET phone = REPLACE(phone, '-', '')
WHERE phone LIKE '%-%';
-- Removes dashes from phone numbers

/*
DANGEROUS UPDATE OPERATIONS:

⚠️ WARNING 1: UPDATE without WHERE (UPDATES EVERYTHING!)
*/
UPDATE customers
SET score = 100;
-- ❌ DISASTER! Sets ALL customers' scores to 100
-- Every single row affected, original scores lost

-- ✓ ALWAYS use WHERE unless truly updating all rows:
UPDATE customers
SET score = 100
WHERE score IS NULL;

/*
⚠️ WARNING 2: UPDATE with wrong condition
*/
UPDATE customers
SET score = 0
WHERE country = 'USA';  -- Oops! Meant to update only inactive users
-- ❌ Sets ALL USA customers' scores to 0

-- ✓ Correct:
UPDATE customers
SET score = 0
WHERE country = 'USA' AND is_active = FALSE;

/*
⚠️ WARNING 3: Using = instead of IS for NULL
*/
UPDATE customers
SET score = 100
WHERE score = NULL;  -- ❌ Wrong! Never matches (always false)
-- 0 rows updated (even if NULL values exist)

-- ✓ Correct:
UPDATE customers
SET score = 100
WHERE score IS NULL;

/*
SAFETY BEST PRACTICES:

1. ALWAYS test with SELECT first:
*/
-- Step 1: Test the condition with SELECT
SELECT * FROM customers WHERE score IS NULL;
-- Check: Are these the rows you want to update?

-- Step 2: Preview what will change
SELECT
    id,
    first_name,
    score AS old_score,
    100 AS new_score
FROM customers
WHERE score IS NULL;

-- Step 3: If correct, run UPDATE
UPDATE customers
SET score = 100
WHERE score IS NULL;

/*
2. Use transactions for safety (allows rollback):
*/
START TRANSACTION;

UPDATE customers
SET score = 95
WHERE id = 11;

-- Check result
SELECT * FROM customers WHERE id = 11;

-- If mistake, rollback:
ROLLBACK;  -- Undoes the UPDATE

-- If correct, commit:
COMMIT;  -- Makes UPDATE permanent

/*
3. Create backup before bulk update:
*/
-- Backup the data first
CREATE TABLE customers_backup AS SELECT * FROM customers;

-- Now safe to update
UPDATE customers
SET score = 100
WHERE score IS NULL;

-- If mistake, restore:
UPDATE customers c
INNER JOIN customers_backup b ON c.id = b.id
SET c.score = b.score;

/*
4. Count rows before updating:
*/
-- Check how many rows will be affected
SELECT COUNT(*) FROM customers WHERE score IS NULL;
-- If count looks wrong, DON'T UPDATE!

-- If count is correct:
UPDATE customers
SET score = 100
WHERE score IS NULL;

/*
5. Use LIMIT for testing (MySQL):
*/
UPDATE customers
SET score = 100
WHERE score IS NULL
LIMIT 5;
-- Updates only first 5 matching rows (safer for testing)

/*
6. Log changes before updating:
*/
-- Insert into audit log before update
INSERT INTO audit_log (table_name, action, old_value, new_value, changed_at)
SELECT
    'customers' AS table_name,
    'UPDATE' AS action,
    score AS old_value,
    100 AS new_value,
    NOW() AS changed_at
FROM customers
WHERE score IS NULL;

-- Then update
UPDATE customers SET score = 100 WHERE score IS NULL;

/*
REAL-WORLD SCENARIOS:

Scenario 1: User Profile Update
*/
-- User changes their email and phone
UPDATE customers
SET email = 'newemail@example.com',
    phone = '+1-555-9876',
    updated_at = NOW()
WHERE id = 11;

/*
Scenario 2: Order Status Progression
*/
-- Order is shipped
UPDATE orders
SET status = 'Shipped',
    shipped_date = NOW(),
    tracking_number = 'TRACK123456'
WHERE order_id = 1001 AND status = 'Processing';

-- Order is delivered
UPDATE orders
SET status = 'Delivered',
    delivered_date = NOW()
WHERE order_id = 1001 AND status = 'Shipped';

/*
Scenario 3: Inventory Management
*/
-- Reduce stock after sale
UPDATE products
SET stock_quantity = stock_quantity - 3
WHERE product_id = 205;

-- Restock inventory
UPDATE products
SET stock_quantity = stock_quantity + 100,
    last_restock_date = CURDATE()
WHERE product_id = 205;

/*
Scenario 4: Price Adjustment Campaign
*/
-- Apply 20% discount to selected categories
START TRANSACTION;

UPDATE products
SET price = price * 0.80,
    discount_applied = TRUE,
    discount_date = NOW()
WHERE category IN ('Electronics', 'Computers', 'Phones')
  AND stock_quantity > 0;

-- Verify changes
SELECT * FROM products WHERE discount_applied = TRUE;

COMMIT;

/*
Scenario 5: Data Cleaning and Normalization
*/
-- Standardize country names
UPDATE customers SET country = 'USA' WHERE country IN ('US', 'United States', 'U.S.A.');
UPDATE customers SET country = 'UK' WHERE country IN ('United Kingdom', 'Great Britain', 'England');
UPDATE customers SET country = 'India' WHERE country = 'Bharat';

-- Convert names to proper case
UPDATE customers
SET first_name = CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(first_name, 2)));

-- Remove extra spaces
UPDATE customers
SET first_name = TRIM(first_name),
    country = TRIM(country);

/*
Scenario 6: Bulk Status Change
*/
-- Mark inactive accounts (no login in 2 years)
UPDATE users
SET is_active = FALSE,
    deactivation_reason = 'Inactivity',
    deactivated_at = NOW()
WHERE last_login < DATE_SUB(NOW(), INTERVAL 2 YEAR)
  AND is_active = TRUE;

/*
Scenario 7: Score Recalculation
*/
-- Recalculate customer scores based on orders
UPDATE customers c
SET score = (
    SELECT COALESCE(SUM(order_total) / 100, 0)
    FROM orders o
    WHERE o.customer_id = c.id
      AND o.order_date > DATE_SUB(NOW(), INTERVAL 1 YEAR)
);

/*
Scenario 8: Setting Default Values for NULL Fields
*/
-- Fill missing scores with category average
UPDATE customers c
SET score = (
    SELECT AVG(score)
    FROM customers
    WHERE country = c.country
      AND score IS NOT NULL
)
WHERE score IS NULL;

/*
Scenario 9: Implementing Business Rules
*/
-- Upgrade to VIP status if score > 95
UPDATE customers
SET membership_tier = 'VIP',
    vip_since = NOW(),
    discount_percentage = 15
WHERE score > 95
  AND membership_tier != 'VIP';

/*
Scenario 10: Time-based Updates
*/
-- Expire old sessions
UPDATE user_sessions
SET is_expired = TRUE,
    expired_at = NOW()
WHERE last_activity < DATE_SUB(NOW(), INTERVAL 30 MINUTE)
  AND is_expired = FALSE;

/*
PERFORMANCE CONSIDERATIONS:

1. Updating with indexes:
*/
-- Fast (indexed column in WHERE):
UPDATE customers SET score = 95 WHERE id = 11;  -- id is PRIMARY KEY

-- Slower (non-indexed column in WHERE):
UPDATE customers SET score = 95 WHERE phone = '555-0123';

-- Consider adding index:
CREATE INDEX idx_phone ON customers(phone);

/*
2. Bulk update vs individual updates:
*/
-- ❌ Slow (individual updates):
UPDATE customers SET score = 100 WHERE id = 1;
UPDATE customers SET score = 100 WHERE id = 2;
UPDATE customers SET score = 100 WHERE id = 3;
-- ... 1000 times

-- ✓ Fast (single bulk update):
UPDATE customers
SET score = 100
WHERE id IN (1, 2, 3, ..., 1000);

/*
3. Updating with complex calculations:
*/
-- May be slow on large tables:
UPDATE customers
SET score = (
    SELECT AVG(order_total)
    FROM orders
    WHERE customer_id = customers.id
) * 0.1;
-- Runs subquery for EACH row

-- Consider pre-calculating in temp table:
CREATE TEMPORARY TABLE score_calc AS
SELECT customer_id, AVG(order_total) * 0.1 AS new_score
FROM orders
GROUP BY customer_id;

UPDATE customers c
INNER JOIN score_calc sc ON c.id = sc.customer_id
SET c.score = sc.new_score;

/*
4. Locking considerations:
*/
-- UPDATE locks rows being modified
-- Long-running UPDATEs can block other queries
-- Consider breaking into smaller batches:
UPDATE customers SET score = 100 WHERE id BETWEEN 1 AND 1000;
UPDATE customers SET score = 100 WHERE id BETWEEN 1001 AND 2000;
-- Allows other queries to proceed between batches

/*
CHECKING UPDATED DATA:

After UPDATE, verify:
*/
-- Check specific updated row
SELECT * FROM customers WHERE id = 11;

-- Check all updated rows
SELECT * FROM customers WHERE score = 100;

-- Compare before/after (if you have backup)
SELECT
    c.id,
    c.first_name,
    b.score AS old_score,
    c.score AS new_score
FROM customers c
LEFT JOIN customers_backup b ON c.id = b.id
WHERE c.score != b.score OR (c.score IS NULL AND b.score IS NOT NULL) OR (c.score IS NOT NULL AND b.score IS NULL);

-- Check affected rows immediately after UPDATE
-- MySQL returns: "Query OK, X rows affected"

/*
COMMON MISTAKES TO AVOID:

1. ❌ Forgetting WHERE clause:
*/
UPDATE customers SET score = 95;  -- ❌ Updates ALL rows!

-- ✓ Correct:
UPDATE customers SET score = 95 WHERE id = 11;

/*
2. ❌ Using = for NULL comparison:
*/
UPDATE customers SET score = 100 WHERE score = NULL;  -- ❌ Never matches

-- ✓ Correct:
UPDATE customers SET score = 100 WHERE score IS NULL;

/*
3. ❌ Circular or conflicting updates:
*/
UPDATE customers
SET score = score + 10
WHERE score > 90;
-- Then immediately:
UPDATE customers
SET score = score - 5
WHERE score > 95;
-- Second update may affect rows changed by first

-- ✓ Better: Combine logic
UPDATE customers
SET score = CASE
    WHEN score > 95 THEN score + 5  -- +10 -5 = +5
    WHEN score > 90 THEN score + 10
    ELSE score
END;

/*
4. ❌ Updating primary/foreign keys without care:
*/
UPDATE customers SET id = 999 WHERE id = 11;  -- ❌ Breaks relationships!

-- ✓ Be very careful with keys, ensure referential integrity

/*
5. ❌ Not considering data type limits:
*/
UPDATE customers SET score = 150 WHERE id = 11;
-- ⚠️ If score is TINYINT (max 127), this may fail or truncate

-- ✓ Verify data type limits before updating

/*
6. ❌ Updating without checking current value:
*/
UPDATE customers SET score = score + 10 WHERE id = 11;
-- ⚠️ If score was NULL, result is NULL (NULL + 10 = NULL)

-- ✓ Handle NULL:
UPDATE customers
SET score = COALESCE(score, 0) + 10
WHERE id = 11;

/*
7. ❌ Not using transactions for critical updates:
*/
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
-- ⚠️ If second UPDATE fails, money disappears!

-- ✓ Correct: Use transaction
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;

/*
UPDATE ADVANCED PATTERNS:

1. Swap values between rows:
*/
-- Swap scores between two customers (requires temp value)
START TRANSACTION;
UPDATE customers SET score = -1 WHERE id = 1;  -- Temp value
UPDATE customers c1
INNER JOIN customers c2 ON c1.id = 1 AND c2.id = 2
SET c1.score = c2.score;
UPDATE customers SET score = (SELECT score FROM customers WHERE id = 2) WHERE id = 1;
COMMIT;

/*
2. Update with ranking:
*/
UPDATE customers c
SET rank = (
    SELECT COUNT(*) + 1
    FROM customers c2
    WHERE c2.score > c.score
);

/*
3. Conditional update based on existence:
*/
UPDATE customers
SET has_orders = EXISTS (
    SELECT 1 FROM orders WHERE customer_id = customers.id
);

/*
4. Update with aggregation from related table:
*/
UPDATE customers c
SET total_spent = (
    SELECT COALESCE(SUM(order_total), 0)
    FROM orders
    WHERE customer_id = c.id
),
order_count = (
    SELECT COUNT(*)
    FROM orders
    WHERE customer_id = c.id
);

/*
HINGLISH SUMMARY:

UPDATE statement existing rows ki values ko modify karne ke liye use hoti hai.

Query 1: UPDATE customers SET score = 95 WHERE id = 11;
- Sirf ek row update hoti hai (id = 11)
- score column ki value 95 set ho jaati hai
- Baaki columns unchanged rahte hain
- Safe operation - targeted update

Query 2: UPDATE customers SET score = 100 WHERE score IS NULL;
- Multiple rows update hoti hain (jahan score NULL hai)
- Saari NULL scores 100 ban jaati hain
- Bulk update - ek saath multiple rows change

WHERE clause CRITICAL hai:
- WHERE ke bina: SAARI rows update (disaster!)
- WHERE ke saath: Sirf matching rows update
- Hamesha WHERE use karo unless truly sab update karna ho

SET clause mein:
- Single column: SET score = 95
- Multiple columns: SET score = 95, country = 'India'
- Expressions: SET score = score + 10
- Functions: SET name = UPPER(name)
- Calculations: SET price = price * 1.10

NULL handling:
❌ WHERE score = NULL  (kabhi work nahi karega)
✓ WHERE score IS NULL  (correct tarika)

Safety practices:
1. Pehle SELECT se test: SELECT * FROM customers WHERE score IS NULL;
2. Transaction use karo: START TRANSACTION; ... COMMIT; (ya ROLLBACK;)
3. Backup banao: CREATE TABLE backup AS SELECT * FROM customers;
4. Count check: SELECT COUNT(*) FROM customers WHERE score IS NULL;
5. LIMIT use karo testing ke liye: UPDATE ... LIMIT 5;

Common patterns:
- Score increase: SET score = score + 10
- Price discount: SET price = price * 0.90
- String formatting: SET name = UPPER(name)
- Default values: SET score = 100 WHERE score IS NULL
- Timestamp update: SET updated_at = NOW()

Common mistakes:
❌ WHERE clause missing (sab update ho jayega!)
❌ = NULL use karna (IS NULL chahiye)
❌ Bina test kiye direct UPDATE
❌ Data type limits ignore karna
❌ NULL + number = NULL (handle with COALESCE)
❌ Critical updates bina transaction ke

Performance tips:
- Indexed columns pe WHERE fast hai
- Bulk updates individual updates se fast
- Complex subqueries slow ho sakte hain
- Break large updates into batches

Recovery:
- ROLLBACK (agar transaction mein hai)
- Backup se restore
- Before/after comparison tables

UPDATE vs INSERT vs DELETE:
- INSERT: Naye rows add karta hai
- UPDATE: Existing rows ko modify karta hai
- DELETE: Rows remove karta hai

Hamesha remember: UPDATE permanent hai (once committed)!
Test with SELECT, use transactions, backup data - especially for bulk updates!

KEY TAKEAWAYS:
✓ ALWAYS use WHERE clause (unless updating all)
✓ Test with SELECT before UPDATE
✓ Use transactions for safety (ROLLBACK option)
✓ Backup data before bulk updates
✓ Use IS NULL, not = NULL
✓ SET multiple columns with commas
✓ Can use expressions and functions in SET
✓ Can reference current row values (score + 10)
✓ Count rows before updating
✓ Be careful with NULL arithmetic
✓ Consider data type limits
✓ Use CASE for conditional updates
✓ Test in development first
✓ Verify changes after UPDATE

=================================================================
*/

-- DML: UPDATE Statements

-- Query 1: Update single row with specific ID
UPDATE customers
SET score = 95
WHERE id = 11;

-- Query 2: Update multiple rows based on NULL condition
UPDATE customers
SET score = 100
WHERE score IS NULL;
