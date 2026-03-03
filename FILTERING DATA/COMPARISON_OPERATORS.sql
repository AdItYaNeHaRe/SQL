/*
=================================================================
QUERY PURPOSE: Filter and retrieve specific rows using comparison operators
=================================================================

CONCEPT EXPLANATION (English):
The WHERE clause is used to filter rows in a SELECT statement based on
specified conditions. Comparison operators allow you to compare column
values against specific values or expressions to determine which rows
to include in the result set.

Filtering is fundamental to SQL queries - instead of retrieving all rows
from a table, you can precisely target only the data you need. The WHERE
clause evaluates each row against your condition(s) and includes only
rows where the condition evaluates to TRUE.

Comparison operators are the building blocks of filtering:
- They compare values (numbers, strings, dates)
- Return TRUE, FALSE, or NULL
- Can be combined with logical operators (AND, OR, NOT)
- Work with all data types
- Essential for data retrieval, updates, and deletions

Think of WHERE clause as a "filter" or "sieve" that lets only matching
rows pass through to your result set.

CONCEPT EXPLANATION (Hinglish):
WHERE clause ka use SELECT statement mein rows ko filter karne ke liye
hota hai, specified conditions ke basis pe. Comparison operators aapko
column values ko specific values ya expressions ke saath compare karne
dete hain yeh decide karne ke liye ki kaunsi rows result set mein include
hongi.

Filtering SQL queries ka fundamental part hai - table ki saari rows
retrieve karne ki bajaye, aap sirf woh data target kar sakte ho jo
aapko chahiye. WHERE clause har row ko aapke condition ke against evaluate
karta hai aur sirf woh rows include karta hai jahan condition TRUE hai.

Comparison operators filtering ke building blocks hain:
- Yeh values compare karte hain (numbers, strings, dates)
- TRUE, FALSE, ya NULL return karte hain
- Logical operators ke saath combine ho sakte hain (AND, OR, NOT)
- Sabhi data types ke saath kaam karte hain
- Data retrieval, updates, aur deletions ke liye zaroori hain

WHERE clause ko ek "filter" ya "channi" ki tarah samjho jo sirf matching
rows ko aapke result set mein aane deta hai.

USE CASES:
- Finding specific records (customer with ID = 100)
- Filtering by ranges (scores between 70 and 90)
- Searching for products above/below certain price
- Finding records created after a specific date
- Identifying students who passed/failed (marks >= 40)
- Locating orders above certain amount
- Finding employees with salary greater than average
- Filtering inventory by stock levels
- Searching for expired subscriptions
- Finding high-value customers (purchases > threshold)

SAMPLE DATA (TestData table):

id | marks | name
---|-------|--------
1  | 85    | Alice
2  | 90    | Bob
3  | 75    | Charlie
4  | 85    | Diana
5  | 70    | Eve

This sample data will be used to demonstrate all examples below.

COMPARISON OPERATORS REFERENCE:

Operator | Symbol | Meaning              | Example
---------|--------|----------------------|------------------
Equal    | =      | Exactly equals       | marks = 85
Not Equal| <> or !=| Does not equal      | marks <> 85
Greater  | >      | Greater than         | marks > 80
Less     | <      | Less than            | marks < 80
Gte      | >=     | Greater or equal to  | marks >= 85
Lte      | <=     | Less than or equal   | marks <= 80

Note: <> and != both mean "not equal" (most databases support both)

SPECIFIC QUERY BREAKDOWN:

=================================================================
QUERY 1: Equal Operator (=)
=================================================================

SELECT id, marks FROM TestData WHERE marks = 85;

Line 1: SELECT id, marks
  → SELECT: Retrieves data from database
  → id, marks: Columns to display in result set
  → Only these two columns will be shown (not name)

Line 2: FROM TestData
  → FROM: Specifies source table
  → TestData: Table name containing the data

Line 3: WHERE marks = 85;
  → WHERE: Introduces filter condition
  → marks = 85: Condition - only rows where marks column equals 85
  → =: Equality operator (exact match)
  → 85: Value to compare against
  → ;: Statement terminator

HOW IT WORKS:
1. Database scans TestData table
2. For each row, checks: Is marks = 85?
3. If TRUE (marks is exactly 85): Include row in result
4. If FALSE (marks is not 85): Skip row
5. Returns all matching rows

Result:
id | marks
---|-------
1  | 85     ← Alice (marks = 85, included)
4  | 85     ← Diana (marks = 85, included)

Rows NOT included:
- Row 2 (Bob, marks = 90)     → 90 ≠ 85
- Row 3 (Charlie, marks = 75) → 75 ≠ 85
- Row 5 (Eve, marks = 70)     → 70 ≠ 85

Use Case: Finding exact matches
- Find customer with specific ID
- Locate product with exact price
- Search for specific status (status = 'Active')

=================================================================
QUERY 2: Not Equal Operator (<>)
=================================================================

SELECT id, marks FROM TestData WHERE marks <> 85;

WHERE marks <> 85:
  → <>: Not equal operator (also written as !=)
  → Selects rows where marks is NOT equal to 85
  → Opposite of = operator
  → Returns all rows except those with marks = 85

HOW IT WORKS:
1. Checks each row: Is marks NOT equal to 85?
2. If TRUE (marks is anything except 85): Include row
3. If FALSE (marks is 85): Skip row

Result:
id | marks
---|-------
2  | 90     ← Bob (90 ≠ 85, included)
3  | 75     ← Charlie (75 ≠ 85, included)
5  | 70     ← Eve (70 ≠ 85, included)

Rows NOT included:
- Row 1 (Alice, marks = 85)  → 85 = 85
- Row 4 (Diana, marks = 85)  → 85 = 85

Alternative Syntax:
SELECT id, marks FROM TestData WHERE marks != 85;
-- != is equivalent to <> (both mean "not equal")
-- Most databases support both, but <> is SQL standard

Use Case: Excluding specific values
- Find all products except discontinued ones
- Show orders that are not delivered
- List students who didn't score exactly 85

=================================================================
QUERY 3: Greater Than Operator (>)
=================================================================

SELECT id, marks FROM TestData WHERE marks > 80;

WHERE marks > 80:
  → >: Greater than operator (strictly greater, not equal)
  → Selects rows where marks is more than 80
  → Does NOT include 80 itself (80 > 80 is FALSE)

HOW IT WORKS:
1. Checks each row: Is marks greater than 80?
2. If TRUE (marks > 80): Include row
3. If FALSE (marks ≤ 80): Skip row

Result:
id | marks
---|-------
1  | 85     ← Alice (85 > 80, included)
2  | 90     ← Bob (90 > 80, included)
4  | 85     ← Diana (85 > 80, included)

Rows NOT included:
- Row 3 (Charlie, marks = 75) → 75 ≤ 80
- Row 5 (Eve, marks = 70)     → 70 ≤ 80

Note: 80 itself would NOT be included (80 > 80 is FALSE)

Use Case: Finding values above threshold
- Products priced above $100
- Students who scored above passing grade
- Orders with amount greater than minimum
- Employees with salary above certain level

=================================================================
QUERY 4: Less Than Operator (<)
=================================================================

SELECT id, marks FROM TestData WHERE marks < 80;

WHERE marks < 80:
  → <: Less than operator (strictly less, not equal)
  → Selects rows where marks is less than 80
  → Does NOT include 80 itself (80 < 80 is FALSE)

HOW IT WORKS:
1. Checks each row: Is marks less than 80?
2. If TRUE (marks < 80): Include row
3. If FALSE (marks ≥ 80): Skip row

Result:
id | marks
---|-------
3  | 75     ← Charlie (75 < 80, included)
5  | 70     ← Eve (70 < 80, included)

Rows NOT included:
- Row 1 (Alice, marks = 85)  → 85 ≥ 80
- Row 2 (Bob, marks = 90)    → 90 ≥ 80
- Row 4 (Diana, marks = 85)  → 85 ≥ 80

Note: 80 itself would NOT be included (80 < 80 is FALSE)

Use Case: Finding values below threshold
- Products on clearance (price < $10)
- Students who need improvement (marks < 40)
- Low stock items (quantity < 10)
- Recent dates (date < '2024-01-01')

=================================================================
QUERY 5: Greater Than or Equal Operator (>=)
=================================================================

SELECT id, marks FROM TestData WHERE marks >= 85;

WHERE marks >= 85:
  → >=: Greater than or equal to operator
  → Selects rows where marks is 85 OR MORE
  → INCLUDES 85 itself (85 >= 85 is TRUE)
  → More inclusive than > operator

HOW IT WORKS:
1. Checks each row: Is marks ≥ 85?
2. If TRUE (marks is 85 or more): Include row
3. If FALSE (marks < 85): Skip row

Result:
id | marks
---|-------
1  | 85     ← Alice (85 >= 85, included - boundary case)
2  | 90     ← Bob (90 >= 85, included)
4  | 85     ← Diana (85 >= 85, included - boundary case)

Rows NOT included:
- Row 3 (Charlie, marks = 75) → 75 < 85
- Row 5 (Eve, marks = 70)     → 70 < 85

Difference from >:
marks > 85:  Would NOT include 85 (only 90)
marks >= 85: INCLUDES 85 (both 85 and 90)

Use Case: Minimum threshold inclusion
- Students who passed (marks >= 40)
- Orders meeting minimum amount (>= $50)
- Eligible age (age >= 18)
- Products in stock (quantity >= 1)

=================================================================
QUERY 6: Less Than or Equal Operator (<=)
=================================================================

SELECT id, marks FROM TestData WHERE marks <= 80;

WHERE marks <= 80:
  → <=: Less than or equal to operator
  → Selects rows where marks is 80 OR LESS
  → INCLUDES 80 itself (80 <= 80 is TRUE)
  → More inclusive than < operator

HOW IT WORKS:
1. Checks each row: Is marks ≤ 80?
2. If TRUE (marks is 80 or less): Include row
3. If FALSE (marks > 80): Skip row

Result:
id | marks
---|-------
3  | 75     ← Charlie (75 <= 80, included)
5  | 70     ← Eve (70 <= 80, included)

If there was a row with marks = 80:
id | marks
---|-------
3  | 75
5  | 70
6  | 80     ← Would be included (80 <= 80 is TRUE)

Rows NOT included:
- Row 1 (Alice, marks = 85)  → 85 > 80
- Row 2 (Bob, marks = 90)    → 90 > 80
- Row 4 (Diana, marks = 85)  → 85 > 80

Difference from <:
marks < 80:  Would NOT include 80 (only 75, 70)
marks <= 80: INCLUDES 80 (75, 70, and 80 if present)

Use Case: Maximum threshold inclusion
- Budget items (price <= $100)
- Students needing help (marks <= 50)
- Maximum age limit (age <= 65)
- Items below threshold (stock <= 5)

COMPARISON OPERATORS COMPREHENSIVE EXAMPLES:

Example 1: Equal with strings
*/
SELECT * FROM customers WHERE country = 'USA';
-- Exact match (case-sensitive in some databases)
-- Returns only USA customers

