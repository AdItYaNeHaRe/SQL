/*
=================================================================
QUERY PURPOSE: Master NULL handling functions and operations
=================================================================

CONCEPT EXPLANATION (English):
NULL in SQL represents the absence of a value - it is NOT the same as:
- Zero (0) - which is a number
- Empty string ('') - which is a string with no characters
- False - which is a boolean value

NULL means "unknown" or "missing data" and has special behavior:
- Any arithmetic operation with NULL returns NULL
- Any comparison with NULL returns UNKNOWN (treated as FALSE)
- NULL cannot be compared using = or !=
- Functions may behave differently with NULL values

NULL handling is critical for:
- Data quality and completeness
- Default value substitution
- Conditional logic
- Report generation
- Data validation
- User experience (displaying "N/A" instead of blank)
- Mathematical calculations (avoiding NULL propagation)
- Business logic implementation

Categories of NULL Functions:

1. REPLACE VALUE Functions
   - ISNULL: Replace NULL with value (SQL Server)
   - COALESCE: Return first non-NULL value (Standard SQL)
   - IFNULL: Replace NULL with value (MySQL)
   - NVL: Replace NULL with value (Oracle)
   - NULLIF: Return NULL if values are equal

2. CHECK FOR NULL Operations
   - IS NULL: Check if value is NULL
   - IS NOT NULL: Check if value is NOT NULL
   - <=> (NULL-safe equals): MySQL specific

3. CONDITIONAL NULL Functions
   - IF with NULL checks (MySQL)
   - CASE with NULL handling
   - IIF with NULL (SQL Server)

CONCEPT EXPLANATION (Hinglish):
NULL SQL mein value ki absence represent karta hai - yeh SAME NAHI hai:
- Zero (0) se - jo ek number hai
- Empty string ('') se - jo characters ke bina string hai
- False se - jo ek boolean value hai

NULL ka matlab hai "unknown" ya "missing data" aur iska special behavior hai:
- Koi bhi arithmetic operation NULL ke saath NULL return karta hai
- Koi bhi comparison NULL ke saath UNKNOWN return karta hai (FALSE jaisa treat)
- NULL ko = ya != se compare nahi kar sakte
- Functions NULL values ke saath differently behave kar sakte hain

NULL handling zaroori hai:
- Data quality aur completeness ke liye
- Default value substitution ke liye
- Conditional logic ke liye
- Report generation ke liye
- Data validation ke liye
- User experience ke liye ("N/A" dikhana blank ki jagah)
- Mathematical calculations ke liye (NULL propagation avoid karna)
- Business logic implementation ke liye

NULL Functions ki categories:

1. REPLACE VALUE Functions
   - ISNULL: NULL ko value se replace karo (SQL Server)
   - COALESCE: Pehli non-NULL value return karo (Standard SQL)
   - IFNULL: NULL ko value se replace karo (MySQL)
   - NVL: NULL ko value se replace karo (Oracle)
   - NULLIF: Agar values equal hain to NULL return karo

2. CHECK FOR NULL Operations
   - IS NULL: Check karo ki value NULL hai
   - IS NOT NULL: Check karo ki value NULL NAHI hai
   - <=> (NULL-safe equals): MySQL specific

3. CONDITIONAL NULL Functions
   - IF with NULL checks (MySQL)
   - CASE with NULL handling
   - IIF with NULL (SQL Server)

USE CASES:
- E-commerce: Display "Out of Stock" for NULL quantities
- HR: Show "Not Assigned" for NULL manager_id
- Finance: Replace NULL bonus with 0 for calculations
- Reports: Display "N/A" for missing data
- Analytics: Handle missing values in aggregations
- Forms: Set default values for optional fields
- APIs: Return consistent data (no NULL breaks)
- Data quality: Identify incomplete records
- Data migration: Handle missing values during transfer
- User interfaces: Show meaningful text instead of blanks

SAMPLE DATA (Products table):

id | product_name    | category     | price  | stock | discount | supplier_id | last_restock | notes
---|-----------------|--------------|--------|-------|----------|-------------|--------------|-------------
1  | Laptop Pro      | Electronics  | 999.99 | 45    | 10.0     | 101         | 2024-02-15   | Best seller
2  | Wireless Mouse  | Electronics  | 25.50  | NULL  | NULL     | 102         | NULL         | NULL
3  | Office Chair    | Furniture    | 299.00 | 30    | 15.0     | NULL        | 2024-01-20   | Ergonomic
4  | Standing Desk   | Furniture    | 599.00 | 12    | NULL     | 103         | 2024-03-01   | NULL
5  | USB Cable       | Electronics  | 15.99  | 0     | 0.0      | 102         | 2024-02-10   | Clearance
6  | Monitor 27"     | Electronics  | NULL   | 8     | 20.0     | NULL        | NULL         | Price TBD
7  | Desk Lamp       | Furniture    | 45.50  | NULL  | NULL     | 104         | 2024-01-15   | LED
8  | Webcam HD       | Electronics  | 89.99  | 0     | NULL     | NULL        | NULL         | NULL

Additional sample (Employees table):

id | first_name | last_name | salary  | bonus | commission | manager_id | dept      | email
---|------------|-----------|---------|-------|------------|------------|-----------|--------------------
1  | John       | Smith     | 75000   | 5000  | NULL       | NULL       | IT        | john@company.com
2  | Sarah      | Johnson   | 65000   | NULL  | 3000       | 1          | Sales     | sarah@company.com
3  | Mike       | Davis     | 80000   | 6000  | NULL       | 1          | IT        | NULL
4  | Emily      | Brown     | NULL    | 4000  | 5000       | NULL       | Marketing | emily@company.com
5  | David      | Wilson    | 55000   | NULL  | NULL       | 2          | Sales     | NULL

=================================================================
SECTION 1: REPLACE VALUE FUNCTIONS
=================================================================

1.1 COALESCE - Return First Non-NULL Value
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: COALESCE(value1, value2, value3, ..., valueN)
Purpose: Returns first non-NULL value from list
Returns: First non-NULL value, or NULL if all are NULL
Standard: ANSI SQL (works across all databases)
*/

