/*
=================================================================
QUERY PURPOSE: Insert new data/records into the customers table
=================================================================

CONCEPT EXPLANATION (English):
INSERT INTO is a DML (Data Manipulation Language) statement used to add
new rows/records into an existing table. Unlike DDL (which changes table
structure), DML works with the actual data inside tables.

There are multiple ways to insert data:
1. INSERT with specific columns listed (recommended)
2. INSERT without column names (inserts into all columns)
3. INSERT multiple rows at once (bulk insert)
4. INSERT with NULL values for optional fields
5. INSERT with DEFAULT values

DML operations (INSERT, UPDATE, DELETE) can be rolled back if used
within a transaction, unlike DDL operations (CREATE, DROP, ALTER).

CONCEPT EXPLANATION (Hinglish):
INSERT INTO ek DML (Data Manipulation Language) statement hai jo existing
table mein naye rows/records add karne ke liye use hoti hai. DDL se unlike
(jo table structure change karta hai), DML actual data ke saath kaam karta
hai jo tables ke andar hota hai.

Data insert karne ke multiple tarike hain:
1. INSERT specific columns ke saath (recommended)
2. INSERT bina column names ke (saare columns mein insert hota hai)
3. INSERT ek saath multiple rows (bulk insert)
4. INSERT NULL values ke saath optional fields ke liye
5. INSERT DEFAULT values ke saath

DML operations (INSERT, UPDATE, DELETE) rollback ho sakte hain agar
transaction ke andar use kiye jaayein, DDL operations (CREATE, DROP, ALTER)
ke unlike.

USE CASES:
- Adding new customer registrations to database
- Recording new orders, transactions, or sales
- Importing data from external sources (CSV, APIs)
- Creating test data for development
- Populating master/reference tables (countries, categories)
- Logging events or activities
- User signup/registration processes
- Adding inventory items
- Recording attendance or timestamps
- Migrating data between systems

SPECIFIC QUERY BREAKDOWN:

=================================================================
QUERY 1: INSERT Multiple Rows with Specific Columns
=================================================================

INSERT INTO customers(id, first_name, country, score)
    VALUE (7, 'Anjali', 'India', 88),
            (8, 'Liam', 'Canada', 92),
            (9, 'Sophia', 'USA', NULL);

Line 1: INSERT INTO customers(id, first_name, country, score)
  → INSERT INTO: SQL command to add new data
  → customers: Target table name where data will be inserted
  → (id, first_name, country, score): Column names being populated
  → Order of values must match this column order
  → These are the ONLY columns receiving values (others will be NULL/DEFAULT)

Line 2: VALUE (7, 'Anjali', 'India', 88),
  → VALUE: Keyword indicating values to insert (should be VALUES - see note below)
  ⚠️ Note: Standard SQL uses VALUES (plural), some databases accept VALUE (singular)
  → (7, 'Anjali', 'India', 88): First row of data
    - 7: id value (INT)
    - 'Anjali': first_name value (VARCHAR - needs quotes)
    - 'India': country value (VARCHAR - needs quotes)
    - 88: score value (INT - no quotes)
  → , (comma): Separates multiple rows

Line 3-4: Additional rows
  → (8, 'Liam', 'Canada', 92): Second row
  → (9, 'Sophia', 'USA', NULL): Third row
    - NULL: Explicit NULL value (no quotes, uppercase)
    - Used when data is unknown/not applicable
    - Column must allow NULL (no NOT NULL constraint)

; : Statement terminator

WHAT HAPPENS:
Before INSERT:
customers table:
id | first_name | country   | score
---|------------|-----------|-------
1  | John       | USA       | 95
2  | Alice      | UK        | 87
... (existing data)

After INSERT:
customers table:
id | first_name | country   | score
---|------------|-----------|-------
1  | John       | USA       | 95
2  | Alice      | UK        | 87
7  | Anjali     | India     | 88      ← New row
8  | Liam       | Canada    | 92      ← New row
9  | Sophia     | USA       | NULL    ← New row (NULL score)

3 rows added successfully!

=================================================================
QUERY 2: INSERT Without Column Names (All Columns)
=================================================================

INSERT INTO customers
VALUES (10, 'Noah', 'UK', 75);

Line 1: INSERT INTO customers
  → No column names specified in parentheses
  → Means: Insert values into ALL columns in table order

Line 2: VALUES (10, 'Noah', 'UK', 75);
  → VALUES: Must provide value for EVERY column in the table
  → Values must match table's column order EXACTLY
  → (10, 'Noah', 'UK', 75):
    - Column 1 (id): 10
    - Column 2 (first_name): 'Noah'
    - Column 3 (country): 'UK'
    - Column 4 (score): 75

⚠️ DANGER: This method is risky!
  - If table structure changes (new column added), query breaks
  - Must know exact column order
  - Less readable - unclear which value goes to which column
  - NOT RECOMMENDED for production code

Better practice: Always specify column names!

WHAT HAPPENS:
Assuming customers table has exactly 4 columns in this order:
id, first_name, country, score

Result:
id | first_name | country | score
---|------------|---------|-------
10 | Noah       | UK      | 75    ← New row

If table had MORE columns (e.g., email, phone):
❌ ERROR: Column count doesn't match value count

=================================================================
QUERY 3: INSERT with Partial Columns (Omitting Optional Columns)
=================================================================

INSERT INTO customers (id, first_name, country)
VALUES (11, 'Emma', 'Australia');

Line 1: INSERT INTO customers (id, first_name, country)
  → Only 3 columns specified
  → Missing column: score (not in the list)

Line 2: VALUES (11, 'Emma', 'Australia');
  → Only 3 values provided (matching 3 columns)
  → score column is NOT provided

WHAT HAPPENS to missing column (score)?
- If score has DEFAULT value defined → Uses that default
- If score allows NULL → Sets to NULL
- If score is NOT NULL without DEFAULT → ❌ ERROR

Result (assuming score allows NULL):
id | first_name | country    | score
---|------------|------------|-------
11 | Emma       | Australia  | NULL  ← score is NULL (not provided)

This is USEFUL when:
- Column has DEFAULT value you want to use
- Column allows NULL and you don't have the data
- Optional fields in user forms (email, phone number, etc.)

DATA TYPES AND QUOTING RULES:

Numbers (INT, DECIMAL, FLOAT):
  → No quotes: 88, 92, 75, 10.5, -42
  → Examples: 88, 3.14, -100

Strings/Text (VARCHAR, CHAR, TEXT):
  → Single quotes: 'Anjali', 'India', 'Noah'
  → Escape quotes inside: 'O''Brien' or 'O\'Brien'
  → Examples: 'John', 'New York', 'It''s great'

Dates (DATE, DATETIME, TIMESTAMP):
  → Single quotes with format: '2024-02-26', '2024-02-26 14:30:00'
  → Format: 'YYYY-MM-DD' or 'YYYY-MM-DD HH:MM:SS'
  → Examples: '1990-05-15', '2024-01-01 08:00:00'

NULL:
  → No quotes: NULL (keyword, uppercase or lowercase)
  → Represents absence of value
  → Examples: NULL, null

Boolean (BOOLEAN, BOOL):
  → TRUE, FALSE (no quotes) or 1, 0
  → Examples: TRUE, FALSE, 1, 0

EXAMPLES:

Example 1: INSERT single row with all columns specified
*/
INSERT INTO customers (id, first_name, country, score)
VALUES (12, 'Oliver', 'Germany', 91);