-- Example 2: Not equal with strings
SELECT * FROM customers WHERE status != 'Inactive';
-- Returns all customers except Inactive ones
-- Equivalent to: WHERE status <> 'Inactive'

-- Example 3: Greater than with dates
SELECT * FROM orders WHERE order_date > '2024-01-01';
-- Orders placed after January 1, 2024
-- Excludes '2024-01-01' itself

-- Example 4: Less than with dates
SELECT * FROM subscriptions WHERE expiry_date < CURDATE();
-- Find expired subscriptions
-- Today's date not included (if expired today, use <=)

-- Example 5: Greater or equal with salary
SELECT * FROM employees WHERE salary >= 50000;
-- Employees earning $50,000 or more
-- Includes exactly $50,000

-- Example 6: Less or equal with age
SELECT * FROM users WHERE age <= 18;
-- Users 18 years old or younger
-- Includes exactly 18

-- Example 7: Comparing two columns
SELECT * FROM products WHERE price > cost;
-- Products where selling price exceeds cost
-- Profitable items

-- Example 8: Equal with NULL (WRONG way)
SELECT * FROM customers WHERE email = NULL;
-- ❌ WRONG! Returns 0 rows (NULL = NULL is UNKNOWN, not TRUE)

-- ✓ CORRECT way:
SELECT * FROM customers WHERE email IS NULL;