-- Example 1: Basic COALESCE with single column
SELECT
    product_name,
    stock,
    COALESCE(stock, 0) AS stock_safe,
    COALESCE(stock, -1) AS stock_with_flag
FROM Products;
/*
Result:
product_name    | stock | stock_safe | stock_with_flag
----------------|-------|------------|----------------
Laptop Pro      | 45    | 45         | 45
Wireless Mouse  | NULL  | 0          | -1              ← NULL replaced
Office Chair    | 30    | 30         | 30
Standing Desk   | 12    | 12         | 12
USB Cable       | 0     | 0          | 0               ← 0 is NOT NULL
Monitor 27"     | 8     | 8          | 8
Desk Lamp       | NULL  | 0          | -1              ← NULL replaced
Webcam HD       | 0     | 0          | 0

Explanation:
- COALESCE(stock, 0) returns stock if not NULL, else 0
- Important: 0 is NOT NULL, so it's returned as-is
- Useful for calculations where NULL would break formula

Use Case: Safe calculations, default values, display formatting
*/

-- Example 2: COALESCE with multiple fallback values
SELECT
    product_name,
    discount,
    price,
    stock,

    -- Try discount first, then fall back to 0
    COALESCE(discount, 0) AS discount_safe,

    -- Multiple fallbacks: discount, price*0.1, stock*0.05, finally 0
    COALESCE(discount, price * 0.1, stock * 0.05, 0) AS multi_fallback,

    -- Fallback chain for text
    COALESCE(notes, 'No notes available') AS notes_display
FROM Products;
/*
Result:
product_name    | discount | price  | stock | discount_safe | multi_fallback | notes_display
----------------|----------|--------|-------|---------------|----------------|------------------
Laptop Pro      | 10.0     | 999.99 | 45    | 10.0          | 10.0           | Best seller
Wireless Mouse  | NULL     | 25.50  | NULL  | 0.0           | 2.55           | No notes available
Office Chair    | 15.0     | 299.00 | 30    | 15.0          | 15.0           | Ergonomic
Standing Desk   | NULL     | 599.00 | 12    | 0.0           | 59.90          | NULL
USB Cable       | 0.0      | 15.99  | 0     | 0.0           | 0.0            | Clearance
Monitor 27"     | 20.0     | NULL   | 8     | 20.0          | 20.0           | Price TBD
Desk Lamp       | NULL     | 45.50  | NULL  | 0.0           | 4.55           | LED
Webcam HD       | NULL     | 89.99  | 0     | 0.0           | 8.999          | No notes available

Explanation:
- COALESCE evaluates arguments left to right
- Returns first non-NULL value found
- If all NULL, returns NULL
- Can mix data types (with caution)

Use Case: Multi-level defaults, cascading fallbacks
*/

-- Example 3: COALESCE in calculations
SELECT
    first_name,
    salary,
    bonus,
    commission,

    -- Without COALESCE (NULL propagation)
    salary + bonus + commission AS total_naive,

    -- With COALESCE (NULL becomes 0)
    salary + COALESCE(bonus, 0) + COALESCE(commission, 0) AS total_safe,

    -- Alternative: COALESCE entire expression
    COALESCE(salary, 0) + COALESCE(bonus, 0) + COALESCE(commission, 0) AS total_complete
FROM Employees;
/*
Result:
first_name | salary | bonus | commission | total_naive | total_safe | total_complete
-----------|--------|-------|------------|-------------|------------|----------------
John       | 75000  | 5000  | NULL       | NULL        | 80000      | 80000
Sarah      | 65000  | NULL  | 3000       | NULL        | 68000      | 68000
Mike       | 80000  | 6000  | NULL       | NULL        | 86000      | 86000
Emily      | NULL   | 4000  | 5000       | NULL        | NULL       | 9000
David      | 55000  | NULL  | NULL       | NULL        | 55000      | 55000

Explanation:
- NULL + anything = NULL (NULL propagation)
- COALESCE prevents NULL propagation in calculations
- total_safe: salary must be non-NULL
- total_complete: handles NULL salary too

Use Case: Financial calculations, aggregations, totaling
*/

-- Example 4: COALESCE with different data types
SELECT
    product_name,
    notes,
    category,

    -- Text fallback chain
    COALESCE(notes, category, 'No information') AS description,

    -- NULL date handling
    last_restock,
    COALESCE(last_restock, CURDATE()) AS restock_display,

    -- Format for display
    CONCAT(
        product_name,
        ' - ',
        COALESCE(notes, 'Standard item')
    ) AS display_label
FROM Products
LIMIT 4;
/*
Result:
product_name    | notes       | category    | description  | last_restock | restock_display | display_label
----------------|-------------|-------------|--------------|--------------|-----------------|---------------------------
Laptop Pro      | Best seller | Electronics | Best seller  | 2024-02-15   | 2024-02-15      | Laptop Pro - Best seller
Wireless Mouse  | NULL        | Electronics | Electronics  | NULL         | 2024-03-15      | Wireless Mouse - Standard item
Office Chair    | Ergonomic   | Furniture   | Ergonomic    | 2024-01-20   | 2024-01-20      | Office Chair - Ergonomic
Standing Desk   | NULL        | Furniture   | Furniture    | 2024-03-01   | 2024-03-01      | Standing Desk - Standard item

Use Case: Display formatting, report generation, user interfaces
*/

/*
1.2 IFNULL - Replace NULL (MySQL/MariaDB)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: IFNULL(expression, replacement_value)
Purpose: Returns replacement if expression is NULL
Returns: expression if not NULL, else replacement
Database: MySQL, MariaDB
*/

-- Example 5: IFNULL basic usage
SELECT
    product_name,
    stock,
    discount,

    -- Replace NULL stock with 0
    IFNULL(stock, 0) AS stock_safe,

    -- Replace NULL discount with default 5%
    IFNULL(discount, 5.0) AS discount_with_default,

    -- Text replacement
    IFNULL(notes, 'Standard product') AS notes_display