-- Example 2: INSERT multiple rows efficiently (bulk insert)
INSERT INTO customers (id, first_name, country, score)
VALUES
    (13, 'Ava', 'France', 89),
    (14, 'Ethan', 'Spain', 94),
    (15, 'Mia', 'Italy', 87),
    (16, 'Lucas', 'Brazil', 90),
    (17, 'Isabella', 'Mexico', 85);
-- Inserts 5 rows in one operation (more efficient than 5 separate INSERTs)

-- Example 3: INSERT with various data types
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2),
    hire_date DATE,
    is_active BOOLEAN,
    notes TEXT
);

INSERT INTO employees (emp_id, name, salary, hire_date, is_active, notes)
VALUES
    (1, 'John Doe', 50000.00, '2024-01-15', TRUE, 'Senior Developer'),
    (2, 'Jane Smith', 65000.50, '2023-06-01', TRUE, NULL),
    (3, 'Bob Johnson', 45000.00, '2024-02-20', FALSE, 'On leave');

-- Example 4: INSERT with DEFAULT values
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO products (product_name, price)
VALUES ('Laptop', 999.99);
-- stock_quantity gets DEFAULT 0
-- created_at gets DEFAULT CURRENT_TIMESTAMP (current date/time)

-- Example 5: INSERT from SELECT (copying data)
INSERT INTO customers (id, first_name, country, score)
SELECT emp_id, emp_name, emp_country, performance_score
FROM employees
WHERE department = 'Sales';
-- Copies data from employees table to customers table