-- Example 9: Not equal with NULL (WRONG way)
SELECT * FROM customers WHERE email <> NULL;
-- ❌ WRONG! Returns 0 rows

-- ✓ CORRECT way:
SELECT * FROM customers WHERE email IS NOT NULL;

-- Example 10: Decimal comparison
SELECT * FROM products WHERE price >= 99.99;
-- Products priced at $99.99 or more
-- Handles decimal precision

-- Example 11: Negative numbers
SELECT * FROM transactions WHERE amount < 0;
-- Find negative transactions (refunds, charges)

-- Example 12: Boundary testing
SELECT * FROM TestData WHERE marks >= 85 AND marks <= 90;
-- Range: 85 to 90 (inclusive on both ends)
-- Same as: WHERE marks BETWEEN 85 AND 90

-- Example 13: Time comparison
SELECT * FROM logs WHERE log_time > '2024-02-26 14:00:00';
-- Logs after 2 PM on Feb 26, 2024

-- Example 14: Boolean comparison (MySQL uses 1/0)
SELECT * FROM users WHERE is_active = 1;
-- Active users (TRUE)
-- Some databases use: WHERE is_active = TRUE

-- Example 15: Character comparison
SELECT * FROM products WHERE category > 'M';
-- Categories alphabetically after 'M'
-- Returns: 'N', 'O', 'P', 'Z', etc.