FROM Products
LIMIT 4;
/*
Result:
product_name    | stock | discount | stock_safe | discount_with_default | notes_display
----------------|-------|----------|------------|----------------------|------------------
Laptop Pro      | 45    | 10.0     | 45         | 10.0                 | Best seller
Wireless Mouse  | NULL  | NULL     | 0          | 5.0                  | Standard product
Office Chair    | 30    | 15.0     | 30         | 15.0                 | Ergonomic
Standing Desk   | 12    | NULL     | 12         | 5.0                  | Standard product

Explanation:
- IFNULL takes exactly 2 arguments (unlike COALESCE)
- Simpler syntax than COALESCE for single replacement
- MySQL/MariaDB specific

Use Case: Simple NULL replacement, MySQL environments
*/

-- Example 6: IFNULL vs COALESCE comparison
SELECT
    product_name,
    discount,
    price,

    -- IFNULL: Only 2 arguments
    IFNULL(discount, 5.0) AS ifnull_result,

    -- COALESCE: Can have multiple arguments
    COALESCE(discount, 5.0) AS coalesce_result,

    -- COALESCE advantage: multiple fallbacks
    COALESCE(discount, price * 0.1, 5.0) AS coalesce_multi
FROM Products
LIMIT 3;
/*
Result:
product_name    | discount | price  | ifnull_result | coalesce_result | coalesce_multi
----------------|----------|--------|---------------|-----------------|----------------
Laptop Pro      | 10.0     | 999.99 | 10.0          | 10.0            | 10.0
Wireless Mouse  | NULL     | 25.50  | 5.0           | 5.0             | 2.55
Office Chair    | 15.0     | 299.00 | 15.0          | 15.0            | 15.0

Recommendation: Use COALESCE for portability (standard SQL)
*/

/*
1.3 ISNULL - Replace NULL (SQL Server)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: ISNULL(expression, replacement_value)
Purpose: Returns replacement if expression is NULL
Database: SQL Server (not standard SQL)
Note: Same name as IS NULL check, different function!
*/

-- Example 7: ISNULL usage (SQL Server syntax)
/*
-- SQL Server:
SELECT
    product_name,
    stock,
    discount,
    ISNULL(stock, 0) AS stock_safe,
    ISNULL(discount, 0.0) AS discount_safe
FROM Products;

-- MySQL equivalent using IFNULL:
*/
SELECT
    product_name,
    stock,
    discount,
    IFNULL(stock, 0) AS stock_safe,
    IFNULL(discount, 0.0) AS discount_safe
FROM Products
LIMIT 3;
/*
Note: In SQL Server, ISNULL is the function
      IS NULL is the comparison operator
      Different things entirely!
*/

/*
1.4 NVL - Replace NULL (Oracle)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: NVL(expression, replacement_value)
Purpose: Returns replacement if expression is NULL
Database: Oracle
*/

-- Example 8: NVL usage (Oracle syntax)
/*
-- Oracle:
SELECT
    product_name,
    stock,
    NVL(stock, 0) AS stock_safe,
    NVL(notes, 'No notes') AS notes_display
FROM Products;

-- MySQL equivalent using IFNULL or COALESCE:
*/
SELECT
    product_name,
    stock,
    COALESCE(stock, 0) AS stock_safe,  -- Standard SQL, works everywhere
    IFNULL(notes, 'No notes') AS notes_display  -- MySQL specific
FROM Products
LIMIT 3;

/*
1.5 NULLIF - Return NULL if Equal
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: NULLIF(expression1, expression2)
Purpose: Returns NULL if expressions are equal, else returns expression1
Returns: NULL if equal, expression1 if different
Use: Convert specific values to NULL
*/

-- Example 9: NULLIF basic usage
SELECT
    product_name,
    stock,
    discount,

    -- Convert 0 to NULL (treat 0 as "no stock")
    NULLIF(stock, 0) AS stock_nullif_zero,

    -- Convert 0 discount to NULL (no discount)
    NULLIF(discount, 0.0) AS discount_nullif_zero,

    -- Convert empty string to NULL (if notes was VARCHAR)
    NULLIF(notes, '') AS notes_nullif_empty
FROM Products;
/*
Result:
product_name    | stock | discount | stock_nullif_zero | discount_nullif_zero | notes_nullif_empty
----------------|-------|----------|-------------------|----------------------|--------------------
Laptop Pro      | 45    | 10.0     | 45                | 10.0                 | Best seller
Wireless Mouse  | NULL  | NULL     | NULL              | NULL                 | NULL
Office Chair    | 30    | 15.0     | 30                | 15.0                 | Ergonomic
Standing Desk   | 12    | NULL     | 12                | NULL                 | NULL
USB Cable       | 0     | 0.0      | NULL              | NULL                 | Clearance
Monitor 27"     | 8     | 20.0     | 8                 | 20.0                 | Price TBD
Desk Lamp       | NULL  | NULL     | NULL              | NULL                 | LED
Webcam HD       | 0     | NULL     | NULL              | NULL                 | NULL

Explanation:
- NULLIF(stock, 0): Returns NULL if stock equals 0, else returns stock
- USB Cable: stock = 0, so NULLIF returns NULL
- Useful for treating specific values as "missing"

Use Case: Converting sentinel values to NULL, data cleansing
*/

-- Example 10: NULLIF to prevent division by zero
SELECT
    product_name,
    price,
    stock,

    -- Unsafe division
    -- price / stock AS price_per_unit,  -- Would error if stock = 0

    -- Safe division using NULLIF
    price / NULLIF(stock, 0) AS price_per_unit_safe,

    -- With COALESCE for complete safety
    COALESCE(price / NULLIF(stock, 0), 0) AS price_per_unit_or_zero