-- Example 6: INSERT with expressions and functions
INSERT INTO customers (id, first_name, country, score)
VALUES
    (18, UPPER('james'), 'USA', 85 + 5),  -- UPPER() function, expression
    (19, CONCAT('Mary', ' ', 'Jane'), 'UK', ROUND(88.7));  -- String concatenation

-- Example 7: INSERT with ON DUPLICATE KEY UPDATE (MySQL)
INSERT INTO customers (id, first_name, country, score)
VALUES (7, 'Anjali', 'India', 88)
ON DUPLICATE KEY UPDATE
    score = 88,
    country = 'India';
-- If id=7 exists, UPDATE instead of INSERT
-- Useful for UPSERT operations (UPDATE or INSERT)

-- Example 8: INSERT IGNORE (MySQL - skip duplicates)
INSERT IGNORE INTO customers (id, first_name, country, score)
VALUES
    (7, 'Duplicate', 'Test', 50),  -- Skipped if id=7 exists
    (20, 'New User', 'Japan', 92);  -- Inserted normally
-- IGNORE keyword: Skips rows that violate constraints (no error)

-- Example 9: INSERT with subquery
INSERT INTO high_scorers (customer_id, name, score)
SELECT id, first_name, score
FROM customers
WHERE score > 90;
-- Creates new table with high-scoring customers

-- Example 10: INSERT with explicit NULL and DEFAULT
INSERT INTO customers (id, first_name, country, score)
VALUES
    (21, 'Tom', 'Ireland', NULL),      -- Explicit NULL
    (22, 'Sara', DEFAULT, 88),         -- DEFAULT for country (if defined)
    (23, 'Mike', 'Poland', DEFAULT);   -- DEFAULT for score

/*
REAL-WORLD SCENARIOS:

Scenario 1: User Registration Form
*/
-- User fills out registration form with optional fields
INSERT INTO users (user_id, username, email, phone, country, signup_date)
VALUES
    (101, 'anjali_sharma', 'anjali@email.com', NULL, 'India', '2024-02-26');
-- phone is NULL because user didn't provide it

/*
Scenario 2: E-commerce Order Processing
*/
-- Customer places order with multiple items
INSERT INTO orders (order_id, customer_id, order_date, total_amount, status)
VALUES (5001, 7, '2024-02-26', 299.99, 'Pending');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (5001, 101, 2, 49.99),
    (5001, 205, 1, 199.99);
-- One order, multiple items inserted

/*
Scenario 3: Bulk Data Import from CSV
*/
-- After parsing CSV file, insert multiple records
INSERT INTO customers (id, first_name, country, score)
VALUES
    (30, 'Raj', 'India', 75),
    (31, 'Priya', 'India', 82),
    (32, 'Amit', 'India', 90),
    (33, 'Neha', 'India', 88),
    (34, 'Vikram', 'India', 95);
-- Efficient bulk insert instead of 5 separate queries

/*
Scenario 4: Logging User Activity
*/
CREATE TABLE activity_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO activity_log (user_id, action)
VALUES (7, 'Login');  -- timestamp auto-populated
-- Simple logging without manual timestamp

/*
Scenario 5: Data Migration with Transformation
*/
-- Migrating from old system to new system
INSERT INTO new_customers (customer_id, full_name, location, rating)
SELECT
    old_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    UPPER(country) AS location,
    CASE
        WHEN score >= 90 THEN 'Excellent'
        WHEN score >= 70 THEN 'Good'
        ELSE 'Average'
    END AS rating
FROM old_customers;

/*
TRANSACTION EXAMPLE (Rollback capability):
*/
START TRANSACTION;

INSERT INTO customers (id, first_name, country, score)
VALUES (40, 'Test User', 'Test Country', 50);

INSERT INTO orders (order_id, customer_id, total_amount)
VALUES (6001, 40, 100.00);

-- If everything is correct:
COMMIT;

-- If error occurs or need to undo:
ROLLBACK;
-- Both INSERTs are undone!