-- Example 16: Not equal to multiple values (verbose)
SELECT * FROM customers WHERE country <> 'USA' AND country <> 'UK';
-- Customers not from USA or UK
-- Better way: WHERE country NOT IN ('USA', 'UK')

-- Example 17: Floating point caution
SELECT * FROM measurements WHERE value = 0.1;
-- ⚠️ May not match due to floating point precision
-- Better: WHERE ABS(value - 0.1) < 0.0001

-- Example 18: Case sensitivity (depends on database)
SELECT * FROM users WHERE username = 'John';
-- MySQL (default): Matches 'John', 'john', 'JOHN' (case-insensitive)
-- PostgreSQL: Only matches 'John' (case-sensitive)
-- Use LOWER() or UPPER() for consistency:
SELECT * FROM users WHERE LOWER(username) = 'john';

-- Example 19: Empty string vs NULL
SELECT * FROM customers WHERE email = '';
-- Matches empty string '' (not NULL)
-- Different from: WHERE email IS NULL

-- Example 20: Comparing expressions
SELECT * FROM orders WHERE (price * quantity) > 1000;
-- Orders with total value over $1000
-- Expression evaluated for each row

/*
COMBINING COMPARISON OPERATORS:

Using AND (both conditions must be TRUE):
*/
SELECT id, marks FROM TestData
WHERE marks >= 80 AND marks < 90;
-- Range: 80 to 89 (inclusive of 80, exclusive of 90)
-- Result: marks 80, 85, 85 (rows 1, 4)

-- Using OR (at least one condition must be TRUE):
SELECT id, marks FROM TestData
WHERE marks < 75 OR marks > 90;
-- Values below 75 OR above 90
-- Result: marks 70 (row 5) - if 90+ existed, would include those

-- Using NOT (negates condition):
SELECT id, marks FROM TestData
WHERE NOT (marks = 85);
-- Same as: WHERE marks <> 85
-- Result: All rows except marks = 85

-- Complex combinations with parentheses:
SELECT id, marks FROM TestData
WHERE (marks >= 80 AND marks < 85) OR marks > 90;
-- Marks 80-84 OR greater than 90
-- Result: marks 90 (row 2)