FROM Products
WHERE price IS NOT NULL;
/*
Result:
product_name    | price  | stock | price_per_unit_safe | price_per_unit_or_zero
----------------|--------|-------|---------------------|------------------------
Laptop Pro      | 999.99 | 45    | 22.22               | 22.22
Wireless Mouse  | 25.50  | NULL  | NULL                | 0.00
Office Chair    | 299.00 | 30    | 9.97                | 9.97
Standing Desk   | 599.00 | 12    | 49.92               | 49.92
USB Cable       | 15.99  | 0     | NULL                | 0.00                    ← Division by zero prevented
Desk Lamp       | 45.50  | NULL  | NULL                | 0.00
Webcam HD       | 89.99  | 0     | NULL                | 0.00                    ← Division by zero prevented

Explanation:
- NULLIF(stock, 0) returns NULL when stock is 0
- Division by NULL returns NULL (safe, no error)
- COALESCE provides final fallback to 0

Use Case: Safe division, preventing errors, ratio calculations
*/

-- Example 11: NULLIF for data cleaning
SELECT
    product_name,
    supplier_id,

    -- Original value
    supplier_id AS original,

    -- Convert invalid supplier ID (999) to NULL
    NULLIF(supplier_id, 999) AS cleaned_supplier_id,

    -- Combine with COALESCE for replacement
    COALESCE(NULLIF(supplier_id, 999), 0) AS supplier_or_default
FROM Products;
/*
Result (assuming some supplier_id = 999):
Converts invalid/sentinel values to NULL, then optionally to default

Use Case: Data migration, cleaning sentinel values, validation
*/

/*
=================================================================
SECTION 2: CHECK FOR NULL OPERATIONS
=================================================================

2.1 IS NULL - Check if Value is NULL
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column IS NULL
Purpose: Check if value is NULL
Returns: TRUE if NULL, FALSE if not NULL
Important: Cannot use = NULL (always returns FALSE)
*/

-- Example 12: IS NULL basic usage
SELECT
    product_name,
    stock,
    discount,
    notes,
    supplier_id
FROM Products
WHERE stock IS NULL;
/*
Result:
product_name    | stock | discount | notes | supplier_id
----------------|-------|----------|-------|-------------
Wireless Mouse  | NULL  | NULL     | NULL  | 102
Desk Lamp       | NULL  | NULL     | LED   | 104

Explanation:
- IS NULL finds rows where stock column is NULL
- Cannot use: WHERE stock = NULL (wrong!)
- Returns 2 products with NULL stock

Use Case: Finding incomplete records, missing data detection
*/

-- Example 13: Multiple NULL checks with OR
SELECT
    product_name,
    stock,
    discount,
    notes,
    supplier_id
FROM Products
WHERE stock IS NULL
   OR discount IS NULL
   OR supplier_id IS NULL;
/*
Result: Products with ANY NULL value

product_name    | stock | discount | notes       | supplier_id
----------------|-------|----------|-------------|-------------
Wireless Mouse  | NULL  | NULL     | NULL        | 102
Office Chair    | 30    | 15.0     | Ergonomic   | NULL
Standing Desk   | 12    | NULL     | NULL        | 103
Monitor 27"     | 8     | 20.0     | Price TBD   | NULL
Desk Lamp       | NULL  | NULL     | LED         | 104
Webcam HD       | 0     | NULL     | NULL        | NULL

Use Case: Data quality checks, incomplete record detection
*/

-- Example 14: IS NULL in SELECT (conditional flags)
SELECT
    product_name,
    stock,
    discount,

    -- Create flags for NULL values
    stock IS NULL AS stock_missing,
    discount IS NULL AS discount_missing,
    notes IS NULL AS notes_missing,

    -- Count of missing values
    (stock IS NULL) + (discount IS NULL) + (notes IS NULL) AS missing_count
FROM Products;
/*
Result:
product_name    | stock | discount | stock_missing | discount_missing | notes_missing | missing_count
----------------|-------|----------|---------------|------------------|---------------|---------------
Laptop Pro      | 45    | 10.0     | 0             | 0                | 0             | 0
Wireless Mouse  | NULL  | NULL     | 1             | 1                | 1             | 3
Office Chair    | 30    | 15.0     | 0             | 0                | 0             | 0
Standing Desk   | 12    | NULL     | 0             | 1                | 1             | 2
USB Cable       | 0     | 0.0      | 0             | 0                | 0             | 0
Monitor 27"     | 8     | 20.0     | 0             | 0                | 0             | 0
Desk Lamp       | NULL  | NULL     | 1             | 1                | 0             | 2
Webcam HD       | 0     | NULL     | 0             | 1                | 1             | 2

Explanation:
- stock IS NULL returns 1 (TRUE) or 0 (FALSE) in MySQL
- Can sum these to count missing values
- Useful for data quality metrics

Use Case: Data quality dashboards, completeness scoring
*/

/*
2.2 IS NOT NULL - Check if Value is NOT NULL
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: column IS NOT NULL
Purpose: Check if value exists (not NULL)
Returns: TRUE if not NULL, FALSE if NULL
*/

-- Example 15: IS NOT NULL for complete records
SELECT
    product_name,
    stock,
    discount,
    supplier_id
FROM Products
WHERE stock IS NOT NULL
  AND discount IS NOT NULL
  AND supplier_id IS NOT NULL;
/*
Result: Only complete products

product_name | stock | discount | supplier_id
-------------|-------|----------|-------------
Laptop Pro   | 45    | 10.0     | 101
Office Chair | 30    | 15.0     | NULL

Wait, Office Chair has NULL supplier_id...

Actual Result:
product_name | stock | discount | supplier_id
-------------|-------|----------|-------------
Laptop Pro   | 45    | 10.0     | 101
USB Cable    | 0     | 0.0      | 102

Explanation:
- All three conditions must be TRUE (AND)
- Only returns rows with no NULL values in these columns
- Note: 0 is NOT NULL

Use Case: Finding complete records, data validation, required fields
*/

-- Example 16: IS NOT NULL for calculations
SELECT
    first_name,
    salary,
    bonus,
    commission