/*
COMMON MISTAKES TO AVOID:

1. ❌ Wrong number of values:
*/
INSERT INTO customers (id, first_name, country, score)
VALUES (50, 'John', 'USA');  -- ❌ Only 3 values, expecting 4

-- ✓ Correct:
INSERT INTO customers (id, first_name, country, score)
VALUES (50, 'John', 'USA', 85);

/*
2. ❌ Missing quotes for strings:
*/
INSERT INTO customers (id, first_name, country, score)
VALUES (51, John, USA, 85);  -- ❌ John and USA need quotes

-- ✓ Correct:
INSERT INTO customers (id, first_name, country, score)
VALUES (51, 'John', 'USA', 85);

/*
3. ❌ Using quotes for numbers:
*/
INSERT INTO customers (id, first_name, country, score)
VALUES ('52', 'Jane', 'UK', '90');  -- ⚠️ Works but poor practice

-- ✓ Correct:
INSERT INTO customers (id, first_name, country, score)
VALUES (52, 'Jane', 'UK', 90);

/*
4. ❌ NULL with quotes:
*/
INSERT INTO customers (id, first_name, country, score)
VALUES (53, 'Tom', 'Canada', 'NULL');  -- ❌ String 'NULL', not NULL value

-- ✓ Correct:
INSERT INTO customers (id, first_name, country, score)
VALUES (53, 'Tom', 'Canada', NULL);

/*
5. ❌ Wrong date format:
*/
INSERT INTO orders (order_id, order_date)
VALUES (7001, '26-02-2024');  -- ❌ Wrong format

-- ✓ Correct:
INSERT INTO orders (order_id, order_date)
VALUES (7001, '2024-02-26');  -- YYYY-MM-DD

/*
6. ❌ Violating PRIMARY KEY (duplicate):
*/
INSERT INTO customers (id, first_name, country, score)
VALUES (7, 'Another User', 'Test', 50);  -- ❌ id=7 already exists!

-- ✓ Correct: Use unique ID or handle duplicate
INSERT INTO customers (id, first_name, country, score)
VALUES (60, 'Another User', 'Test', 50);

/*
7. ❌ Violating NOT NULL constraint:
*/
-- If first_name is NOT NULL:
INSERT INTO customers (id, country, score)
VALUES (61, 'USA', 85);  -- ❌ Missing required first_name

-- ✓ Correct:
INSERT INTO customers (id, first_name, country, score)
VALUES (61, 'Mike', 'USA', 85);

/*
8. ❌ VALUE instead of VALUES:
*/
INSERT INTO customers (id, first_name, country, score)
VALUE (7, 'Test', 'USA', 50);  -- ⚠️ Works in MySQL, but non-standard

-- ✓ Correct (Standard SQL):
INSERT INTO customers (id, first_name, country, score)
VALUES (7, 'Test', 'USA', 50);

/*
9. ❌ Inserting into AUTO_INCREMENT column:
*/
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO products (id, name)
VALUES (1, 'Product A');  -- ⚠️ Usually let database auto-generate

-- ✓ Better:
INSERT INTO products (name)
VALUES ('Product A');  -- id auto-generated

/*
10. ❌ Not specifying columns (fragile code):
*/
INSERT INTO customers
VALUES (70, 'Alice', 'France', 88);  -- ❌ Breaks if table structure changes

-- ✓ Correct:
INSERT INTO customers (id, first_name, country, score)
VALUES (70, 'Alice', 'France', 88);

/*
PERFORMANCE CONSIDERATIONS:

1. Bulk INSERT is faster than individual INSERTs:
*/
-- ❌ Slow (5 separate operations):
INSERT INTO customers VALUES (1, 'A', 'USA', 80);
INSERT INTO customers VALUES (2, 'B', 'UK', 85);
INSERT INTO customers VALUES (3, 'C', 'India', 90);
INSERT INTO customers VALUES (4, 'D', 'Canada', 75);
INSERT INTO customers VALUES (5, 'E', 'Australia', 88);

-- ✓ Fast (1 operation):
INSERT INTO customers VALUES
    (1, 'A', 'USA', 80),
    (2, 'B', 'UK', 85),
    (3, 'C', 'India', 90),
    (4, 'D', 'Canada', 75),
    (5, 'E', 'Australia', 88);

/*
2. Disable indexes during bulk insert (for very large imports):
*/
ALTER TABLE customers DISABLE KEYS;  -- MySQL
-- Insert millions of rows
INSERT INTO customers VALUES (...);
ALTER TABLE customers ENABLE KEYS;