/*
COMMON PATTERNS AND IDIOMS:

Pattern 1: Range checking (inclusive)
*/
SELECT * FROM students WHERE marks >= 40 AND marks <= 100;
-- Passed students (40 to 100)
-- Better alternative: WHERE marks BETWEEN 40 AND 100

-- Pattern 2: Range checking (exclusive)
SELECT * FROM products WHERE price > 10 AND price < 100;
-- Products between $10 and $100 (not including boundaries)

-- Pattern 3: Outside range
SELECT * FROM measurements WHERE value < 0 OR value > 100;
-- Values outside 0-100 range
-- Better: WHERE value NOT BETWEEN 0 AND 100

-- Pattern 4: Top performers
SELECT * FROM students WHERE marks >= 90;
-- A-grade students (90+)

-- Pattern 5: Bottom performers
SELECT * FROM students WHERE marks < 40;
-- Failed students (below 40)

-- Pattern 6: Middle range
SELECT * FROM products WHERE price >= 50 AND price <= 150;
-- Mid-range products

-- Pattern 7: Budget constraint
SELECT * FROM products WHERE price <= 100;
-- Within budget (max $100)

-- Pattern 8: Minimum requirement
SELECT * FROM candidates WHERE experience >= 5;
-- Candidates with 5+ years experience

-- Pattern 9: Age restrictions
SELECT * FROM users WHERE age >= 18 AND age <= 65;
-- Working-age population

-- Pattern 10: Recent records
SELECT * FROM orders WHERE order_date >= DATE_SUB(NOW(), INTERVAL 30 DAY);
-- Orders from last 30 days

/*
REAL-WORLD SCENARIOS:

Scenario 1: E-commerce Product Search
*/
-- Find affordable electronics
SELECT product_name, price
FROM products
WHERE category = 'Electronics'
  AND price <= 500;

-- Find premium products
SELECT product_name, price
FROM products
WHERE price >= 1000;

/*
Scenario 2: Student Grade System
*/
-- Find students who passed
SELECT student_name, marks
FROM students
WHERE marks >= 40;

-- Find students with distinction (90+)
SELECT student_name, marks
FROM students
WHERE marks >= 90;

-- Find students needing improvement
SELECT student_name, marks
FROM students
WHERE marks < 40;

/*
Scenario 3: Inventory Management
*/
-- Low stock alert (reorder needed)
SELECT product_name, stock_quantity
FROM inventory
WHERE stock_quantity < 10;

-- Out of stock items
SELECT product_name
FROM inventory
WHERE stock_quantity = 0;

-- Well-stocked items
SELECT product_name, stock_quantity
FROM inventory
WHERE stock_quantity >= 100;

/*
Scenario 4: HR - Salary Analysis
*/
-- Entry-level employees
SELECT employee_name, salary
FROM employees
WHERE salary < 40000;

-- Mid-level employees
SELECT employee_name, salary
FROM employees
WHERE salary >= 40000 AND salary < 80000;

-- Senior employees
SELECT employee_name, salary
FROM employees
WHERE salary >= 80000;

/*
Scenario 5: Banking - Transaction Monitoring
*/
-- Large transactions (potential fraud)
SELECT transaction_id, amount, account_id
FROM transactions
WHERE amount > 10000;

-- Negative transactions (refunds)
SELECT transaction_id, amount
FROM transactions
WHERE amount < 0;

-- Zero-amount transactions (suspicious)
SELECT transaction_id
FROM transactions
WHERE amount = 0;

/*
Scenario 6: Healthcare - Patient Age Groups
*/
-- Pediatric patients (under 18)
SELECT patient_name, age
FROM patients
WHERE age < 18;

-- Adult patients (18-64)
SELECT patient_name, age
FROM patients
WHERE age >= 18 AND age < 65;

-- Senior patients (65+)
SELECT patient_name, age
FROM patients
WHERE age >= 65;