FROM Employees
WHERE bonus IS NOT NULL
   OR commission IS NOT NULL;
/*
Result: Employees with at least one incentive

first_name | salary | bonus | commission
-----------|--------|-------|------------
John       | 75000  | 5000  | NULL
Sarah      | 65000  | NULL  | 3000
Mike       | 80000  | 6000  | NULL
Emily      | NULL   | 4000  | 5000

Explanation:
- Returns rows where bonus OR commission exists
- Useful for filtering records with partial data

Use Case: Incentive eligibility, partial data analysis
*/

/*
2.3 NULL-Safe Equals (<=> ) - MySQL Specific
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: value1 <=> value2
Purpose: NULL-safe equality comparison
Returns: TRUE if both NULL or both equal, FALSE otherwise
Database: MySQL specific
*/

-- Example 17: NULL-safe equals operator
SELECT
    product_name,
    stock,
    discount,

    -- Regular equals (fails with NULL)
    stock = discount AS regular_equals,

    -- NULL-safe equals
    stock <=> discount AS null_safe_equals,

    -- NULL <=> NULL is TRUE
    stock <=> NULL AS is_stock_null
FROM Products
LIMIT 5;
/*
Result:
product_name    | stock | discount | regular_equals | null_safe_equals | is_stock_null
----------------|-------|----------|----------------|------------------|---------------
Laptop Pro      | 45    | 10.0     | 0              | 0                | 0
Wireless Mouse  | NULL  | NULL     | NULL           | 1                | 1
Office Chair    | 30    | 15.0     | 0              | 0                | 0
Standing Desk   | 12    | NULL     | NULL           | 0                | 0
USB Cable       | 0     | 0.0      | 1              | 1                | 0

Explanation:
- stock = discount returns NULL when either is NULL
- stock <=> discount returns TRUE when both NULL
- Wireless Mouse: NULL <=> NULL = TRUE (1)
- USB Cable: 0 <=> 0.0 = TRUE (1)

Use Case: NULL-aware comparisons, data synchronization
*/

-- Example 18: Practical use of <=>
SELECT
    p1.product_name AS product1,
    p2.product_name AS product2,
    p1.stock AS stock1,
    p2.stock AS stock2
FROM Products p1
JOIN Products p2 ON p1.id < p2.id
WHERE p1.stock <=> p2.stock  -- Match even if both NULL
LIMIT 5;
/*
Result: Pairs of products with same stock (including both NULL)

Use Case: Finding duplicates, matching records including NULLs
*/

/*
=================================================================
SECTION 3: CONDITIONAL NULL HANDLING
=================================================================

3.1 CASE with NULL
━━━━━━━━━━━━━━━━━━

Use CASE for complex NULL handling logic
*/

-- Example 19: CASE for NULL categorization
SELECT
    product_name,
    stock,
    discount,
    price,

    -- Complex NULL handling
    CASE
        WHEN stock IS NULL THEN 'Stock Unknown'
        WHEN stock = 0 THEN 'Out of Stock'
        WHEN stock < 10 THEN 'Low Stock'
        WHEN stock < 50 THEN 'In Stock'
        ELSE 'Well Stocked'
    END AS stock_status,

    CASE
        WHEN discount IS NULL AND price IS NULL THEN 'Incomplete Product'
        WHEN discount IS NULL THEN 'No Discount'
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount >= 20 THEN 'Great Deal'
        WHEN discount >= 10 THEN 'Good Deal'
        ELSE 'Small Discount'
    END AS discount_status
FROM Products;
/*
Result:
product_name    | stock | discount | price  | stock_status  | discount_status
----------------|-------|----------|--------|---------------|------------------
Laptop Pro      | 45    | 10.0     | 999.99 | In Stock      | Good Deal
Wireless Mouse  | NULL  | NULL     | 25.50  | Stock Unknown | No Discount
Office Chair    | 30    | 15.0     | 299.00 | In Stock      | Good Deal
Standing Desk   | 12    | NULL     | 599.00 | In Stock      | No Discount
USB Cable       | 0     | 0.0      | 15.99  | Out of Stock  | No Discount
Monitor 27"     | 8     | 20.0     | NULL   | Low Stock     | Great Deal
Desk Lamp       | NULL  | NULL     | 45.50  | Stock Unknown | No Discount
Webcam HD       | 0     | NULL     | 89.99  | Out of Stock  | No Discount

Use Case: Status categorization, display logic, business rules
*/

-- Example 20: CASE with COALESCE
SELECT
    first_name,
    salary,
    bonus,
    commission,

    -- Total compensation with complex logic
    CASE
        WHEN salary IS NULL AND bonus IS NULL AND commission IS NULL
        THEN 'No compensation data'

        WHEN salary IS NULL
        THEN CONCAT('Partial: $', COALESCE(bonus, 0) + COALESCE(commission, 0))

        ELSE CONCAT('$', salary + COALESCE(bonus, 0) + COALESCE(commission, 0))
    END AS compensation_summary,

    -- Compensation type
    CASE
        WHEN bonus IS NOT NULL AND commission IS NOT NULL THEN 'Base + Bonus + Commission'
        WHEN bonus IS NOT NULL THEN 'Base + Bonus'
        WHEN commission IS NOT NULL THEN 'Base + Commission'
        WHEN salary IS NOT NULL THEN 'Base Only'
        ELSE 'Unknown'
    END AS comp_type
FROM Employees;
/*
Result:
first_name | salary | bonus | commission | compensation_summary | comp_type
-----------|--------|-------|------------|----------------------|-------------------------
John       | 75000  | 5000  | NULL       | $80000               | Base + Bonus
Sarah      | 65000  | NULL  | 3000       | $68000               | Base + Commission
Mike       | 80000  | 6000  | NULL       | $86000               | Base + Bonus
Emily      | NULL   | 4000  | 5000       | Partial: $9000       | Unknown
David      | 55000  | NULL  | NULL       | $55000               | Base Only

Use Case: Complex business logic, formatted displays, categorization
*/