/*
3. Use LOAD DATA for large CSV imports (MySQL):
*/
LOAD DATA INFILE '/path/to/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS  -- Skip header
(id, first_name, country, score);
-- Much faster than INSERT for large files

/*
4. Batch INSERTs in transactions:
*/
START TRANSACTION;
-- Insert 1000 rows
INSERT INTO customers VALUES (...);  -- Repeat 1000 times
COMMIT;
-- Faster than auto-committing after each INSERT

/*
CHECKING INSERTED DATA:

After INSERT, verify:
*/
-- Check all customers
SELECT * FROM customers;

-- Check specific inserted rows
SELECT * FROM customers WHERE id IN (7, 8, 9, 10, 11);

-- Check count
SELECT COUNT(*) FROM customers;

-- Check last inserted ID (AUTO_INCREMENT)
SELECT LAST_INSERT_ID();  -- MySQL
SELECT @@IDENTITY;  -- SQL Server

/*
RETURNING INSERTED DATA (PostgreSQL):
*/
INSERT INTO customers (first_name, country, score)
VALUES ('Bob', 'USA', 85)
RETURNING *;  -- Returns the inserted row with auto-generated ID

/*
HINGLISH SUMMARY:

INSERT INTO statement ka use karke hum table mein naye rows add karte hain.
Teen tarike dikhaaye gaye:

1. INSERT with specific columns (BEST PRACTICE):
   INSERT INTO customers (id, first_name, country, score)
   VALUES (7, 'Anjali', 'India', 88);
   - Column names specify karo
   - Missing columns NULL ya DEFAULT value lete hain
   - Sabse safe aur readable method

2. INSERT without column names (RISKY):
   INSERT INTO customers VALUES (10, 'Noah', 'UK', 75);
   - Saare columns ki values deni padti hain
   - Column order match karna zaroori hai
   - Table structure change hone pe break ho jata hai
   - Production code mein avoid karo

3. INSERT partial columns (optional fields skip):
   INSERT INTO customers (id, first_name, country) VALUES (11, 'Emma', 'Australia');
   - Sirf required columns provide karo
   - Missing columns NULL ya DEFAULT lete hain
   - Forms mein useful jahan optional fields hain

Multiple rows ek saath insert karna zyada efficient hai:
VALUES (7, 'Anjali', 'India', 88),
       (8, 'Liam', 'Canada', 92),
       (9, 'Sophia', 'USA', NULL);

Data types ka dhyan rakho:
- Numbers: quotes nahi (88, 92, 75)
- Strings: single quotes ('Anjali', 'India')
- NULL: quotes nahi, keyword hai (NULL)
- Dates: quotes mein ('2024-02-26')

Common mistakes se bacho:
❌ Values ki galat count
❌ Strings ke liye quotes missing
❌ NULL ko 'NULL' string ki tarah likhna
❌ Duplicate PRIMARY KEY insert karna
❌ NOT NULL columns ko skip karna

Transaction use karo agar rollback chahiye:
START TRANSACTION;
INSERT INTO ...
COMMIT; (ya ROLLBACK;)

Bulk insert zyada fast hai individual inserts se!

KEY TAKEAWAYS:
✓ Always specify column names (readability + safety)
✓ Use bulk INSERT for multiple rows (performance)
✓ Quote strings, dates; don't quote numbers, NULL
✓ Handle NULL values properly (unquoted keyword)
✓ Check constraints (PRIMARY KEY, NOT NULL, UNIQUE)
✓ Use transactions for related INSERTs
✓ Verify data after INSERT with SELECT
✓ Use proper date format (YYYY-MM-DD)
✓ Consider AUTO_INCREMENT for IDs
✓ Test with small data before bulk insert

=================================================================
*/

-- DML: INSERT Statements

-- Query 1: INSERT multiple rows with specific columns
INSERT INTO customers(id, first_name, country, score)
    VALUE (7, 'Anjali', 'India', 88),
            (8, 'Liam', 'Canada', 92),
            (9, 'Sophia', 'USA', NULL);

-- Query 2: INSERT without column names (all columns)
INSERT INTO customers
VALUES (10, 'Noah', 'UK', 75);

-- Query 3: INSERT with partial columns (omitting optional fields)
INSERT INTO customers (id, first_name, country)
VALUES (11, 'Emma', 'Australia');