/*
PERFORMANCE CONSIDERATIONS:

1. Indexes help comparison operators:
*/
-- Fast (if index on marks):
SELECT * FROM TestData WHERE marks = 85;

-- Slower (if no index):
SELECT * FROM TestData WHERE marks > 80;
-- Range scan, but still benefits from index

-- Consider adding index:
CREATE INDEX idx_marks ON TestData(marks);

/*
2. Avoid functions on indexed columns:
*/
-- ❌ Slow (can't use index):
SELECT * FROM orders WHERE YEAR(order_date) = 2024;

-- ✓ Fast (can use index):
SELECT * FROM orders
WHERE order_date >= '2024-01-01'
  AND order_date < '2025-01-01';

/*
3. Be careful with OR (may not use indexes efficiently):
*/
-- May not use indexes optimally:
SELECT * FROM products WHERE price < 10 OR price > 1000;

-- Consider splitting:
SELECT * FROM products WHERE price < 10
UNION
SELECT * FROM products WHERE price > 1000;

/*
COMMON MISTAKES TO AVOID:

1. ❌ Using = with NULL:
*/
SELECT * FROM customers WHERE email = NULL;  -- Returns 0 rows!

-- ✓ Correct:
SELECT * FROM customers WHERE email IS NULL;

/*
2. ❌ Confusing > and >=:
*/
SELECT * FROM students WHERE marks > 40;  -- Excludes 40
-- If passing is 40, should be:
SELECT * FROM students WHERE marks >= 40;  -- Includes 40

/*
3. ❌ Wrong operator for exclusion:
*/
SELECT * FROM orders WHERE status = 'Cancelled';  -- Wrong operator
-- Should be:
SELECT * FROM orders WHERE status != 'Cancelled';

/*
4. ❌ String comparison case issues:
*/
SELECT * FROM users WHERE username = 'john';
-- May not match 'John' in case-sensitive databases

-- ✓ Better:
SELECT * FROM users WHERE LOWER(username) = 'john';

/*
5. ❌ Date comparison without time:
*/
SELECT * FROM orders WHERE order_date = '2024-02-26';
-- May not match if order_date has time component (2024-02-26 14:30:00)

-- ✓ Better:
SELECT * FROM orders WHERE DATE(order_date) = '2024-02-26';
-- Or use range:
SELECT * FROM orders
WHERE order_date >= '2024-02-26'
  AND order_date < '2024-02-27';

/*
6. ❌ Floating point equality:
*/
SELECT * FROM measurements WHERE value = 0.1;
-- May not match due to precision

-- ✓ Better:
SELECT * FROM measurements WHERE ABS(value - 0.1) < 0.0001;

/*
TESTING YOUR UNDERSTANDING:

Given TestData:
id | marks
---|-------
1  | 85
2  | 90
3  | 75
4  | 85
5  | 70

Quiz Questions:
*/

-- Q1: How many rows for marks > 85?
SELECT COUNT(*) FROM TestData WHERE marks > 85;
-- Answer: 1 (only row 2 with marks = 90)

-- Q2: How many rows for marks >= 85?
SELECT COUNT(*) FROM TestData WHERE marks >= 85;
-- Answer: 3 (rows 1, 2, 4 with marks 85, 90, 85)

-- Q3: How many rows for marks != 85?
SELECT COUNT(*) FROM TestData WHERE marks != 85;
-- Answer: 3 (rows 2, 3, 5 with marks 90, 75, 70)

-- Q4: What's the difference between < and <=?
-- Answer: < excludes boundary, <= includes boundary
-- marks < 80: returns 75, 70 (excludes 80)
-- marks <= 80: returns 75, 70, 80 (includes 80)

-- Q5: Which operator for "not equal"?
-- Answer: Both <> and != work (standard is <>)

/*
HINGLISH SUMMARY:

WHERE clause ke saath comparison operators ka use karke hum specific
rows ko filter kar sakte hain.

6 main comparison operators:

1. = (Equal) - Exact match
   SELECT * FROM TestData WHERE marks = 85;
   → Sirf woh rows jahan marks exactly 85 hai

2. <> or != (Not Equal) - Exclude specific value
   SELECT * FROM TestData WHERE marks <> 85;
   → Sabhi rows except marks = 85

3. > (Greater Than) - Values above (boundary excluded)
   SELECT * FROM TestData WHERE marks > 80;
   → Marks 80 se zyada (80 included NAHI)

4. < (Less Than) - Values below (boundary excluded)
   SELECT * FROM TestData WHERE marks < 80;
   → Marks 80 se kam (80 included NAHI)

5. >= (Greater Than or Equal) - Minimum threshold
   SELECT * FROM TestData WHERE marks >= 85;
   → Marks 85 ya zyada (85 included HAI)

6. <= (Less Than or Equal) - Maximum threshold
   SELECT * FROM TestData WHERE marks <= 80;
   → Marks 80 ya kam (80 included HAI)

Key differences:
- > excludes boundary, >= includes boundary
- < excludes boundary, <= includes boundary
- = exact match chahiye
- <> ya != exclusion ke liye

Common use cases:
- Range checking: marks >= 40 AND marks <= 100
- Threshold: price <= 100 (budget)
- Minimum requirement: age >= 18
- Exclusion: status != 'Cancelled'

NULL handling (IMPORTANT):
❌ WHERE marks = NULL  (galat - kabhi kaam nahi karega)
✓ WHERE marks IS NULL  (sahi tarika)

Combining operators:
- AND: Dono conditions TRUE chahiye
- OR: Kam se kam ek condition TRUE chahiye
- NOT: Condition ko negate karta hai

Performance tips:
- Indexed columns pe fast
- Functions avoid karo indexed columns pe
- Range queries index use kar sakte hain

Common mistakes:
❌ = NULL use karna (IS NULL chahiye)
❌ > aur >= confuse karna
❌ Case sensitivity ignore karna strings mein
❌ Date+time comparison mein sirf date check karna

Real-world examples:
- Students: marks >= 40 (passed)
- Products: price <= 100 (budget items)
- Inventory: stock < 10 (low stock alert)
- Age: age >= 18 (adults)
- Salary: salary >= 50000 (mid-level)

Remember:
- Hamesha sahi operator choose karo
- Boundary cases check karo (=, >=, <=)
- NULL ke liye IS NULL/IS NOT NULL use karo
- Test karo pehle sample data pe

KEY TAKEAWAYS:
✓ WHERE clause filters rows based on conditions
✓ = for exact match, <> or != for exclusion
✓ > and < exclude boundary values
✓ >= and <= include boundary values
✓ Use IS NULL for NULL checks, not =
✓ Can combine with AND, OR, NOT
✓ Works with numbers, strings, dates
✓ Indexes improve performance
✓ Test boundary cases carefully
✓ Choose correct operator for your logic

=================================================================
*/

-- All comparison operators demo with TestData:

-- Equal (=) - Exact match
SELECT id, marks FROM TestData WHERE marks = 85;
-- Returns: rows 1,4 (marks exactly 85)

-- Not Equal (<>) - Exclusion
SELECT id, marks FROM TestData WHERE marks <> 85;
-- Returns: rows 2,3,5 (marks anything except 85)

-- Greater Than (>) - Above threshold (boundary excluded)
SELECT id, marks FROM TestData WHERE marks > 80;
-- Returns: rows 1,2,4 (marks 85, 90, 85 - all above 80)

-- Less Than (<) - Below threshold (boundary excluded)
SELECT id, marks FROM TestData WHERE marks < 80;
-- Returns: rows 3,5 (marks 75, 70 - both below 80)

-- Greater Than or Equal (>=) - Minimum inclusive
SELECT id, marks FROM TestData WHERE marks >= 85;
-- Returns: rows 1,2,4 (marks 85, 90, 85 - all 85 or above)

-- Less Than or Equal (<=) - Maximum inclusive
SELECT id, marks FROM TestData WHERE marks <= 80;
-- Returns: rows 3,5 (marks 75, 70 - both 80 or below)