/*
3.2 IF Function with NULL (MySQL)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Syntax: IF(condition, value_if_true, value_if_false)
Purpose: Conditional expression
Database: MySQL specific
*/

-- Example 21: IF with NULL checks
SELECT
    product_name,
    stock,
    discount,

    -- Simple IF with NULL check
    IF(stock IS NULL, 'Unknown', stock) AS stock_display,

    -- Nested IF
    IF(stock IS NULL, 'Unknown',
       IF(stock = 0, 'Out of Stock',
          IF(stock < 10, 'Low',
             'Available'))) AS stock_label,

    -- IF with calculation
    IF(discount IS NULL, 0, discount) AS discount_safe
FROM Products
LIMIT 5;
/*
Result:
product_name    | stock | discount | stock_display | stock_label   | discount_safe
----------------|-------|----------|---------------|---------------|---------------
Laptop Pro      | 45    | 10.0     | 45            | Available     | 10.0
Wireless Mouse  | NULL  | NULL     | Unknown       | Unknown       | 0.0
Office Chair    | 30    | 15.0     | 30            | Available     | 15.0
Standing Desk   | 12    | NULL     | 12            | Available     | 0.0
USB Cable       | 0     | 0.0      | 0             | Out of Stock  | 0.0

Use Case: Simple conditionals, MySQL environments
*/

/*
=================================================================
SECTION 4: COMPREHENSIVE REAL-WORLD EXAMPLES
=================================================================
*/

-- Example 22: Product Catalog with Complete NULL Handling
SELECT
    id,
    product_name,

    -- Price handling
    price,
    COALESCE(price, 0.00) AS price_display,
    IF(price IS NULL, 'Price TBD', CONCAT('$', price)) AS price_formatted,

    -- Stock handling
    stock,
    COALESCE(stock, 0) AS stock_safe,
    CASE
        WHEN stock IS NULL THEN 'Unknown'
        WHEN stock = 0 THEN 'Out of Stock'
        WHEN stock < 10 THEN CONCAT(stock, ' left - Low Stock!')
        ELSE CONCAT(stock, ' available')
    END AS stock_message,

    -- Discount handling
    discount,
    COALESCE(discount, 0) AS discount_safe,
    CONCAT(COALESCE(discount, 0), '% off') AS discount_display,

    -- Calculated final price
    ROUND(
        COALESCE(price, 0) * (1 - COALESCE(discount, 0) / 100),
        2
    ) AS final_price,

    -- Supplier handling
    supplier_id,
    COALESCE(supplier_id, 0) AS supplier_id_safe,
    IF(supplier_id IS NULL, 'Direct', CONCAT('Supplier #', supplier_id)) AS supplier_name,

    -- Notes handling
    COALESCE(notes, 'Standard product') AS description,

    -- Completeness score
    (price IS NOT NULL) +
    (stock IS NOT NULL) +
    (discount IS NOT NULL) +
    (supplier_id IS NOT NULL) +
    (notes IS NOT NULL) AS completeness_score,

    -- Quality flag
    CASE
        WHEN price IS NULL OR stock IS NULL THEN 'Incomplete'
        WHEN supplier_id IS NULL THEN 'Review Needed'
        ELSE 'Complete'
    END AS data_quality

FROM Products
ORDER BY completeness_score DESC, product_name;
/*
Complete product listing with all NULL scenarios handled

Use Case: E-commerce product display, catalog management
*/

-- Example 23: Employee Compensation Report with NULL Handling
SELECT
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name,
    dept,

    -- Salary components
    salary,
    COALESCE(salary, 0) AS base_salary,
    IFNULL(bonus, 0) AS bonus_amount,
    COALESCE(commission, 0) AS commission_amount,

    -- Total compensation
    COALESCE(salary, 0) + COALESCE(bonus, 0) + COALESCE(commission, 0) AS total_comp,

    -- Compensation breakdown
    CONCAT(
        'Base: $', COALESCE(salary, 0),
        CASE WHEN bonus IS NOT NULL THEN CONCAT(' + Bonus: $', bonus) ELSE '' END,
        CASE WHEN commission IS NOT NULL THEN CONCAT(' + Comm: $', commission) ELSE '' END
    ) AS comp_breakdown,

    -- Incentive percentage
    CASE
        WHEN salary IS NULL OR salary = 0 THEN 'N/A'
        ELSE CONCAT(
            ROUND(
                (COALESCE(bonus, 0) + COALESCE(commission, 0)) /
                NULLIF(salary, 0) * 100,
                1
            ),
            '%'
        )
    END AS incentive_pct,

    -- Manager status
    CASE
        WHEN manager_id IS NULL THEN 'Top Level'
        ELSE CONCAT('Reports to Manager #', manager_id)
    END AS reporting,

    -- Email status
    CASE
        WHEN email IS NULL THEN 'Email Missing - Action Required'
        ELSE email
    END AS email_status,

    -- Data completeness
    CASE
        WHEN salary IS NULL THEN 'Missing Salary Data'
        WHEN email IS NULL THEN 'Missing Contact Info'
        WHEN dept IS NULL THEN 'Missing Department'
        ELSE 'Complete'
    END AS data_status

FROM Employees
ORDER BY total_comp DESC;
/*
Complete HR report with NULL handling for all scenarios

Use Case: Payroll reports, HR dashboards, compensation analysis
*/

-- Example 24: Sales Analysis with NULL-Safe Calculations
CREATE TEMPORARY TABLE Sales (
    id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount_pct DECIMAL(5,2),
    tax_rate DECIMAL(5,2),
    shipping_cost DECIMAL(10,2)
);

INSERT INTO Sales VALUES
(1, 1, 2, 999.99, 10.0, 8.0, 25.00),
(2, 2, 5, 25.50, NULL, 8.0, NULL),
(3, 3, NULL, 299.00, 15.0, 8.0, 15.00),
(4, 4, 1, NULL, 0.0, 8.0, 10.00),
(5, 5, 3, 89.99, NULL, NULL, NULL);

SELECT
    id,
    product_id,

    -- Quantity handling
    quantity,
    COALESCE(quantity, 0) AS qty_safe,

    -- Price handling
    unit_price,
    COALESCE(unit_price, 0.00) AS price_safe,

    -- Subtotal (NULL-safe)
    COALESCE(quantity, 0) * COALESCE(unit_price, 0) AS subtotal,

    -- Discount calculation (NULL-safe)
    COALESCE(quantity, 0) * COALESCE(unit_price, 0) *
    (COALESCE(discount_pct, 0) / 100) AS discount_amount,

    -- After discount
    COALESCE(quantity, 0) * COALESCE(unit_price, 0) *
    (1 - COALESCE(discount_pct, 0) / 100) AS after_discount,

    -- Tax calculation (NULL-safe)
    COALESCE(quantity, 0) * COALESCE(unit_price, 0) *
    (1 - COALESCE(discount_pct, 0) / 100) *
    (COALESCE(tax_rate, 0) / 100) AS tax_amount,

    -- Shipping handling
    COALESCE(shipping_cost, 0.00) AS shipping,

    -- Grand total (NULL-safe)
    ROUND(
        COALESCE(quantity, 0) * COALESCE(unit_price, 0) *
        (1 - COALESCE(discount_pct, 0) / 100) *
        (1 + COALESCE(tax_rate, 0) / 100) +
        COALESCE(shipping_cost, 0),
        2
    ) AS grand_total,

    -- Data quality flags
    CASE
        WHEN quantity IS NULL THEN 'Missing Quantity'
        WHEN unit_price IS NULL THEN 'Missing Price'
        WHEN discount_pct IS NULL AND tax_rate IS NULL THEN 'Missing Tax Info'
        ELSE 'Complete'
    END AS data_quality

FROM Sales;
/*
Result: Complete sales calculations handling all NULL scenarios

Use Case: Invoice generation, sales reporting, financial calculations
*/

DROP TEMPORARY TABLE Sales;

/*
=================================================================
SECTION 5: AGGREGATE FUNCTIONS AND NULL
=================================================================
*/

-- Example 25: NULL behavior in aggregates
SELECT
    'Aggregate Behavior with NULL' AS description,

    -- COUNT(*) counts all rows
    COUNT(*) AS total_rows,

    -- COUNT(column) counts non-NULL values
    COUNT(stock) AS stock_count,
    COUNT(discount) AS discount_count,
    COUNT(notes) AS notes_count,

    -- AVG ignores NULL
    AVG(stock) AS avg_stock,
    AVG(discount) AS avg_discount,

    -- AVG with NULL handling
    AVG(COALESCE(stock, 0)) AS avg_stock_with_zero,

    -- SUM ignores NULL
    SUM(stock) AS sum_stock,
    SUM(COALESCE(stock, 0)) AS sum_stock_including_null,

    -- MIN/MAX ignore NULL
    MIN(stock) AS min_stock,
    MAX(stock) AS max_stock

FROM Products;
/*
Result:
description                    | total_rows | stock_count | discount_count | notes_count | avg_stock | avg_discount | avg_stock_with_zero | sum_stock | sum_stock_including_null | min_stock | max_stock
-------------------------------|------------|-------------|----------------|-------------|-----------|--------------|---------------------|-----------|--------------------------|-----------|----------
Aggregate Behavior with NULL   | 8          | 6           | 4              | 4           | 15.8333   | 11.25        | 11.875              | 95        | 95                       | 0         | 45

Explanation:
- COUNT(*): All 8 rows
- COUNT(stock): Only 6 non-NULL values
- AVG(stock): Average of 6 values (ignores 2 NULLs)
- AVG(COALESCE(stock, 0)): Treats NULL as 0, averages all 8

Use Case: Statistical analysis, understanding NULL impact
*/

-- Example 26: GROUP BY with NULL
SELECT
    supplier_id,
    COUNT(*) AS product_count,
    COUNT(stock) AS products_with_stock,
    AVG(COALESCE(stock, 0)) AS avg_stock,
    SUM(COALESCE(price, 0)) AS total_value
FROM Products
GROUP BY supplier_id
ORDER BY supplier_id;
/*
Result:
supplier_id | product_count | products_with_stock | avg_stock | total_value
------------|---------------|---------------------|-----------|-------------
NULL        | 3             | 1                   | 2.67      | 344.50
101         | 1             | 1                   | 45.00     | 999.99
102         | 2             | 0                   | 0.00      | 41.49
103         | 1             | 1                   | 12.00     | 599.00
104         | 1             | 0                   | 0.00      | 45.50

Explanation:
- NULL supplier_id forms its own group
- Aggregates handle NULL values within each group

Use Case: Grouped analysis, finding patterns including unknowns
*/

/*
=================================================================
COMMON MISTAKES AND BEST PRACTICES
=================================================================
*/

-- ❌ MISTAKE 1: Using = NULL or != NULL
SELECT * FROM Products WHERE stock = NULL;  -- Returns nothing!

-- ✓ CORRECT: Use IS NULL
SELECT * FROM Products WHERE stock IS NULL;

-- ❌ MISTAKE 2: Not handling NULL in calculations
SELECT product_name, price + discount AS total
FROM Products;  -- Returns NULL if either is NULL

-- ✓ CORRECT: Use COALESCE
SELECT product_name, price + COALESCE(discount, 0) AS total
FROM Products;

-- ❌ MISTAKE 3: Forgetting NULL in CONCAT
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM Employees;  -- Returns NULL if any part is NULL

-- ✓ CORRECT: Use COALESCE
SELECT CONCAT(COALESCE(first_name, ''), ' ', COALESCE(last_name, '')) AS full_name
FROM Employees;

-- ❌ MISTAKE 4: Division by zero without NULL check
SELECT price / stock FROM Products;  -- Error when stock = 0

-- ✓ CORRECT: Use NULLIF
SELECT price / NULLIF(stock, 0) FROM Products;

-- ❌ MISTAKE 5: Assuming COUNT counts NULL
SELECT COUNT(stock) FROM Products;  -- Only counts non-NULL

-- ✓ AWARE: Use COUNT(*) for all rows
SELECT COUNT(*) AS all_rows, COUNT(stock) AS non_null_stock FROM Products;

/*
=================================================================
HINGLISH SUMMARY
=================================================================

NULL handling SQL mein bahut zaroori hai kyunki NULL = "missing value"

Key points:
- NULL ≠ 0, NULL ≠ '', NULL ≠ FALSE
- NULL = "unknown" ya "missing"
- NULL + anything = NULL (propagation)
- NULL cannot be compared with = (use IS NULL)

1. REPLACE VALUE Functions - NULL ko replace karna

   COALESCE(val1, val2, val3) - Pehli non-NULL value
   - COALESCE(stock, 0) → stock ya 0
   - COALESCE(discount, price*0.1, 5) → multiple fallbacks
   - Standard SQL, sabhi databases mein kaam karta hai

   IFNULL(val, replacement) - MySQL
   - IFNULL(stock, 0) → stock ya 0
   - Sirf 2 arguments

   ISNULL(val, replacement) - SQL Server
   - Same as IFNULL

   NULLIF(val1, val2) - Agar equal to NULL return
   - NULLIF(stock, 0) → 0 ko NULL mein convert
   - Division by zero prevent karne ke liye useful

2. CHECK FOR NULL - NULL check karna

   IS NULL - NULL hai?
   - WHERE stock IS NULL
   - NOT: WHERE stock = NULL ❌

   IS NOT NULL - NULL nahi hai?
   - WHERE stock IS NOT NULL
   - Non-NULL values chahiye

   <=> - NULL-safe equals (MySQL)
   - NULL <=> NULL = TRUE
   - Regular = fails with NULL

3. Calculations mein NULL handling

   Unsafe:
   salary + bonus → NULL if bonus is NULL

   Safe:
   salary + COALESCE(bonus, 0) → Always works

   Division by zero:
   price / NULLIF(stock, 0) → NULL instead of error

4. Aggregates aur NULL

   - COUNT(*) → All rows
   - COUNT(column) → Non-NULL only
   - AVG, SUM → Ignore NULL
   - MIN, MAX → Ignore NULL

Real-world patterns:

Display formatting:
COALESCE(stock, 0) → 0 dikhao instead of NULL
IF(stock IS NULL, 'Unknown', stock) → "Unknown" dikhao

Calculations:
salary + COALESCE(bonus, 0) + COALESCE(commission, 0) → Safe total

Division:
price / NULLIF(stock, 0) → Division by zero se bacho

Data quality:
(price IS NOT NULL) + (stock IS NOT NULL) → Completeness score

CASE with NULL:
CASE
  WHEN stock IS NULL THEN 'Unknown'
  WHEN stock = 0 THEN 'Out of Stock'
  ELSE 'In Stock'
END

Common mistakes:
❌ stock = NULL (use IS NULL)
❌ price + discount (NULL propagation)
❌ CONCAT with NULL (result NULL)
❌ price / stock (division by zero)
❌ COUNT(column) for all rows (use COUNT(*))

Best practices:
✓ Hamesha COALESCE use karo calculations mein
✓ IS NULL use karo, = NULL nahi
✓ NULLIF use karo division by zero se bachne ke liye
✓ Display ke liye meaningful defaults do
✓ Data quality metrics track karo
✓ NULL handling explicit rakho

Remember:
- NULL = missing/unknown
- Use IS NULL, not = NULL
- COALESCE for defaults
- NULLIF for sentinel values
- Aggregates ignore NULL
- NULL propagates in calculations
- Handle NULL explicitly for data quality

KEY TAKEAWAYS:
✓ NULL represents missing/unknown data
✓ NULL ≠ 0, '', or FALSE
✓ Use IS NULL/IS NOT NULL for checking
✓ COALESCE returns first non-NULL value
✓ IFNULL/ISNULL for simple replacement
✓ NULLIF converts values to NULL
✓ NULL in calculations returns NULL
✓ Use COALESCE to prevent NULL propagation
✓ NULLIF prevents division by zero
✓ Aggregates (COUNT, AVG, SUM) ignore NULL
✓ COUNT(*) counts all, COUNT(column) counts non-NULL
✓ Always handle NULL explicitly
✓ Test NULL scenarios thoroughly
✓ NULL-safe equals (<=> ) for MySQL
✓ CASE statements for complex NULL logic

=================================================================
*/

-- Final comprehensive example:
SELECT
    product_name,

    -- Original values
    price,
    stock,
    discount,
    supplier_id,

    -- NULL replacement
    COALESCE(price, 0) AS price_safe,
    IFNULL(stock, 0) AS stock_safe,
    COALESCE(discount, 0) AS discount_safe,

    -- Display formatting
    CONCAT('$', COALESCE(price, 0)) AS price_display,
    IF(stock IS NULL, 'Unknown',
       IF(stock = 0, 'Out of Stock',
          CONCAT(stock, ' available'))) AS stock_display,

    -- Calculations (NULL-safe)
    ROUND(
        COALESCE(price, 0) * (1 - COALESCE(discount, 0) / 100),
        2
    ) AS final_price,

    -- Division (safe)
    ROUND(COALESCE(price, 0) / NULLIF(stock, 0), 2) AS price_per_unit,

    -- NULL checks
    price IS NULL AS missing_price,
    stock IS NULL AS missing_stock,

    -- Completeness score
    (price IS NOT NULL) +
    (stock IS NOT NULL) +
    (discount IS NOT NULL) +
    (supplier_id IS NOT NULL) AS completeness,

    -- Status
    CASE
        WHEN price IS NULL OR stock IS NULL THEN 'Incomplete'
        WHEN supplier_id IS NULL THEN 'Review Needed'
        ELSE 'Complete'
    END AS status

FROM Products;
